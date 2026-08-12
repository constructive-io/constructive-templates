-- Verify: schemas/myapp_storage_public/tables/app_files/triggers/app_files_force_current_user_actor_id_tg


SELECT assert_trigger('myapp_storage_public.app_files'::regclass, 'app_files_force_current_user_actor_id_tg', 'myapp_app_private.app_files_force_current_user_actor_id'::regproc, 7);


