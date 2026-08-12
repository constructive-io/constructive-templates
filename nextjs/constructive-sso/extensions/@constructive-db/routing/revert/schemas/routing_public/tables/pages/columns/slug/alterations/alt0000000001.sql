-- Revert: schemas/routing_public/tables/pages/columns/slug/alterations/alt0000000001


ALTER TABLE routing_public.pages 
  ALTER COLUMN slug DROP NOT NULL;