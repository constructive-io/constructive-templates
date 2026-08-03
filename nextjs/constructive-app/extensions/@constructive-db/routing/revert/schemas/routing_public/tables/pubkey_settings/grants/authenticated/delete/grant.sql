-- Revert: schemas/routing_public/tables/pubkey_settings/grants/authenticated/delete/grant


REVOKE DELETE ON routing_public.pubkey_settings FROM authenticated RESTRICT;