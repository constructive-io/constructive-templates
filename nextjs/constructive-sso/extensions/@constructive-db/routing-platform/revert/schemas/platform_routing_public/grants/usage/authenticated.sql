-- Revert: schemas/platform_routing_public/grants/usage/authenticated


REVOKE USAGE ON SCHEMA platform_routing_public FROM authenticated RESTRICT;