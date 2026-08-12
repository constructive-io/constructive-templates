-- Verify: schemas/routing_public/tables/platform_email_identities/table


SELECT assert_table(CAST('routing_public.platform_email_identities' AS regclass), false, NULL);