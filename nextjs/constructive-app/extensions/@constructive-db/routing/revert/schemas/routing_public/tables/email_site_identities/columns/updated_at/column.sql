-- Revert: schemas/routing_public/tables/email_site_identities/columns/updated_at/column


ALTER TABLE routing_public.email_site_identities 
  DROP COLUMN updated_at RESTRICT;