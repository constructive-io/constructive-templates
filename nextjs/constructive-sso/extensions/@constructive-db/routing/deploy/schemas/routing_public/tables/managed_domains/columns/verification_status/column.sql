-- Deploy: schemas/routing_public/tables/managed_domains/columns/verification_status/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/managed_domains/table


ALTER TABLE routing_public.managed_domains 
  ADD COLUMN verification_status text;