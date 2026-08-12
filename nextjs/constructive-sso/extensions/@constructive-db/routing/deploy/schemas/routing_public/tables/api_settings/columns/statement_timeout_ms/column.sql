-- Deploy: schemas/routing_public/tables/api_settings/columns/statement_timeout_ms/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/api_settings/table


ALTER TABLE routing_public.api_settings 
  ADD COLUMN statement_timeout_ms bigint;