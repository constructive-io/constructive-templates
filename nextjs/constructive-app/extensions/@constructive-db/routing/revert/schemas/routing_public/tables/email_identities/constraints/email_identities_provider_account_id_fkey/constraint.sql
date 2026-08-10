-- Revert: schemas/routing_public/tables/email_identities/constraints/email_identities_provider_account_id_fkey/constraint


ALTER TABLE routing_public.email_identities 
  DROP CONSTRAINT email_identities_provider_account_id_fkey RESTRICT;