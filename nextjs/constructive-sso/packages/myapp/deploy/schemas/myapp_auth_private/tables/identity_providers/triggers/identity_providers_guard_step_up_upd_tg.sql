-- Deploy: schemas/myapp_auth_private/tables/identity_providers/triggers/identity_providers_guard_step_up_upd_tg
-- made with <3 @ constructive.io

-- requires: schemas/myapp_app_private/schema
-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/identity_providers/table
-- requires: schemas/myapp_app_private/trigger_fns/identity_providers_guard_step_up_upd_fn


CREATE TRIGGER identity_providers_guard_step_up_upd_tg
BEFORE UPDATE ON myapp_auth_private.identity_providers
FOR EACH ROW
WHEN ((NEW.slug IS DISTINCT FROM OLD.slug OR NEW.kind IS DISTINCT FROM OLD.kind OR NEW.enabled IS DISTINCT FROM OLD.enabled OR NEW.issuer_url IS DISTINCT FROM OLD.issuer_url OR NEW.discovery_url_override IS DISTINCT FROM OLD.discovery_url_override OR NEW.authorization_url IS DISTINCT FROM OLD.authorization_url OR NEW.token_url IS DISTINCT FROM OLD.token_url OR NEW.userinfo_url IS DISTINCT FROM OLD.userinfo_url OR NEW.client_id IS DISTINCT FROM OLD.client_id OR NEW.client_secret_id IS DISTINCT FROM OLD.client_secret_id OR NEW.acceptable_client_ids IS DISTINCT FROM OLD.acceptable_client_ids OR NEW.scopes IS DISTINCT FROM OLD.scopes OR NEW.extra_authorization_params IS DISTINCT FROM OLD.extra_authorization_params OR NEW.email_optional IS DISTINCT FROM OLD.email_optional OR NEW.allow_link_by_email IS DISTINCT FROM OLD.allow_link_by_email OR NEW.skip_nonce_check IS DISTINCT FROM OLD.skip_nonce_check OR NEW.pkce_enabled IS DISTINCT FROM OLD.pkce_enabled) AND OLD.created_at < (now() - '6 hours'::interval))
EXECUTE PROCEDURE myapp_app_private.identity_providers_guard_step_up_upd_fn ( );

