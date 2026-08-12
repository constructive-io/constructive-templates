-- Revert: schemas/routing_public/tables/email_identities/columns/reply_to_address/column


ALTER TABLE routing_public.email_identities 
  DROP COLUMN reply_to_address RESTRICT;