-- Revert: schemas/routing_public/tables/sites/columns/id/alterations/alt0000000001


ALTER TABLE routing_public.sites 
  ALTER COLUMN id DROP NOT NULL;