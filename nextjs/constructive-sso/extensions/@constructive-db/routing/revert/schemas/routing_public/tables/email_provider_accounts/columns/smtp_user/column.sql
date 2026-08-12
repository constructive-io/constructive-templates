-- Revert: schemas/routing_public/tables/email_provider_accounts/columns/smtp_user/column


ALTER TABLE routing_public.email_provider_accounts 
  DROP COLUMN smtp_user RESTRICT;