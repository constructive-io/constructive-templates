-- Deploy: schemas/routing_public/tables/platform_managed_domains/columns/domain/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_managed_domains/table
-- requires: schemas/routing_public/tables/platform_managed_domains/columns/domain/column


ALTER TABLE routing_public.platform_managed_domains 
  ADD CONSTRAINT platform_managed_domains_domain_chk 
    CHECK (domain = lower(domain));