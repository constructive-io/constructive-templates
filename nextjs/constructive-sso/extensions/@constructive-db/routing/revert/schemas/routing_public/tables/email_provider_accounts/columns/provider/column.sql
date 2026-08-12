-- Revert: schemas/routing_public/tables/email_provider_accounts/columns/provider/column


ALTER TABLE routing_public.email_provider_accounts 
  DROP COLUMN provider RESTRICT;