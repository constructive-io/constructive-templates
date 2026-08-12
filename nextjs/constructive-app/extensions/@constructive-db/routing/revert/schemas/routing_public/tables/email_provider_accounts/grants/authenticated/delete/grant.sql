-- Revert: schemas/routing_public/tables/email_provider_accounts/grants/authenticated/delete/grant


REVOKE DELETE ON routing_public.email_provider_accounts FROM authenticated RESTRICT;