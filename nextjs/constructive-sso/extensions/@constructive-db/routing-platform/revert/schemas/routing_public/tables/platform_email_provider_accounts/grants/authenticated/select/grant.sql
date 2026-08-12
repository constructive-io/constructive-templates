-- Revert: schemas/routing_public/tables/platform_email_provider_accounts/grants/authenticated/select/grant


REVOKE SELECT ON routing_public.platform_email_provider_accounts FROM authenticated RESTRICT;