select count(*) from (
SELECT /*+ NO_CPU_COSTING */
                       DISTINCT UPPER(REPLACE(ua.zip_code, ' ')) zip_code,
                                u.date_of_birth,
                                u.user_id,
                                u.country_id,
                                LOWER(uc.contact_info) email_address
                  FROM mraeu.user_address ua,
                       mraeu.users u,
                       mraeu.user_contact uc
                 WHERE u.user_id = ua.user_id
                   AND u.country_id = ua.country_id
                   AND EXISTS (SELECT NULL FROM MRAEU.SUBSCRIPTION S WHERE S.USER_ID = U.USER_ID AND S.COUNTRY_ID = U.COUNTRY_ID)
                   AND ua.obsolete_flag = 'N'
                   AND ua.address_type_id = CASE
                                                WHEN u.country_id = 5 THEN 1
                                                WHEN u.country_id = 6 THEN 3
                                                WHEN u.country_id = 15 THEN 5
                                            END
                   AND u.user_id = uc.user_id
                   AND u.country_id = uc.country_id
                   AND uc.contact_type_id = 4
                   AND u.user_status_type_id = 1
                   AND u.member_type_id = 7
                   AND u.ww_uuid IS NULL /* EUBO-350 */
                   AND (u.last_upd_by NOT LIKE 'link_mp_to_dotcom%' OR TRUNC(u.last_upd_date) <> TRUNC(SYSDATE))
                   );