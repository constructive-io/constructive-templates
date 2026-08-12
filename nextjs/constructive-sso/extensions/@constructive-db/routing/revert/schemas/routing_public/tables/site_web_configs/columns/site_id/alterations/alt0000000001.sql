-- Revert: schemas/routing_public/tables/site_web_configs/columns/site_id/alterations/alt0000000001


ALTER TABLE routing_public.site_web_configs 
  ALTER COLUMN site_id DROP NOT NULL;