-- Revert: schemas/routing_public/tables/domains/columns/is_wildcard/alterations/alt0000000001


ALTER TABLE routing_public.domains 
  ALTER COLUMN is_wildcard DROP NOT NULL;