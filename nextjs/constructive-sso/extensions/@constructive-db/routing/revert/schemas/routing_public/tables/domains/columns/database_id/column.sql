-- Revert: schemas/routing_public/tables/domains/columns/database_id/column


ALTER TABLE routing_public.domains 
  DROP COLUMN database_id RESTRICT;