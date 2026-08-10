-- Revert: schemas/myapp_memberships_public/tables/org_capability_default_grants/grants/authenticated/select/grant


REVOKE SELECT ON myapp_memberships_public.org_capability_default_grants FROM authenticated;


