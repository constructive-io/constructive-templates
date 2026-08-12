-- Revert: schemas/routing_public/tables/platform_email_identities/grants/authenticated/update/grant


REVOKE UPDATE ON routing_public.platform_email_identities FROM authenticated RESTRICT;