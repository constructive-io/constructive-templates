-- Verify: local-fixes
-- Asserts the validator override has been applied by grepping the
-- function source for the membership_types OR-branch added in
-- constructive-db commit 5a35b43773.

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM pg_proc p
        JOIN pg_namespace n ON n.oid = p.pronamespace
        WHERE n.nspname = 'metaschema_modules_public'
          AND p.proname = 'tg_validate_blueprint_definition'
          AND pg_get_functiondef(p.oid) LIKE '%membership_types%'
    ) THEN
        RAISE EXCEPTION 'verify: tg_validate_blueprint_definition missing membership_types branch';
    END IF;
END $$;

