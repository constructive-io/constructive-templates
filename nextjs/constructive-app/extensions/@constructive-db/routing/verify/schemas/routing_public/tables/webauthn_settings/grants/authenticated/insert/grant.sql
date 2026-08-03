-- Verify: schemas/routing_public/tables/webauthn_settings/grants/authenticated/insert/grant


SELECT verify_table_grant('routing_public.webauthn_settings', 'INSERT', 'authenticated');