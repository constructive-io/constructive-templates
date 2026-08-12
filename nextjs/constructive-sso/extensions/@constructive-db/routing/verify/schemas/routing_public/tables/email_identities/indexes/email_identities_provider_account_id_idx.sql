-- Verify: schemas/routing_public/tables/email_identities/indexes/email_identities_provider_account_id_idx


SELECT assert_index(CAST('routing_public.email_identities_provider_account_id_idx' AS regclass), CAST('routing_public.email_identities' AS regclass), false);