
--  93,364  ( Belgium) 
select *
from mraeu.core_migration_data
where email_personal is not null;


--  892,752  ( UK, France, Germany)
select *
from mraeu.meg_core_migration_data
where email_personal is not null;

--  171,590 ( Switzerland and Sweden )
select *
from mraeu.eu_core_migration
where email_personal is not null;


