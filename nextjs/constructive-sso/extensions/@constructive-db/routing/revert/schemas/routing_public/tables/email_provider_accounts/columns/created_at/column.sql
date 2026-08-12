-- Revert: schemas/routing_public/tables/email_provider_accounts/columns/created_at/column


ALTER TABLE routing_public.email_provider_accounts 
  DROP COLUMN created_at RESTRICT;