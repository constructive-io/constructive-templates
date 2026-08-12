-- Revert: schemas/routing_public/tables/email_identities/columns/created_at/alterations/alt0000000001


ALTER TABLE routing_public.email_identities 
  ALTER COLUMN created_at DROP DEFAULT;