-- Deploy: schemas/myapp_auth_public/tables/principals/columns/user_id/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principals/columns/user_id/column


COMMENT ON COLUMN myapp_auth_public.principals.user_id IS E'The user row (type=3 Principal) that represents this principal identity';

