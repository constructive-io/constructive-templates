-- Revert: schemas/routing_public/tables/email_provider_accounts/columns/provider/alterations/alt0000000001


ALTER TABLE routing_public.email_provider_accounts 
  ALTER COLUMN provider DROP NOT NULL;