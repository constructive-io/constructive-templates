-- Deploy: schemas/routing_public/tables/database_settings/columns/enable_direct_uploads/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/database_settings/table
-- requires: schemas/routing_public/tables/database_settings/columns/enable_direct_uploads/column


ALTER TABLE routing_public.database_settings 
  ALTER COLUMN enable_direct_uploads SET DEFAULT true;