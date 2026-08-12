-- Revert: schemas/routing_public/tables/email_identities/columns/is_default/alterations/alt0000000001


ALTER TABLE routing_public.email_identities 
  ALTER COLUMN is_default DROP NOT NULL;