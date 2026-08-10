-- Verify: schemas/myapp_auth_public/tables/principals/triggers/principals_guard_step_up_upd_tg


SELECT assert_trigger('myapp_auth_public.principals'::regclass, 'principals_guard_step_up_upd_tg', 'myapp_app_private.principals_guard_step_up_upd_fn'::regproc, 19);


