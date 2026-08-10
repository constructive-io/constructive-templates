-- Revert: schemas/routing_public/tables/platform_pages/columns/updated_at/alterations/alt0000000001


ALTER TABLE routing_public.platform_pages 
  ALTER COLUMN updated_at DROP NOT NULL;