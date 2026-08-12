-- Deploy: schemas/routing_public/tables/domains/indexes/routing_public_domains_database_id_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/domains/table
-- requires: schemas/routing_public/tables/domains/columns/database_id/column


CREATE INDEX routing_public_domains_database_id_idx ON routing_public.domains (database_id);