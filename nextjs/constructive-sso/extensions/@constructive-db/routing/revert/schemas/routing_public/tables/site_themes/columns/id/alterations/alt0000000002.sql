-- Revert: schemas/routing_public/tables/site_themes/columns/id/alterations/alt0000000002


ALTER TABLE routing_public.site_themes 
  ALTER COLUMN id DROP DEFAULT;