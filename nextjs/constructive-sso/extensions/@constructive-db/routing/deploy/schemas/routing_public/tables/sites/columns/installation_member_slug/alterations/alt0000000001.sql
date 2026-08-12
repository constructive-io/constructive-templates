-- Deploy: schemas/routing_public/tables/sites/columns/installation_member_slug/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/sites/columns/installation_member_slug/column


COMMENT ON COLUMN routing_public.sites.installation_member_slug IS 'Slug of the release member (a Service resource) that serves this site; set iff installation_id is set';