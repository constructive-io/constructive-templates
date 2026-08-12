-- Deploy: schemas/routing_public/tables/platform_email_provider_accounts/columns/is_active/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_email_provider_accounts/table
-- requires: schemas/routing_public/tables/platform_email_provider_accounts/columns/is_active/column


ALTER TABLE routing_public.platform_email_provider_accounts 
  ALTER COLUMN is_active SET NOT NULL;