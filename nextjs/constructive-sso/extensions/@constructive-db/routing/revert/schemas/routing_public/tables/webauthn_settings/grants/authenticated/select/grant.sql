-- Revert: schemas/routing_public/tables/webauthn_settings/grants/authenticated/select/grant


REVOKE SELECT ON routing_public.webauthn_settings FROM authenticated RESTRICT;