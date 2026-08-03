-- Deploy: schemas/routing_public/tables/platform_domain_events/columns/metadata/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_domain_events/table


ALTER TABLE routing_public.platform_domain_events 
  ADD COLUMN metadata jsonb;