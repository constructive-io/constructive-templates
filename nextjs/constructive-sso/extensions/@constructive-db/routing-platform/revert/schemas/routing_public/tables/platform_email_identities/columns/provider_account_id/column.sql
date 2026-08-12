-- Revert: schemas/routing_public/tables/platform_email_identities/columns/provider_account_id/column


ALTER TABLE routing_public.platform_email_identities 
  DROP COLUMN provider_account_id RESTRICT;