-- Verify: schemas/routing_public/tables/platform_domain_verifications/grants/authenticated/insert/grant


SELECT verify_table_grant('routing_public.platform_domain_verifications', 'INSERT', 'authenticated');