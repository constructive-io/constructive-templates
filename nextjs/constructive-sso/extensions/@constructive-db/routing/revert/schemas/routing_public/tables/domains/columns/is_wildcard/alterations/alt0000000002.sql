-- Revert: schemas/routing_public/tables/domains/columns/is_wildcard/alterations/alt0000000002


ALTER TABLE routing_public.domains 
  ALTER COLUMN is_wildcard DROP DEFAULT;