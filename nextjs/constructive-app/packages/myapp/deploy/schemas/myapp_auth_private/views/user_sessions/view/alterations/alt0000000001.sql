-- Deploy: schemas/myapp_auth_private/views/user_sessions/view/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/views/user_sessions/view


COMMENT ON VIEW myapp_auth_private.user_sessions IS E'@behavior -insert -update -delete';

