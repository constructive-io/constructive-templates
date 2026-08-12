-- Deploy: schemas/routing_public/tables/platform_email_provider_accounts/columns/name/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_email_provider_accounts/table
-- requires: schemas/routing_public/tables/platform_email_provider_accounts/columns/name/column


ALTER TABLE routing_public.platform_email_provider_accounts 
  ALTER COLUMN name SET NOT NULL;