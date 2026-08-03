-- Deploy: schemas/routing_public/tables/platform_domain_verifications/constraints/platform_domain_verifications_pkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_domain_verifications/table


ALTER TABLE routing_public.platform_domain_verifications 
  ADD CONSTRAINT platform_domain_verifications_pkey PRIMARY KEY (id);