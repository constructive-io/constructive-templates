-- Revert: schemas/routing_public/tables/webauthn_settings/grants/authenticated/delete/grant


REVOKE DELETE ON routing_public.webauthn_settings FROM authenticated RESTRICT;