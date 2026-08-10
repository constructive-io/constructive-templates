-- Revert: schemas/routing_public/tables/email_site_identities/grants/authenticated/select/grant


REVOKE SELECT ON routing_public.email_site_identities FROM authenticated RESTRICT;