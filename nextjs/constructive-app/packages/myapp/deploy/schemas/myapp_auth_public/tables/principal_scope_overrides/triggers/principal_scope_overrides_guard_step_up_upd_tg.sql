-- Deploy: schemas/myapp_auth_public/tables/principal_scope_overrides/triggers/principal_scope_overrides_guard_step_up_upd_tg
-- made with <3 @ constructive.io

-- requires: schemas/myapp_app_private/schema
-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principal_scope_overrides/table
-- requires: schemas/myapp_app_private/trigger_fns/principal_scope_overrides_guard_step_up_upd_fn


CREATE TRIGGER principal_scope_overrides_guard_step_up_upd_tg
BEFORE UPDATE ON myapp_auth_public.principal_scope_overrides
FOR EACH ROW
WHEN ((NEW.allowed_mask IS DISTINCT FROM OLD.allowed_mask OR NEW.use_admin_owner IS DISTINCT FROM OLD.use_admin_owner OR NEW.is_read_only IS DISTINCT FROM OLD.is_read_only) AND OLD.created_at < (now() - '6 hours'::interval))
EXECUTE PROCEDURE myapp_app_private.principal_scope_overrides_guard_step_up_upd_fn ( );

