-- Revert: schemas/routing_public/tables/routes/columns/config/column


ALTER TABLE routing_public.routes 
  DROP COLUMN config RESTRICT;