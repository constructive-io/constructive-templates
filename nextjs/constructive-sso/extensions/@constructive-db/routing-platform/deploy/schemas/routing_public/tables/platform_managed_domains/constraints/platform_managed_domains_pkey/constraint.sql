-- Deploy: schemas/routing_public/tables/platform_managed_domains/constraints/platform_managed_domains_pkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_managed_domains/table


ALTER TABLE routing_public.platform_managed_domains 
  ADD CONSTRAINT platform_managed_domains_pkey PRIMARY KEY (id);