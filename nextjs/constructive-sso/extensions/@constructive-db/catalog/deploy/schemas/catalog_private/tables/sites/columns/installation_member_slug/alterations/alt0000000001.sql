-- Deploy: schemas/catalog_private/tables/sites/columns/installation_member_slug/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites/columns/installation_member_slug/column


COMMENT ON COLUMN catalog_private.sites.installation_member_slug IS 'Slug of the release member that serves this site, propagated from the source row';