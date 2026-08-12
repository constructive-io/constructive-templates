-- Deploy: schemas/myapp_store_public/procedures/app_internal_secrets_set/procedure
-- made with <3 @ constructive.io

-- requires: schemas/myapp_store_public/schema
-- requires: schemas/myapp_store_private/tables/app_internal_secrets/table


CREATE FUNCTION myapp_store_public.app_internal_secrets_set(
  IN secret_name text,
  IN secret_value text,
  IN secret_namespace_id uuid,
  IN algo text DEFAULT 'pgp',
  IN secret_realm text DEFAULT NULL
) RETURNS boolean AS $_PGFN_$
BEGIN
  INSERT INTO myapp_store_private.app_internal_secrets (
    namespace_id,
    name,
    value,
    algo,
    realm
  )
  VALUES
    (app_internal_secrets_set.secret_namespace_id, app_internal_secrets_set.secret_name, app_internal_secrets_set.secret_value::bytea, app_internal_secrets_set.algo, app_internal_secrets_set.secret_realm)
  ON CONFLICT (namespace_id, name, realm) WHERE retired_at IS NULL DO UPDATE SET
  value = app_internal_secrets_set.secret_value::bytea, algo = EXCLUDED.algo;
  RETURN true;
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE;

