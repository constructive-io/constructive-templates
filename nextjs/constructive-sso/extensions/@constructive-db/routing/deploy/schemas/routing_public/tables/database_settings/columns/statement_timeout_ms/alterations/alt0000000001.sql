-- Deploy: schemas/routing_public/tables/database_settings/columns/statement_timeout_ms/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/database_settings/columns/statement_timeout_ms/column


COMMENT ON COLUMN routing_public.database_settings.statement_timeout_ms IS 'Scope-wide default GraphQL statement timeout in milliseconds; NULL inherits the platform default. Clamped by the plan cap at read time.';