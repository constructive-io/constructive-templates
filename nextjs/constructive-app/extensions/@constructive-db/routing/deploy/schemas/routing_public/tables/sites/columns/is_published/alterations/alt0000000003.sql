-- Deploy: schemas/routing_public/tables/sites/columns/is_published/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/sites/columns/is_published/column


COMMENT ON COLUMN routing_public.sites.is_published IS 'Whether other scopes may see and route to this site surface';