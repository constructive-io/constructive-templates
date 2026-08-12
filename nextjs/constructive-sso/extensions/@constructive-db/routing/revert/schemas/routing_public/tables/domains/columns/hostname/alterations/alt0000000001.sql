-- Revert: schemas/routing_public/tables/domains/columns/hostname/alterations/alt0000000001


ALTER TABLE routing_public.domains 
  ALTER COLUMN hostname DROP NOT NULL;