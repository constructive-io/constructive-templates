-- Verify: schemas/routing_public/tables/pubkey_settings/grants/authenticated/select/grant


SELECT assert_table_grant(CAST('routing_public.pubkey_settings' AS regclass), 'authenticated', 'SELECT', NULL, true);