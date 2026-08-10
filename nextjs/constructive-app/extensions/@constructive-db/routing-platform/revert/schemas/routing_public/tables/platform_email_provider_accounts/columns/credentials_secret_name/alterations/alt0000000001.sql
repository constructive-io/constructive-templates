-- Revert: schemas/routing_public/tables/platform_email_provider_accounts/columns/credentials_secret_name/alterations/alt0000000001


ALTER TABLE routing_public.platform_email_provider_accounts 
  ALTER COLUMN credentials_secret_name DROP NOT NULL;