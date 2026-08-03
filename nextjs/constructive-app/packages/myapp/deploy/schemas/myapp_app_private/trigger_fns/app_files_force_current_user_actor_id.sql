-- Deploy: schemas/myapp_app_private/trigger_fns/app_files_force_current_user_actor_id
-- made with <3 @ constructive.io

-- requires: schemas/myapp_app_private/schema


CREATE FUNCTION myapp_app_private.app_files_force_current_user_actor_id() RETURNS TRIGGER AS $_PGFN_$
BEGIN
  IF jwt_public.current_user_id() IS NOT NULL THEN
    SELECT jwt_public.current_user_id() INTO NEW.actor_id;
  END IF;
  RETURN NEW;
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE;

