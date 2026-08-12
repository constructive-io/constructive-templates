-- Verify: schemas/routing_public/tables/email_identities/grants/authenticated/delete/grant


SELECT assert_table_grant(CAST('routing_public.email_identities' AS regclass), 'authenticated', 'DELETE', NULL, true);