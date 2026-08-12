-- Revert: schemas/routing_public/tables/platform_email_identities/columns/name/column


ALTER TABLE routing_public.platform_email_identities 
  DROP COLUMN name RESTRICT;