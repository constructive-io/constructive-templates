-- Revert: schemas/routing_public/tables/platform_email_identities/columns/support_address/column


ALTER TABLE routing_public.platform_email_identities 
  DROP COLUMN support_address RESTRICT;