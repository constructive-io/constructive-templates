-- Revert: schemas/platform_routing_public/tables/platform_routes/grants/authenticated/update/grant


REVOKE UPDATE ON platform_routing_public.platform_routes FROM authenticated RESTRICT;