-- Revert: schemas/routing_public/tables/platform_email_site_identities/columns/site_id/column


ALTER TABLE routing_public.platform_email_site_identities 
  DROP COLUMN site_id RESTRICT;