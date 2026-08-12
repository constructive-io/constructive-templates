-- Revert: schemas/catalog_private/tables/domains/columns/parent_hostname/column


ALTER TABLE catalog_private.domains 
  DROP COLUMN parent_hostname RESTRICT;