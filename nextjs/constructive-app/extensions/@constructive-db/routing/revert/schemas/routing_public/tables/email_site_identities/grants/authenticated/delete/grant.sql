-- Revert: schemas/routing_public/tables/email_site_identities/grants/authenticated/delete/grant


REVOKE DELETE ON routing_public.email_site_identities FROM authenticated RESTRICT;