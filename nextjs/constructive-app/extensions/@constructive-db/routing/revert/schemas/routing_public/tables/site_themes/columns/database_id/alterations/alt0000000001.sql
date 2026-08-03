-- Revert: schemas/routing_public/tables/site_themes/columns/database_id/alterations/alt0000000001


ALTER TABLE routing_public.site_themes 
  ALTER COLUMN database_id DROP NOT NULL;