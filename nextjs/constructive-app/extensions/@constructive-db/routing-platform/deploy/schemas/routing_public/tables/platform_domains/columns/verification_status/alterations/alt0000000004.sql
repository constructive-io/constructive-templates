-- Deploy: schemas/routing_public/tables/platform_domains/columns/verification_status/alterations/alt0000000004
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_domains/table
-- requires: schemas/routing_public/tables/platform_domains/columns/verification_status/column


ALTER TABLE routing_public.platform_domains 
  ADD CONSTRAINT platform_domains_verification_status_chk 
    CHECK (verification_status IN ('unverified', 'pending', 'verified', 'failed'));