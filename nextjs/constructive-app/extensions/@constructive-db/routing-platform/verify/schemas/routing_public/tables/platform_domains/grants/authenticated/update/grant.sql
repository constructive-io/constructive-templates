-- Verify: schemas/routing_public/tables/platform_domains/grants/authenticated/update/grant


SELECT verify_table_grant('routing_public.platform_domains', 'UPDATE', 'authenticated');