-- Deploy: schemas/routing_public/tables/platform_domains/columns/hostname/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_domains/table
-- requires: schemas/routing_public/tables/platform_domains/columns/hostname/column


ALTER TABLE routing_public.platform_domains 
  ADD CONSTRAINT platform_domains_hostname_chk 
    CHECK (hostname = lower(hostname));