-- Revert: schemas/routing_public/tables/platform_domains/columns/is_wildcard/alterations/alt0000000001


ALTER TABLE routing_public.platform_domains 
  ALTER COLUMN is_wildcard DROP NOT NULL;