-- Revert: schemas/routing_public/tables/sites/columns/is_published/alterations/alt0000000001


ALTER TABLE routing_public.sites 
  ALTER COLUMN is_published DROP NOT NULL;