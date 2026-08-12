-- Deploy: schemas/routing_public/tables/domain_events/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/domain_events/table


ALTER TABLE routing_public.domain_events 
  DISABLE ROW LEVEL SECURITY;