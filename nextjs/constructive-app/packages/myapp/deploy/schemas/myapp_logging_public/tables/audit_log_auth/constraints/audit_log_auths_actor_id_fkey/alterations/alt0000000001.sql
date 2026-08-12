-- Deploy: schemas/myapp_logging_public/tables/audit_log_auth/constraints/audit_log_auths_actor_id_fkey/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_logging_public/schema
-- requires: schemas/myapp_logging_public/tables/audit_log_auth/constraints/audit_log_auths_actor_id_fkey/constraint


COMMENT ON CONSTRAINT audit_log_auths_actor_id_fkey ON myapp_logging_public.audit_log_auth IS E'@foreignFieldName authAuditLog';

