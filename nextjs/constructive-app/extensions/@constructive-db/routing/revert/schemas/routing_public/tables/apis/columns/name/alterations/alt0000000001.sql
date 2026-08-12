-- Revert: schemas/routing_public/tables/apis/columns/name/alterations/alt0000000001


ALTER TABLE routing_public.apis 
  ALTER COLUMN name DROP NOT NULL;