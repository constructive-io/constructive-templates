-- Revert: schemas/routing_public/tables/platform_email_provider_accounts/columns/region/column


ALTER TABLE routing_public.platform_email_provider_accounts 
  DROP COLUMN region RESTRICT;