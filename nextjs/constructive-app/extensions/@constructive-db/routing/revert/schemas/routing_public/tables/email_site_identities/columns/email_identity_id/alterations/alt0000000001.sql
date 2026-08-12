-- Revert: schemas/routing_public/tables/email_site_identities/columns/email_identity_id/alterations/alt0000000001


ALTER TABLE routing_public.email_site_identities 
  ALTER COLUMN email_identity_id DROP NOT NULL;