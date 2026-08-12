-- Revert: schemas/routing_public/tables/platform_email_identities/columns/is_active/alterations/alt0000000001


ALTER TABLE routing_public.platform_email_identities 
  ALTER COLUMN is_active DROP NOT NULL;