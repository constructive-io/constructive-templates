-- Revert: schemas/routing_public/tables/site_modules/columns/site_id/alterations/alt0000000001


ALTER TABLE routing_public.site_modules 
  ALTER COLUMN site_id DROP NOT NULL;