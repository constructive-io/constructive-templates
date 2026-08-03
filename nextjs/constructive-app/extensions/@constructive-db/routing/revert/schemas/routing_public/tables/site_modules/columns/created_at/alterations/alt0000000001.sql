-- Revert: schemas/routing_public/tables/site_modules/columns/created_at/alterations/alt0000000001


ALTER TABLE routing_public.site_modules 
  ALTER COLUMN created_at DROP DEFAULT;