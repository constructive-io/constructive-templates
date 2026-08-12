-- Deploy: schemas/routing_public/tables/domain_verifications/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/domain_verifications/table


ALTER TABLE routing_public.domain_verifications 
  DISABLE ROW LEVEL SECURITY;