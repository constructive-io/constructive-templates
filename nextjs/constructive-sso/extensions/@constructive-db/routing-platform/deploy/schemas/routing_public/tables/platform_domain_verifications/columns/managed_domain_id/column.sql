-- Deploy: schemas/routing_public/tables/platform_domain_verifications/columns/managed_domain_id/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_domain_verifications/table


ALTER TABLE routing_public.platform_domain_verifications 
  ADD COLUMN managed_domain_id uuid;