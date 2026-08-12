-- Verify: schemas/routing_public/tables/email_provider_accounts/table


SELECT assert_table(CAST('routing_public.email_provider_accounts' AS regclass), false, NULL);