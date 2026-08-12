-- Revert: schemas/routing_public/tables/site_web_configs/columns/created_at/alterations/alt0000000001


ALTER TABLE routing_public.site_web_configs 
  ALTER COLUMN created_at DROP DEFAULT;