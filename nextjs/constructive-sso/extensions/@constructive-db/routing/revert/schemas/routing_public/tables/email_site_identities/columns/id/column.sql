-- Revert: schemas/routing_public/tables/email_site_identities/columns/id/column


ALTER TABLE routing_public.email_site_identities 
  DROP COLUMN id RESTRICT;