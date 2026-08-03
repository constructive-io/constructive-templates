-- Deploy: schemas/platform_routing_public/tables/platform_routes/constraints/platform_routes_domain_id_fkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/platform_routing_public/schema
-- requires: schemas/routing_public/tables/platform_domains/table
-- requires: schemas/platform_routing_public/tables/platform_routes/table


ALTER TABLE platform_routing_public.platform_routes 
  ADD CONSTRAINT platform_routes_domain_id_fkey
    FOREIGN KEY(domain_id)
    REFERENCES routing_public.platform_domains (id)
    ON DELETE CASCADE;