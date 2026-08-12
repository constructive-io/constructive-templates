-- Revert: schemas/routing_public/tables/platform_email_provider_accounts/columns/is_active/alterations/alt0000000002


ALTER TABLE routing_public.platform_email_provider_accounts 
  ALTER COLUMN is_active DROP DEFAULT;