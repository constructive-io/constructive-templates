-- Deploy: schemas/routing_public/tables/sites/indexes/routing_public_sites_installation_id_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/sites/table
-- requires: schemas/routing_public/tables/sites/columns/installation_id/column


CREATE INDEX routing_public_sites_installation_id_idx ON routing_public.sites (installation_id);