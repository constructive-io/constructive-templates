-- Revert: schemas/routing_public/tables/platform_email_provider_accounts/columns/provider_account_name/column


ALTER TABLE routing_public.platform_email_provider_accounts 
  DROP COLUMN provider_account_name RESTRICT;