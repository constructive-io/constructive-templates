-- Revert: schemas/routing_public/tables/platform_apis/columns/id/alterations/alt0000000001


ALTER TABLE routing_public.platform_apis 
  ALTER COLUMN id DROP NOT NULL;