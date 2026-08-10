-- Revert: schemas/myapp_memberships_public/tables/org_capability_default_capabilities/grants/authenticated/insert/grant


REVOKE INSERT ON myapp_memberships_public.org_capability_default_capabilities FROM authenticated;


