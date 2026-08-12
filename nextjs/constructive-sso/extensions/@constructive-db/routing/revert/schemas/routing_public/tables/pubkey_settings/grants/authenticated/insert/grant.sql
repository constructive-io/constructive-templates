-- Revert: schemas/routing_public/tables/pubkey_settings/grants/authenticated/insert/grant


REVOKE INSERT ON routing_public.pubkey_settings FROM authenticated RESTRICT;