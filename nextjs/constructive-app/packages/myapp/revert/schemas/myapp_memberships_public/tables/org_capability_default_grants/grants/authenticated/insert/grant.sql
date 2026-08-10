-- Revert: schemas/myapp_memberships_public/tables/org_capability_default_grants/grants/authenticated/insert/grant


REVOKE INSERT ON myapp_memberships_public.org_capability_default_grants FROM authenticated;


