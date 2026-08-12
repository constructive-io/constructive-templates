-- Deploy: schemas/routing_public/tables/managed_domains/columns/tls_status/alterations/alt0000000004
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/managed_domains/table
-- requires: schemas/routing_public/tables/managed_domains/columns/tls_status/column


ALTER TABLE routing_public.managed_domains 
  ADD CONSTRAINT managed_domains_tls_status_chk 
    CHECK (tls_status IN ('none', 'provisioning', 'active', 'failed'));