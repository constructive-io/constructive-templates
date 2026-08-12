-- Deploy: schemas/routing_public/tables/domains/columns/verification_status/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/domains/table
-- requires: schemas/routing_public/tables/domains/columns/verification_status/column


ALTER TABLE routing_public.domains 
  ALTER COLUMN verification_status SET NOT NULL;