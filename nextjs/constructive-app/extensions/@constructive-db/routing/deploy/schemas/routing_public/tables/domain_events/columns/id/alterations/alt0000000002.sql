-- Deploy: schemas/routing_public/tables/domain_events/columns/id/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/domain_events/table
-- requires: schemas/routing_public/tables/domain_events/columns/id/column


ALTER TABLE routing_public.domain_events 
  ALTER COLUMN id SET DEFAULT uuidv7();