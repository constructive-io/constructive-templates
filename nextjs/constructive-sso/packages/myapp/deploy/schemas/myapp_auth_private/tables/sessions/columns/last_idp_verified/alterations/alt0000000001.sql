-- Deploy: schemas/myapp_auth_private/tables/sessions/columns/last_idp_verified/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/sessions/columns/last_idp_verified/column


COMMENT ON COLUMN myapp_auth_private.sessions.last_idp_verified IS E'Timestamp of last identity-provider assertion for step-up authentication';

