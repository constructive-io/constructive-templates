-- Revert: schemas/routing_public/tables/platform_email_provider_accounts/columns/updated_at/column


ALTER TABLE routing_public.platform_email_provider_accounts 
  DROP COLUMN updated_at RESTRICT;