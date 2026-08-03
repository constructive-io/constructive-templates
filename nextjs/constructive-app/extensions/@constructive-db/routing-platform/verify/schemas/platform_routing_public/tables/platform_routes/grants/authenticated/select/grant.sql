-- Verify: schemas/platform_routing_public/tables/platform_routes/grants/authenticated/select/grant


SELECT verify_table_grant('platform_routing_public.platform_routes', 'SELECT', 'authenticated');