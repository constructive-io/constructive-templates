-- Revert: schemas/routing_public/tables/platform_managed_domains/columns/allow_public_usage/alterations/alt0000000001


ALTER TABLE routing_public.platform_managed_domains 
  ALTER COLUMN allow_public_usage DROP NOT NULL;