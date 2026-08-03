-- Deploy: schemas/myapp_auth_public/tables/principals/columns/bypass_step_up/alterations/alt0000000004
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principals/columns/bypass_step_up/column


COMMENT ON COLUMN myapp_auth_public.principals.bypass_step_up IS E'@has_guard
Whether this principal bypasses MFA step-up requirements';

