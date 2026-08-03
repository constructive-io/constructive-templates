-- Revert: schemas/routing_public/tables/apis/columns/config/column


ALTER TABLE routing_public.apis 
  DROP COLUMN config RESTRICT;