-- Deploy: schemas/myapp_memberships_public/trigger_fns/app_membership_defaults_peoplestamps
-- made with <3 @ constructive.io

-- requires: schemas/myapp_memberships_public/schema


CREATE FUNCTION myapp_memberships_public.app_membership_defaults_peoplestamps() RETURNS TRIGGER AS $_PGFN_$
BEGIN
  IF TG_OP = 'INSERT' THEN
    SELECT jwt_public.current_user_id() INTO NEW.created_by;
    SELECT jwt_public.current_user_id() INTO NEW.updated_by;
  ELSIF TG_OP = 'UPDATE' THEN
    SELECT OLD.created_by INTO NEW.created_by;
    SELECT jwt_public.current_user_id() INTO NEW.updated_by;
  END IF;
  RETURN NEW;
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE;

