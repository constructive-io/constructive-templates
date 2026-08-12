-- Revert: schemas/routing_public/tables/domain_verifications/grants/authenticated/delete/grant


REVOKE DELETE ON routing_public.domain_verifications FROM authenticated RESTRICT;