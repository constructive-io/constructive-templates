-- Revert: schemas/routing_public/tables/email_provider_accounts/columns/api_base_url/column


ALTER TABLE routing_public.email_provider_accounts 
  DROP COLUMN api_base_url RESTRICT;