-- Verify: schemas/myapp_limits_public/tables/org_limit_aggregates/triggers/_99999_org_limit_aggregates_audit_tg


SELECT assert_trigger('myapp_limits_public.org_limit_aggregates'::regclass, '_99999_org_limit_aggregates_audit_tg', 'myapp_limits_private.org_limit_aggregates_audit_tg_fn'::regproc, 23);


