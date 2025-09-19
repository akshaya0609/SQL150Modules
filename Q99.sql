CREATE TABLE entries (
    emp_name VARCHAR(10),
    address VARCHAR(10),
    floor INT,
    resources VARCHAR(10)
);
INSERT INTO entries (emp_name, address, floor, resources) VALUES
('Ankit', 'Bangalore', 1, 'CPU'),
('Ankit', 'Bangalore', 1, 'CPU'),
('Ankit', 'Bangalore', 2, 'DESKTOP'),
('Bikaas', 'Bangalore', 2, 'DESKTOP'),
('Bikaas', 'Bangalore', 2, 'DESKTOP'),
('Bikaas', 'Bangalore', 1, 'MONITOR');

SELECT e.emp_name,
       COUNT(*) AS total_visits,
       (SELECT floor
        FROM entries e2
        WHERE e2.emp_name = e.emp_name
        GROUP BY floor
        ORDER BY COUNT(*) DESC
        LIMIT 1) AS most_visited_floor,
       GROUP_CONCAT(DISTINCT resources ORDER BY resources) AS resources_used
FROM entries e
GROUP BY e.emp_name
ORDER BY e.emp_name;
