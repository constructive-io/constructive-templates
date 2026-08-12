-- Revert: schemas/routing_public/tables/site_metadata/grants/authenticated/update/grant


REVOKE UPDATE ON routing_public.site_metadata FROM authenticated RESTRICT;