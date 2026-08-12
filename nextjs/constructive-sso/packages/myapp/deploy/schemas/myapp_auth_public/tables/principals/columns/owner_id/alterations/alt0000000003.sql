-- Deploy: schemas/myapp_auth_public/tables/principals/columns/owner_id/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principals/columns/owner_id/column


COMMENT ON COLUMN myapp_auth_public.principals.owner_id IS E'@has_guard
The human user who owns and manages this principal';

