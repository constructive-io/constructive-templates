-- Deploy: schemas/routing_public/tables/platform_sites/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_sites/table


COMMENT ON TABLE routing_public.platform_sites IS '@scope platform
@scopeTier global
Site surfaces exposed by this scope; publication makes a surface bindable from other scopes';