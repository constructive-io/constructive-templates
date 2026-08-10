-- Verify: schemas/routing_public/tables/platform_email_identities/indexes/platform_email_identities_provider_account_id_idx


SELECT assert_index(CAST('routing_public.platform_email_identities_provider_account_id_idx' AS regclass), CAST('routing_public.platform_email_identities' AS regclass), false);