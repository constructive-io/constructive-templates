-- Verify: schemas/routing_public/tables/pubkey_settings/table


SELECT assert_table(CAST('routing_public.pubkey_settings' AS regclass), false, NULL);