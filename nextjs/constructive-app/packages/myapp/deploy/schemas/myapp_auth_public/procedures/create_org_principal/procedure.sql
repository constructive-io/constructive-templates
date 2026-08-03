-- Deploy: schemas/myapp_auth_public/procedures/create_org_principal/procedure
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_users_public/tables/users/table
-- requires: schemas/myapp_auth_public/tables/principals/table
-- requires: schemas/myapp_logging_public/tables/audit_log_auth/table
-- requires: schemas/myapp_memberships_private/tables/org_memberships_sprt/table


CREATE FUNCTION myapp_auth_public.create_org_principal(
  IN name text,
  IN org_id uuid,
  IN use_admin_owner boolean DEFAULT true,
  IN is_read_only boolean DEFAULT false,
  IN bypass_step_up boolean DEFAULT false,
  OUT principal_id uuid
) RETURNS uuid AS $_PGFN_$
DECLARE
  v_user_id uuid;
  v_principal_user_id uuid;
  v_principal_id uuid;
  v_org_type int;
  v_is_admin boolean;
BEGIN
  v_user_id := jwt_public.current_user_id();
  IF v_user_id IS NULL THEN
    PERFORM errors.raise_error('NOT_AUTHENTICATED', '{}', 'public');
  END IF;
  IF jwt_public.current_principal_id() <> v_user_id THEN
    PERFORM errors.raise_error('PRINCIPAL_CANNOT_CREATE_PRINCIPAL', '{}', 'public');
  END IF;
  SELECT type
  FROM myapp_users_public.users
  WHERE
    id = create_org_principal.org_id INTO v_org_type;
  IF v_org_type IS NULL OR v_org_type <> 2 THEN
    PERFORM errors.raise_error('INVALID_ORGANIZATION', '{}', 'public');
  END IF;
  SELECT is_admin
  FROM myapp_memberships_private.org_memberships_sprt
  WHERE
    actor_id = v_user_id AND entity_id = create_org_principal.org_id INTO v_is_admin;
  IF v_is_admin IS NOT TRUE THEN
    PERFORM errors.raise_error('NOT_ORG_ADMIN', '{}', 'public');
  END IF;
  v_principal_user_id := uuidv7();
  INSERT INTO myapp_users_public.users (
    id,
    type,
    username,
    display_name
  )
  VALUES
    (v_principal_user_id, 3, create_org_principal.name, create_org_principal.name);
  v_principal_id := uuidv7();
  INSERT INTO myapp_auth_public.principals (
    id,
    owner_id,
    user_id,
    name,
    use_admin_owner,
    is_read_only,
    bypass_step_up
  )
  VALUES
    (v_principal_id, v_user_id, v_principal_user_id, create_org_principal.name, create_org_principal.use_admin_owner, create_org_principal.is_read_only, create_org_principal.bypass_step_up);
  UPDATE myapp_memberships_private.org_memberships_sprt SET
  is_admin = v_is_admin
  WHERE
    actor_id = v_user_id AND entity_id = create_org_principal.org_id;
  INSERT INTO myapp_logging_public.audit_log_auth (
    actor_id,
    event,
    success
  )
  VALUES
    (v_user_id, 'create_org_principal', true);
  SELECT v_principal_user_id INTO principal_id;
  RETURN;
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

