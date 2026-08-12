-- Revert: schemas/routing_public/tables/email_site_identities/columns/site_id/column


ALTER TABLE routing_public.email_site_identities 
  DROP COLUMN site_id RESTRICT;