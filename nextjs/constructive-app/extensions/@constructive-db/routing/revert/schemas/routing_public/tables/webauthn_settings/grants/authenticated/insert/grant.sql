-- Revert: schemas/routing_public/tables/webauthn_settings/grants/authenticated/insert/grant


REVOKE INSERT ON routing_public.webauthn_settings FROM authenticated RESTRICT;