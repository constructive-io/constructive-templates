-- Deploy: schemas/routing_public/tables/platform_email_provider_accounts/columns/provider_account_name/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_email_provider_accounts/table


ALTER TABLE routing_public.platform_email_provider_accounts 
  ADD COLUMN provider_account_name text;