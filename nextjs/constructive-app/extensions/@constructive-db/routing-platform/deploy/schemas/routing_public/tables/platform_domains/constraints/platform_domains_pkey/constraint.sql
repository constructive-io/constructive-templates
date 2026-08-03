-- Deploy: schemas/routing_public/tables/platform_domains/constraints/platform_domains_pkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_domains/table


ALTER TABLE routing_public.platform_domains 
  ADD CONSTRAINT platform_domains_pkey PRIMARY KEY (id);