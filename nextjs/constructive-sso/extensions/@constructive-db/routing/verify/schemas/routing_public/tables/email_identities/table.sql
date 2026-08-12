-- Verify: schemas/routing_public/tables/email_identities/table


SELECT assert_table(CAST('routing_public.email_identities' AS regclass), false, NULL);