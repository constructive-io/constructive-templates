-- Revert: schemas/routing_public/tables/email_provider_accounts/constraints/email_provider_accounts_pkey/constraint


ALTER TABLE routing_public.email_provider_accounts 
  DROP CONSTRAINT email_provider_accounts_pkey RESTRICT;