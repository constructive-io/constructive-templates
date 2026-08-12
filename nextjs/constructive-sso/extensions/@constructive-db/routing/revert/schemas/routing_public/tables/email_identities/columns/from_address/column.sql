-- Revert: schemas/routing_public/tables/email_identities/columns/from_address/column


ALTER TABLE routing_public.email_identities 
  DROP COLUMN from_address RESTRICT;