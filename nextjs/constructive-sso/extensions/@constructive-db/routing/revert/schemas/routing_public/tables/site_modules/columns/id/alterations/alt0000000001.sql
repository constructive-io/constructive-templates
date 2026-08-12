-- Revert: schemas/routing_public/tables/site_modules/columns/id/alterations/alt0000000001


ALTER TABLE routing_public.site_modules 
  ALTER COLUMN id DROP NOT NULL;