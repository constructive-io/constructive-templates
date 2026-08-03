-- Revert: schemas/routing_public/tables/platform_sites/grants/authenticated/delete/grant


REVOKE DELETE ON routing_public.platform_sites FROM authenticated RESTRICT;