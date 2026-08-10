-- Revert: schemas/routing_public/tables/email_identities/columns/from_address/alterations/alt0000000001


ALTER TABLE routing_public.email_identities 
  ALTER COLUMN from_address DROP NOT NULL;