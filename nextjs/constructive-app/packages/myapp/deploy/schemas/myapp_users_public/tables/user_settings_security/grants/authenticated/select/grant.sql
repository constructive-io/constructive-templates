-- Deploy: schemas/myapp_users_public/tables/user_settings_security/grants/authenticated/select/grant
-- made with <3 @ constructive.io

-- requires: schemas/myapp_users_public/schema
-- requires: schemas/myapp_users_public/tables/user_settings_security/table


GRANT SELECT ON myapp_users_public.user_settings_security TO authenticated;

