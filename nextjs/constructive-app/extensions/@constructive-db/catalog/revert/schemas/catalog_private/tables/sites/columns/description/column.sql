-- Revert: schemas/catalog_private/tables/sites/columns/description/column


ALTER TABLE catalog_private.sites 
  DROP COLUMN description RESTRICT;