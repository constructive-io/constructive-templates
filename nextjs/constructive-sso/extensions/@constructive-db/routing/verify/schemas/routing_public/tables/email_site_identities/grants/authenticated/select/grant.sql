-- Verify: schemas/routing_public/tables/email_site_identities/grants/authenticated/select/grant


SELECT assert_table_grant(CAST('routing_public.email_site_identities' AS regclass), 'authenticated', 'SELECT', NULL, true);