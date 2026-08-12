-- Deploy: schemas/routing_public/tables/domain_events/columns/updated_at/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/domain_events/table


ALTER TABLE routing_public.domain_events 
  ADD COLUMN updated_at timestamptz;