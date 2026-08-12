-- Revert: schemas/routing_public/tables/platform_email_identities/columns/transport_mode/column


ALTER TABLE routing_public.platform_email_identities 
  DROP COLUMN transport_mode RESTRICT;