-- Verify: schemas/routing_public/tables/platform_email_identities/grants/authenticated/update/grant


SELECT assert_table_grant(CAST('routing_public.platform_email_identities' AS regclass), 'authenticated', 'UPDATE', NULL, true);