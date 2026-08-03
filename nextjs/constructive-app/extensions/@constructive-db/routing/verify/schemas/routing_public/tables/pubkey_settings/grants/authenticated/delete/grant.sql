-- Verify: schemas/routing_public/tables/pubkey_settings/grants/authenticated/delete/grant


SELECT verify_table_grant('routing_public.pubkey_settings', 'DELETE', 'authenticated');