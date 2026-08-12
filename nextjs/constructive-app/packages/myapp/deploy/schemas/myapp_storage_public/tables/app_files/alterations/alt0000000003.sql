-- Deploy: schemas/myapp_storage_public/tables/app_files/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/myapp_storage_public/schema
-- requires: schemas/myapp_storage_public/tables/app_files/table


COMMENT ON TABLE myapp_storage_public.app_files IS E'@storageFiles
Individual file records within buckets, with immutable identity fields and mutable metadata';

