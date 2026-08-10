-- Revert: schemas/routing_public/tables/email_identities/columns/transport_mode/alterations/alt0000000002


ALTER TABLE routing_public.email_identities 
  ALTER COLUMN transport_mode DROP DEFAULT;