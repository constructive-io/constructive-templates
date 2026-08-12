-- Verify: schemas/routing_public/tables/platform_email_provider_accounts/grants/authenticated/update/grant


SELECT assert_table_grant(CAST('routing_public.platform_email_provider_accounts' AS regclass), 'authenticated', 'UPDATE', NULL, true);