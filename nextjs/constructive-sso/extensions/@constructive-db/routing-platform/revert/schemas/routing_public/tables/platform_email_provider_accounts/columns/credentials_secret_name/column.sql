-- Revert: schemas/routing_public/tables/platform_email_provider_accounts/columns/credentials_secret_name/column


ALTER TABLE routing_public.platform_email_provider_accounts 
  DROP COLUMN credentials_secret_name RESTRICT;