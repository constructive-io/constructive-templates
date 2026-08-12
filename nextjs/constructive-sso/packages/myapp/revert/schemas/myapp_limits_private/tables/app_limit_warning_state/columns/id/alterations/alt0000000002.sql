-- Revert: schemas/myapp_limits_private/tables/app_limit_warning_state/columns/id/alterations/alt0000000002


ALTER TABLE myapp_limits_private.app_limit_warning_state 
  ALTER COLUMN id DROP DEFAULT;


