-- Revert: schemas/routing_public/tables/route_bindings/columns/is_active/alterations/alt0000000002


ALTER TABLE routing_public.route_bindings 
  ALTER COLUMN is_active DROP DEFAULT;