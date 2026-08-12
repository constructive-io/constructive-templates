-- Verify: schemas/routing_public/tables/email_site_identities/indexes/email_site_identities_database_id_idx


SELECT assert_index(CAST('routing_public.email_site_identities_database_id_idx' AS regclass), CAST('routing_public.email_site_identities' AS regclass), false);