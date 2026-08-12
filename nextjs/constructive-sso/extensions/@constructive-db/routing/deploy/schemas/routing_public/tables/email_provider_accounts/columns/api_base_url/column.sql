-- Deploy: schemas/routing_public/tables/email_provider_accounts/columns/api_base_url/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/email_provider_accounts/table


ALTER TABLE routing_public.email_provider_accounts 
  ADD COLUMN api_base_url text;