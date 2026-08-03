-- Deploy: schemas/myapp_auth_public/tables/principal_scope_overrides/triggers/principal_scope_overrides_guard_step_up_del_tg
-- made with <3 @ constructive.io

-- requires: schemas/myapp_app_private/schema
-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principal_scope_overrides/table
-- requires: schemas/myapp_app_private/trigger_fns/principal_scope_overrides_guard_step_up_del_fn


CREATE TRIGGER principal_scope_overrides_guard_step_up_del_tg
BEFORE DELETE ON myapp_auth_public.principal_scope_overrides
FOR EACH ROW
WHEN (OLD.created_at < (now() - '6 hours'::interval))
EXECUTE PROCEDURE myapp_app_private.principal_scope_overrides_guard_step_up_del_fn ( );

