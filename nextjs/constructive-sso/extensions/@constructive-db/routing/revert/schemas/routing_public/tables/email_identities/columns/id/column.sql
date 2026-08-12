-- Revert: schemas/routing_public/tables/email_identities/columns/id/column


ALTER TABLE routing_public.email_identities 
  DROP COLUMN id RESTRICT;