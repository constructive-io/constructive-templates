-- Revert: schemas/routing_public/tables/site_themes/columns/site_id/alterations/alt0000000001


ALTER TABLE routing_public.site_themes 
  ALTER COLUMN site_id DROP NOT NULL;