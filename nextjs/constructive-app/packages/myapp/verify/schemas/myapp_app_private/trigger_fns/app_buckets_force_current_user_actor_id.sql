-- Verify: schemas/myapp_app_private/trigger_fns/app_buckets_force_current_user_actor_id


SELECT assert_function('myapp_app_private.app_buckets_force_current_user_actor_id()'::regprocedure, 'TRIGGER'::regtype, false, false, 'VOLATILE');


