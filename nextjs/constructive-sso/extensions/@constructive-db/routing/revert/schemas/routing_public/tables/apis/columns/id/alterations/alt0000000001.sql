-- Revert: schemas/routing_public/tables/apis/columns/id/alterations/alt0000000001


ALTER TABLE routing_public.apis 
  ALTER COLUMN id DROP NOT NULL;