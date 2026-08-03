-- Revert: schemas/routing_public/tables/site_metadata/grants/authenticated/delete/grant


REVOKE DELETE ON routing_public.site_metadata FROM authenticated RESTRICT;