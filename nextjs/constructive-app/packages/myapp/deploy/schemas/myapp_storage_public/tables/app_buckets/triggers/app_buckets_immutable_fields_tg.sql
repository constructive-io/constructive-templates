-- Deploy: schemas/myapp_storage_public/tables/app_buckets/triggers/app_buckets_immutable_fields_tg
-- made with <3 @ constructive.io

-- requires: schemas/myapp_app_private/schema
-- requires: schemas/myapp_storage_public/schema
-- requires: schemas/myapp_storage_public/tables/app_buckets/table
-- requires: schemas/myapp_app_private/trigger_fns/app_buckets_immutable_fields


CREATE TRIGGER app_buckets_immutable_fields_tg
BEFORE UPDATE ON myapp_storage_public.app_buckets
FOR EACH ROW
EXECUTE PROCEDURE myapp_app_private.app_buckets_immutable_fields ( );

