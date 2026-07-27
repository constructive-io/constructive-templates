-- Deploy: schemas/myapp_auth_public/tables/principals/columns/use_admin_owner/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principals/columns/use_admin_owner/column


COMMENT ON COLUMN myapp_auth_public.principals.use_admin_owner IS E'Whether this principal inherits admin/owner privileges from the owner';

