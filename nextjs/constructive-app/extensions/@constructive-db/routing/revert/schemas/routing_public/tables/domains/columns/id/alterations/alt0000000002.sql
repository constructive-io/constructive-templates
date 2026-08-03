-- Revert: schemas/routing_public/tables/domains/columns/id/alterations/alt0000000002


ALTER TABLE routing_public.domains 
  ALTER COLUMN id DROP DEFAULT;