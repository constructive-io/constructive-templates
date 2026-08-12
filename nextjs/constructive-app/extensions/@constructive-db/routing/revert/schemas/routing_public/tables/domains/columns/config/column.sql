-- Revert: schemas/routing_public/tables/domains/columns/config/column


ALTER TABLE routing_public.domains 
  DROP COLUMN config RESTRICT;