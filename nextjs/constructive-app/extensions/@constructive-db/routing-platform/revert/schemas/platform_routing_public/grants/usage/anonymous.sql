-- Revert: schemas/platform_routing_public/grants/usage/anonymous


REVOKE USAGE ON SCHEMA platform_routing_public FROM anonymous RESTRICT;