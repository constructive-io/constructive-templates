-- Deploy: schemas/routing_public/tables/domains/columns/is_wildcard/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/domains/table
-- requires: schemas/routing_public/tables/domains/columns/is_wildcard/column


ALTER TABLE routing_public.domains 
  ALTER COLUMN is_wildcard SET DEFAULT false;