-- Revert: schemas/catalog_private/tables/bindings/constraints/bindings_pkey/constraint


ALTER TABLE catalog_private.bindings 
  DROP CONSTRAINT bindings_pkey RESTRICT;