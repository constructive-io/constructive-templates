-- Revert: schemas/routing_public/tables/platform_domains/columns/updated_at/alterations/alt0000000001


ALTER TABLE routing_public.platform_domains 
  ALTER COLUMN updated_at DROP DEFAULT;