-- Deploy: schemas/routing_public/tables/email_provider_accounts/columns/database_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/email_provider_accounts/table
-- requires: schemas/routing_public/tables/email_provider_accounts/columns/database_id/column


ALTER TABLE routing_public.email_provider_accounts 
  ALTER COLUMN database_id SET NOT NULL;