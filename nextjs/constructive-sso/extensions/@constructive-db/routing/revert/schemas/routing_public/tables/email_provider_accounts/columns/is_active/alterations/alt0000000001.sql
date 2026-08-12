-- Revert: schemas/routing_public/tables/email_provider_accounts/columns/is_active/alterations/alt0000000001


ALTER TABLE routing_public.email_provider_accounts 
  ALTER COLUMN is_active DROP NOT NULL;