-- Revert: schemas/routing_public/tables/domains/columns/tls_status/alterations/alt0000000001


ALTER TABLE routing_public.domains 
  ALTER COLUMN tls_status DROP NOT NULL;