-- Deploy: schemas/routing_public/tables/platform_domain_events/constraints/platform_domain_events_domain_id_fkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_domains/table
-- requires: schemas/routing_public/tables/platform_domain_events/table


ALTER TABLE routing_public.platform_domain_events 
  ADD CONSTRAINT platform_domain_events_domain_id_fkey
    FOREIGN KEY(domain_id)
    REFERENCES routing_public.platform_domains (id)
    ON DELETE CASCADE;