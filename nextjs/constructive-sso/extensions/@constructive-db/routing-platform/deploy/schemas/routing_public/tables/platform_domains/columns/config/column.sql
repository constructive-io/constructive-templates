-- Deploy: schemas/routing_public/tables/platform_domains/columns/config/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_domains/table


ALTER TABLE routing_public.platform_domains 
  ADD COLUMN config jsonb;