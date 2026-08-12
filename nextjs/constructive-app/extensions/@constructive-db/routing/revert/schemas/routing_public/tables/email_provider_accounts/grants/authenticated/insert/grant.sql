-- Revert: schemas/routing_public/tables/email_provider_accounts/grants/authenticated/insert/grant


REVOKE INSERT ON routing_public.email_provider_accounts FROM authenticated RESTRICT;