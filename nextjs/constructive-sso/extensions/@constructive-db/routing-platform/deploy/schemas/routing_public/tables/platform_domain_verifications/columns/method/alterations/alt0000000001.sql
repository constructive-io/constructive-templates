-- Deploy: schemas/routing_public/tables/platform_domain_verifications/columns/method/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_domain_verifications/table
-- requires: schemas/routing_public/tables/platform_domain_verifications/columns/method/column


ALTER TABLE routing_public.platform_domain_verifications 
  ALTER COLUMN method SET NOT NULL;