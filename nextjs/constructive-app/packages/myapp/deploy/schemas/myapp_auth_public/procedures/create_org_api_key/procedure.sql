-- Deploy: schemas/myapp_auth_public/procedures/create_org_api_key/procedure
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_private/tables/sessions/table
-- requires: schemas/myapp_auth_private/tables/app_settings_auth/table
-- requires: schemas/myapp_auth_private/tables/session_credentials/table


CREATE FUNCTION myapp_auth_public.create_org_api_key(
  IN org_id uuid,
  IN principal_id uuid,
  IN key_name text DEFAULT NULL,
  IN access_level text DEFAULT 'full_access',
  IN mfa_level text DEFAULT 'none',
  IN expires_in interval DEFAULT NULL,
  OUT api_key text,
  OUT key_id uuid,
  OUT expires_at timestamptz
) RETURNS record AS $_PGFN_$
DECLARE
  v_user_id uuid;
  v_session_id uuid;
  v_credential_id uuid;
  v_plaintext_key text;
  v_settings myapp_auth_private.app_settings_auth;
  v_count int := 0;
  v_effective_duration interval;
  v_expires_at timestamptz;
  v_owner_id uuid;
BEGIN
  v_user_id := jwt_public.current_user_id();
  IF v_user_id IS NULL THEN
    PERFORM errors.raise_error('NOT_AUTHENTICATED', '{}', 'public');
  END IF;
  IF jwt_public.current_principal_id() <> v_user_id THEN
    PERFORM errors.raise_error('PRINCIPAL_CANNOT_CREATE_API_KEY', '{}', 'public');
  END IF;
  v_settings := myapp_auth_private.auth_settings();
  IF NOT (COALESCE(v_settings.allow_api_keys, true)) THEN
    PERFORM errors.raise_error('API_KEYS_DISABLED', '{}', 'public');
  END IF;
  IF create_org_api_key.access_level <> 'full_access' AND create_org_api_key.access_level <> 'read_only' THEN
    PERFORM errors.raise_error('INVALID_ACCESS_LEVEL', '{}', 'public');
  END IF;
  IF create_org_api_key.mfa_level <> 'none' AND create_org_api_key.mfa_level <> 'verified' THEN
    PERFORM errors.raise_error('INVALID_MFA_LEVEL', '{}', 'public');
  END IF;
  SELECT p.owner_id
  FROM myapp_auth_public.principals AS p
  WHERE
    p.user_id = create_org_api_key.principal_id INTO v_owner_id;
  IF v_owner_id IS NULL THEN
    PERFORM errors.raise_error('PRINCIPAL_NOT_FOUND', '{}', 'public');
  END IF;
  IF v_owner_id <> create_org_api_key.org_id THEN
    PERFORM errors.raise_error('PRINCIPAL_NOT_IN_ORG', '{}', 'public');
  END IF;
  SELECT count(*)
  FROM myapp_auth_private.session_credentials AS c
  WHERE
    (c.principal_id = create_org_api_key.principal_id AND c.kind = 'api_key') AND c.revoked_at IS NULL INTO v_count;
  IF NOT (v_count < (COALESCE(v_settings.api_key_max_per_user, 10))) THEN
    PERFORM errors.raise_error('API_KEY_LIMIT_REACHED', '{}', 'public');
  END IF;
  v_effective_duration := COALESCE(create_org_api_key.expires_in, v_settings.api_key_default_duration, '90 days'::interval);
  IF v_settings.api_key_max_duration IS NOT NULL AND v_effective_duration > v_settings.api_key_max_duration THEN
    v_effective_duration := v_settings.api_key_max_duration;
  END IF;
  v_expires_at := now() + v_effective_duration;
  v_session_id := uuidv7();
  v_plaintext_key := (CASE 
    WHEN 'api_key' = 'api_key' THEN 'cnc_live_sk_' 
    WHEN 'api_key' = 'bearer' THEN 'cnc_live_bt_' 
    WHEN 'api_key' = 'access_token' THEN 'cnc_live_at_' 
    WHEN 'api_key' = 'mfa_challenge' THEN 'cnc_live_mfa_' 
    WHEN 'api_key' = 'one_time' THEN 'cnc_live_ot_' 
    WHEN 'api_key' = 'webauthn' THEN 'cnc_live_wa_' 
    ELSE 'cnc_live_tk_' 
  END) || translate(encode(gen_random_bytes(24), 'base64'), '+/=', '-_');
  v_credential_id := uuidv7();
  PERFORM myapp_auth_private.mint_org_credential(v_session_id, v_credential_id, create_org_api_key.org_id, create_org_api_key.principal_id, digest(v_plaintext_key, 'sha256'), create_org_api_key.mfa_level, create_org_api_key.access_level, v_expires_at, create_org_api_key.key_name, v_user_id);
  SELECT v_plaintext_key INTO api_key;
  SELECT v_credential_id INTO key_id;
  SELECT v_expires_at INTO expires_at;
  RETURN;
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE SECURITY INVOKER;

