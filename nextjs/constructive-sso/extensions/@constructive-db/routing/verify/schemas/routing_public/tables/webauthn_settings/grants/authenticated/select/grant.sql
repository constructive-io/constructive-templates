-- Verify: schemas/routing_public/tables/webauthn_settings/grants/authenticated/select/grant


SELECT assert_table_grant(CAST('routing_public.webauthn_settings' AS regclass), 'authenticated', 'SELECT', NULL, true);