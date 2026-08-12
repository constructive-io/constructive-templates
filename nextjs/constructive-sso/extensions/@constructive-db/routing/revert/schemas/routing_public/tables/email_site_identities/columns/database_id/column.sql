-- Revert: schemas/routing_public/tables/email_site_identities/columns/database_id/column


ALTER TABLE routing_public.email_site_identities 
  DROP COLUMN database_id RESTRICT;