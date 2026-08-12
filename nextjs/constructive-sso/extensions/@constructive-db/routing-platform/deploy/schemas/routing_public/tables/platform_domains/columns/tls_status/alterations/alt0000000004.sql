-- Deploy: schemas/routing_public/tables/platform_domains/columns/tls_status/alterations/alt0000000004
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_domains/table
-- requires: schemas/routing_public/tables/platform_domains/columns/tls_status/column


ALTER TABLE routing_public.platform_domains 
  ADD CONSTRAINT platform_domains_tls_status_chk 
    CHECK (tls_status IN ('none', 'pending', 'ready', 'failed'));