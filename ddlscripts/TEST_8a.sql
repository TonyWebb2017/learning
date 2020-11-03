SELECT COUNTRY_ID
FROM MRAEU.EU_CORE_MIGRATION
GROUP BY COUNTRY_ID;

select count(*),country_id
from mraeu.users
where ww_uuid is null
and member_type_id = 7
and user_status_type_id = 1 group by country_id;

select count(*)
from mraeu.users u 
where ww_uuid is null
and member_type_id in ( 7,14)
and user_status_type_id = 1
--and country_id = 6
and uuid_match_source is  null
and not exists (select null from mraeu.subscription s where s.user_id = u.user_id and s.country_id = u.country_id);