-- Verify: schemas/routing_public/tables/platform_email_provider_accounts/grants/authenticated/insert/grant


SELECT assert_table_grant(CAST('routing_public.platform_email_provider_accounts' AS regclass), 'authenticated', 'INSERT', NULL, true);