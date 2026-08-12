-- Deploy: schemas/routing_public/tables/managed_domains/indexes/managed_domains_database_id_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/managed_domains/table
-- requires: schemas/routing_public/tables/managed_domains/columns/database_id/column


CREATE INDEX managed_domains_database_id_idx ON routing_public.managed_domains (database_id);