-- Revert: schemas/routing_public/tables/site_web_configs/columns/updated_at/alterations/alt0000000001


ALTER TABLE routing_public.site_web_configs 
  ALTER COLUMN updated_at DROP DEFAULT;