-- Revert: schemas/routing_public/tables/email_provider_accounts/columns/id/column


ALTER TABLE routing_public.email_provider_accounts 
  DROP COLUMN id RESTRICT;