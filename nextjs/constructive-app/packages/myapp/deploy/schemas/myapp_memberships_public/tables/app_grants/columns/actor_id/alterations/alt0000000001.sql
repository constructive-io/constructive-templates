-- Deploy: schemas/myapp_memberships_public/tables/app_grants/columns/actor_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_memberships_public/schema
-- requires: schemas/myapp_memberships_public/tables/app_grants/columns/actor_id/column


COMMENT ON COLUMN myapp_memberships_public.app_grants.actor_id IS E'The member receiving or losing the capability grant; NULL if user was deleted';

