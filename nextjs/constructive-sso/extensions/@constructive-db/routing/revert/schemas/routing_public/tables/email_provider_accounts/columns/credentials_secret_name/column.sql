-- Revert: schemas/routing_public/tables/email_provider_accounts/columns/credentials_secret_name/column


ALTER TABLE routing_public.email_provider_accounts 
  DROP COLUMN credentials_secret_name RESTRICT;