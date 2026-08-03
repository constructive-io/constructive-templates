-- Revert: schemas/platform_routing_public/tables/platform_routes/grants/authenticated/insert/grant


REVOKE INSERT ON platform_routing_public.platform_routes FROM authenticated RESTRICT;