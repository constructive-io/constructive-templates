-- Revert: schemas/routing_public/tables/api_settings/grants/authenticated/insert/grant


REVOKE INSERT ON routing_public.api_settings FROM authenticated RESTRICT;