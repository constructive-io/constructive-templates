-- Revert: schemas/routing_public/tables/platform_email_site_identities/columns/id/column


ALTER TABLE routing_public.platform_email_site_identities 
  DROP COLUMN id RESTRICT;