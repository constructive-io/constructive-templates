-- Revert: schemas/routing_public/tables/email_provider_accounts/columns/is_active/column


ALTER TABLE routing_public.email_provider_accounts 
  DROP COLUMN is_active RESTRICT;