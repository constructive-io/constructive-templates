-- Revert: schemas/routing_public/tables/route_bindings/columns/target_site_id/column


ALTER TABLE routing_public.route_bindings 
  DROP COLUMN target_site_id RESTRICT;