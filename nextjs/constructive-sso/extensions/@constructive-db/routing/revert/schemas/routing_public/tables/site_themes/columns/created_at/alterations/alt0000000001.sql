-- Revert: schemas/routing_public/tables/site_themes/columns/created_at/alterations/alt0000000001


ALTER TABLE routing_public.site_themes 
  ALTER COLUMN created_at DROP DEFAULT;