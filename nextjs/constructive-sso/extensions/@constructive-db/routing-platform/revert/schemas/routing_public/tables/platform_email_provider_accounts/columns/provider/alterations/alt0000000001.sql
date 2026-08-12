-- Revert: schemas/routing_public/tables/platform_email_provider_accounts/columns/provider/alterations/alt0000000001


ALTER TABLE routing_public.platform_email_provider_accounts 
  ALTER COLUMN provider DROP NOT NULL;