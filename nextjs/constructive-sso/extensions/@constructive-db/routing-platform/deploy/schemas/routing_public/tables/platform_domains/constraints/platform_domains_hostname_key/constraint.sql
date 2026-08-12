-- Deploy: schemas/routing_public/tables/platform_domains/constraints/platform_domains_hostname_key/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_domains/table


ALTER TABLE routing_public.platform_domains 
  ADD CONSTRAINT platform_domains_hostname_key 
    UNIQUE (hostname);