-- Revert: schemas/routing_public/tables/platform_managed_domains/columns/domain/alterations/alt0000000001


ALTER TABLE routing_public.platform_managed_domains 
  ALTER COLUMN domain DROP NOT NULL;