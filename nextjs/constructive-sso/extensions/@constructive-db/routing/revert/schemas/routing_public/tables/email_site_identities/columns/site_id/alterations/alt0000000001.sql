-- Revert: schemas/routing_public/tables/email_site_identities/columns/site_id/alterations/alt0000000001


ALTER TABLE routing_public.email_site_identities 
  ALTER COLUMN site_id DROP NOT NULL;