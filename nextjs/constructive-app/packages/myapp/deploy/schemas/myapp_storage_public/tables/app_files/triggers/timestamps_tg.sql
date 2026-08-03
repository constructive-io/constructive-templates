-- Deploy: schemas/myapp_storage_public/tables/app_files/triggers/timestamps_tg
-- made with <3 @ constructive.io

-- requires: schemas/myapp_storage_public/schema
-- requires: schemas/myapp_storage_public/tables/app_files/table


CREATE TRIGGER timestamps_tg
BEFORE INSERT OR UPDATE ON myapp_storage_public.app_files
FOR EACH ROW
EXECUTE PROCEDURE stamps.timestamps ( );

