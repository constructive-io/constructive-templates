-- Revert: schemas/routing_public/tables/pages/columns/site_id/alterations/alt0000000001


ALTER TABLE routing_public.pages 
  ALTER COLUMN site_id DROP NOT NULL;