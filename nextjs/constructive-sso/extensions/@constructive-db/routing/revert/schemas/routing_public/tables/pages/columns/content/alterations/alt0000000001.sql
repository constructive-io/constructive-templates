-- Revert: schemas/routing_public/tables/pages/columns/content/alterations/alt0000000001


ALTER TABLE routing_public.pages 
  ALTER COLUMN content DROP NOT NULL;