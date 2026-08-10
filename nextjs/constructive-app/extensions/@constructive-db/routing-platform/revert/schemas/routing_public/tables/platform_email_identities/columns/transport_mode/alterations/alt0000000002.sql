-- Revert: schemas/routing_public/tables/platform_email_identities/columns/transport_mode/alterations/alt0000000002


ALTER TABLE routing_public.platform_email_identities 
  ALTER COLUMN transport_mode DROP DEFAULT;