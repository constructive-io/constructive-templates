-- Revert: schemas/routing_public/tables/email_provider_accounts/columns/database_id/alterations/alt0000000001


ALTER TABLE routing_public.email_provider_accounts 
  ALTER COLUMN database_id DROP NOT NULL;