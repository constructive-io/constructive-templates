-- Deploy: schemas/myapp_store_private/procedures/app_internal_secrets_verify/procedure
-- made with <3 @ constructive.io

-- requires: schemas/myapp_store_private/schema
-- requires: schemas/myapp_store_private/tables/app_internal_secrets/table


CREATE FUNCTION myapp_store_private.app_internal_secrets_verify(
  IN secret_name text,
  IN value text,
  IN namespace_id uuid
) RETURNS boolean AS $_PGFN_$
DECLARE
  v_secret_text text;
  v_secret myapp_store_private.app_internal_secrets;
BEGIN
  SELECT myapp_store_private.app_internal_secrets_get(app_internal_secrets_verify.secret_name, NULL::text, app_internal_secrets_verify.namespace_id) INTO v_secret_text;
  SELECT *
  FROM myapp_store_private.app_internal_secrets AS s
  WHERE
    (s.namespace_id = app_internal_secrets_verify.namespace_id AND s.name = app_internal_secrets_verify.secret_name) AND s.retired_at IS NULL INTO v_secret;
  IF v_secret.algo = 'crypt' THEN
    RETURN v_secret_text = public.crypt(app_internal_secrets_verify.value::bytea::text, v_secret_text);
  ELSIF v_secret.algo = 'pgp' THEN
    RETURN app_internal_secrets_verify.value = v_secret_text;
  END IF;
  RETURN app_internal_secrets_verify.value = v_secret_text;
END;
$_PGFN_$ LANGUAGE plpgsql STABLE;

