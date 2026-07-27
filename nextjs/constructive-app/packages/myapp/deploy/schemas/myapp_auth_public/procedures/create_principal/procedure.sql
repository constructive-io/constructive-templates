-- Deploy: schemas/myapp_auth_public/procedures/create_principal/procedure
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_users_public/tables/users/table
-- requires: schemas/myapp_auth_public/tables/principals/table
-- requires: schemas/myapp_logging_public/tables/audit_log_auth/table
-- requires: schemas/myapp_auth_public/tables/principal_entities/table
-- requires: schemas/myapp_memberships_private/tables/app_memberships_sprt/table


CREATE FUNCTION myapp_auth_public.create_principal(
  IN name text,
  IN use_admin_owner boolean DEFAULT true,
  IN entity_ids uuid[] DEFAULT NULL,
  IN is_read_only boolean DEFAULT false,
  IN bypass_step_up boolean DEFAULT true,
  OUT principal_id uuid
) RETURNS uuid AS $_PGFN_$
DECLARE
  v_user_id uuid;
  v_principal_user_id uuid;
  v_principal_id uuid;
BEGIN
  v_user_id := jwt_public.current_user_id();
  IF v_user_id IS NULL THEN
    RAISE EXCEPTION 'NOT_AUTHENTICATED';
  END IF;
  IF jwt_public.current_principal_id() <> v_user_id THEN
    RAISE EXCEPTION 'PRINCIPAL_CANNOT_CREATE_PRINCIPAL';
  END IF;
  v_principal_user_id := uuidv7();
  INSERT INTO myapp_users_public.users (
    id,
    type,
    username,
    display_name
  )
  VALUES
    (v_principal_user_id, 3, create_principal.name, create_principal.name);
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
    (v_principal_id, v_user_id, v_principal_user_id, create_principal.name, create_principal.use_admin_owner, create_principal.is_read_only, create_principal.bypass_step_up);
  IF create_principal.entity_ids IS NOT NULL THEN
    INSERT INTO myapp_auth_public.principal_entities (
      id,
      principal_id,
      entity_id,
      owner_id
    )
    SELECT
      uuidv7(),
      v_principal_id,
      unnest(create_principal.entity_ids),
      v_user_id;
  END IF;
  INSERT INTO myapp_logging_public.audit_log_auth (
    actor_id,
    event,
    success
  )
  VALUES
    (v_user_id, 'create_principal', true);
  SELECT v_principal_user_id INTO principal_id;
  RETURN;
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

