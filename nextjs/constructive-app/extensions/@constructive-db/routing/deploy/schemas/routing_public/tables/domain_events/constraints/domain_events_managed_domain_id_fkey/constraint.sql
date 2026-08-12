-- Deploy: schemas/routing_public/tables/domain_events/constraints/domain_events_managed_domain_id_fkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/domain_events/table
-- requires: schemas/routing_public/tables/managed_domains/table


ALTER TABLE routing_public.domain_events 
  ADD CONSTRAINT domain_events_managed_domain_id_fkey
    FOREIGN KEY(managed_domain_id)
    REFERENCES routing_public.managed_domains (id)
    ON DELETE CASCADE;