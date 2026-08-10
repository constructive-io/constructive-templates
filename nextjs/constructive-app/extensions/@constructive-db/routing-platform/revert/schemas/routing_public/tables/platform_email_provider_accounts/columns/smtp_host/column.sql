-- Revert: schemas/routing_public/tables/platform_email_provider_accounts/columns/smtp_host/column


ALTER TABLE routing_public.platform_email_provider_accounts 
  DROP COLUMN smtp_host RESTRICT;