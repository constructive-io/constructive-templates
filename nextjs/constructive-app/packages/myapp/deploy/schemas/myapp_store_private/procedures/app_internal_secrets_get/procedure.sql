-- Deploy: schemas/myapp_store_private/procedures/app_internal_secrets_get/procedure
-- made with <3 @ constructive.io

-- requires: schemas/myapp_store_private/schema
-- requires: schemas/myapp_store_private/tables/app_internal_secrets/table


CREATE FUNCTION myapp_store_private.app_internal_secrets_get(
  IN secret_name text,
  IN namespace_id uuid,
  IN default_value text DEFAULT NULL,
  IN realm text DEFAULT NULL
) RETURNS text AS $_PGFN_$
DECLARE
  v_secret myapp_store_private.app_internal_secrets;
BEGIN
  SELECT *
  FROM myapp_store_private.app_internal_secrets AS s
  WHERE
    s.realm = app_internal_secrets_get.realm AND ((s.namespace_id = app_internal_secrets_get.namespace_id AND s.name = app_internal_secrets_get.secret_name) AND s.retired_at IS NULL) INTO v_secret;
  IF NOT (FOUND) OR v_secret IS NULL THEN
    SELECT *
    FROM myapp_store_private.app_internal_secrets AS s
    WHERE
      s.realm IS NULL AND ((s.namespace_id = app_internal_secrets_get.namespace_id AND s.name = app_internal_secrets_get.secret_name) AND s.retired_at IS NULL) INTO v_secret;
  END IF;
  IF NOT (FOUND) OR v_secret IS NULL THEN
    RETURN app_internal_secrets_get.default_value;
  END IF;
  IF v_secret.algo = 'crypt' THEN
    RETURN pg_catalog.convert_from(v_secret.value, 'SQL_ASCII');
  ELSIF v_secret.algo = 'pgp' THEN
    RETURN pg_catalog.convert_from(pg_catalog.decode(public.pgp_sym_decrypt(v_secret.value, v_secret.key_id::text), 'hex'), 'SQL_ASCII');
  END IF;
  RETURN pg_catalog.convert_from(v_secret.value, 'SQL_ASCII');
END;
$_PGFN_$ LANGUAGE plpgsql STABLE;

