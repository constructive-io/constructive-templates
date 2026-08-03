-- Deploy: schemas/myapp_storage_public/tables/app_files/triggers/app_files_immutable_fields_tg
-- made with <3 @ constructive.io

-- requires: schemas/myapp_app_private/schema
-- requires: schemas/myapp_storage_public/schema
-- requires: schemas/myapp_storage_public/tables/app_files/table
-- requires: schemas/myapp_app_private/trigger_fns/app_files_immutable_fields


CREATE TRIGGER app_files_immutable_fields_tg
BEFORE UPDATE ON myapp_storage_public.app_files
FOR EACH ROW
EXECUTE PROCEDURE myapp_app_private.app_files_immutable_fields ( );

