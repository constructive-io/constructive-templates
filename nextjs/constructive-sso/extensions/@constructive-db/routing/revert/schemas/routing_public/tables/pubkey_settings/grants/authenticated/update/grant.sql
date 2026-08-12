-- Revert: schemas/routing_public/tables/pubkey_settings/grants/authenticated/update/grant


REVOKE UPDATE ON routing_public.pubkey_settings FROM authenticated RESTRICT;