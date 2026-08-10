-- Deploy: schemas/myapp_store_public/procedures/app_internal_secrets_remove_array/procedure
-- made with <3 @ constructive.io

-- requires: schemas/myapp_store_public/schema
-- requires: schemas/myapp_store_private/tables/app_internal_secrets/table


CREATE FUNCTION myapp_store_public.app_internal_secrets_remove_array(
  IN secret_names text[],
  IN namespace_id uuid,
  IN realm text DEFAULT NULL
) RETURNS void AS $_PGFN_$
BEGIN
  DELETE FROM myapp_store_private.app_internal_secrets AS s
  WHERE
    s.realm IS NOT DISTINCT FROM app_internal_secrets_remove_array.realm AND ((s.namespace_id = app_internal_secrets_remove_array.namespace_id AND s.name = ANY( app_internal_secrets_remove_array.secret_names )) AND s.retired_at IS NULL);
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE;

