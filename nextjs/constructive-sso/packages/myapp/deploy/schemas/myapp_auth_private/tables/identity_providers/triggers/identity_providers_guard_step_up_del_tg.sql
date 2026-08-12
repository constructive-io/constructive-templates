-- Deploy: schemas/myapp_auth_private/tables/identity_providers/triggers/identity_providers_guard_step_up_del_tg
-- made with <3 @ constructive.io

-- requires: schemas/myapp_app_private/schema
-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/identity_providers/table
-- requires: schemas/myapp_app_private/trigger_fns/identity_providers_guard_step_up_del_fn


CREATE TRIGGER identity_providers_guard_step_up_del_tg
BEFORE DELETE ON myapp_auth_private.identity_providers
FOR EACH ROW
WHEN (OLD.created_at < (now() - '6 hours'::interval))
EXECUTE PROCEDURE myapp_app_private.identity_providers_guard_step_up_del_fn ( );

