-- Revert: schemas/routing_public/tables/platform_email_provider_accounts/columns/smtp_user/column


ALTER TABLE routing_public.platform_email_provider_accounts 
  DROP COLUMN smtp_user RESTRICT;