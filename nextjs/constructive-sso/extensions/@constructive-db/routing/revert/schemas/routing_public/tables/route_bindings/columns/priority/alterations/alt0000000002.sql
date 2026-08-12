-- Revert: schemas/routing_public/tables/route_bindings/columns/priority/alterations/alt0000000002


ALTER TABLE routing_public.route_bindings 
  ALTER COLUMN priority DROP DEFAULT;