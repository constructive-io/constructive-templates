-- Revert: schemas/catalog_private/tables/bindings/columns/graph_id/column


ALTER TABLE catalog_private.bindings 
  DROP COLUMN graph_id RESTRICT;