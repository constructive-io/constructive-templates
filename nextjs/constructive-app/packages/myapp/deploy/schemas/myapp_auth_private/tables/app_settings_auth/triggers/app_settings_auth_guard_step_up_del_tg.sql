-- Deploy: schemas/myapp_auth_private/tables/app_settings_auth/triggers/app_settings_auth_guard_step_up_del_tg
-- made with <3 @ constructive.io

-- requires: schemas/myapp_app_private/schema
-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/app_settings_auth/table
-- requires: schemas/myapp_app_private/trigger_fns/app_settings_auth_guard_step_up_del_fn


CREATE TRIGGER app_settings_auth_guard_step_up_del_tg
BEFORE DELETE ON myapp_auth_private.app_settings_auth
FOR EACH ROW
WHEN (OLD.created_at < (now() - '6 hours'::interval))
EXECUTE PROCEDURE myapp_app_private.app_settings_auth_guard_step_up_del_fn ( );

