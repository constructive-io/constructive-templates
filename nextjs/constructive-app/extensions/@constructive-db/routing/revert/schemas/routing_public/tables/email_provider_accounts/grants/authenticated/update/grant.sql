-- Revert: schemas/routing_public/tables/email_provider_accounts/grants/authenticated/update/grant


REVOKE UPDATE ON routing_public.email_provider_accounts FROM authenticated RESTRICT;