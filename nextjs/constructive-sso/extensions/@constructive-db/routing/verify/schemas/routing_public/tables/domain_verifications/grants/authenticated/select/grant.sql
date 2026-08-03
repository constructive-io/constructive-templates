-- Verify: schemas/routing_public/tables/domain_verifications/grants/authenticated/select/grant


SELECT verify_table_grant('routing_public.domain_verifications', 'SELECT', 'authenticated');