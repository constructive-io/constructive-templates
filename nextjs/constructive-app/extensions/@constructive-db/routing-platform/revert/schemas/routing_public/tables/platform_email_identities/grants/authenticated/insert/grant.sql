-- Revert: schemas/routing_public/tables/platform_email_identities/grants/authenticated/insert/grant


REVOKE INSERT ON routing_public.platform_email_identities FROM authenticated RESTRICT;