-- Deploy: schemas/catalog_private/tables/domains/grants/authenticated/select/grant
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/domains/table


GRANT SELECT ON catalog_private.domains TO authenticated;