-- Revert: schemas/routing_public/tables/domains/columns/is_published/alterations/alt0000000001


ALTER TABLE routing_public.domains 
  ALTER COLUMN is_published DROP NOT NULL;