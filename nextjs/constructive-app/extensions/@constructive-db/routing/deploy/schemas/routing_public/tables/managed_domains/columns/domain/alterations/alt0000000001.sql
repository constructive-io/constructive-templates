-- Deploy: schemas/routing_public/tables/managed_domains/columns/domain/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/managed_domains/table
-- requires: schemas/routing_public/tables/managed_domains/columns/domain/column


ALTER TABLE routing_public.managed_domains 
  ALTER COLUMN domain SET NOT NULL;