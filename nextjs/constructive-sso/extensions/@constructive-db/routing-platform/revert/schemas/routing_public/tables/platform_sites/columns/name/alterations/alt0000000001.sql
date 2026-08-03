-- Revert: schemas/routing_public/tables/platform_sites/columns/name/alterations/alt0000000001


ALTER TABLE routing_public.platform_sites 
  ALTER COLUMN name DROP NOT NULL;