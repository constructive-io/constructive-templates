-- Verify: schemas/myapp_logging_public/tables/audit_log_auth/policies/auth_sel_dir_own/policy


SELECT assert_policy('myapp_logging_public.audit_log_auth'::regclass, 'auth_sel_dir_own', 'SELECT', true, true, false);


