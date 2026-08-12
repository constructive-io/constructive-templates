-- Deploy: schemas/myapp_capabilities_public/procedures/app_capabilities_get_mask_by_names/procedure
-- made with <3 @ constructive.io

-- requires: schemas/myapp_capabilities_public/schema
-- requires: schemas/myapp_capabilities_public/tables/app_capabilities/table


CREATE FUNCTION myapp_capabilities_public.app_capabilities_get_mask_by_names(
  names citext[]
) RETURNS bit varying AS $_PGFN_$
SELECT bit_or(bitstr)
FROM myapp_capabilities_public.app_capabilities
WHERE
  name = ANY( names )
$_PGFN_$ LANGUAGE sql STABLE SECURITY INVOKER;

