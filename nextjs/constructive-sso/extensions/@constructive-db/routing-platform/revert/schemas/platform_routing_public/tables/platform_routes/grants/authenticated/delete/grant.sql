-- Revert: schemas/platform_routing_public/tables/platform_routes/grants/authenticated/delete/grant


REVOKE DELETE ON platform_routing_public.platform_routes FROM authenticated RESTRICT;