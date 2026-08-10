-- Verify: schemas/myapp_limits_public/tables/app_limits/triggers/_99999_app_limits_audit_tg


SELECT assert_trigger('myapp_limits_public.app_limits'::regclass, '_99999_app_limits_audit_tg', 'myapp_limits_private.app_limits_audit_tg_fn'::regproc, 23);


