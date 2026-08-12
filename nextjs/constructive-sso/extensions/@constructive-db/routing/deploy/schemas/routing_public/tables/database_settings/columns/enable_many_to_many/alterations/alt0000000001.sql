-- Deploy: schemas/routing_public/tables/database_settings/columns/enable_many_to_many/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/database_settings/table
-- requires: schemas/routing_public/tables/database_settings/columns/enable_many_to_many/column


ALTER TABLE routing_public.database_settings 
  ALTER COLUMN enable_many_to_many SET NOT NULL;