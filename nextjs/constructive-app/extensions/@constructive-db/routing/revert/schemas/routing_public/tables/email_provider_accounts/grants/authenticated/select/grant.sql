-- Revert: schemas/routing_public/tables/email_provider_accounts/grants/authenticated/select/grant


REVOKE SELECT ON routing_public.email_provider_accounts FROM authenticated RESTRICT;