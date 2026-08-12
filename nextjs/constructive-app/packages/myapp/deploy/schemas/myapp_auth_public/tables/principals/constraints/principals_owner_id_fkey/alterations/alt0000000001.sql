-- Deploy: schemas/myapp_auth_public/tables/principals/constraints/principals_owner_id_fkey/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principals/constraints/principals_owner_id_fkey/constraint


COMMENT ON CONSTRAINT principals_owner_id_fkey ON myapp_auth_public.principals IS E'@foreignFieldName principals';

