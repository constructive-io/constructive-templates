-- Revert: schemas/platform_routing_private/grants/usage/authenticated


REVOKE USAGE ON SCHEMA platform_routing_private FROM authenticated RESTRICT;