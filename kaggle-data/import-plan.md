Author - Taxonomy ()
    (from review node import)
Labels - Taxonomy
    (from tombstones import)
Genre - Taxonomy
    (from review node import)

Artists - Taxonomy+Fields:
artists.csv
    artist_id,
    name,
    artist_url

Tombstones Paragraph (rename):
    review_tombstone_id,
    review_url,
    picker_index,
    title,
    score,
    best_new_music,
    best_new_reissue,
    labels,
    years


Review - Node:
titles,
tombstone_ids,
artist_ids,
genres,
authors,
review_url,
is_standard_review,
pub_date,
body