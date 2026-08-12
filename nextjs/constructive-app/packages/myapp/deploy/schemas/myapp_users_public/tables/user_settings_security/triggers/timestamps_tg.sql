-- Deploy: schemas/myapp_users_public/tables/user_settings_security/triggers/timestamps_tg
-- made with <3 @ constructive.io

-- requires: schemas/myapp_users_public/schema
-- requires: schemas/myapp_users_public/tables/user_settings_security/table


CREATE TRIGGER timestamps_tg
BEFORE INSERT OR UPDATE ON myapp_users_public.user_settings_security
FOR EACH ROW
EXECUTE PROCEDURE stamps.timestamps ( );

