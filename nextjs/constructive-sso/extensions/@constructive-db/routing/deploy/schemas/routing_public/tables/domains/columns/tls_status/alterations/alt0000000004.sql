-- Deploy: schemas/routing_public/tables/domains/columns/tls_status/alterations/alt0000000004
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/domains/table
-- requires: schemas/routing_public/tables/domains/columns/tls_status/column


ALTER TABLE routing_public.domains 
  ADD CONSTRAINT domains_tls_status_chk 
    CHECK (tls_status IN ('none', 'pending', 'ready', 'failed'));