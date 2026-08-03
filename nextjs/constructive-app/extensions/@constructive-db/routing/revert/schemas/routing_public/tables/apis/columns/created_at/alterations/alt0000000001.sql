-- Revert: schemas/routing_public/tables/apis/columns/created_at/alterations/alt0000000001


ALTER TABLE routing_public.apis 
  ALTER COLUMN created_at DROP DEFAULT;