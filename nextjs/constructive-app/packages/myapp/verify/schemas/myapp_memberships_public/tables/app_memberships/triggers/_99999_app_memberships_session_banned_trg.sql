-- Verify: schemas/myapp_memberships_public/tables/app_memberships/triggers/_99999_app_memberships_session_banned_trg


SELECT assert_trigger('myapp_memberships_public.app_memberships'::regclass, '_99999_app_memberships_session_banned_trg', 'myapp_auth_private.app_memberships_session_banned_tg'::regproc, 17);


