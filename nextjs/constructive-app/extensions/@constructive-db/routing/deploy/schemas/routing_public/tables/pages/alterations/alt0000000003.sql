-- Deploy: schemas/routing_public/tables/pages/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/pages/table


COMMENT ON TABLE routing_public.pages IS '@scope database
@scopeKey database_id
@scopeTier database
Site-owned page content — merkle-versioned head over the infra store; never a routing surface';