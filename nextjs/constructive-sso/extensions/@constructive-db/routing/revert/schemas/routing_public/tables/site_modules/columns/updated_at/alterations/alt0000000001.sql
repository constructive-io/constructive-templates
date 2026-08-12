-- Revert: schemas/routing_public/tables/site_modules/columns/updated_at/alterations/alt0000000001


ALTER TABLE routing_public.site_modules 
  ALTER COLUMN updated_at DROP DEFAULT;