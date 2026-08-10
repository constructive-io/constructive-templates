-- Revert: schemas/myapp_memberships_public/tables/app_capability_default_grants/grants/authenticated/select/grant


REVOKE SELECT ON myapp_memberships_public.app_capability_default_grants FROM authenticated;


