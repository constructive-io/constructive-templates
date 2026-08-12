-- Revert: schemas/routing_public/tables/email_identities/columns/is_active/alterations/alt0000000002


ALTER TABLE routing_public.email_identities 
  ALTER COLUMN is_active DROP DEFAULT;