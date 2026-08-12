-- Revert: schemas/routing_public/tables/email_identities/grants/authenticated/update/grant


REVOKE UPDATE ON routing_public.email_identities FROM authenticated RESTRICT;