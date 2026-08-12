-- Deploy: schemas/routing_public/tables/platform_domain_verifications/columns/attempts/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_domain_verifications/table
-- requires: schemas/routing_public/tables/platform_domain_verifications/columns/attempts/column


ALTER TABLE routing_public.platform_domain_verifications 
  ALTER COLUMN attempts SET NOT NULL;