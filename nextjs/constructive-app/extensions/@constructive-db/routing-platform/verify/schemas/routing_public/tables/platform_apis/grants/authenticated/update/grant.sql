-- Verify: schemas/routing_public/tables/platform_apis/grants/authenticated/update/grant


SELECT verify_table_grant('routing_public.platform_apis', 'UPDATE', 'authenticated');