-- Revert: schemas/routing_public/tables/api_settings/grants/authenticated/select/grant


REVOKE SELECT ON routing_public.api_settings FROM authenticated RESTRICT;