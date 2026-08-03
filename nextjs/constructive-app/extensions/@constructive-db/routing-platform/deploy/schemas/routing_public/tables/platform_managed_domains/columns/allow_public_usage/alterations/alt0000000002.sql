-- Deploy: schemas/routing_public/tables/platform_managed_domains/columns/allow_public_usage/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_managed_domains/table
-- requires: schemas/routing_public/tables/platform_managed_domains/columns/allow_public_usage/column


ALTER TABLE routing_public.platform_managed_domains 
  ALTER COLUMN allow_public_usage SET DEFAULT false;