-- Revert: schemas/routing_public/tables/site_themes/columns/is_active/alterations/alt0000000001


ALTER TABLE routing_public.site_themes 
  ALTER COLUMN is_active DROP NOT NULL;