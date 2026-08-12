-- Revert: schemas/routing_public/tables/site_metadata/grants/authenticated/insert/grant


REVOKE INSERT ON routing_public.site_metadata FROM authenticated RESTRICT;