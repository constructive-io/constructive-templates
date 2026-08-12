-- Revert: schemas/routing_public/tables/site_modules/columns/is_enabled/alterations/alt0000000002


ALTER TABLE routing_public.site_modules 
  ALTER COLUMN is_enabled DROP DEFAULT;