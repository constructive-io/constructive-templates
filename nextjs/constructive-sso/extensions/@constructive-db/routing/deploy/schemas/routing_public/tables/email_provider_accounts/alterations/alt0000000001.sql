-- Deploy: schemas/routing_public/tables/email_provider_accounts/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/email_provider_accounts/table


ALTER TABLE routing_public.email_provider_accounts 
  DISABLE ROW LEVEL SECURITY;