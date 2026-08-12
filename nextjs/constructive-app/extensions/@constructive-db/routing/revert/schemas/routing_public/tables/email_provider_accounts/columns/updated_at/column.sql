-- Revert: schemas/routing_public/tables/email_provider_accounts/columns/updated_at/column


ALTER TABLE routing_public.email_provider_accounts 
  DROP COLUMN updated_at RESTRICT;