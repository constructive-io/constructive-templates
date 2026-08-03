-- Revert: schemas/routing_public/tables/domains/columns/created_at/column


ALTER TABLE routing_public.domains 
  DROP COLUMN created_at RESTRICT;