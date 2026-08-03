-- Revert: schemas/routing_public/tables/platform_site_metadata/grants/authenticated/update/grant


REVOKE UPDATE ON routing_public.platform_site_metadata FROM authenticated RESTRICT;