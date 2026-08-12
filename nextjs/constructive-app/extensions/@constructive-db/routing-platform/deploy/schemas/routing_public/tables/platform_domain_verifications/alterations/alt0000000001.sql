-- Deploy: schemas/routing_public/tables/platform_domain_verifications/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_domain_verifications/table


ALTER TABLE routing_public.platform_domain_verifications 
  DISABLE ROW LEVEL SECURITY;