-- Deploy: schemas/routing_public/tables/domain_events/columns/managed_domain_id/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/domain_events/table


ALTER TABLE routing_public.domain_events 
  ADD COLUMN managed_domain_id uuid;