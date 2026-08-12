-- Revert: schemas/routing_public/tables/platform_email_site_identities/grants/authenticated/select/grant


REVOKE SELECT ON routing_public.platform_email_site_identities FROM authenticated RESTRICT;