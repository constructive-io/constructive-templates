-- Deploy: schemas/routing_public/tables/platform_apis/columns/role_name/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_apis/columns/role_name/column


COMMENT ON COLUMN routing_public.platform_apis.role_name IS '@has_guard
Authenticated role the API executes as';