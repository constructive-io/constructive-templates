-- Revert: schemas/routing_public/tables/email_identities/grants/authenticated/insert/grant


REVOKE INSERT ON routing_public.email_identities FROM authenticated RESTRICT;