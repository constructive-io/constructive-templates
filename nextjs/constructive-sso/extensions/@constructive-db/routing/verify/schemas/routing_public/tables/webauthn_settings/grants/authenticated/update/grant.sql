-- Verify: schemas/routing_public/tables/webauthn_settings/grants/authenticated/update/grant


SELECT verify_table_grant('routing_public.webauthn_settings', 'UPDATE', 'authenticated');