-- Revert: schemas/routing_public/tables/email_identities/columns/is_active/alterations/alt0000000001


ALTER TABLE routing_public.email_identities 
  ALTER COLUMN is_active DROP NOT NULL;