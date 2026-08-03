-- Deploy: schemas/routing_public/tables/domains/columns/is_published/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/domains/table


ALTER TABLE routing_public.domains 
  ADD COLUMN is_published boolean;