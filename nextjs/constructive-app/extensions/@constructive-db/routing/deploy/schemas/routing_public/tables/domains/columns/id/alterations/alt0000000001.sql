-- Deploy: schemas/routing_public/tables/domains/columns/id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/domains/table
-- requires: schemas/routing_public/tables/domains/columns/id/column


ALTER TABLE routing_public.domains 
  ALTER COLUMN id SET NOT NULL;