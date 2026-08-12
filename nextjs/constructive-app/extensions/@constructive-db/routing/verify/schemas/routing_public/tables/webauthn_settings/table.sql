-- Verify: schemas/routing_public/tables/webauthn_settings/table


SELECT assert_table(CAST('routing_public.webauthn_settings' AS regclass), false, NULL);