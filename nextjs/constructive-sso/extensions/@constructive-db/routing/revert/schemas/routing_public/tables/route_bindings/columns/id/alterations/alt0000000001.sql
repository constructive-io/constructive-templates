-- Revert: schemas/routing_public/tables/route_bindings/columns/id/alterations/alt0000000001


ALTER TABLE routing_public.route_bindings 
  ALTER COLUMN id DROP NOT NULL;