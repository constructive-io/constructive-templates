-- Verify: schemas/routing_public/tables/webauthn_settings/grants/authenticated/delete/grant


SELECT assert_table_grant(CAST('routing_public.webauthn_settings' AS regclass), 'authenticated', 'DELETE', NULL, true);