-- Deploy: schemas/myapp_memberships_private/procedures/org_memberships_perm_ids/procedure
-- made with <3 @ constructive.io

-- requires: schemas/myapp_memberships_private/schema
-- requires: schemas/myapp_memberships_public/tables/org_memberships/table
-- requires: schemas/myapp_capabilities_public/tables/org_capabilities/table


CREATE FUNCTION myapp_memberships_private.org_memberships_perm_ids(
  IN perm text
) RETURNS uuid[] AS $_PGFN_$
SELECT array_agg(m.entity_id)
FROM myapp_memberships_public.org_memberships AS m, myapp_capabilities_public.org_capabilities AS p
WHERE
  (p.name = perm AND (m.capabilities & p.bitstr) = p.bitstr) AND m.actor_id = jwt_public.current_user_id()
$_PGFN_$ LANGUAGE sql STABLE SECURITY DEFINER;

