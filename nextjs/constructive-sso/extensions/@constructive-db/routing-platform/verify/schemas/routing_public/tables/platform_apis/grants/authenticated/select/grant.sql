-- Verify: schemas/routing_public/tables/platform_apis/grants/authenticated/select/grant


SELECT verify_table_grant('routing_public.platform_apis', 'SELECT', 'authenticated');