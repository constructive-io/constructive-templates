-- Revert: schemas/routing_public/tables/email_identities/columns/transport_mode/column


ALTER TABLE routing_public.email_identities 
  DROP COLUMN transport_mode RESTRICT;