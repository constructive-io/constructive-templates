-- Verify: schemas/myapp_storage_public/tables/app_buckets/triggers/app_buckets_force_current_user_actor_id_tg


SELECT assert_trigger('myapp_storage_public.app_buckets'::regclass, 'app_buckets_force_current_user_actor_id_tg', 'myapp_app_private.app_buckets_force_current_user_actor_id'::regproc, 7);


