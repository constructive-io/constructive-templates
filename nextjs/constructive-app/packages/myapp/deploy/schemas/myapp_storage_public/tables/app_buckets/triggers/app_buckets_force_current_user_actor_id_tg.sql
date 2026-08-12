-- Deploy: schemas/myapp_storage_public/tables/app_buckets/triggers/app_buckets_force_current_user_actor_id_tg
-- made with <3 @ constructive.io

-- requires: schemas/myapp_app_private/schema
-- requires: schemas/myapp_storage_public/schema
-- requires: schemas/myapp_storage_public/tables/app_buckets/table
-- requires: schemas/myapp_app_private/trigger_fns/app_buckets_force_current_user_actor_id


CREATE TRIGGER app_buckets_force_current_user_actor_id_tg
BEFORE INSERT ON myapp_storage_public.app_buckets
FOR EACH ROW
EXECUTE PROCEDURE myapp_app_private.app_buckets_force_current_user_actor_id ( );

