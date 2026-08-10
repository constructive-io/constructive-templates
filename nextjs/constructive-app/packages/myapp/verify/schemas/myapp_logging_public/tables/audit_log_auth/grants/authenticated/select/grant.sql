-- Verify: schemas/myapp_logging_public/tables/audit_log_auth/grants/authenticated/select/grant


SELECT assert_table_grant('myapp_logging_public.audit_log_auth'::regclass, 'authenticated', 'SELECT', NULL, true);


