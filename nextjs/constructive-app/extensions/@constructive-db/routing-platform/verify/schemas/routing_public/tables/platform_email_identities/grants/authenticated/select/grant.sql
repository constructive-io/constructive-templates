-- Verify: schemas/routing_public/tables/platform_email_identities/grants/authenticated/select/grant


SELECT assert_table_grant(CAST('routing_public.platform_email_identities' AS regclass), 'authenticated', 'SELECT', NULL, true);