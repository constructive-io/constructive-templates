-- Revert: schemas/myapp_memberships_public/tables/app_capability_default_capabilities/grants/authenticated/delete/grant


REVOKE DELETE ON myapp_memberships_public.app_capability_default_capabilities FROM authenticated;


