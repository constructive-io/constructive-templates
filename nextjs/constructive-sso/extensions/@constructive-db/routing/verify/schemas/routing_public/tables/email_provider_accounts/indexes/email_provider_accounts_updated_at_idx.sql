-- Verify: schemas/routing_public/tables/email_provider_accounts/indexes/email_provider_accounts_updated_at_idx


SELECT assert_index(CAST('routing_public.email_provider_accounts_updated_at_idx' AS regclass), CAST('routing_public.email_provider_accounts' AS regclass), false);