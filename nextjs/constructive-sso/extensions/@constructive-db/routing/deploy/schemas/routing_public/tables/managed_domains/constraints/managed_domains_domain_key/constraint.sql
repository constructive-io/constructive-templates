-- Deploy: schemas/routing_public/tables/managed_domains/constraints/managed_domains_domain_key/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/managed_domains/table


ALTER TABLE routing_public.managed_domains 
  ADD CONSTRAINT managed_domains_domain_key 
    UNIQUE (domain);