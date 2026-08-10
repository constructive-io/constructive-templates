-- Revert: schemas/routing_public/tables/email_provider_accounts/columns/smtp_host/column


ALTER TABLE routing_public.email_provider_accounts 
  DROP COLUMN smtp_host RESTRICT;