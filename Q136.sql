DROP TABLE IF EXISTS companies; 
CREATE TABLE companies (
    id INT,
    name VARCHAR(100),
    phone VARCHAR(50),
    is_promoted INT
);
INSERT INTO companies VALUES
(1, 'Wehner and Sons', '+86 (302) 414-2559', 0),
(2, 'Schaefer-Rogahn', '+33 (982) 752-6689', 0),
(3, 'King and Sons', '+51 (578) 555-1781', 1),
(4, 'Considine LLC', '+33 (487) 383-2644', 0),
(5, 'Parisian-Zieme', '+1 (399) 688-1824', 0),
(6, 'Renner and Parisian', '+7 (720) 699-2313', 0),
(7, 'Fadel and Fahey', '+86 (307) 777-1731', 1);
-- Categories table
DROP TABLE IF EXISTS categories;
CREATE TABLE categories (
    company_id INT,
    name VARCHAR(100),
    rating DECIMAL(3,1)
);
INSERT INTO categories VALUES
(1, 'Drilled Shafts', 5.0),
(1, 'Granite Surfaces', 3.0),
(1, 'Structural and Misc Steel', 0.0),
(2, 'Waterproofing & Caulking', 0.0),
(3, 'Drywall & Acoustical', 1.0),
(3, 'Electrical and Fire Alarm', 2.0),
(3, 'Drywall & Acoustical A', 3.0),
(4, 'Ornament Railings', 3.0),
(4, 'Exterior Signage', 0.0),
(4, 'Termite Control1', 3.0),
(4, 'Termite Control2', 1.0);

SELECT CASE WHEN c.is_promoted = 1 THEN CONCAT('[PROMOTED] ', c.name) ELSE c.name END AS name,
c.phone,
CASE WHEN c.is_promoted = 1 THEN NULL
ELSE CONCAT(
            FLOOR(AVG(cat.rating)), ' stars (',
            ROUND(AVG(cat.rating),1), ', based on ',
            COUNT(cat.rating), ' reviews)'
        )
END AS rating
FROM companies c
LEFT JOIN categories cat ON c.id = cat.company_id
GROUP BY c.id, c.name, c.phone, c.is_promoted
HAVING (c.is_promoted = 1 OR AVG(cat.rating) >= 1)
ORDER BY c.is_promoted DESC, AVG(cat.rating) DESC, COUNT(cat.rating) DESC;