-- Revert: schemas/routing_public/tables/apis/columns/updated_at/alterations/alt0000000001


ALTER TABLE routing_public.apis 
  ALTER COLUMN updated_at DROP DEFAULT;