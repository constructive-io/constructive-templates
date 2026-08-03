-- Deploy: schemas/routing_public/tables/domains/constraints/domains_hostname_key/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/domains/table


ALTER TABLE routing_public.domains 
  ADD CONSTRAINT domains_hostname_key 
    UNIQUE (hostname);