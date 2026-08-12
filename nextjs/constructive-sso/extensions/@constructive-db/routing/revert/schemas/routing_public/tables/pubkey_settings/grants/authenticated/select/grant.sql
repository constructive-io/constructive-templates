-- Revert: schemas/routing_public/tables/pubkey_settings/grants/authenticated/select/grant


REVOKE SELECT ON routing_public.pubkey_settings FROM authenticated RESTRICT;