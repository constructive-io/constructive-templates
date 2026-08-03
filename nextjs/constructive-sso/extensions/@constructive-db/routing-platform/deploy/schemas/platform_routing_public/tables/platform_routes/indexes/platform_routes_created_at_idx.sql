-- Deploy: schemas/platform_routing_public/tables/platform_routes/indexes/platform_routes_created_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/platform_routing_public/schema
-- requires: schemas/platform_routing_public/tables/platform_routes/table
-- requires: schemas/platform_routing_public/tables/platform_routes/columns/created_at/column


CREATE INDEX platform_routes_created_at_idx ON platform_routing_public.platform_routes (created_at);