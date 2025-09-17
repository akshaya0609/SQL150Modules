DROP TABLE IF EXISTS projects;
CREATE TABLE projects (
  id INT,
  project_number INT,
  source_system VARCHAR(20)
);
INSERT INTO projects (id, project_number, source_system) VALUES
(1, 1001, 'EagleEye'),
(2, 1001, 'SwiftLink'),
(3, 1001, 'DataVault'),
(4, 1002, 'SwiftLink'),
(5, 1003, 'DataVault'),
(6, 1004, 'EagleEye'),
(7, 1004, 'SwiftLink'),
(8, 1005, 'DataVault'),
(9, 1005, 'EagleEye'),
(10, 1006, 'EagleEye'),
(11, 1007, 'DataVault');

with cte as (
select id, project_number, source_system,
row_number() over (partition by project_number order by
case when source_system='EagleEye' then 1
     when source_system='SwiftLink' then 2
     when source_system='DataVault' then 3 end) as rn
from projects)
select c.id, c.project_number,c.source_system
from cte c
where rn=1
order by c.id;