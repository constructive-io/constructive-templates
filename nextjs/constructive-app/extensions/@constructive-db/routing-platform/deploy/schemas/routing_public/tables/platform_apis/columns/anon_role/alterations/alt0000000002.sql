-- Deploy: schemas/routing_public/tables/platform_apis/columns/anon_role/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_apis/columns/anon_role/column


COMMENT ON COLUMN routing_public.platform_apis.anon_role IS '@has_guard
Anonymous role the API executes as';