-- Deploy: schemas/routing_public/tables/domain_verifications/columns/status/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/domain_verifications/table
-- requires: schemas/routing_public/tables/domain_verifications/columns/status/column


ALTER TABLE routing_public.domain_verifications 
  ALTER COLUMN status SET DEFAULT 'pending';