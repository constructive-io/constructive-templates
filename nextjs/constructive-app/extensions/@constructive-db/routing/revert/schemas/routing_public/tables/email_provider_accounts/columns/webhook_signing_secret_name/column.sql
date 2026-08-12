-- Revert: schemas/routing_public/tables/email_provider_accounts/columns/webhook_signing_secret_name/column


ALTER TABLE routing_public.email_provider_accounts 
  DROP COLUMN webhook_signing_secret_name RESTRICT;