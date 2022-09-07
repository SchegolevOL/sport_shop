create view vw_workers
as select last_name, first_name,patronymic
from tab_workers
join tab_human_name
on tab_human_name.id_human_name = tab_workers.id_worker_name;