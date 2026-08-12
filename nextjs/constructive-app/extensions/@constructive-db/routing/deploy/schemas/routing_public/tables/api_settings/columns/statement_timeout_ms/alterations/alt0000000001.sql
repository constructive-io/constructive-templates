-- Deploy: schemas/routing_public/tables/api_settings/columns/statement_timeout_ms/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/api_settings/columns/statement_timeout_ms/column


COMMENT ON COLUMN routing_public.api_settings.statement_timeout_ms IS 'Override: GraphQL statement timeout in milliseconds (NULL = inherit from database_settings). Clamped by the plan cap at read time.';