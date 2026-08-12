-- Verify: schemas/routing_public/tables/platform_email_provider_accounts/table


SELECT assert_table(CAST('routing_public.platform_email_provider_accounts' AS regclass), false, NULL);