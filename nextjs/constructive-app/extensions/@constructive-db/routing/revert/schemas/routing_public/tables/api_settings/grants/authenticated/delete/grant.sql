-- Revert: schemas/routing_public/tables/api_settings/grants/authenticated/delete/grant


REVOKE DELETE ON routing_public.api_settings FROM authenticated RESTRICT;