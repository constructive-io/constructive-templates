-- Revert: schemas/routing_public/tables/platform_email_provider_accounts/columns/api_base_url/column


ALTER TABLE routing_public.platform_email_provider_accounts 
  DROP COLUMN api_base_url RESTRICT;