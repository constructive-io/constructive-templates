-- Revert: schemas/routing_public/tables/platform_email_identities/columns/is_default/column


ALTER TABLE routing_public.platform_email_identities 
  DROP COLUMN is_default RESTRICT;