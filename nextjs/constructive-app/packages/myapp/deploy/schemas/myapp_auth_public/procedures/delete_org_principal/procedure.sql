-- Deploy: schemas/myapp_auth_public/procedures/delete_org_principal/procedure
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_users_public/tables/users/table
-- requires: schemas/myapp_auth_public/tables/principals/table
-- requires: schemas/myapp_logging_public/tables/audit_log_auth/table
-- requires: schemas/myapp_memberships_private/tables/org_memberships_sprt/table


CREATE FUNCTION myapp_auth_public.delete_org_principal(
  IN principal_id uuid,
  OUT success boolean
) RETURNS boolean AS $_PGFN_$
DECLARE
  v_user_id uuid;
  v_owner_id uuid;
  v_org_id uuid;
  v_is_admin boolean;
BEGIN
  v_user_id := jwt_public.current_user_id();
  IF v_user_id IS NULL THEN
    PERFORM errors.raise_error('NOT_AUTHENTICATED', '{}', 'public');
  END IF;
  IF jwt_public.current_principal_id() <> v_user_id THEN
    PERFORM errors.raise_error('PRINCIPAL_CANNOT_DELETE_PRINCIPAL', '{}', 'public');
  END IF;
  SELECT owner_id
  FROM myapp_auth_public.principals
  WHERE
    user_id = delete_org_principal.principal_id INTO v_owner_id;
  IF v_owner_id IS NULL THEN
    PERFORM errors.raise_error('PRINCIPAL_NOT_FOUND', '{}', 'public');
  END IF;
  SELECT entity_id
  FROM myapp_memberships_private.org_memberships_sprt
  WHERE
    actor_id = delete_org_principal.principal_id
  LIMIT
  1 INTO v_org_id;
  IF v_org_id IS NULL THEN
    PERFORM errors.raise_error('NOT_ORG_PRINCIPAL', '{}', 'public');
  END IF;
  SELECT is_admin
  FROM myapp_memberships_private.org_memberships_sprt
  WHERE
    actor_id = v_user_id AND entity_id = v_org_id INTO v_is_admin;
  IF v_is_admin IS NOT TRUE THEN
    PERFORM errors.raise_error('NOT_ORG_ADMIN', '{}', 'public');
  END IF;
  DELETE FROM myapp_users_public.users
  WHERE
    id = delete_org_principal.principal_id;
  INSERT INTO myapp_logging_public.audit_log_auth (
    actor_id,
    event,
    success
  )
  VALUES
    (v_user_id, 'delete_org_principal', true);
  SELECT true INTO success;
  RETURN;
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

