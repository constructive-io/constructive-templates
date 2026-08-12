-- Deploy: schemas/routing_public/tables/platform_pages/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_pages/table


COMMENT ON TABLE routing_public.platform_pages IS '@scope platform
@scopeTier global
Site-owned page content — merkle-versioned head over the infra store; never a routing surface';