-- Revert: schemas/routing_public/tables/email_identities/columns/support_address/column


ALTER TABLE routing_public.email_identities 
  DROP COLUMN support_address RESTRICT;