-- Verify: schemas/routing_public/tables/platform_domain_verifications/grants/authenticated/select/grant


SELECT verify_table_grant('routing_public.platform_domain_verifications', 'SELECT', 'authenticated');