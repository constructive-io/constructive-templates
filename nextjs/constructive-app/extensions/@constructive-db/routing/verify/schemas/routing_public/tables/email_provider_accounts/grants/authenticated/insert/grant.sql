-- Verify: schemas/routing_public/tables/email_provider_accounts/grants/authenticated/insert/grant


SELECT assert_table_grant(CAST('routing_public.email_provider_accounts' AS regclass), 'authenticated', 'INSERT', NULL, true);