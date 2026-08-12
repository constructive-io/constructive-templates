-- Deploy: schemas/routing_public/tables/domain_verifications/columns/created_at/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/domain_verifications/table
-- requires: schemas/routing_public/tables/domain_verifications/columns/created_at/column


ALTER TABLE routing_public.domain_verifications 
  ALTER COLUMN created_at SET DEFAULT now();