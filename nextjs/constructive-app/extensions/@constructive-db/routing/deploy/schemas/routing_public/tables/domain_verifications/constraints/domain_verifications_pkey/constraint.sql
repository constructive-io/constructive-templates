-- Deploy: schemas/routing_public/tables/domain_verifications/constraints/domain_verifications_pkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/domain_verifications/table


ALTER TABLE routing_public.domain_verifications 
  ADD CONSTRAINT domain_verifications_pkey PRIMARY KEY (id);