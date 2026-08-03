-- Verify: schemas/routing_public/tables/platform_domains/grants/authenticated/select/grant


SELECT verify_table_grant('routing_public.platform_domains', 'SELECT', 'authenticated');