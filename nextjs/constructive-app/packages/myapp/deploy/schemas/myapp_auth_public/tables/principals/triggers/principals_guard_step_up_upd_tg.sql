-- Deploy: schemas/myapp_auth_public/tables/principals/triggers/principals_guard_step_up_upd_tg
-- made with <3 @ constructive.io

-- requires: schemas/myapp_app_private/schema
-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principals/table
-- requires: schemas/myapp_app_private/trigger_fns/principals_guard_step_up_upd_fn


CREATE TRIGGER principals_guard_step_up_upd_tg
BEFORE UPDATE ON myapp_auth_public.principals
FOR EACH ROW
WHEN ((NEW.owner_id IS DISTINCT FROM OLD.owner_id OR NEW.use_admin_owner IS DISTINCT FROM OLD.use_admin_owner OR NEW.is_read_only IS DISTINCT FROM OLD.is_read_only OR NEW.bypass_step_up IS DISTINCT FROM OLD.bypass_step_up) AND OLD.created_at < (now() - '6 hours'::interval))
EXECUTE PROCEDURE myapp_app_private.principals_guard_step_up_upd_fn ( );

