-- Deploy: schemas/myapp_user_identifiers_public/views/user_connected_accounts/view/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_public/schema
-- requires: schemas/myapp_user_identifiers_public/views/user_connected_accounts/view


COMMENT ON VIEW myapp_user_identifiers_public.user_connected_accounts IS E'@behavior -insert -update -delete';

