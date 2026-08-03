-- Deploy: schemas/routing_public/tables/managed_domains/columns/domain/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/managed_domains/table
-- requires: schemas/routing_public/tables/managed_domains/columns/domain/column


ALTER TABLE routing_public.managed_domains 
  ADD CONSTRAINT managed_domains_domain_chk 
    CHECK (domain = lower(domain));