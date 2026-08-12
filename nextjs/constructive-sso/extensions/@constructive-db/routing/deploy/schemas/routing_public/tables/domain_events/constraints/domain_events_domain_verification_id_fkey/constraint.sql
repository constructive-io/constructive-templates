-- Deploy: schemas/routing_public/tables/domain_events/constraints/domain_events_domain_verification_id_fkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/domain_events/table
-- requires: schemas/routing_public/tables/domain_verifications/table


ALTER TABLE routing_public.domain_events 
  ADD CONSTRAINT domain_events_domain_verification_id_fkey
    FOREIGN KEY(domain_verification_id)
    REFERENCES routing_public.domain_verifications (id)
    ON DELETE SET NULL;