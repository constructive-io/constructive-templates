-- Revert: schemas/myapp_auth_private/tables/app_settings_rate_limit/alterations/fix0000000003


DELETE FROM myapp_auth_private.app_settings_rate_limit
WHERE
  ip_rate_limit_window = '15 minutes'::interval AND ip_max_attempts = 250 AND ip_lockout_duration = '30 minutes'::interval AND user_rate_limit_window = '15 minutes'::interval AND user_max_attempts = 10 AND user_lockout_duration = '15 minutes'::interval AND email_cooldown_period = '1 minute'::interval AND ip_ua_max_attempts = 50 AND login_max_attempts = 5 AND login_lockout_duration = '15 minutes'::interval;


