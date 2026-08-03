-- Revert: schemas/routing_public/tables/site_themes/columns/id/alterations/alt0000000001


ALTER TABLE routing_public.site_themes 
  ALTER COLUMN id DROP NOT NULL;