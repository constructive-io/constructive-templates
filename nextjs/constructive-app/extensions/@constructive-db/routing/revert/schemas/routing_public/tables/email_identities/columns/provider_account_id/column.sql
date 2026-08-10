-- Revert: schemas/routing_public/tables/email_identities/columns/provider_account_id/column


ALTER TABLE routing_public.email_identities 
  DROP COLUMN provider_account_id RESTRICT;