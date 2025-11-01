


Label - taxo (from tombstones import)

Tombstones Paragraph (rename):
+ label (serial) from tombstone_label_map
+ year (serial) from tombstone_release_year_map


Artists - Taxo:
artists
    name
    artist_url
    artist_id

Author - Taxo (from main node)
Genre - Taxo (from main node)

Main Node:
reviews_flat
+ artist_id (serial) from artist_review_map
+ review_tombstone_id (serial) from tombstones
y    0|review_url|varchar|0||0
y    1|is_standard_review|boolean|0||0
    2|artist_count||0||0
    3|artists||0||0
y    4|title||0||0
    5|score||0||0
    6|best_new_music||0||0
    7|best_new_reissue||0||0
y    8|authors||0||0
y    9|genres||0||0
    10|labels||0||0
y    11|pub_date|datetime|0||0
    12|release_year||0||0
y    13|body|TEXT|0||0





noteS:
finding multiples:

SELECT
    review_url,
    COUNT(DISTINCT review_tombstone_id) AS review_count
FROM
    tombstones
GROUP BY
    review_url
HAVING
    COUNT(DISTINCT review_tombstone_id) > 1;

