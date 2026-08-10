-- Verify: schemas/myapp_auth_private/tables/identity_providers/triggers/identity_providers_guard_step_up_del_tg


SELECT assert_trigger('myapp_auth_private.identity_providers'::regclass, 'identity_providers_guard_step_up_del_tg', 'myapp_app_private.identity_providers_guard_step_up_del_fn'::regproc, 11);


