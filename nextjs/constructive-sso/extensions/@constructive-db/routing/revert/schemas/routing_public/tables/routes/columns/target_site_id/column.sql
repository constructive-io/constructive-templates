-- Revert: schemas/routing_public/tables/routes/columns/target_site_id/column


ALTER TABLE routing_public.routes 
  DROP COLUMN target_site_id RESTRICT;