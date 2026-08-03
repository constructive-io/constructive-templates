-- Verify: schemas/routing_public/tables/webauthn_settings/grants/authenticated/select/grant


SELECT verify_table_grant('routing_public.webauthn_settings', 'SELECT', 'authenticated');