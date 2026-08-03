-- Deploy: schemas/routing_public/tables/api_settings/columns/enable_presigned_uploads/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/api_settings/table


ALTER TABLE routing_public.api_settings 
  ADD COLUMN enable_presigned_uploads boolean;