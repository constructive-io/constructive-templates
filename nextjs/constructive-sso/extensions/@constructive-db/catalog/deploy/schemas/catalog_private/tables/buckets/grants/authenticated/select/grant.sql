-- Deploy: schemas/catalog_private/tables/buckets/grants/authenticated/select/grant
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/buckets/table


GRANT SELECT ON catalog_private.buckets TO authenticated;