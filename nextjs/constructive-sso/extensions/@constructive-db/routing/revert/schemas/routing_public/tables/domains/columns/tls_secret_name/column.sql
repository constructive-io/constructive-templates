-- Revert: schemas/routing_public/tables/domains/columns/tls_secret_name/column


ALTER TABLE routing_public.domains 
  DROP COLUMN tls_secret_name RESTRICT;