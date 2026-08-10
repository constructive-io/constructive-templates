-- Revert: schemas/routing_public/tables/platform_email_identities/columns/from_address/column


ALTER TABLE routing_public.platform_email_identities 
  DROP COLUMN from_address RESTRICT;