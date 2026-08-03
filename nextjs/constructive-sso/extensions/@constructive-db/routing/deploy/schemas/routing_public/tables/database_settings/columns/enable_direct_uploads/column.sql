-- Deploy: schemas/routing_public/tables/database_settings/columns/enable_direct_uploads/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/database_settings/table


ALTER TABLE routing_public.database_settings 
  ADD COLUMN enable_direct_uploads boolean;