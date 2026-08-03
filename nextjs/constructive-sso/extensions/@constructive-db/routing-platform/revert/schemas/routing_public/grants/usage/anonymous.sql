-- Revert: schemas/routing_public/grants/usage/anonymous


REVOKE USAGE ON SCHEMA routing_public FROM anonymous RESTRICT;