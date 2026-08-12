-- Revert: schemas/routing_public/tables/email_identities/columns/database_id/alterations/alt0000000001


ALTER TABLE routing_public.email_identities 
  ALTER COLUMN database_id DROP NOT NULL;