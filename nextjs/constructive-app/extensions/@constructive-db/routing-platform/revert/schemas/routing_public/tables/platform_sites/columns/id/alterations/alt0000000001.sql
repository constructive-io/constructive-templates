-- Revert: schemas/routing_public/tables/platform_sites/columns/id/alterations/alt0000000001


ALTER TABLE routing_public.platform_sites 
  ALTER COLUMN id DROP NOT NULL;