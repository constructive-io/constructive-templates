-- Revert: schemas/routing_public/tables/domains/columns/verified_at/column


ALTER TABLE routing_public.domains 
  DROP COLUMN verified_at RESTRICT;