-- Deploy: schemas/routing_public/tables/platform_apis/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_apis/table


COMMENT ON TABLE routing_public.platform_apis IS '@scope platform
@scopeTier global
API surfaces exposed by this scope; publication makes a surface bindable from other scopes';