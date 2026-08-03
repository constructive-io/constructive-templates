-- Revert: schemas/routing_public/tables/routes/columns/domain_id/alterations/alt0000000001


ALTER TABLE routing_public.routes 
  ALTER COLUMN domain_id DROP NOT NULL;