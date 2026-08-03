-- Verify: schemas/routing_public/tables/platform_managed_domains/grants/authenticated/insert/grant


SELECT verify_table_grant('routing_public.platform_managed_domains', 'INSERT', 'authenticated');