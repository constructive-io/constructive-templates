-- Deploy: schemas/myapp_capabilities_public/procedures/org_capabilities_get_mask/procedure
-- made with <3 @ constructive.io

-- requires: schemas/myapp_capabilities_public/schema
-- requires: schemas/myapp_capabilities_public/tables/org_capabilities/table


CREATE FUNCTION myapp_capabilities_public.org_capabilities_get_mask(
  ids uuid[]
) RETURNS bit varying AS $_PGFN_$
SELECT bit_or(bitstr)
FROM myapp_capabilities_public.org_capabilities
WHERE
  id = ANY( ids )
$_PGFN_$ LANGUAGE sql STABLE SECURITY INVOKER;

