-- Revert: schemas/routing_public/tables/route_bindings/columns/updated_at/alterations/alt0000000001


ALTER TABLE routing_public.route_bindings 
  ALTER COLUMN updated_at DROP NOT NULL;