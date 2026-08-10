-- Revert: schemas/myapp_memberships_public/tables/app_capability_default_grants/grants/authenticated/insert/grant


REVOKE INSERT ON myapp_memberships_public.app_capability_default_grants FROM authenticated;


