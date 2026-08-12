-- Revert: schemas/routing_public/tables/platform_email_identities/columns/from_address/alterations/alt0000000001


ALTER TABLE routing_public.platform_email_identities 
  ALTER COLUMN from_address DROP NOT NULL;