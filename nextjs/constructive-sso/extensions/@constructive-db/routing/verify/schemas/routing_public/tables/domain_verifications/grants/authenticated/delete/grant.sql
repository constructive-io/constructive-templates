-- Verify: schemas/routing_public/tables/domain_verifications/grants/authenticated/delete/grant


SELECT verify_table_grant('routing_public.domain_verifications', 'DELETE', 'authenticated');