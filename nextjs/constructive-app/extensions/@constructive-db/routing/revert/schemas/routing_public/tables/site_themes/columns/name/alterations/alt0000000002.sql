-- Revert: schemas/routing_public/tables/site_themes/columns/name/alterations/alt0000000002


ALTER TABLE routing_public.site_themes 
  ALTER COLUMN name DROP DEFAULT;