-- Revert: schemas/routing_public/tables/platform_email_identities/columns/name/alterations/alt0000000001


ALTER TABLE routing_public.platform_email_identities 
  ALTER COLUMN name DROP NOT NULL;