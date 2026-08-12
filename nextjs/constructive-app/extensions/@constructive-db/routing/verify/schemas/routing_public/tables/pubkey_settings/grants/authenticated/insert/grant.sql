-- Verify: schemas/routing_public/tables/pubkey_settings/grants/authenticated/insert/grant


SELECT assert_table_grant(CAST('routing_public.pubkey_settings' AS regclass), 'authenticated', 'INSERT', NULL, true);