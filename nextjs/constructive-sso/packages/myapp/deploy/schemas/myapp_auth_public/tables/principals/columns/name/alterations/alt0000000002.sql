-- Deploy: schemas/myapp_auth_public/tables/principals/columns/name/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principals/columns/name/column


COMMENT ON COLUMN myapp_auth_public.principals.name IS E'Human-readable label for this principal (e.g., billing-bot, ci-deploy-key)';

