-- Revert: schemas/routing_public/tables/domains/columns/updated_at/alterations/alt0000000001


ALTER TABLE routing_public.domains 
  ALTER COLUMN updated_at DROP DEFAULT;