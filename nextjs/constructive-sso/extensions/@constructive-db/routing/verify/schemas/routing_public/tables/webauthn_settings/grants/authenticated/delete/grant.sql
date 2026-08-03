-- Verify: schemas/routing_public/tables/webauthn_settings/grants/authenticated/delete/grant


SELECT verify_table_grant('routing_public.webauthn_settings', 'DELETE', 'authenticated');