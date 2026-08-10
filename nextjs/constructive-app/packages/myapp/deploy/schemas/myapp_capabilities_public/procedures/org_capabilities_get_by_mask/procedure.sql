-- Deploy: schemas/myapp_capabilities_public/procedures/org_capabilities_get_by_mask/procedure
-- made with <3 @ constructive.io

-- requires: schemas/myapp_capabilities_public/schema
-- requires: schemas/myapp_capabilities_public/tables/org_capabilities/table


CREATE FUNCTION myapp_capabilities_public.org_capabilities_get_by_mask(
  mask bit varying
) RETURNS SETOF myapp_capabilities_public.org_capabilities AS $_PGFN_$
SELECT *
FROM myapp_capabilities_public.org_capabilities
WHERE
  (bitstr & myapp_capabilities_public.org_capabilities_get_padded_mask(mask)) = bitstr
$_PGFN_$ LANGUAGE sql STABLE SECURITY INVOKER;

