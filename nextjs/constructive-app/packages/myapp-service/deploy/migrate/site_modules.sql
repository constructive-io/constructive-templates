-- Deploy: migrate/site_modules
-- made with <3 @ constructive.io

-- requires: migrate/domains


SET session_replication_role TO replica;
-- using replica in case we are deploying triggers to metaschema_public

-- unaccent, postgis affected and require grants
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public to public;

DO $LQLMIGRATION$
  DECLARE
  BEGIN

    EXECUTE format('GRANT CONNECT ON DATABASE %I TO %I', current_database(), 'app_user');
    EXECUTE format('GRANT CONNECT ON DATABASE %I TO %I', current_database(), 'app_admin');

  END;
$LQLMIGRATION$;

INSERT INTO services_public.site_modules (
  id,
  database_id,
  site_id,
  name,
  data
) VALUES
  ('019fa2a1-500a-7277-80aa-f900e17fb295', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5009-7a3c-8273-4676bbf9bcaa', 'legal_terms_module', '{"site":{"www":"constructive.io","host":"app.constructive.io","siteUrl":"https://app.constructive.io"},"emails":{"abuse":"abuse@constructive.io","hello":"hello@constructive.io","legal":"legal@constructive.io","privacy":"privacy@constructive.io","support":"support@constructive.io","copyright":"copyright@constructive.io","arbitrationOptOut":"arbitration-opt-out@constructive.io"},"company":{"addr":["28 Geary","STE 650 #2503","San Francisco CA 94108"],"name":"Interweb, Inc.","nick":"Myapp","website":"https://constructive.io/","legalState":"California","legalCounty":"San Francisco"}}'),
  ('019fa2a1-72e6-7760-b0cf-db908601aa67', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5009-7a3c-8273-4676bbf9bcaa', 'user_auth_module', '{"sign_in":"sign_in","sign_up":"sign_up","sign_out":"sign_out","auth_schema":"myapp_auth_public","set_password":"set_password","verify_email":"verify_email","check_password":"check_password","reset_password":"reset_password","forgot_password":"forgot_password","verify_password":"verify_password","send_verification_email":"send_verification_email"}');


SET session_replication_role TO DEFAULT;


