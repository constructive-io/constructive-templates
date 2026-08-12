-- Verify: schemas/routing_public/tables/platform_email_site_identities/indexes/platform_email_site_identities_email_identity_id_idx


SELECT assert_index(CAST('routing_public.platform_email_site_identities_email_identity_id_idx' AS regclass), CAST('routing_public.platform_email_site_identities' AS regclass), false);