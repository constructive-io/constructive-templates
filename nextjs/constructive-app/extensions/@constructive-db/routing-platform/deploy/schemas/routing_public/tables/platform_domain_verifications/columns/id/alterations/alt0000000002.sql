-- Deploy: schemas/routing_public/tables/platform_domain_verifications/columns/id/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_domain_verifications/table
-- requires: schemas/routing_public/tables/platform_domain_verifications/columns/id/column


ALTER TABLE routing_public.platform_domain_verifications 
  ALTER COLUMN id SET DEFAULT uuidv7();