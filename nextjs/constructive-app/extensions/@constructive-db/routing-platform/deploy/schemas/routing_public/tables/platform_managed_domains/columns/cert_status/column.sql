-- Deploy: schemas/routing_public/tables/platform_managed_domains/columns/cert_status/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_managed_domains/table


ALTER TABLE routing_public.platform_managed_domains 
  ADD COLUMN cert_status text;