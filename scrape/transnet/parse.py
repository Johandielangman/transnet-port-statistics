# =============== // STANDARD IMPORT // ===============

from pathlib import Path

# =============== // LIBRARY IMPORT // ===============

from loguru import logger
import boto3

# =============== // MODULE IMPORT // ===============

import constants as c

# =============== // INITIAL SETUP // ===============

logger.add(f"{c.LOG_DIR / 'parse.log'}")


class Parser():
    def __init__(self) -> None:
        self.client = boto3.client('textract')

    def parse(self, category: str, year: str, pdf_path: Path) -> None:
        data_output_dir = c.DOWNLOADS_DIR.parent / "csv" / category / year
        meta_output_dir = c.DOWNLOADS_DIR.parent / "csv_meta" / category / year

        data_output_dir.mkdir(exist_ok=True, parents=True)
        meta_output_dir.mkdir(exist_ok=True, parents=True)

        logger.info(f"Parsing {pdf_path.name}")

        document_bytes: bytes = pdf_path.read_bytes()

        try:
            response = self.client.analyze_document(
                Document={'Bytes': document_bytes},
                FeatureTypes=['TABLES']
            )
        except Exception as e:
            logger.error(f"Failed to process {pdf_path.name}: {e}")
            return

        logger.info("Document analyzed — extracting tables…")
        csv_content, csv_meta_content = self._extract_tables(response)

        # Write content file (raw table data)
        data_output_file = data_output_dir / f"{pdf_path.stem}_tables.csv"
        data_output_file.write_text(csv_content)
        logger.success(f"Table data written to {data_output_file}")

        # Write meta file (confidence scores)
        meta_output_file = meta_output_dir / f"{pdf_path.stem}_tables_meta.csv"
        meta_output_file.write_text(csv_meta_content)
        logger.success(f"Metadata written to {meta_output_file}")

    def _extract_tables(self, response: dict) -> tuple[str, str]:
        blocks = response['Blocks']
        blocks_map = {block['Id']: block for block in blocks}
        table_blocks = [block for block in blocks if block['BlockType'] == "TABLE"]

        if not table_blocks:
            logger.warning("No tables found in the document.")
            return "NO TABLES FOUND\n", "NO TABLES FOUND\n"

        csv_output = ""
        csv_meta_output = ""

        for index, table in enumerate(table_blocks):
            table_csv, table_meta_csv = self._generate_table_csv(table, blocks_map, index + 1)
            csv_output += table_csv + '\n\n'
            csv_meta_output += table_meta_csv + '\n\n'

        return csv_output.strip(), csv_meta_output.strip()

    def _generate_table_csv(self, table, blocks_map, table_index: int) -> tuple[str, str]:
        rows, scores = self._get_rows_columns_map(table, blocks_map)

        # Generate table data CSV (without headers or meta)
        data_csv = ""
        for row_index, cols in rows.items():
            row_text = ','.join(text.strip() for _, text in sorted(cols.items()))
            data_csv += f"{row_text}\n"

        # Generate metadata CSV (confidence scores only)
        meta_csv = ""
        col_count = 0
        for score in scores:
            meta_csv += f"{score},"
            col_count += 1
            if col_count == len(cols):
                meta_csv = meta_csv.rstrip(",") + "\n"
                col_count = 0

        return data_csv.strip(), meta_csv.strip()

    def _get_rows_columns_map(self, table, blocks_map):
        rows = {}
        scores = []
        for relationship in table.get('Relationships', []):
            if relationship['Type'] == 'CHILD':
                for child_id in relationship['Ids']:
                    cell = blocks_map[child_id]
                    if cell['BlockType'] == 'CELL':
                        row_index = cell['RowIndex']
                        col_index = cell['ColumnIndex']

                        if row_index not in rows:
                            rows[row_index] = {}

                        scores.append(f"{cell['Confidence']:.2f}")

                        text = self._get_text(cell, blocks_map)
                        rows[row_index][col_index] = text
        return rows, scores

    def _get_text(self, cell, blocks_map):
        text = ""
        for relationship in cell.get('Relationships', []):
            if relationship['Type'] == 'CHILD':
                for child_id in relationship['Ids']:
                    word = blocks_map[child_id]
                    if word['BlockType'] == 'WORD':
                        if "," in word['Text'] and word['Text'].replace(",", "").isnumeric():
                            text += f'"{word["Text"]}" '
                        else:
                            text += f"{word['Text']} "
                    elif word['BlockType'] == 'SELECTION_ELEMENT' and word['SelectionStatus'] == 'SELECTED':
                        text += "X "
        return text.strip()
