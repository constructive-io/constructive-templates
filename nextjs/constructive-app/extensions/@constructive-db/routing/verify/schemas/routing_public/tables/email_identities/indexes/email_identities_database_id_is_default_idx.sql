-- Verify: schemas/routing_public/tables/email_identities/indexes/email_identities_database_id_is_default_idx


SELECT assert_index(CAST('routing_public.email_identities_database_id_is_default_idx' AS regclass), CAST('routing_public.email_identities' AS regclass), true);