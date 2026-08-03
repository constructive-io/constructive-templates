-- Deploy: schemas/routing_public/tables/domain_verifications/constraints/domain_verifications_domain_id_fkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/domains/table
-- requires: schemas/routing_public/tables/domain_verifications/table


ALTER TABLE routing_public.domain_verifications 
  ADD CONSTRAINT domain_verifications_domain_id_fkey
    FOREIGN KEY(domain_id)
    REFERENCES routing_public.domains (id)
    ON DELETE CASCADE;