-- Verify: schemas/routing_public/tables/platform_apis/grants/authenticated/insert/grant


SELECT verify_table_grant('routing_public.platform_apis', 'INSERT', 'authenticated');