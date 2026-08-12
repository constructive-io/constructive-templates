-- Revert: schemas/routing_public/tables/email_identities/columns/updated_at/alterations/alt0000000001


ALTER TABLE routing_public.email_identities 
  ALTER COLUMN updated_at DROP DEFAULT;