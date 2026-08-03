-- Verify: schemas/routing_public/tables/pubkey_settings/grants/authenticated/insert/grant


SELECT verify_table_grant('routing_public.pubkey_settings', 'INSERT', 'authenticated');