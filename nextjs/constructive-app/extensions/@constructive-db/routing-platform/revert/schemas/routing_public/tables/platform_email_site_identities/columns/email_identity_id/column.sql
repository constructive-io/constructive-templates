-- Revert: schemas/routing_public/tables/platform_email_site_identities/columns/email_identity_id/column


ALTER TABLE routing_public.platform_email_site_identities 
  DROP COLUMN email_identity_id RESTRICT;