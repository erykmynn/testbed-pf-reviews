
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

