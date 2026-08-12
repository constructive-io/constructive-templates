-- Verify: schemas/myapp_logging_public/tables/audit_log_auth/indexes/audit_log_auths_event_idx


SELECT assert_index('myapp_logging_public.audit_log_auths_event_idx'::regclass, 'myapp_logging_public.audit_log_auth'::regclass, false);


