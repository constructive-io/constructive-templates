-- Revert: schemas/routing_public/tables/platform_apis/columns/name/alterations/alt0000000001


ALTER TABLE routing_public.platform_apis 
  ALTER COLUMN name DROP NOT NULL;