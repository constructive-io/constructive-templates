-- Revert: schemas/routing_public/tables/route_bindings/columns/domain_id/column


ALTER TABLE routing_public.route_bindings 
  DROP COLUMN domain_id RESTRICT;