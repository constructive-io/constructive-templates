-- Revert: schemas/routing_public/tables/route_bindings/columns/id/alterations/alt0000000002


ALTER TABLE routing_public.route_bindings 
  ALTER COLUMN id DROP DEFAULT;