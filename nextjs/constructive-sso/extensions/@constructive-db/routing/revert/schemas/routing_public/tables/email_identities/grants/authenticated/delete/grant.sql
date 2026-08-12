-- Revert: schemas/routing_public/tables/email_identities/grants/authenticated/delete/grant


REVOKE DELETE ON routing_public.email_identities FROM authenticated RESTRICT;