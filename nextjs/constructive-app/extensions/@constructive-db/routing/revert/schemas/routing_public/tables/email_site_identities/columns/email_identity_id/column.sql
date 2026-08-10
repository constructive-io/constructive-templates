-- Revert: schemas/routing_public/tables/email_site_identities/columns/email_identity_id/column


ALTER TABLE routing_public.email_site_identities 
  DROP COLUMN email_identity_id RESTRICT;