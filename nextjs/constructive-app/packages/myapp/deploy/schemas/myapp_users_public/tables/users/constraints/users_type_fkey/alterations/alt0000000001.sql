-- Deploy: schemas/myapp_users_public/tables/users/constraints/users_type_fkey/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_users_public/schema
-- requires: schemas/myapp_users_public/tables/users/constraints/users_type_fkey/constraint


COMMENT ON CONSTRAINT users_type_fkey ON myapp_users_public.users IS E'@backwardBehavior -list -connection -single -filterBy';

