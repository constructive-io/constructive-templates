-- Revert: schemas/routing_public/tables/email_site_identities/columns/id/alterations/alt0000000002


ALTER TABLE routing_public.email_site_identities 
  ALTER COLUMN id DROP DEFAULT;