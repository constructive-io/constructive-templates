-- Revert: schemas/routing_public/tables/email_identities/columns/id/alterations/alt0000000001


ALTER TABLE routing_public.email_identities 
  ALTER COLUMN id DROP NOT NULL;