-- Revert: schemas/routing_public/tables/sites/columns/installation_id/column


ALTER TABLE routing_public.sites 
  DROP COLUMN installation_id RESTRICT;