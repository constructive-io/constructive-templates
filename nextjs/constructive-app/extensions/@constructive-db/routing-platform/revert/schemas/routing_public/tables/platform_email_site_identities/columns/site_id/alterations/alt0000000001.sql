-- Revert: schemas/routing_public/tables/platform_email_site_identities/columns/site_id/alterations/alt0000000001


ALTER TABLE routing_public.platform_email_site_identities 
  ALTER COLUMN site_id DROP NOT NULL;