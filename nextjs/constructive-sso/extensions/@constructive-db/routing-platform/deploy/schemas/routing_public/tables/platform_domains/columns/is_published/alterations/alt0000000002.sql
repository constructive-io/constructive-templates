-- Deploy: schemas/routing_public/tables/platform_domains/columns/is_published/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_domains/table
-- requires: schemas/routing_public/tables/platform_domains/columns/is_published/column


ALTER TABLE routing_public.platform_domains 
  ALTER COLUMN is_published SET DEFAULT false;