-- Revert: schemas/routing_public/tables/sites/columns/config/column


ALTER TABLE routing_public.sites 
  DROP COLUMN config RESTRICT;