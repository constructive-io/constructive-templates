-- Revert: schemas/routing_public/tables/domains/columns/parent_hostname/column


ALTER TABLE routing_public.domains 
  DROP COLUMN parent_hostname RESTRICT;