-- Deploy: schemas/myapp_auth_public/procedures/revoke_org_api_key/procedure
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_private/tables/sessions/table
-- requires: schemas/myapp_auth_private/tables/session_credentials/table


CREATE FUNCTION myapp_auth_public.revoke_org_api_key(
  IN key_id uuid,
  IN org_id uuid
) RETURNS boolean AS $_PGFN_$
DECLARE
  v_user_id uuid;
  v_session_id uuid;
  v_principal_id uuid;
  v_owner_id uuid;
BEGIN
  v_user_id := jwt_public.current_user_id();
  IF v_user_id IS NULL THEN
    PERFORM errors.raise_error('NOT_AUTHENTICATED', '{}', 'public');
  END IF;
  IF jwt_public.current_principal_id() <> v_user_id THEN
    PERFORM errors.raise_error('PRINCIPAL_CANNOT_REVOKE_API_KEY', '{}', 'public');
  END IF;
  SELECT
    sc.session_id,
    sc.principal_id
  FROM myapp_auth_private.session_credentials AS sc
  WHERE
    ((sc.id = revoke_org_api_key.key_id AND sc.kind = 'api_key') AND sc.org_id = revoke_org_api_key.org_id) AND sc.principal_id IS NOT NULL INTO v_session_id, v_principal_id;
  IF v_session_id IS NULL THEN
    PERFORM errors.raise_error('ORG_API_KEY_NOT_FOUND', '{}', 'public');
  END IF;
  SELECT p.owner_id
  FROM myapp_auth_public.principals AS p
  WHERE
    p.user_id = v_principal_id INTO v_owner_id;
  IF v_owner_id IS NULL THEN
    PERFORM errors.raise_error('ORG_API_KEY_NOT_FOUND', '{}', 'public');
  END IF;
  PERFORM myapp_auth_private.revoke_org_credential(revoke_org_api_key.key_id, v_session_id, v_user_id);
  RETURN true;
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE STRICT SECURITY INVOKER;

