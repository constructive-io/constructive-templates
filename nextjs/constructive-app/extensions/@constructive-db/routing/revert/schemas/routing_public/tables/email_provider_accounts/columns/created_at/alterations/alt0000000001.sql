-- Revert: schemas/routing_public/tables/email_provider_accounts/columns/created_at/alterations/alt0000000001


ALTER TABLE routing_public.email_provider_accounts 
  ALTER COLUMN created_at DROP DEFAULT;