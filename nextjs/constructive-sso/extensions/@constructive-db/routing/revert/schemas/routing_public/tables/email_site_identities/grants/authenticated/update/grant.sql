-- Revert: schemas/routing_public/tables/email_site_identities/grants/authenticated/update/grant


REVOKE UPDATE ON routing_public.email_site_identities FROM authenticated RESTRICT;