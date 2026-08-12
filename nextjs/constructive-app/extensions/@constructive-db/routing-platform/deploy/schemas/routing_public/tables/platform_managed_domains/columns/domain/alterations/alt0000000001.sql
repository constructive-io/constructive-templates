-- Deploy: schemas/routing_public/tables/platform_managed_domains/columns/domain/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_managed_domains/table
-- requires: schemas/routing_public/tables/platform_managed_domains/columns/domain/column


ALTER TABLE routing_public.platform_managed_domains 
  ALTER COLUMN domain SET NOT NULL;