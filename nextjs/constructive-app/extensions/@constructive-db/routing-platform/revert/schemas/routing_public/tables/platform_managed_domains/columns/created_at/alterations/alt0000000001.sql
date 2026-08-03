-- Revert: schemas/routing_public/tables/platform_managed_domains/columns/created_at/alterations/alt0000000001


ALTER TABLE routing_public.platform_managed_domains 
  ALTER COLUMN created_at DROP DEFAULT;