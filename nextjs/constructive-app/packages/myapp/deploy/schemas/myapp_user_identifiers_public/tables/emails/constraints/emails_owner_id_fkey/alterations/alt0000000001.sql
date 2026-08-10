-- Deploy: schemas/myapp_user_identifiers_public/tables/emails/constraints/emails_owner_id_fkey/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_public/schema
-- requires: schemas/myapp_user_identifiers_public/tables/emails/constraints/emails_owner_id_fkey/constraint


COMMENT ON CONSTRAINT emails_owner_id_fkey ON myapp_user_identifiers_public.emails IS E'@foreignFieldName emails';

