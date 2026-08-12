-- Deploy: schemas/myapp_auth_private/tables/auth_user_devices/triggers/timestamps_tg
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/auth_user_devices/table


CREATE TRIGGER timestamps_tg
BEFORE INSERT OR UPDATE ON myapp_auth_private.auth_user_devices
FOR EACH ROW
EXECUTE PROCEDURE stamps.timestamps ( );

