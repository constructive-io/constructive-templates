-- Revert: schemas/routing_public/tables/email_identities/columns/is_default/column


ALTER TABLE routing_public.email_identities 
  DROP COLUMN is_default RESTRICT;