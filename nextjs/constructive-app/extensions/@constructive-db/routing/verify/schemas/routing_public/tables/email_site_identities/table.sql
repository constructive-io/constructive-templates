-- Verify: schemas/routing_public/tables/email_site_identities/table


SELECT assert_table(CAST('routing_public.email_site_identities' AS regclass), false, NULL);