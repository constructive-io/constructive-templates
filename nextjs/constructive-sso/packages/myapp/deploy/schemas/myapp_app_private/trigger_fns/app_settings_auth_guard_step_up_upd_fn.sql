-- Deploy: schemas/myapp_app_private/trigger_fns/app_settings_auth_guard_step_up_upd_fn
-- made with <3 @ constructive.io

-- requires: schemas/myapp_app_private/schema


CREATE FUNCTION myapp_app_private.app_settings_auth_guard_step_up_upd_fn() RETURNS TRIGGER AS $_PGFN_$
BEGIN
  PERFORM myapp_auth_public.require_step_up('mfa');
  RETURN NEW;
END;
$_PGFN_$ LANGUAGE plpgsql STABLE SECURITY DEFINER;

