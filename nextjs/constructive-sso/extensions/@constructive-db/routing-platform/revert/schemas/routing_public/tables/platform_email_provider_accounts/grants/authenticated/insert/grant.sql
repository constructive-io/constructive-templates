-- Revert: schemas/routing_public/tables/platform_email_provider_accounts/grants/authenticated/insert/grant


REVOKE INSERT ON routing_public.platform_email_provider_accounts FROM authenticated RESTRICT;