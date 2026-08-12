-- Deploy: schemas/routing_public/tables/database_settings/columns/enable_search/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/database_settings/columns/enable_search/column


COMMENT ON COLUMN routing_public.database_settings.enable_search IS 'Enable unified search (tsvector, BM25, pg_trgm, pgvector) in the GraphQL API';