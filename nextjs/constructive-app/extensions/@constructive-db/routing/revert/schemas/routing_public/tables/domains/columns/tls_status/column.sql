-- Revert: schemas/routing_public/tables/domains/columns/tls_status/column


ALTER TABLE routing_public.domains 
  DROP COLUMN tls_status RESTRICT;