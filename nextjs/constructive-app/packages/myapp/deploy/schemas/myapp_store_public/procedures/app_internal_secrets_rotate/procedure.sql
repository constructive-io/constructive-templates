-- Deploy: schemas/myapp_store_public/procedures/app_internal_secrets_rotate/procedure
-- made with <3 @ constructive.io

-- requires: schemas/myapp_store_public/schema
-- requires: schemas/myapp_store_private/tables/app_internal_secrets/table


CREATE FUNCTION myapp_store_public.app_internal_secrets_rotate(
  IN secret_name text,
  IN secret_value text,
  IN namespace_id uuid,
  IN algo text DEFAULT 'pgp',
  IN realm text DEFAULT NULL
) RETURNS boolean AS $_PGFN_$
BEGIN
  UPDATE myapp_store_private.app_internal_secrets AS s SET
  retired_at = pg_catalog.now()
  WHERE
    s.realm IS NOT DISTINCT FROM app_internal_secrets_rotate.realm AND ((s.namespace_id = app_internal_secrets_rotate.namespace_id AND s.name = app_internal_secrets_rotate.secret_name) AND s.retired_at IS NULL);
  INSERT INTO myapp_store_private.app_internal_secrets (
    namespace_id,
    name,
    value,
    algo,
    rotated_at,
    realm
  )
  VALUES
    (app_internal_secrets_rotate.namespace_id, app_internal_secrets_rotate.secret_name, app_internal_secrets_rotate.secret_value::bytea, app_internal_secrets_rotate.algo, pg_catalog.now(), app_internal_secrets_rotate.realm);
  RETURN true;
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE;

