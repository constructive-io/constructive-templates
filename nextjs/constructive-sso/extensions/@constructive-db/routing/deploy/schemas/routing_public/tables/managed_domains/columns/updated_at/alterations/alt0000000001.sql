-- Deploy: schemas/routing_public/tables/managed_domains/columns/updated_at/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/managed_domains/table
-- requires: schemas/routing_public/tables/managed_domains/columns/updated_at/column


ALTER TABLE routing_public.managed_domains 
  ALTER COLUMN updated_at SET DEFAULT now();