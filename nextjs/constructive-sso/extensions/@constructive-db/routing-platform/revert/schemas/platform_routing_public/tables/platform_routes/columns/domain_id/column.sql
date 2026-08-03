-- Revert: schemas/platform_routing_public/tables/platform_routes/columns/domain_id/column


ALTER TABLE platform_routing_public.platform_routes 
  DROP COLUMN domain_id RESTRICT;