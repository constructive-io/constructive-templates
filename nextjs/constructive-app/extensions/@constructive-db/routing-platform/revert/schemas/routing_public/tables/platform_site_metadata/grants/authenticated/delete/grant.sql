-- Revert: schemas/routing_public/tables/platform_site_metadata/grants/authenticated/delete/grant


REVOKE DELETE ON routing_public.platform_site_metadata FROM authenticated RESTRICT;