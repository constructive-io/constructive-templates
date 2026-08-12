-- Verify: schemas/myapp_limits_public/tables/org_limits/triggers/_99999_org_limits_audit_tg


SELECT assert_trigger('myapp_limits_public.org_limits'::regclass, '_99999_org_limits_audit_tg', 'myapp_limits_private.org_limits_audit_tg_fn'::regproc, 23);


