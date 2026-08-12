-- Revert: schemas/routing_public/tables/email_identities/columns/updated_at/column


ALTER TABLE routing_public.email_identities 
  DROP COLUMN updated_at RESTRICT;