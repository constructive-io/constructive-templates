-- Deploy: schemas/routing_public/tables/domains/columns/managed/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/domains/table
-- requires: schemas/routing_public/tables/domains/columns/managed/column


ALTER TABLE routing_public.domains 
  ALTER COLUMN managed SET DEFAULT false;