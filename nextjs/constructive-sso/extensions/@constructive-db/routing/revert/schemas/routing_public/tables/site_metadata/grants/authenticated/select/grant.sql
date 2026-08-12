-- Revert: schemas/routing_public/tables/site_metadata/grants/authenticated/select/grant


REVOKE SELECT ON routing_public.site_metadata FROM authenticated RESTRICT;