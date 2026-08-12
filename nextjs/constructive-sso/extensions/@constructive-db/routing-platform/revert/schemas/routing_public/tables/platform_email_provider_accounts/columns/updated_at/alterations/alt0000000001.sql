-- Revert: schemas/routing_public/tables/platform_email_provider_accounts/columns/updated_at/alterations/alt0000000001


ALTER TABLE routing_public.platform_email_provider_accounts 
  ALTER COLUMN updated_at DROP DEFAULT;