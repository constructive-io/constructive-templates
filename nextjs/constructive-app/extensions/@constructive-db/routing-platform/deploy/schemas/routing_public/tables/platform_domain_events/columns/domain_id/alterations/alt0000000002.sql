-- Deploy: schemas/routing_public/tables/platform_domain_events/columns/domain_id/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_domain_events/table
-- requires: schemas/routing_public/tables/platform_domain_events/columns/domain_id/column
-- requires: schemas/routing_public/tables/platform_domain_events/columns/managed_domain_id/column


ALTER TABLE routing_public.platform_domain_events 
  ADD CONSTRAINT platform_domain_events_domain_id_managed_domain_id_chk 
    CHECK (num_nonnulls(domain_id, managed_domain_id) = 1);