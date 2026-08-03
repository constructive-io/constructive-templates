-- Revert: schemas/routing_public/tables/domains/columns/updated_at/column


ALTER TABLE routing_public.domains 
  DROP COLUMN updated_at RESTRICT;