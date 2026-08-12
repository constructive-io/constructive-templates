-- Revert: schemas/routing_public/tables/email_provider_accounts/columns/region/column


ALTER TABLE routing_public.email_provider_accounts 
  DROP COLUMN region RESTRICT;