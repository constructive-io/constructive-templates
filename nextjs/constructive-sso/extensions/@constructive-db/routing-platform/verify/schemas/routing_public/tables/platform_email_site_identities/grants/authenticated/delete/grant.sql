-- Verify: schemas/routing_public/tables/platform_email_site_identities/grants/authenticated/delete/grant


SELECT assert_table_grant(CAST('routing_public.platform_email_site_identities' AS regclass), 'authenticated', 'DELETE', NULL, true);