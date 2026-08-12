-- Revert: schemas/routing_public/tables/platform_email_identities/columns/updated_at/alterations/alt0000000001


ALTER TABLE routing_public.platform_email_identities 
  ALTER COLUMN updated_at DROP DEFAULT;