-- Revert: schemas/routing_public/tables/platform_email_provider_accounts/columns/created_at/column


ALTER TABLE routing_public.platform_email_provider_accounts 
  DROP COLUMN created_at RESTRICT;