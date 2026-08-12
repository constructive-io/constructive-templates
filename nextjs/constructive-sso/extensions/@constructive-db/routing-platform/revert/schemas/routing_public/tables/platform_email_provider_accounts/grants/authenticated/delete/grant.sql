-- Revert: schemas/routing_public/tables/platform_email_provider_accounts/grants/authenticated/delete/grant


REVOKE DELETE ON routing_public.platform_email_provider_accounts FROM authenticated RESTRICT;