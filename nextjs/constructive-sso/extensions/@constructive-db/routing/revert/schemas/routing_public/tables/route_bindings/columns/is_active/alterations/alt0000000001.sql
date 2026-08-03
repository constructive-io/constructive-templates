-- Revert: schemas/routing_public/tables/route_bindings/columns/is_active/alterations/alt0000000001


ALTER TABLE routing_public.route_bindings 
  ALTER COLUMN is_active DROP NOT NULL;