-- Revert: schemas/routing_public/tables/webauthn_settings/grants/authenticated/update/grant


REVOKE UPDATE ON routing_public.webauthn_settings FROM authenticated RESTRICT;