-- Revert: schemas/routing_public/tables/platform_site_metadata/grants/authenticated/select/grant


REVOKE SELECT ON routing_public.platform_site_metadata FROM authenticated RESTRICT;