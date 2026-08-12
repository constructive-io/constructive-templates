-- Revert: schemas/routing_public/tables/platform_email_site_identities/columns/created_at/column


ALTER TABLE routing_public.platform_email_site_identities 
  DROP COLUMN created_at RESTRICT;