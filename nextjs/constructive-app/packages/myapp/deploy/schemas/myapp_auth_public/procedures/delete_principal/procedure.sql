-- Deploy: schemas/myapp_auth_public/procedures/delete_principal/procedure
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_users_public/tables/users/table
-- requires: schemas/myapp_auth_public/tables/principals/table
-- requires: schemas/myapp_logging_public/tables/audit_log_auth/table


CREATE FUNCTION myapp_auth_public.delete_principal(
  IN principal_id uuid,
  OUT success boolean
) RETURNS boolean AS $_PGFN_$
DECLARE
  v_user_id uuid;
  v_owner_id uuid;
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
    user_id = delete_principal.principal_id INTO v_owner_id;
  IF v_owner_id IS NULL THEN
    PERFORM errors.raise_error('PRINCIPAL_NOT_FOUND', '{}', 'public');
  END IF;
  IF v_owner_id <> v_user_id THEN
    PERFORM errors.raise_error('NOT_OWNER', '{}', 'public');
  END IF;
  DELETE FROM myapp_users_public.users
  WHERE
    id = delete_principal.principal_id;
  INSERT INTO myapp_logging_public.audit_log_auth (
    actor_id,
    event,
    success
  )
  VALUES
    (v_user_id, 'delete_principal', true);
  SELECT true INTO success;
  RETURN;
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

