-- Revert: schemas/routing_public/tables/sites/columns/database_id/column


ALTER TABLE routing_public.sites 
  DROP COLUMN database_id RESTRICT;