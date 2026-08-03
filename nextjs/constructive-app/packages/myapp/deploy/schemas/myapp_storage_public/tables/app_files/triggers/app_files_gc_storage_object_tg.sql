-- Deploy: schemas/myapp_storage_public/tables/app_files/triggers/app_files_gc_storage_object_tg
-- made with <3 @ constructive.io

-- requires: schemas/myapp_storage_public/schema
-- requires: schemas/myapp_storage_private/schema
-- requires: schemas/myapp_storage_public/tables/app_files/table
-- requires: schemas/myapp_storage_private/trigger_fns/app_files_gc_storage_object


CREATE TRIGGER app_files_gc_storage_object_tg
AFTER DELETE ON myapp_storage_public.app_files
FOR EACH ROW
EXECUTE PROCEDURE myapp_storage_private.app_files_gc_storage_object ( );

