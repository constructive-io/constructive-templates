-- Verify: schemas/routing_public/tables/pubkey_settings/grants/authenticated/delete/grant


SELECT assert_table_grant(CAST('routing_public.pubkey_settings' AS regclass), 'authenticated', 'DELETE', NULL, true);