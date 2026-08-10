-- Verify: schemas/routing_public/tables/email_site_identities/grants/authenticated/insert/grant


SELECT assert_table_grant(CAST('routing_public.email_site_identities' AS regclass), 'authenticated', 'INSERT', NULL, true);