-- Revert: schemas/routing_public/tables/routes/columns/is_active/alterations/alt0000000001


ALTER TABLE routing_public.routes 
  ALTER COLUMN is_active DROP NOT NULL;