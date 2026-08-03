-- Revert: schemas/routing_public/tables/domains/columns/managed/alterations/alt0000000001


ALTER TABLE routing_public.domains 
  ALTER COLUMN managed DROP NOT NULL;