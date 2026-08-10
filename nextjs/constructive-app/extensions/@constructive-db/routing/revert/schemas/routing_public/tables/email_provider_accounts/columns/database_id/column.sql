-- Revert: schemas/routing_public/tables/email_provider_accounts/columns/database_id/column


ALTER TABLE routing_public.email_provider_accounts 
  DROP COLUMN database_id RESTRICT;