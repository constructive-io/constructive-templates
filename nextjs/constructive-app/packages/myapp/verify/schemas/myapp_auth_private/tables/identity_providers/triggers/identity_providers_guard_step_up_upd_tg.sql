-- Verify: schemas/myapp_auth_private/tables/identity_providers/triggers/identity_providers_guard_step_up_upd_tg


SELECT assert_trigger('myapp_auth_private.identity_providers'::regclass, 'identity_providers_guard_step_up_upd_tg', 'myapp_app_private.identity_providers_guard_step_up_upd_fn'::regproc, 19);


