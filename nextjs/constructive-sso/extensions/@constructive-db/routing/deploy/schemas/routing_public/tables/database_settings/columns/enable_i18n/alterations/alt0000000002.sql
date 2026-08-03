-- Deploy: schemas/routing_public/tables/database_settings/columns/enable_i18n/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/database_settings/table
-- requires: schemas/routing_public/tables/database_settings/columns/enable_i18n/column


ALTER TABLE routing_public.database_settings 
  ALTER COLUMN enable_i18n SET DEFAULT false;