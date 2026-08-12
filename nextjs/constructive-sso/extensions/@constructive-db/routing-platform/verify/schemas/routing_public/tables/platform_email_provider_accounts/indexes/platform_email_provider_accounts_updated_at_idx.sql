-- Verify: schemas/routing_public/tables/platform_email_provider_accounts/indexes/platform_email_provider_accounts_updated_at_idx


SELECT assert_index(CAST('routing_public.platform_email_provider_accounts_updated_at_idx' AS regclass), CAST('routing_public.platform_email_provider_accounts' AS regclass), false);