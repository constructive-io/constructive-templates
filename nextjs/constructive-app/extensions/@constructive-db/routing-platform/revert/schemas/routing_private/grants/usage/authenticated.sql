-- Revert: schemas/routing_private/grants/usage/authenticated


REVOKE USAGE ON SCHEMA routing_private FROM authenticated RESTRICT;