-- Revert: schemas/routing_public/tables/email_identities/columns/name/column


ALTER TABLE routing_public.email_identities 
  DROP COLUMN name RESTRICT;