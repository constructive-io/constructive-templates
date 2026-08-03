-- Deploy: schemas/myapp_auth_public/procedures/approve_device/procedure
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_store_private/schema
-- requires: schemas/myapp_auth_private/tables/auth_user_devices/table


CREATE FUNCTION myapp_auth_public.approve_device(
  IN approval_token text
) RETURNS boolean AS $_PGFN_$
DECLARE
  v_token_hash text;
  v_stored_user_id text;
  v_stored_device_hash text;
  v_created_at text;
BEGIN
  v_token_hash := encode(digest(approve_device.approval_token, 'sha256'), 'hex');
  v_stored_user_id := myapp_store_private.user_state_get(v_token_hash, 'device_approval_user_id');
  IF v_stored_user_id IS NULL THEN
    PERFORM errors.raise_error('INVALID_TOKEN', '{}', 'public');
  END IF;
  v_stored_device_hash := myapp_store_private.user_state_get(v_token_hash, 'device_approval_device_hash');
  v_created_at := myapp_store_private.user_state_get(v_token_hash, 'device_approval_created_at');
  IF v_created_at IS NOT NULL AND v_created_at::timestamptz < (now() - '15 minutes'::interval) THEN
    PERFORM myapp_store_private.user_state_del(v_token_hash, 'device_approval_user_id');
    PERFORM myapp_store_private.user_state_del(v_token_hash, 'device_approval_device_hash');
    PERFORM myapp_store_private.user_state_del(v_token_hash, 'device_approval_created_at');
    PERFORM errors.raise_error('EXPIRED_TOKEN', '{}', 'public');
  END IF;
  UPDATE myapp_auth_private.auth_user_devices AS ud SET
  is_approved = true, approved_at = now(), approval_method = 'email_link'
  WHERE
    ud.user_id = v_stored_user_id::uuid AND ud.device_token_hash = decode(v_stored_device_hash, 'hex');
  IF NOT (FOUND) THEN
    PERFORM errors.raise_error('DEVICE_NOT_FOUND', '{}', 'public');
  END IF;
  PERFORM myapp_store_private.user_state_del(v_token_hash, 'device_approval_user_id');
  PERFORM myapp_store_private.user_state_del(v_token_hash, 'device_approval_device_hash');
  PERFORM myapp_store_private.user_state_del(v_token_hash, 'device_approval_created_at');
  INSERT INTO myapp_logging_public.audit_log_auth (
    actor_id,
    event,
    success
  )
  VALUES
    (v_stored_user_id::uuid, 'approve_device', true);
  RETURN true;
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE STRICT SECURITY DEFINER;

