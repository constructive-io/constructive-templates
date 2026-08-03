-- Revert: schemas/routing_private/grants/usage/anonymous


REVOKE USAGE ON SCHEMA routing_private FROM anonymous RESTRICT;