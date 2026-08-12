-- Deploy: schemas/routing_public/tables/platform_managed_domains/columns/verification_status/alterations/alt0000000004
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_managed_domains/table
-- requires: schemas/routing_public/tables/platform_managed_domains/columns/verification_status/column


ALTER TABLE routing_public.platform_managed_domains 
  ADD CONSTRAINT platform_managed_domains_verification_status_chk 
    CHECK (verification_status IN ('pending', 'checking', 'verified', 'failed', 'expired'));