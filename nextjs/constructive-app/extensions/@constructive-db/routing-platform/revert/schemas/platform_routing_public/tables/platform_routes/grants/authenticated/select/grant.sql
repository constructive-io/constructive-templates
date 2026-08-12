-- Revert: schemas/platform_routing_public/tables/platform_routes/grants/authenticated/select/grant


REVOKE SELECT ON platform_routing_public.platform_routes FROM authenticated RESTRICT;