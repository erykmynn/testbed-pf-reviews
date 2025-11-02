#! /bin/zsh
SCRIPT_DIR="${0:A:h}"
echo $SCRIPT_DIR
DB_FILE="$SCRIPT_DIR/data.sqlite3"
#optional limiter, for prod set to ""
limit_opt="LIMIT 50"

#db filecheck
if [[ ! -f "$DB_FILE" ]]; then
    echo "Error: Database file '$DB_FILE' not found."
    exit 1
fi

mkdir -p "$SCRIPT_DIR/csv"

# THIS IS THE EXECUTION function
function sqlcsv_call() {
    # echo $query $limit_opt;
sqlite3 "$DB_FILE" <<EOF
.headers on
.mode csv
.output "$SCRIPT_DIR/csv/$output_file"
$query $limit_opt;
.output stdout
EOF
unset output_file
unset query 
}

# output_file="test.csv"
# query="select * from reviews_flat where review_url = '/reviews/albums/11121-the-assassination-of-jesse-james-by-the-coward-robert-ford/' $limit_opt"

#Artists
output_file="artists.csv"
query="SELECT * FROM artists"
sqlcsv_call

#Tombstones
output_file="tombstones.csv"
query="WITH TombstoneLabels AS (
    SELECT
        review_tombstone_id,
        JSON_GROUP_ARRAY(label) AS labels
    FROM
        tombstone_label_map
    GROUP BY
        review_tombstone_id
),
TombstoneYears AS (
    SELECT
        review_tombstone_id,
        JSON_GROUP_ARRAY(release_year) AS years
    FROM
        tombstone_release_year_map
    GROUP BY
        review_tombstone_id
)
SELECT
    T.*,
    L.labels,
    Y.years
FROM
    TOMBSTONES AS T
LEFT JOIN
    TombstoneLabels AS L ON T.review_tombstone_id = L.review_tombstone_id
LEFT JOIN
    TombstoneYears AS Y ON T.review_tombstone_id = Y.review_tombstone_id"
sqlcsv_call

#reviews
output_file="reviews.csv"
query="WITH TombstoneInfo AS (
    SELECT
        T1.review_url,
        GROUP_CONCAT(T1.title, ' / ') AS titles,
        GROUP_CONCAT(T1.review_tombstone_id) AS tombstone_ids
    FROM (
        SELECT
            review_url,
            title,
            review_tombstone_id
        FROM
            tombstones
        ORDER BY
            review_url, picker_index ASC
    ) AS T1
    GROUP BY
        T1.review_url
),
ArtistGroup AS (
    SELECT
        review_url,
        JSON_GROUP_ARRAY(artist_id) AS artist_ids
    FROM
        artist_review_map
    GROUP BY
        review_url
),
GenreGroup AS (
    SELECT
        review_url,
        JSON_GROUP_ARRAY(genre) AS genres
    FROM
        genre_review_map
    GROUP BY
        review_url
),
AuthorGroup AS (
    SELECT
        review_url,
        JSON_GROUP_ARRAY(author) AS authors
    FROM
        author_review_map
    GROUP BY
        review_url
)
SELECT
    T.titles,
    T.tombstone_ids,
    A.artist_ids,
    G.genres,
    Au.authors,
    R.*
FROM
    reviews AS R
LEFT JOIN
    TombstoneInfo AS T ON R.review_url = T.review_url
LEFT JOIN
    ArtistGroup AS A ON R.review_url = A.review_url
LEFT JOIN
    GenreGroup AS G ON R.review_url = G.review_url
LEFT JOIN
    AuthorGroup AS Au ON R.review_url = Au.review_url"
sqlcsv_call