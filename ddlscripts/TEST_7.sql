-- Jira EUBO-47 Data Fixtest-22
-- Steve Gibby 22/11/2018
UPDATE MRAEU.CORE_MIGRATION_DATA c
   SET processed_flag = 'N',
       log_desc = NULL,
       gender = NULL
 WHERE gender is NOT NULL
   AND gender = 'U';
   
COMMIT;
