-- Jira EUBO-47 Data Fixtest-24
-- Steve Gibby 22/11/2018
UPDATE MRAEU.CORE_MIGRATION_DATA c
   SET processed_flag = 'N',
       log_desc = NULL,
       gender = NULL
 WHERE gender is NOT NULL
   AND gender = 'U';

UPDATE MRAEU.CORE_MIGRATION_DATA c
   SET processed_flag = 'Y',
       log_desc = NULL,
       gender = NULL
 WHERE gender is NOT NULL
   AND gender = 'U';
   
COMMIT;

--learn-1
ROLLBACK;

