-- Revert: schemas/routing_public/tables/platform_email_provider_accounts/columns/is_active/column


ALTER TABLE routing_public.platform_email_provider_accounts 
  DROP COLUMN is_active RESTRICT;