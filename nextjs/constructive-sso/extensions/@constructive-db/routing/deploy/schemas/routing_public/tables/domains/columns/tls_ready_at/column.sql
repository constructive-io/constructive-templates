-- Deploy: schemas/routing_public/tables/domains/columns/tls_ready_at/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/domains/table


ALTER TABLE routing_public.domains 
  ADD COLUMN tls_ready_at timestamptz;