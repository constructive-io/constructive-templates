-- Deploy: schemas/routing_public/tables/email_provider_accounts/columns/webhook_signing_secret_name/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/email_provider_accounts/table


ALTER TABLE routing_public.email_provider_accounts 
  ADD COLUMN webhook_signing_secret_name text;