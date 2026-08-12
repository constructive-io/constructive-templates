-- Revert: schemas/routing_public/tables/routes/columns/domain_id/column


ALTER TABLE routing_public.routes 
  DROP COLUMN domain_id RESTRICT;