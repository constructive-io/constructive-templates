-- Verify: schemas/myapp_auth_public/tables/principal_scope_overrides/triggers/principal_scope_overrides_guard_step_up_upd_tg


SELECT assert_trigger('myapp_auth_public.principal_scope_overrides'::regclass, 'principal_scope_overrides_guard_step_up_upd_tg', 'myapp_app_private.principal_scope_overrides_guard_step_up_upd_fn'::regproc, 19);


