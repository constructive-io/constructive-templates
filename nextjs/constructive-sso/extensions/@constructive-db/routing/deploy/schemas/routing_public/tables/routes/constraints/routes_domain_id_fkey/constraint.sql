-- Deploy: schemas/routing_public/tables/routes/constraints/routes_domain_id_fkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/routes/table
-- requires: schemas/routing_public/tables/domains/table


ALTER TABLE routing_public.routes 
  ADD CONSTRAINT routes_domain_id_fkey
    FOREIGN KEY(domain_id)
    REFERENCES routing_public.domains (id)
    ON DELETE CASCADE;