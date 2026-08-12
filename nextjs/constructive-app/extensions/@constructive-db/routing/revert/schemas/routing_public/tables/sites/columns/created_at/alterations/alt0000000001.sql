-- Revert: schemas/routing_public/tables/sites/columns/created_at/alterations/alt0000000001


ALTER TABLE routing_public.sites 
  ALTER COLUMN created_at DROP DEFAULT;