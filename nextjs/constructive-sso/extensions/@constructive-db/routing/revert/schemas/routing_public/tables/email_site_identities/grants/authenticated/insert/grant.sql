-- Revert: schemas/routing_public/tables/email_site_identities/grants/authenticated/insert/grant


REVOKE INSERT ON routing_public.email_site_identities FROM authenticated RESTRICT;