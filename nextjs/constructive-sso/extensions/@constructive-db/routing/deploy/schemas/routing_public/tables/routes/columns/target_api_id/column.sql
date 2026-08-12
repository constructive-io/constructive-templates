-- Deploy: schemas/routing_public/tables/routes/columns/target_api_id/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/routes/table


ALTER TABLE routing_public.routes 
  ADD COLUMN target_api_id uuid;