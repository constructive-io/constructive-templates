-- Revert: schemas/routing_public/tables/email_identities/columns/is_active/column


ALTER TABLE routing_public.email_identities 
  DROP COLUMN is_active RESTRICT;