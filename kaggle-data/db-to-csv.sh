#! /bin/zsh
SCRIPT_DIR="${0:A:h}"
echo $SCRIPT_DIR
DB_FILE="$SCRIPT_DIR/data.sqlite3"

if [[ ! -f "$DB_FILE" ]]; then
    echo "Error: Database file '$DB_FILE' not found."
    exit 1
fi

echo "ok"

output_file="test.csv"
query="select * from reviews_flat where review_url = '/reviews/albums/11121-the-assassination-of-jesse-james-by-the-coward-robert-ford/' limit 5"

sqlite3 "$DB_FILE" <<EOF
.headers on
.mode csv
.output "$SCRIPT_DIR/$output_file"
$query;
.output stdout
EOF