-- Deploy: schemas/routing_public/tables/platform_domain_events/columns/id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_domain_events/table
-- requires: schemas/routing_public/tables/platform_domain_events/columns/id/column


ALTER TABLE routing_public.platform_domain_events 
  ALTER COLUMN id SET NOT NULL;