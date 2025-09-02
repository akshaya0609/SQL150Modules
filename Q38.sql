DROP TABLE IF EXISTS product_reviews;
CREATE TABLE product_reviews (
    review_id   INT PRIMARY KEY,
    product_id  INT NOT NULL,
    review_text VARCHAR(40) NOT NULL
);
INSERT INTO product_reviews (review_id, product_id, review_text) VALUES
(1, 101, 'The product is excellent!'),
(2, 102, 'This product is Amazing.'),
(3, 103, 'Not an excellent product.'),
(4, 104, 'The quality is Excellent.'),
(5, 105, 'An amazing product!'),
(6, 106, 'This is not an amazing product.'),
(7, 107, 'This product is not Excellent.'),
(8, 108, 'This is a not excellent product.'),
(9, 109, 'The product is not amazing.'),
(10,110, 'An excellent product, not amazing.'),
(11,101, 'A good product');

select review_id,product_id,review_text from product_reviews
where (lower(review_text) like '%excellent%' or lower(review_text) like '%amazing%' and 
lower(review_text) not like '%not amazing%' and lower(review_text) not like '%not excellent%' )
order by review_id;
