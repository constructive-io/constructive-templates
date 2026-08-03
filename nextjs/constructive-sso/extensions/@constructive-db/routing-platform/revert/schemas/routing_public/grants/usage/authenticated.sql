-- Revert: schemas/routing_public/grants/usage/authenticated


REVOKE USAGE ON SCHEMA routing_public FROM authenticated RESTRICT;