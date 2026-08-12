-- Revert: schemas/routing_public/tables/email_site_identities/columns/created_at/column


ALTER TABLE routing_public.email_site_identities 
  DROP COLUMN created_at RESTRICT;