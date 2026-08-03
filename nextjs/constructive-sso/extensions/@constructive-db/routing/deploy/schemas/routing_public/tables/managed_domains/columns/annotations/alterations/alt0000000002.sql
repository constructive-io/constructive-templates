-- Deploy: schemas/routing_public/tables/managed_domains/columns/annotations/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/managed_domains/table
-- requires: schemas/routing_public/tables/managed_domains/columns/annotations/column


ALTER TABLE routing_public.managed_domains 
  ALTER COLUMN annotations SET DEFAULT '{}'::jsonb;