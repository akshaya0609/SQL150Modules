DROP TABLE IF EXISTS relations;
DROP TABLE IF EXISTS people;

CREATE TABLE people (
  id     INT PRIMARY KEY,
  name   VARCHAR(20),
  gender CHAR(1)          -- 'F' or 'M'
);

INSERT INTO people (id,name,gender) VALUES
(107,'Days','F'),
(145,'Hawbaker','M'),
(155,'Hansel','F'),
(202,'Blackston','M'),
(227,'Criss','F'),
(278,'Keffer','M'),
(305,'Canty','M'),
(329,'Mozingo','M'),
(425,'Nolf','M'),
(534,'Waugh','M');        -- note: parent id 586 will be missing on purpose

CREATE TABLE relations (
  c_id INT,  -- child
  p_id INT   -- parent
);
INSERT INTO relations (c_id,p_id) VALUES
(145,202),(145,107),   -- Hawbaker -> father Blackston, mother Days
(278,305),(278,155),   -- Keffer   -> father Canty,     mother Hansel
(329,425),(329,227),   -- Mozingo  -> father Nolf,      mother Criss
(534,586);             -- Waugh    -> parent missing in people

SELECT
  child.name AS child_name,
  MAX(CASE WHEN parent.gender = 'F' THEN parent.name END) AS mother_name,
  MAX(CASE WHEN parent.gender = 'M' THEN parent.name END) AS father_name
FROM relations r
JOIN people child
  ON child.id = r.c_id
LEFT JOIN people parent
  ON parent.id = r.p_id              
GROUP BY child.name
ORDER BY child.name;