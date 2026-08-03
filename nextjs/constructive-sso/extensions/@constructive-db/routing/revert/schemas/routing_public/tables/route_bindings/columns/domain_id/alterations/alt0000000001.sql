-- Revert: schemas/routing_public/tables/route_bindings/columns/domain_id/alterations/alt0000000001


ALTER TABLE routing_public.route_bindings 
  ALTER COLUMN domain_id DROP NOT NULL;