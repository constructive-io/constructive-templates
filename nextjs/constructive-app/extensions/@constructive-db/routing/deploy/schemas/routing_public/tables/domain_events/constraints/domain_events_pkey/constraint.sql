-- Deploy: schemas/routing_public/tables/domain_events/constraints/domain_events_pkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/domain_events/table


ALTER TABLE routing_public.domain_events 
  ADD CONSTRAINT domain_events_pkey PRIMARY KEY (id);