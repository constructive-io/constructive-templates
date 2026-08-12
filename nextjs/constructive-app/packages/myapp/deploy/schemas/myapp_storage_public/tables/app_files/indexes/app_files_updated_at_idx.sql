-- Deploy: schemas/myapp_storage_public/tables/app_files/indexes/app_files_updated_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/myapp_storage_public/schema
-- requires: schemas/myapp_storage_public/tables/app_files/table
-- requires: schemas/myapp_storage_public/tables/app_files/columns/updated_at/column


CREATE INDEX app_files_updated_at_idx ON myapp_storage_public.app_files ( updated_at );

