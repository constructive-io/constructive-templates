-- Verify: schemas/routing_public/tables/pubkey_settings/grants/authenticated/select/grant


SELECT verify_table_grant('routing_public.pubkey_settings', 'SELECT', 'authenticated');