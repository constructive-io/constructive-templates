-- Deploy: schemas/myapp_auth_private/procedures/rotate_identity_provider_app_secret/procedure
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/identity_providers/table
-- requires: schemas/myapp_store_private/tables/app_internal_secrets/table


CREATE FUNCTION myapp_auth_private.rotate_identity_provider_app_secret(
  IN provider_id uuid,
  IN new_secret text
) RETURNS boolean AS $_PGFN_$
DECLARE
  v_secret_id uuid;
  v_slug text;
  v_namespace_id uuid;
BEGIN
  SELECT
    client_secret_id,
    slug
  FROM myapp_auth_private.identity_providers
  WHERE
    id = rotate_identity_provider_app_secret.provider_id INTO v_secret_id, v_slug;
  IF NOT (FOUND) THEN
    RAISE EXCEPTION 'IDENTITY_PROVIDER_NOT_FOUND';
  END IF;
  v_namespace_id := uuid_nil();
  IF v_secret_id IS NULL THEN
    INSERT INTO myapp_store_private.app_internal_secrets (
      namespace_id,
      name,
      value,
      algo
    )
    VALUES
      (v_namespace_id, v_slug || '/client-secret', rotate_identity_provider_app_secret.new_secret::bytea, 'pgp')
    RETURNING * INTO v_secret_id;
    UPDATE myapp_auth_private.identity_providers SET
    client_secret_id = v_secret_id
    WHERE
      id = rotate_identity_provider_app_secret.provider_id;
  ELSE
    UPDATE myapp_store_private.app_internal_secrets SET
    value = rotate_identity_provider_app_secret.new_secret::bytea, algo = 'pgp'
    WHERE
      id = v_secret_id;
  END IF;
  RETURN true;
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE STRICT SECURITY DEFINER;

