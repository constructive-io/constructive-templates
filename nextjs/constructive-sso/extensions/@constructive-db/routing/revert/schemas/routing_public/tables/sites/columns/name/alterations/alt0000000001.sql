-- Revert: schemas/routing_public/tables/sites/columns/name/alterations/alt0000000001


ALTER TABLE routing_public.sites 
  ALTER COLUMN name DROP NOT NULL;