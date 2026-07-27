-- Deploy: schemas/myapp_auth_public/tables/principals/columns/is_read_only/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principals/columns/is_read_only/column


COMMENT ON COLUMN myapp_auth_public.principals.is_read_only IS E'Whether this principal is restricted to read-only operations';

