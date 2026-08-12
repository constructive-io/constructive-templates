\echo Use "CREATE EXTENSION myapp" to load this file. \quit
CREATE SCHEMA myapp_app_public;

GRANT USAGE ON SCHEMA myapp_app_public TO administrator;

GRANT USAGE ON SCHEMA myapp_app_public TO authenticated;

GRANT USAGE ON SCHEMA myapp_app_public TO anonymous;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_app_public
  GRANT ALL ON TABLES TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_app_public
  GRANT USAGE ON SEQUENCES TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_app_public
  GRANT ALL ON FUNCTIONS TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_app_public
  GRANT ALL ON FUNCTIONS TO authenticated;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_app_public
  GRANT USAGE ON SEQUENCES TO authenticated;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_app_public
  GRANT ALL ON FUNCTIONS TO anonymous;

CREATE SCHEMA myapp_app_private;

GRANT USAGE ON SCHEMA myapp_app_private TO administrator;

GRANT USAGE ON SCHEMA myapp_app_private TO authenticated;

GRANT USAGE ON SCHEMA myapp_app_private TO anonymous;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_app_private
  GRANT ALL ON TABLES TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_app_private
  GRANT USAGE ON SEQUENCES TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_app_private
  GRANT ALL ON FUNCTIONS TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_app_private
  GRANT ALL ON FUNCTIONS TO authenticated;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_app_private
  GRANT USAGE ON SEQUENCES TO authenticated;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_app_private
  GRANT ALL ON FUNCTIONS TO anonymous;

CREATE SCHEMA myapp_users_public;

GRANT USAGE ON SCHEMA myapp_users_public TO administrator;

GRANT USAGE ON SCHEMA myapp_users_public TO authenticated;

GRANT USAGE ON SCHEMA myapp_users_public TO anonymous;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_users_public
  GRANT ALL ON TABLES TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_users_public
  GRANT USAGE ON SEQUENCES TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_users_public
  GRANT ALL ON FUNCTIONS TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_users_public
  GRANT ALL ON FUNCTIONS TO authenticated;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_users_public
  GRANT USAGE ON SEQUENCES TO authenticated;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_users_public
  GRANT ALL ON FUNCTIONS TO anonymous;

CREATE TABLE myapp_users_public.users ();

ALTER TABLE myapp_users_public.users 
  DISABLE ROW LEVEL SECURITY;

ALTER TABLE myapp_users_public.users 
  ADD COLUMN id uuid;

ALTER TABLE myapp_users_public.users 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_users_public.users 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_users_public.users 
  ADD CONSTRAINT users_pkey PRIMARY KEY (id);

ALTER TABLE myapp_users_public.users 
  ADD COLUMN username citext;

ALTER TABLE myapp_users_public.users 
  ADD CONSTRAINT users_username_chk 
    CHECK (character_length(username) <= 256);

ALTER TABLE myapp_users_public.users 
  ADD CONSTRAINT users_username_key 
    UNIQUE (username);

ALTER TABLE myapp_users_public.users 
  ADD COLUMN display_name text;

ALTER TABLE myapp_users_public.users 
  ADD CONSTRAINT users_display_name_chk 
    CHECK (character_length(display_name) <= 256);

ALTER TABLE myapp_users_public.users 
  ADD COLUMN profile_picture image;

ALTER TABLE myapp_users_public.users 
  ADD COLUMN search_tsv tsvector;

CREATE FUNCTION myapp_app_private.users_search_tsv_tsv() RETURNS trigger AS $EOFCODE$

BEGIN
NEW.search_tsv = (setweight(to_tsvector('pg_catalog.simple', COALESCE(NEW.display_name, '')), 'B') || setweight(to_tsvector('pg_catalog.simple', COALESCE(NEW.username, '')), 'A'));
RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE;

CREATE TRIGGER users_search_tsv_tsv_insert_tg
  BEFORE INSERT
  ON myapp_users_public.users
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_app_private.users_search_tsv_tsv();

CREATE TRIGGER users_search_tsv_tsv_update_tg
  BEFORE UPDATE
  ON myapp_users_public.users
  FOR EACH ROW
  WHEN (old.username IS DISTINCT FROM new.username
    OR old.display_name IS DISTINCT FROM new.display_name)
  EXECUTE PROCEDURE myapp_app_private.users_search_tsv_tsv();

CREATE INDEX users_search_tsv_gin_idx ON myapp_users_public.users USING gin (search_tsv);

CREATE TABLE myapp_users_public.role_types ();

ALTER TABLE myapp_users_public.role_types 
  DISABLE ROW LEVEL SECURITY;

ALTER TABLE myapp_users_public.role_types 
  ADD COLUMN id int;

ALTER TABLE myapp_users_public.role_types 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_users_public.role_types 
  ADD CONSTRAINT role_types_pkey PRIMARY KEY (id);

ALTER TABLE myapp_users_public.role_types 
  ADD COLUMN name citext;

ALTER TABLE myapp_users_public.role_types 
  ALTER COLUMN name SET NOT NULL;

ALTER TABLE myapp_users_public.role_types 
  ADD CONSTRAINT role_types_name_key 
    UNIQUE (name);

ALTER TABLE myapp_users_public.users 
  ADD COLUMN type int;

ALTER TABLE myapp_users_public.users 
  ALTER COLUMN type SET NOT NULL;

ALTER TABLE myapp_users_public.users 
  ALTER COLUMN type SET DEFAULT 1;

ALTER TABLE myapp_users_public.users 
  ADD CONSTRAINT users_type_fkey
    FOREIGN KEY(type)
    REFERENCES myapp_users_public.role_types (id)
    ON DELETE RESTRICT;

CREATE INDEX users_type_idx ON myapp_users_public.users (type);

INSERT INTO myapp_users_public.role_types (
  id,
  name
) VALUES
  (1, 'User'),
  (2, 'Organization'),
  (3, 'Principal');

ALTER TABLE myapp_users_public.users 
  ADD COLUMN created_at timestamptz;

ALTER TABLE myapp_users_public.users 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE myapp_users_public.users 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE myapp_users_public.users 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE TRIGGER timestamps_tg
  BEFORE INSERT OR UPDATE
  ON myapp_users_public.users
  FOR EACH ROW
  EXECUTE PROCEDURE stamps.timestamps();

CREATE INDEX users_created_at_idx ON myapp_users_public.users (created_at);

CREATE INDEX users_updated_at_idx ON myapp_users_public.users (updated_at);

ALTER TABLE myapp_users_public.users 
  ENABLE ROW LEVEL SECURITY;

GRANT SELECT ON myapp_users_public.users TO authenticated;

GRANT DELETE ON myapp_users_public.users TO authenticated;

GRANT UPDATE ( username, display_name, profile_picture ) ON myapp_users_public.users TO authenticated;

GRANT INSERT ( type, display_name, profile_picture, username ) ON myapp_users_public.users TO authenticated;

CREATE POLICY auth_sel_all_all
  ON myapp_users_public.users
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    true
  );

CREATE SCHEMA myapp_memberships_public;

GRANT USAGE ON SCHEMA myapp_memberships_public TO administrator;

GRANT USAGE ON SCHEMA myapp_memberships_public TO authenticated;

GRANT USAGE ON SCHEMA myapp_memberships_public TO anonymous;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_memberships_public
  GRANT ALL ON TABLES TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_memberships_public
  GRANT USAGE ON SEQUENCES TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_memberships_public
  GRANT ALL ON FUNCTIONS TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_memberships_public
  GRANT ALL ON FUNCTIONS TO authenticated;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_memberships_public
  GRANT USAGE ON SEQUENCES TO authenticated;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_memberships_public
  GRANT ALL ON FUNCTIONS TO anonymous;

CREATE TABLE myapp_memberships_public.membership_types ();

ALTER TABLE myapp_memberships_public.membership_types 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_memberships_public.membership_types IS 'Defines the different scopes of membership (e.g. App Member, Organization Member, Group Member)';

ALTER TABLE myapp_memberships_public.membership_types 
  ADD COLUMN id int;

ALTER TABLE myapp_memberships_public.membership_types 
  ALTER COLUMN id SET NOT NULL;

COMMENT ON COLUMN myapp_memberships_public.membership_types.id IS 'Integer identifier for the membership type (1=App, 2=Organization, 3=Group)';

ALTER TABLE myapp_memberships_public.membership_types 
  ADD CONSTRAINT membership_types_pkey PRIMARY KEY (id);

ALTER TABLE myapp_memberships_public.membership_types 
  ADD COLUMN name citext;

ALTER TABLE myapp_memberships_public.membership_types 
  ALTER COLUMN name SET NOT NULL;

COMMENT ON COLUMN myapp_memberships_public.membership_types.name IS 'Human-readable name of the membership type';

ALTER TABLE myapp_memberships_public.membership_types 
  ADD COLUMN description text;

ALTER TABLE myapp_memberships_public.membership_types 
  ALTER COLUMN description SET NOT NULL;

COMMENT ON COLUMN myapp_memberships_public.membership_types.description IS 'Description of what this membership type represents';

ALTER TABLE myapp_memberships_public.membership_types 
  ADD COLUMN scope text;

ALTER TABLE myapp_memberships_public.membership_types 
  ALTER COLUMN scope SET NOT NULL;

COMMENT ON COLUMN myapp_memberships_public.membership_types.scope IS 'Scope identifier for this membership type, used to resolve scope on module config tables';

ALTER TABLE myapp_memberships_public.membership_types 
  ADD COLUMN parent_membership_type int;

COMMENT ON COLUMN myapp_memberships_public.membership_types.parent_membership_type IS 'Parent membership type ID for SPRT cascade chain (e.g. type 2 parent=1, type 3 parent=2)';

ALTER TABLE myapp_memberships_public.membership_types 
  ADD COLUMN has_users_table_entry boolean;

ALTER TABLE myapp_memberships_public.membership_types 
  ALTER COLUMN has_users_table_entry SET NOT NULL;

ALTER TABLE myapp_memberships_public.membership_types 
  ALTER COLUMN has_users_table_entry SET DEFAULT false;

COMMENT ON COLUMN myapp_memberships_public.membership_types.has_users_table_entry IS 'When true, entities of this membership type get a one-to-one ID in the users table and a corresponding role_type entry, enabling them to own resources via owner_id FKs';

ALTER TABLE myapp_memberships_public.membership_types 
  ADD CONSTRAINT membership_types_name_key 
    UNIQUE (name);

INSERT INTO myapp_memberships_public.membership_types (
  id,
  name,
  description,
  scope,
  parent_membership_type,
  has_users_table_entry
) VALUES
  (1, 'App Member', 'Memberships to the app.', 'app', NULL, CAST('f' AS boolean)),
  (2, 'Organization Member', 'Membership to an organization.', 'org', 1, CAST('t' AS boolean));

ALTER TABLE myapp_memberships_public.membership_types 
  ENABLE ROW LEVEL SECURITY;

GRANT SELECT ON myapp_memberships_public.membership_types TO authenticated;

CREATE POLICY auth_sel_all_all
  ON myapp_memberships_public.membership_types
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    true
  );

CREATE SCHEMA myapp_permissions_public;

GRANT USAGE ON SCHEMA myapp_permissions_public TO administrator;

GRANT USAGE ON SCHEMA myapp_permissions_public TO authenticated;

GRANT USAGE ON SCHEMA myapp_permissions_public TO anonymous;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_permissions_public
  GRANT ALL ON TABLES TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_permissions_public
  GRANT USAGE ON SEQUENCES TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_permissions_public
  GRANT ALL ON FUNCTIONS TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_permissions_public
  GRANT ALL ON FUNCTIONS TO authenticated;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_permissions_public
  GRANT USAGE ON SEQUENCES TO authenticated;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_permissions_public
  GRANT ALL ON FUNCTIONS TO anonymous;

CREATE SCHEMA myapp_permissions_private;

GRANT USAGE ON SCHEMA myapp_permissions_private TO administrator;

GRANT USAGE ON SCHEMA myapp_permissions_private TO authenticated;

GRANT USAGE ON SCHEMA myapp_permissions_private TO anonymous;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_permissions_private
  GRANT ALL ON TABLES TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_permissions_private
  GRANT USAGE ON SEQUENCES TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_permissions_private
  GRANT ALL ON FUNCTIONS TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_permissions_private
  GRANT ALL ON FUNCTIONS TO authenticated;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_permissions_private
  GRANT USAGE ON SEQUENCES TO authenticated;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_permissions_private
  GRANT ALL ON FUNCTIONS TO anonymous;

CREATE TABLE myapp_permissions_public.app_permissions ();

ALTER TABLE myapp_permissions_public.app_permissions 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_permissions_public.app_permissions IS 'Defines available permissions as named bits within a bitmask, used by the RBAC system for access control';

ALTER TABLE myapp_permissions_public.app_permissions 
  ADD COLUMN id uuid;

ALTER TABLE myapp_permissions_public.app_permissions 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_permissions_public.app_permissions 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_permissions_public.app_permissions 
  ADD CONSTRAINT app_permissions_pkey PRIMARY KEY (id);

ALTER TABLE myapp_permissions_public.app_permissions 
  ADD COLUMN name citext;

COMMENT ON COLUMN myapp_permissions_public.app_permissions.name IS 'Human-readable permission name (e.g. read, write, manage)';

ALTER TABLE myapp_permissions_public.app_permissions 
  ADD CONSTRAINT app_permissions_name_key 
    UNIQUE (name);

ALTER TABLE myapp_permissions_public.app_permissions 
  ADD COLUMN bitnum int;

ALTER TABLE myapp_permissions_public.app_permissions 
  ADD CONSTRAINT app_permissions_bitnum_chk 
    CHECK (
    bitnum >= 1
      AND bitnum <= 64
  );

COMMENT ON COLUMN myapp_permissions_public.app_permissions.bitnum IS 'Position of this permission in the bitmask (1-indexed), must be unique per permission set';

ALTER TABLE myapp_permissions_public.app_permissions 
  ADD CONSTRAINT app_permissions_bitnum_key 
    UNIQUE (bitnum);

ALTER TABLE myapp_permissions_public.app_permissions 
  ADD COLUMN bitstr pg_catalog.bit(64);

ALTER TABLE myapp_permissions_public.app_permissions 
  ALTER COLUMN bitstr SET NOT NULL;

ALTER TABLE myapp_permissions_public.app_permissions 
  ALTER COLUMN bitstr SET DEFAULT CAST(lpad('', 64, '0') AS pg_catalog.bit(64));

COMMENT ON COLUMN myapp_permissions_public.app_permissions.bitstr IS 'Pre-computed bitmask with only this permission bit set, used for bitwise OR/AND operations';

ALTER TABLE myapp_permissions_public.app_permissions 
  ADD COLUMN description text;

COMMENT ON COLUMN myapp_permissions_public.app_permissions.description IS 'Human-readable description of what this permission allows';

ALTER TABLE myapp_permissions_public.app_permissions 
  ENABLE ROW LEVEL SECURITY;

GRANT SELECT ON myapp_permissions_public.app_permissions TO authenticated;

CREATE POLICY auth_sel_all_all
  ON myapp_permissions_public.app_permissions
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    true
  );

CREATE FUNCTION myapp_permissions_public.app_permissions_get_padded_mask(
  mask pg_catalog.varbit
) RETURNS pg_catalog.varbit AS $EOFCODE$
SELECT utils.bitmask_pad(mask, 64, '0')
$EOFCODE$ LANGUAGE sql IMMUTABLE SECURITY INVOKER;

CREATE FUNCTION myapp_permissions_public.app_permissions_get_by_mask(
  mask pg_catalog.varbit
) RETURNS SETOF myapp_permissions_public.app_permissions AS $EOFCODE$
SELECT *
FROM myapp_permissions_public.app_permissions
WHERE
  (bitstr & myapp_permissions_public.app_permissions_get_padded_mask(mask)) = bitstr
$EOFCODE$ LANGUAGE sql STABLE SECURITY INVOKER;

CREATE FUNCTION myapp_permissions_public.app_permissions_get_mask(
  ids uuid[]
) RETURNS pg_catalog.varbit AS $EOFCODE$
SELECT bit_or(bitstr)
FROM myapp_permissions_public.app_permissions
WHERE
  id = ANY( ids )
$EOFCODE$ LANGUAGE sql STABLE SECURITY INVOKER;

CREATE FUNCTION myapp_permissions_public.app_permissions_get_mask_by_names(
  names citext[]
) RETURNS pg_catalog.varbit AS $EOFCODE$
SELECT bit_or(bitstr)
FROM myapp_permissions_public.app_permissions
WHERE
  name = ANY( names )
$EOFCODE$ LANGUAGE sql STABLE SECURITY INVOKER;

CREATE FUNCTION myapp_permissions_private.app_permissions_bitnum_tg() RETURNS trigger AS $EOFCODE$
DECLARE
  bitlen int := bit_length(NEW.bitstr);
BEGIN
  NEW.bitstr := (lpad('', bitlen - NEW.bitnum, '0') || '1') || lpad('', NEW.bitnum - 1, '0');
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY INVOKER;

CREATE TRIGGER app_permissions_insert_trg
  BEFORE INSERT
  ON myapp_permissions_public.app_permissions
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_permissions_private.app_permissions_bitnum_tg();

CREATE TABLE myapp_permissions_public.app_permission_defaults ();

ALTER TABLE myapp_permissions_public.app_permission_defaults 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_permissions_public.app_permission_defaults IS 'Stores the default permission bitmask assigned to new members upon joining';

ALTER TABLE myapp_permissions_public.app_permission_defaults 
  ADD COLUMN id uuid;

ALTER TABLE myapp_permissions_public.app_permission_defaults 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_permissions_public.app_permission_defaults 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_permissions_public.app_permission_defaults 
  ADD CONSTRAINT app_permission_defaults_pkey PRIMARY KEY (id);

ALTER TABLE myapp_permissions_public.app_permission_defaults 
  ADD COLUMN permissions pg_catalog.bit(64);

ALTER TABLE myapp_permissions_public.app_permission_defaults 
  ALTER COLUMN permissions SET NOT NULL;

ALTER TABLE myapp_permissions_public.app_permission_defaults 
  ALTER COLUMN permissions SET DEFAULT CAST(lpad('', 64, '0') AS pg_catalog.bit(64));

COMMENT ON COLUMN myapp_permissions_public.app_permission_defaults.permissions IS 'Default permission bitmask applied to new members';

CREATE TRIGGER app_permission_defaults_insert_trg
  BEFORE INSERT
  ON myapp_permissions_public.app_permission_defaults
  FOR EACH ROW
  EXECUTE PROCEDURE utils.ensure_singleton();

INSERT INTO myapp_permissions_public.app_permission_defaults (
  permissions
) VALUES
  (DEFAULT);

CREATE SCHEMA myapp_limits_public;

GRANT USAGE ON SCHEMA myapp_limits_public TO administrator;

GRANT USAGE ON SCHEMA myapp_limits_public TO authenticated;

GRANT USAGE ON SCHEMA myapp_limits_public TO anonymous;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_limits_public
  GRANT ALL ON TABLES TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_limits_public
  GRANT USAGE ON SEQUENCES TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_limits_public
  GRANT ALL ON FUNCTIONS TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_limits_public
  GRANT ALL ON FUNCTIONS TO authenticated;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_limits_public
  GRANT USAGE ON SEQUENCES TO authenticated;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_limits_public
  GRANT ALL ON FUNCTIONS TO anonymous;

CREATE SCHEMA myapp_limits_private;

GRANT USAGE ON SCHEMA myapp_limits_private TO administrator;

GRANT USAGE ON SCHEMA myapp_limits_private TO authenticated;

GRANT USAGE ON SCHEMA myapp_limits_private TO anonymous;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_limits_private
  GRANT ALL ON TABLES TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_limits_private
  GRANT USAGE ON SEQUENCES TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_limits_private
  GRANT ALL ON FUNCTIONS TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_limits_private
  GRANT ALL ON FUNCTIONS TO authenticated;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_limits_private
  GRANT USAGE ON SEQUENCES TO authenticated;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_limits_private
  GRANT ALL ON FUNCTIONS TO anonymous;

CREATE TABLE myapp_limits_public.app_limits ();

ALTER TABLE myapp_limits_public.app_limits 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_limits_public.app_limits IS 'Tracks per-actor usage counts against configurable maximum limits';

ALTER TABLE myapp_limits_public.app_limits 
  ADD COLUMN id uuid;

ALTER TABLE myapp_limits_public.app_limits 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_limits_public.app_limits 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_limits_public.app_limits 
  ADD CONSTRAINT app_limits_pkey PRIMARY KEY (id);

ALTER TABLE myapp_limits_public.app_limits 
  ADD COLUMN name citext;

COMMENT ON COLUMN myapp_limits_public.app_limits.name IS 'Name identifier of the limit being tracked';

ALTER TABLE myapp_limits_public.app_limits 
  ADD COLUMN actor_id uuid;

ALTER TABLE myapp_limits_public.app_limits 
  ALTER COLUMN actor_id SET NOT NULL;

COMMENT ON COLUMN myapp_limits_public.app_limits.actor_id IS 'User whose usage is being tracked against this limit';

ALTER TABLE myapp_limits_public.app_limits 
  ADD CONSTRAINT app_limits_actor_id_fkey
    FOREIGN KEY(actor_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE CASCADE;

CREATE INDEX app_limits_actor_id_idx ON myapp_limits_public.app_limits (actor_id);

ALTER TABLE myapp_limits_public.app_limits 
  ADD COLUMN num bigint;

COMMENT ON COLUMN myapp_limits_public.app_limits.num IS 'Current usage count for this actor and limit';

ALTER TABLE myapp_limits_public.app_limits 
  ADD COLUMN max bigint;

COMMENT ON COLUMN myapp_limits_public.app_limits.max IS 'Maximum allowed usage; negative means unlimited. Modified by plans, credits, and achievements.';

ALTER TABLE myapp_limits_public.app_limits 
  ADD COLUMN soft_max bigint;

COMMENT ON COLUMN myapp_limits_public.app_limits.soft_max IS 'Soft limit threshold for warnings; NULL means no soft limit. When num >= soft_max, consumers should warn but still allow until max is reached.';

ALTER TABLE myapp_limits_public.app_limits 
  ADD COLUMN window_start timestamptz;

COMMENT ON COLUMN myapp_limits_public.app_limits.window_start IS 'Start of the current metering window; NULL means no time window';

ALTER TABLE myapp_limits_public.app_limits 
  ADD COLUMN window_duration interval;

COMMENT ON COLUMN myapp_limits_public.app_limits.window_duration IS 'Duration of the metering window (e.g. 1 day, 1 month); NULL means no time window';

ALTER TABLE myapp_limits_public.app_limits 
  ADD COLUMN plan_max bigint;

ALTER TABLE myapp_limits_public.app_limits 
  ALTER COLUMN plan_max SET DEFAULT 0;

COMMENT ON COLUMN myapp_limits_public.app_limits.plan_max IS 'Ceiling set by the active plan via apply_plan(). Window reset does not change this value.';

ALTER TABLE myapp_limits_public.app_limits 
  ADD COLUMN purchased_credits bigint;

ALTER TABLE myapp_limits_public.app_limits 
  ALTER COLUMN purchased_credits SET DEFAULT 0;

COMMENT ON COLUMN myapp_limits_public.app_limits.purchased_credits IS 'Permanent credits from purchases, admin grants, or lifetime rewards. Survives window reset.';

ALTER TABLE myapp_limits_public.app_limits 
  ADD COLUMN period_credits bigint;

ALTER TABLE myapp_limits_public.app_limits 
  ALTER COLUMN period_credits SET DEFAULT 0;

COMMENT ON COLUMN myapp_limits_public.app_limits.period_credits IS 'Temporary credits for the current billing window. Resets to 0 on window expiry.';

ALTER TABLE myapp_limits_public.app_limits 
  ADD CONSTRAINT app_limits_name_actor_id_key 
    UNIQUE (name, actor_id);

ALTER TABLE myapp_limits_public.app_limits 
  ADD COLUMN organization_id uuid;

COMMENT ON COLUMN myapp_limits_public.app_limits.organization_id IS 'Resolved billable organization via get_organization_id';

ALTER TABLE myapp_limits_public.app_limits 
  ADD COLUMN entity_type text;

COMMENT ON COLUMN myapp_limits_public.app_limits.entity_type IS 'Entity type prefix (org, team, app, etc.) for interpreting entity_id';

CREATE TABLE myapp_limits_public.app_limit_defaults ();

ALTER TABLE myapp_limits_public.app_limit_defaults 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_limits_public.app_limit_defaults IS 'Default maximum values for each named limit, applied when no per-actor override exists';

ALTER TABLE myapp_limits_public.app_limit_defaults 
  ADD COLUMN id uuid;

ALTER TABLE myapp_limits_public.app_limit_defaults 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_limits_public.app_limit_defaults 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_limits_public.app_limit_defaults 
  ADD CONSTRAINT app_limit_defaults_pkey PRIMARY KEY (id);

ALTER TABLE myapp_limits_public.app_limit_defaults 
  ADD COLUMN name citext;

ALTER TABLE myapp_limits_public.app_limit_defaults 
  ALTER COLUMN name SET NOT NULL;

COMMENT ON COLUMN myapp_limits_public.app_limit_defaults.name IS 'Name identifier of the limit this default applies to';

ALTER TABLE myapp_limits_public.app_limit_defaults 
  ADD COLUMN max bigint;

COMMENT ON COLUMN myapp_limits_public.app_limit_defaults.max IS 'Default maximum usage allowed for this limit';

ALTER TABLE myapp_limits_public.app_limit_defaults 
  ADD COLUMN soft_max bigint;

COMMENT ON COLUMN myapp_limits_public.app_limit_defaults.soft_max IS 'Default soft limit threshold for warnings; NULL means no soft limit';

ALTER TABLE myapp_limits_public.app_limit_defaults 
  ADD CONSTRAINT app_limit_defaults_name_key 
    UNIQUE (name);

CREATE FUNCTION myapp_limits_private.app_limits_inc(
  IN limitname citext,
  IN actor_id uuid DEFAULT jwt_public.current_user_id(),
  IN amount bigint DEFAULT 1
) RETURNS boolean AS $EOFCODE$
DECLARE
  max_default bigint := 0;
BEGIN
  SELECT max
  FROM myapp_limits_public.app_limit_defaults
  WHERE
    name = app_limits_inc.limitname INTO max_default;
  IF NOT (FOUND) THEN
    max_default := 0;
  END IF;
  INSERT INTO myapp_limits_public.app_limits (
    name,
    num,
    max,
    actor_id
  )
  VALUES
    (app_limits_inc.limitname, 0, max_default, app_limits_inc.actor_id)
  ON CONFLICT ON CONSTRAINT app_limits_name_actor_id_key DO NOTHING;
  UPDATE myapp_limits_public.app_limits AS l SET
  num = 0, period_credits = 0, max = plan_max + purchased_credits, window_start = pg_catalog.now()
  WHERE
    (l.name = app_limits_inc.limitname AND l.actor_id = app_limits_inc.actor_id) AND (l.window_duration IS NOT NULL AND (l.window_start + l.window_duration) <= pg_catalog.now());
  UPDATE myapp_limits_public.app_limits AS l SET
  num = num + app_limits_inc.amount
  WHERE
    (l.name = app_limits_inc.limitname AND l.actor_id = app_limits_inc.actor_id) AND (l.max < 0 OR l.max >= (l.num + app_limits_inc.amount));
  IF FOUND THEN
    RETURN true;
  ELSE
    RETURN false;
  END IF;
  RETURN false;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION myapp_limits_private.app_limits_dec(
  IN limitname citext,
  IN actor_id uuid DEFAULT jwt_public.current_user_id(),
  IN amount bigint DEFAULT 1
) RETURNS boolean AS $EOFCODE$
DECLARE
  max_default bigint := 0;
BEGIN
  SELECT max
  FROM myapp_limits_public.app_limit_defaults
  WHERE
    name = app_limits_dec.limitname INTO max_default;
  IF NOT (FOUND) THEN
    max_default := 0;
  END IF;
  INSERT INTO myapp_limits_public.app_limits (
    name,
    num,
    max,
    actor_id
  )
  VALUES
    (app_limits_dec.limitname, 0, max_default, app_limits_dec.actor_id)
  ON CONFLICT ON CONSTRAINT app_limits_name_actor_id_key DO NOTHING;
  UPDATE myapp_limits_public.app_limits AS l SET
  num = GREATEST(num - app_limits_dec.amount, 0)
  WHERE
    l.name = app_limits_dec.limitname AND l.actor_id = app_limits_dec.actor_id;
  RETURN true;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION myapp_limits_private.app_limits_inc_tg() RETURNS trigger AS $EOFCODE$
DECLARE
  limit_ok boolean;
  actor_id uuid;
  limitname citext;
BEGIN
  IF tg_nargs < 1 THEN
    RAISE EXCEPTION 'LIMIT_TRIGGER_ARGS (%)', tg_name;
  ELSIF tg_nargs = 1 THEN
    limitname := (tg_argv)[0];
    limit_ok := myapp_limits_private.app_limits_inc(limitname);
  ELSIF tg_nargs >= 2 THEN
    limitname := (tg_argv)[0];
    EXECUTE pg_catalog.format('SELECT ($1).%s', (tg_argv)[1]) INTO actor_id USING NEW;
    limit_ok := myapp_limits_private.app_limits_inc(limitname, actor_id);
  END IF;
  IF limit_ok = false THEN
    RAISE EXCEPTION 'LIMIT_REACHED';
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE;

CREATE FUNCTION myapp_limits_private.app_limits_dec_tg() RETURNS trigger AS $EOFCODE$
DECLARE
  actor_id uuid;
  limitname citext;
BEGIN
  IF tg_nargs < 1 THEN
    RAISE EXCEPTION 'LIMIT_TRIGGER_ARGS (%)', tg_name;
  ELSIF tg_nargs = 1 THEN
    limitname := (tg_argv)[0];
    PERFORM myapp_limits_private.app_limits_dec(limitname);
  ELSIF tg_nargs >= 2 THEN
    limitname := (tg_argv)[0];
    EXECUTE pg_catalog.format('SELECT ($1).%s', (tg_argv)[1]) INTO actor_id USING OLD;
    PERFORM myapp_limits_private.app_limits_dec(limitname, actor_id);
  END IF;
  RETURN OLD;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE;

CREATE FUNCTION myapp_limits_private.app_limits_upd_tg() RETURNS trigger AS $EOFCODE$
DECLARE
  limit_ok boolean;
  old_actor_id uuid;
  new_actor_id uuid;
  limitname citext;
BEGIN
  IF tg_nargs < 1 THEN
    RAISE EXCEPTION 'LIMIT_TRIGGER_ARGS (%)', tg_name;
  ELSIF tg_nargs = 1 THEN
    RAISE EXCEPTION 'LIMIT_TRIGGER_ARGS (%)', tg_name;
  ELSIF tg_nargs >= 2 THEN
    limitname := (tg_argv)[0];
    EXECUTE pg_catalog.format('SELECT ($1).%s', (tg_argv)[1]) INTO new_actor_id USING NEW;
    EXECUTE pg_catalog.format('SELECT ($1).%s', (tg_argv)[1]) INTO old_actor_id USING OLD;
    PERFORM myapp_limits_private.app_limits_dec(limitname, old_actor_id);
    limit_ok := myapp_limits_private.app_limits_inc(limitname, new_actor_id);
  END IF;
  IF limit_ok = false THEN
    RAISE EXCEPTION 'LIMIT_REACHED';
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE;

CREATE TABLE myapp_limits_public.app_limit_credits ();

ALTER TABLE myapp_limits_public.app_limit_credits 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_limits_public.app_limit_credits IS 'Append-only ledger of credit grants that automatically update limit ceilings';

ALTER TABLE myapp_limits_public.app_limit_credits 
  ADD COLUMN id uuid;

ALTER TABLE myapp_limits_public.app_limit_credits 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_limits_public.app_limit_credits 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_limits_public.app_limit_credits 
  ADD CONSTRAINT app_limit_credits_pkey PRIMARY KEY (id);

ALTER TABLE myapp_limits_public.app_limit_credits 
  ADD COLUMN default_limit_id uuid;

ALTER TABLE myapp_limits_public.app_limit_credits 
  ALTER COLUMN default_limit_id SET NOT NULL;

COMMENT ON COLUMN myapp_limits_public.app_limit_credits.default_limit_id IS 'FK to default_limits — which limit definition this credit applies to';

ALTER TABLE myapp_limits_public.app_limit_credits 
  ADD CONSTRAINT app_limit_credits_default_limit_id_fkey
    FOREIGN KEY(default_limit_id)
    REFERENCES myapp_limits_public.app_limit_defaults (id)
    ON DELETE RESTRICT;

CREATE INDEX app_limit_credits_default_limit_id_idx ON myapp_limits_public.app_limit_credits (default_limit_id);

ALTER TABLE myapp_limits_public.app_limit_credits 
  ADD COLUMN actor_id uuid;

COMMENT ON COLUMN myapp_limits_public.app_limit_credits.actor_id IS 'User this credit is for; NULL for aggregate entity-level credits';

ALTER TABLE myapp_limits_public.app_limit_credits 
  ADD CONSTRAINT app_limit_credits_actor_id_fkey
    FOREIGN KEY(actor_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE CASCADE;

CREATE INDEX app_limit_credits_actor_id_idx ON myapp_limits_public.app_limit_credits (actor_id);

ALTER TABLE myapp_limits_public.app_limit_credits 
  ADD COLUMN amount bigint;

ALTER TABLE myapp_limits_public.app_limit_credits 
  ALTER COLUMN amount SET NOT NULL;

COMMENT ON COLUMN myapp_limits_public.app_limit_credits.amount IS 'Number of credits to grant (positive to add, negative to revoke)';

ALTER TABLE myapp_limits_public.app_limit_credits 
  ADD COLUMN credit_type text;

ALTER TABLE myapp_limits_public.app_limit_credits 
  ALTER COLUMN credit_type SET NOT NULL;

ALTER TABLE myapp_limits_public.app_limit_credits 
  ALTER COLUMN credit_type SET DEFAULT 'permanent';

COMMENT ON COLUMN myapp_limits_public.app_limit_credits.credit_type IS 'Credit durability: permanent (survives window reset) or period (resets on window expiry)';

ALTER TABLE myapp_limits_public.app_limit_credits 
  ADD COLUMN reason text;

COMMENT ON COLUMN myapp_limits_public.app_limit_credits.reason IS 'Optional reason for the credit grant (promo code, admin grant, etc.)';

ALTER TABLE myapp_limits_public.app_limit_credits 
  ENABLE ROW LEVEL SECURITY;

GRANT INSERT ON myapp_limits_public.app_limit_credits TO authenticated;

GRANT SELECT ON myapp_limits_public.app_limit_credits TO authenticated;

CREATE POLICY auth_sel_own
  ON myapp_limits_public.app_limit_credits
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    actor_id = jwt_public.current_principal_id()
  );

CREATE FUNCTION myapp_limits_private.app_limit_credits_apply_tg_fn() RETURNS trigger AS $EOFCODE$
DECLARE
  v_limit_name text;
BEGIN
  SELECT name
  FROM myapp_limits_public.app_limit_defaults
  WHERE
    id = NEW.default_limit_id INTO v_limit_name;
  IF NOT (FOUND) THEN
    RAISE WARNING 'INVALID_DEFAULT_LIMIT_ID';
  END IF;
  IF NEW.credit_type = 'permanent' THEN
    UPDATE myapp_limits_public.app_limits SET
    purchased_credits = purchased_credits + NEW.amount, max = ((plan_max + purchased_credits) + NEW.amount) + period_credits
    WHERE
      name = v_limit_name AND actor_id = NEW.actor_id;
  ELSE
    UPDATE myapp_limits_public.app_limits SET
    period_credits = period_credits + NEW.amount, max = (plan_max + purchased_credits) + (period_credits + NEW.amount)
    WHERE
      name = v_limit_name AND actor_id = NEW.actor_id;
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE TRIGGER _00100_app_limit_credits_apply_tg
  AFTER INSERT
  ON myapp_limits_public.app_limit_credits
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_limits_private.app_limit_credits_apply_tg_fn();

CREATE FUNCTION myapp_limits_private.app_limits_check(
  IN limitname citext,
  IN amount bigint DEFAULT 1,
  IN user_id uuid DEFAULT jwt_public.current_user_id()
) RETURNS boolean AS $EOFCODE$
DECLARE
  max_default bigint := 0;
  rec myapp_limits_public.app_limits;
BEGIN
  SELECT max
  FROM myapp_limits_public.app_limit_defaults
  WHERE
    name = app_limits_check.limitname INTO max_default;
  IF NOT (FOUND) THEN
    max_default := 0;
  END IF;
  INSERT INTO myapp_limits_public.app_limits (
    name,
    num,
    max,
    actor_id
  )
  VALUES
    (app_limits_check.limitname, 0, max_default, app_limits_check.user_id)
  ON CONFLICT ON CONSTRAINT app_limits_name_actor_id_key DO NOTHING;
  UPDATE myapp_limits_public.app_limits AS l SET
  num = 0, period_credits = 0, max = plan_max + purchased_credits, window_start = pg_catalog.now()
  WHERE
    (l.name = app_limits_check.limitname AND l.actor_id = app_limits_check.user_id) AND (l.window_duration IS NOT NULL AND (l.window_start + l.window_duration) <= pg_catalog.now());
  SELECT *
  FROM myapp_limits_public.app_limits
  WHERE
    name = app_limits_check.limitname AND actor_id = app_limits_check.user_id
  FOR UPDATE INTO rec;
  IF rec.max < 0 OR rec.max >= (rec.num + app_limits_check.amount) THEN
    RETURN true;
  ELSE
    RETURN false;
  END IF;
  RETURN false;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION myapp_limits_private.app_limits_modify(
  IN limitname citext,
  IN delta bigint,
  IN reason text DEFAULT '',
  IN user_id uuid DEFAULT jwt_public.current_user_id()
) RETURNS boolean AS $EOFCODE$
DECLARE
  max_default bigint := 0;
BEGIN
  SELECT max
  FROM myapp_limits_public.app_limit_defaults
  WHERE
    name = app_limits_modify.limitname INTO max_default;
  IF NOT (FOUND) THEN
    max_default := 0;
  END IF;
  INSERT INTO myapp_limits_public.app_limits (
    name,
    num,
    max,
    actor_id
  )
  VALUES
    (app_limits_modify.limitname, 0, max_default, app_limits_modify.user_id)
  ON CONFLICT ON CONSTRAINT app_limits_name_actor_id_key DO NOTHING;
  UPDATE myapp_limits_public.app_limits SET
  max = max + app_limits_modify.delta
  WHERE
    name = app_limits_modify.limitname AND actor_id = app_limits_modify.user_id;
  RETURN true;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE TABLE myapp_limits_public.app_limit_events (
  created_at timestamptz NOT NULL DEFAULT now()
) PARTITION BY RANGE (created_at);

ALTER TABLE myapp_limits_public.app_limit_events 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_limits_public.app_limit_events IS 'Append-only log of limit events for historical reporting and audit';

ALTER TABLE myapp_limits_public.app_limit_events 
  ADD COLUMN id uuid;

ALTER TABLE myapp_limits_public.app_limit_events 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_limits_public.app_limit_events 
  ALTER COLUMN id SET DEFAULT uuidv7();

COMMENT ON COLUMN myapp_limits_public.app_limit_events.id IS 'Unique identifier for each limit event';

ALTER TABLE myapp_limits_public.app_limit_events 
  ADD COLUMN name citext;

COMMENT ON COLUMN myapp_limits_public.app_limit_events.name IS 'Limit name this event applies to';

ALTER TABLE myapp_limits_public.app_limit_events 
  ADD COLUMN actor_id uuid;

COMMENT ON COLUMN myapp_limits_public.app_limit_events.actor_id IS 'User who triggered this event; NULL for system/aggregate events';

ALTER TABLE myapp_limits_public.app_limit_events 
  ADD COLUMN entity_id uuid;

COMMENT ON COLUMN myapp_limits_public.app_limit_events.entity_id IS 'Entity this event applies to; NULL for app-level events';

ALTER TABLE myapp_limits_public.app_limit_events 
  ADD COLUMN organization_id uuid;

COMMENT ON COLUMN myapp_limits_public.app_limit_events.organization_id IS 'Resolved billable organization via get_organization_id; NULL for app-level events';

ALTER TABLE myapp_limits_public.app_limit_events 
  ADD COLUMN entity_type text;

COMMENT ON COLUMN myapp_limits_public.app_limit_events.entity_type IS 'Entity type prefix (org, team, app, etc.) for interpreting entity_id';

ALTER TABLE myapp_limits_public.app_limit_events 
  ADD COLUMN event_type text;

COMMENT ON COLUMN myapp_limits_public.app_limit_events.event_type IS 'Event type: inc, dec, check, modify, transfer, apply_plan, reset';

ALTER TABLE myapp_limits_public.app_limit_events 
  ADD COLUMN delta bigint;

COMMENT ON COLUMN myapp_limits_public.app_limit_events.delta IS 'Change amount: positive for increment, negative for decrement';

ALTER TABLE myapp_limits_public.app_limit_events 
  ADD COLUMN num_before bigint;

COMMENT ON COLUMN myapp_limits_public.app_limit_events.num_before IS 'Usage count before this event';

ALTER TABLE myapp_limits_public.app_limit_events 
  ADD COLUMN num_after bigint;

COMMENT ON COLUMN myapp_limits_public.app_limit_events.num_after IS 'Usage count after this event';

ALTER TABLE myapp_limits_public.app_limit_events 
  ADD COLUMN max_at_event bigint;

COMMENT ON COLUMN myapp_limits_public.app_limit_events.max_at_event IS 'Max limit ceiling at the time of this event';

ALTER TABLE myapp_limits_public.app_limit_events 
  ADD COLUMN reason text;

COMMENT ON COLUMN myapp_limits_public.app_limit_events.reason IS 'Optional reason or source: achievement, invite, plan_change, purchase, etc.';

ALTER TABLE myapp_limits_public.app_limit_events 
  ADD CONSTRAINT app_limit_events_pkey PRIMARY KEY (created_at, id);

ALTER TABLE myapp_limits_public.app_limit_events 
  ENABLE ROW LEVEL SECURITY;

GRANT INSERT ON myapp_limits_public.app_limit_events TO authenticated;

GRANT SELECT ON myapp_limits_public.app_limit_events TO authenticated;

CREATE POLICY auth_sel_own
  ON myapp_limits_public.app_limit_events
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    actor_id = jwt_public.current_principal_id()
  );

INSERT INTO metaschema_public.partition (
  id,
  database_id,
  table_id,
  strategy,
  partition_key_id,
  "interval",
  retention,
  retention_keep_table,
  premake,
  naming_pattern
) VALUES
  ('4dafa1ac-a209-40ee-9204-722c5a02d686', '019fb68d-023e-72ec-b6fc-33d15bd99e09', '019fb68d-0621-73b2-8b39-124afb08e9fd', 'range', '019fb68d-063d-75cd-8fb4-bed0627e3d7a', '1 month', '12 months', true, 2, '{parent}_{bounds}') ON CONFLICT (table_id) DO NOTHING;

CREATE FUNCTION myapp_limits_private.app_limits_audit_tg_fn() RETURNS trigger AS $EOFCODE$
BEGIN
  INSERT INTO myapp_limits_public.app_limit_events (
    name,
    actor_id,
    event_type,
    delta,
    num_before,
    num_after,
    max_at_event
  )
  VALUES
    (NEW.name, NEW.actor_id, CASE 
        WHEN OLD IS NOT NULL AND NEW.max <> OLD.max THEN 'modify' 
        WHEN (NEW.num - (COALESCE(OLD.num, 0))) >= 0 THEN 'inc' 
        ELSE 'dec' 
      END, NEW.num - (COALESCE(OLD.num, 0)), COALESCE(OLD.num, 0), NEW.num, NEW.max);
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE TRIGGER _99999_app_limits_audit_tg
  BEFORE INSERT OR UPDATE
  ON myapp_limits_public.app_limits
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_limits_private.app_limits_audit_tg_fn();

CREATE TABLE myapp_limits_public.app_limit_credit_codes ();

ALTER TABLE myapp_limits_public.app_limit_credit_codes 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_limits_public.app_limit_credit_codes IS 'Redeemable credit codes managed by admins with the add_credits permission';

ALTER TABLE myapp_limits_public.app_limit_credit_codes 
  ADD COLUMN id uuid;

ALTER TABLE myapp_limits_public.app_limit_credit_codes 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_limits_public.app_limit_credit_codes 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_limits_public.app_limit_credit_codes 
  ADD CONSTRAINT app_limit_credit_codes_pkey PRIMARY KEY (id);

ALTER TABLE myapp_limits_public.app_limit_credit_codes 
  ADD COLUMN code citext;

ALTER TABLE myapp_limits_public.app_limit_credit_codes 
  ALTER COLUMN code SET NOT NULL;

COMMENT ON COLUMN myapp_limits_public.app_limit_credit_codes.code IS 'Human-readable credit code (case-insensitive, unique)';

ALTER TABLE myapp_limits_public.app_limit_credit_codes 
  ADD CONSTRAINT app_limit_credit_codes_code_key 
    UNIQUE (code);

ALTER TABLE myapp_limits_public.app_limit_credit_codes 
  ADD COLUMN max_redemptions int;

COMMENT ON COLUMN myapp_limits_public.app_limit_credit_codes.max_redemptions IS 'Maximum total redemptions allowed; NULL for unlimited';

ALTER TABLE myapp_limits_public.app_limit_credit_codes 
  ADD COLUMN current_redemptions int;

ALTER TABLE myapp_limits_public.app_limit_credit_codes 
  ALTER COLUMN current_redemptions SET NOT NULL;

ALTER TABLE myapp_limits_public.app_limit_credit_codes 
  ALTER COLUMN current_redemptions SET DEFAULT 0;

COMMENT ON COLUMN myapp_limits_public.app_limit_credit_codes.current_redemptions IS 'Current number of redemptions (incremented by trigger on credit_redemptions)';

ALTER TABLE myapp_limits_public.app_limit_credit_codes 
  ADD COLUMN expires_at timestamptz;

COMMENT ON COLUMN myapp_limits_public.app_limit_credit_codes.expires_at IS 'Expiration timestamp; NULL for no expiry';

ALTER TABLE myapp_limits_public.app_limit_credit_codes 
  ENABLE ROW LEVEL SECURITY;

GRANT INSERT ON myapp_limits_public.app_limit_credit_codes TO authenticated;

GRANT SELECT ON myapp_limits_public.app_limit_credit_codes TO authenticated;

GRANT UPDATE ON myapp_limits_public.app_limit_credit_codes TO authenticated;

GRANT DELETE ON myapp_limits_public.app_limit_credit_codes TO authenticated;

CREATE TABLE myapp_limits_public.app_limit_credit_code_items ();

ALTER TABLE myapp_limits_public.app_limit_credit_code_items 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_limits_public.app_limit_credit_code_items IS 'Items within a credit code — each row grants credits for a specific limit definition';

ALTER TABLE myapp_limits_public.app_limit_credit_code_items 
  ADD COLUMN id uuid;

ALTER TABLE myapp_limits_public.app_limit_credit_code_items 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_limits_public.app_limit_credit_code_items 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_limits_public.app_limit_credit_code_items 
  ADD CONSTRAINT app_limit_credit_code_items_pkey PRIMARY KEY (id);

ALTER TABLE myapp_limits_public.app_limit_credit_code_items 
  ADD COLUMN credit_code_id uuid;

ALTER TABLE myapp_limits_public.app_limit_credit_code_items 
  ALTER COLUMN credit_code_id SET NOT NULL;

COMMENT ON COLUMN myapp_limits_public.app_limit_credit_code_items.credit_code_id IS 'FK to credit_codes — which code this item belongs to';

ALTER TABLE myapp_limits_public.app_limit_credit_code_items 
  ADD CONSTRAINT app_limit_credit_code_items_credit_code_id_fkey
    FOREIGN KEY(credit_code_id)
    REFERENCES myapp_limits_public.app_limit_credit_codes (id)
    ON DELETE CASCADE;

ALTER TABLE myapp_limits_public.app_limit_credit_code_items 
  ADD COLUMN default_limit_id uuid;

ALTER TABLE myapp_limits_public.app_limit_credit_code_items 
  ALTER COLUMN default_limit_id SET NOT NULL;

COMMENT ON COLUMN myapp_limits_public.app_limit_credit_code_items.default_limit_id IS 'FK to default_limits — which limit this item grants credits for';

ALTER TABLE myapp_limits_public.app_limit_credit_code_items 
  ADD CONSTRAINT app_limit_credit_code_items_default_limit_id_fkey
    FOREIGN KEY(default_limit_id)
    REFERENCES myapp_limits_public.app_limit_defaults (id)
    ON DELETE RESTRICT;

CREATE INDEX app_limit_credit_code_items_default_limit_id_idx ON myapp_limits_public.app_limit_credit_code_items (default_limit_id);

ALTER TABLE myapp_limits_public.app_limit_credit_code_items 
  ADD COLUMN amount bigint;

ALTER TABLE myapp_limits_public.app_limit_credit_code_items 
  ALTER COLUMN amount SET NOT NULL;

COMMENT ON COLUMN myapp_limits_public.app_limit_credit_code_items.amount IS 'Number of credits this item grants per redemption';

ALTER TABLE myapp_limits_public.app_limit_credit_code_items 
  ADD COLUMN credit_type text;

ALTER TABLE myapp_limits_public.app_limit_credit_code_items 
  ALTER COLUMN credit_type SET NOT NULL;

ALTER TABLE myapp_limits_public.app_limit_credit_code_items 
  ALTER COLUMN credit_type SET DEFAULT 'permanent';

COMMENT ON COLUMN myapp_limits_public.app_limit_credit_code_items.credit_type IS 'Credit durability: permanent (survives window reset) or period (resets on window expiry)';

ALTER TABLE myapp_limits_public.app_limit_credit_code_items 
  ADD CONSTRAINT app_limit_credit_code_items_credit_code_id_default_limit_id_key 
    UNIQUE (credit_code_id, default_limit_id);

ALTER TABLE myapp_limits_public.app_limit_credit_code_items 
  ENABLE ROW LEVEL SECURITY;

GRANT INSERT ON myapp_limits_public.app_limit_credit_code_items TO authenticated;

GRANT SELECT ON myapp_limits_public.app_limit_credit_code_items TO authenticated;

GRANT UPDATE ON myapp_limits_public.app_limit_credit_code_items TO authenticated;

GRANT DELETE ON myapp_limits_public.app_limit_credit_code_items TO authenticated;

CREATE TABLE myapp_limits_public.app_limit_credit_redemptions ();

ALTER TABLE myapp_limits_public.app_limit_credit_redemptions 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_limits_public.app_limit_credit_redemptions IS 'Append-only ledger of code redemptions; AFTER INSERT trigger validates and cascades to limit_credits';

ALTER TABLE myapp_limits_public.app_limit_credit_redemptions 
  ADD COLUMN id uuid;

ALTER TABLE myapp_limits_public.app_limit_credit_redemptions 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_limits_public.app_limit_credit_redemptions 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_limits_public.app_limit_credit_redemptions 
  ADD CONSTRAINT app_limit_credit_redemptions_pkey PRIMARY KEY (id);

ALTER TABLE myapp_limits_public.app_limit_credit_redemptions 
  ADD COLUMN credit_code_id uuid;

ALTER TABLE myapp_limits_public.app_limit_credit_redemptions 
  ALTER COLUMN credit_code_id SET NOT NULL;

COMMENT ON COLUMN myapp_limits_public.app_limit_credit_redemptions.credit_code_id IS 'FK to credit_codes — which code is being redeemed';

ALTER TABLE myapp_limits_public.app_limit_credit_redemptions 
  ADD CONSTRAINT app_limit_credit_redemptions_credit_code_id_fkey
    FOREIGN KEY(credit_code_id)
    REFERENCES myapp_limits_public.app_limit_credit_codes (id)
    ON DELETE RESTRICT;

ALTER TABLE myapp_limits_public.app_limit_credit_redemptions 
  ADD COLUMN entity_id uuid;

ALTER TABLE myapp_limits_public.app_limit_credit_redemptions 
  ALTER COLUMN entity_id SET NOT NULL;

COMMENT ON COLUMN myapp_limits_public.app_limit_credit_redemptions.entity_id IS 'Entity receiving the credits (personal org user_id or org entity_id)';

ALTER TABLE myapp_limits_public.app_limit_credit_redemptions 
  ADD COLUMN organization_id uuid;

COMMENT ON COLUMN myapp_limits_public.app_limit_credit_redemptions.organization_id IS 'Resolved billable organization via get_organization_id';

ALTER TABLE myapp_limits_public.app_limit_credit_redemptions 
  ADD COLUMN entity_type text;

COMMENT ON COLUMN myapp_limits_public.app_limit_credit_redemptions.entity_type IS 'Membership prefix identifying the entity kind (org, team, app)';

ALTER TABLE myapp_limits_public.app_limit_credit_redemptions 
  ADD CONSTRAINT app_limit_credit_redemptions_credit_code_id_entity_id_key 
    UNIQUE (credit_code_id, entity_id);

ALTER TABLE myapp_limits_public.app_limit_credit_redemptions 
  ENABLE ROW LEVEL SECURITY;

GRANT INSERT ON myapp_limits_public.app_limit_credit_redemptions TO authenticated;

GRANT SELECT ON myapp_limits_public.app_limit_credit_redemptions TO authenticated;

CREATE FUNCTION myapp_limits_private.app_limit_credit_redemptions_apply_tg_fn() RETURNS trigger AS $EOFCODE$
DECLARE
  v_code myapp_limits_public.app_limit_credit_codes;
BEGIN
  SELECT *
  FROM myapp_limits_public.app_limit_credit_codes
  WHERE
    id = NEW.credit_code_id
  FOR UPDATE INTO v_code;
  IF NOT (FOUND) THEN
    RAISE WARNING 'CREDIT_CODE_NOT_FOUND';
  END IF;
  IF v_code.expires_at IS NOT NULL AND v_code.expires_at < pg_catalog.now() THEN
    RAISE WARNING 'CREDIT_CODE_EXPIRED';
  END IF;
  IF v_code.max_redemptions IS NOT NULL AND v_code.current_redemptions >= v_code.max_redemptions THEN
    RAISE WARNING 'CREDIT_CODE_MAX_REDEMPTIONS_REACHED';
  END IF;
  UPDATE myapp_limits_public.app_limit_credit_codes SET
  current_redemptions = current_redemptions + 1
  WHERE
    id = v_code.id;
  INSERT INTO myapp_limits_public.app_limit_credits (
    default_limit_id,
    actor_id,
    amount,
    credit_type,
    reason
  )
  SELECT
    ci.default_limit_id,
    NEW.entity_id,
    ci.amount,
    ci.credit_type,
    'credit_code:' || v_code.id::text
  FROM myapp_limits_public.app_limit_credit_code_items AS ci
  WHERE
    ci.credit_code_id = v_code.id;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE TRIGGER _00100_app_limit_credit_redemptions_apply_tg
  AFTER INSERT
  ON myapp_limits_public.app_limit_credit_redemptions
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_limits_private.app_limit_credit_redemptions_apply_tg_fn();

CREATE TABLE myapp_limits_public.app_limit_caps_defaults ();

ALTER TABLE myapp_limits_public.app_limit_caps_defaults 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_limits_public.app_limit_caps_defaults IS 'Default cap values for static configuration limits (max file size, feature flags, etc.). Not metered — just read by consumers.';

ALTER TABLE myapp_limits_public.app_limit_caps_defaults 
  ADD COLUMN id uuid;

ALTER TABLE myapp_limits_public.app_limit_caps_defaults 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_limits_public.app_limit_caps_defaults 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_limits_public.app_limit_caps_defaults 
  ADD CONSTRAINT app_limit_caps_defaults_pkey PRIMARY KEY (id);

ALTER TABLE myapp_limits_public.app_limit_caps_defaults 
  ADD COLUMN name citext;

ALTER TABLE myapp_limits_public.app_limit_caps_defaults 
  ALTER COLUMN name SET NOT NULL;

COMMENT ON COLUMN myapp_limits_public.app_limit_caps_defaults.name IS 'Name identifier of the cap (e.g. max_file_upload_size, advanced_analytics)';

ALTER TABLE myapp_limits_public.app_limit_caps_defaults 
  ADD COLUMN max bigint;

ALTER TABLE myapp_limits_public.app_limit_caps_defaults 
  ALTER COLUMN max SET NOT NULL;

ALTER TABLE myapp_limits_public.app_limit_caps_defaults 
  ALTER COLUMN max SET DEFAULT 0;

COMMENT ON COLUMN myapp_limits_public.app_limit_caps_defaults.max IS 'Default cap value. For feature flags: 0=disabled, 1=enabled. For size caps: the limit in bytes/units.';

ALTER TABLE myapp_limits_public.app_limit_caps_defaults 
  ADD CONSTRAINT app_limit_caps_defaults_name_key 
    UNIQUE (name);

CREATE TABLE myapp_limits_public.app_limit_caps ();

ALTER TABLE myapp_limits_public.app_limit_caps 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_limits_public.app_limit_caps IS 'Per-entity cap overrides. Allows specific orgs/entities to have different cap values than the scope default.';

ALTER TABLE myapp_limits_public.app_limit_caps 
  ADD COLUMN id uuid;

ALTER TABLE myapp_limits_public.app_limit_caps 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_limits_public.app_limit_caps 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_limits_public.app_limit_caps 
  ADD CONSTRAINT app_limit_caps_pkey PRIMARY KEY (id);

ALTER TABLE myapp_limits_public.app_limit_caps 
  ADD COLUMN name citext;

ALTER TABLE myapp_limits_public.app_limit_caps 
  ALTER COLUMN name SET NOT NULL;

COMMENT ON COLUMN myapp_limits_public.app_limit_caps.name IS 'Name identifier of the cap being overridden';

ALTER TABLE myapp_limits_public.app_limit_caps 
  ADD COLUMN entity_id uuid;

ALTER TABLE myapp_limits_public.app_limit_caps 
  ALTER COLUMN entity_id SET NOT NULL;

COMMENT ON COLUMN myapp_limits_public.app_limit_caps.entity_id IS 'Entity this cap override applies to';

ALTER TABLE myapp_limits_public.app_limit_caps 
  ADD COLUMN max bigint;

ALTER TABLE myapp_limits_public.app_limit_caps 
  ALTER COLUMN max SET NOT NULL;

ALTER TABLE myapp_limits_public.app_limit_caps 
  ALTER COLUMN max SET DEFAULT 0;

COMMENT ON COLUMN myapp_limits_public.app_limit_caps.max IS 'Override cap value for this entity';

ALTER TABLE myapp_limits_public.app_limit_caps 
  ADD CONSTRAINT app_limit_caps_name_entity_id_key 
    UNIQUE (name, entity_id);

CREATE FUNCTION myapp_limits_private.app_limits_cap_check_tg_fn() RETURNS trigger AS $EOFCODE$
DECLARE
  v_cap_name citext;
  v_cap_value bigint;
BEGIN
  IF tg_nargs < 1 THEN
    RAISE EXCEPTION 'CAP_CHECK_TRIGGER_ARGS (%)', tg_name;
  END IF;
  v_cap_value := (tg_argv)[0];
  SELECT myapp_limits_private.app_limits_resolve_cap(v_cap_name) INTO v_cap_value;
  IF pg_catalog.coalesce(v_cap_value, 0) <= 0 THEN
    RAISE EXCEPTION 'FEATURE_DISABLED (%)', v_cap_name;
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY INVOKER;

CREATE FUNCTION myapp_limits_private.app_limits_resolve_cap(
  IN cap_name citext
) RETURNS bigint AS $EOFCODE$
DECLARE
  v_cap_value bigint;
BEGIN
  SELECT max
  FROM myapp_limits_public.app_limit_caps_defaults
  WHERE
    name = app_limits_resolve_cap.cap_name INTO v_cap_value;
  RETURN COALESCE(v_cap_value, 0::bigint);
END;
$EOFCODE$ LANGUAGE plpgsql STABLE SECURITY DEFINER;

CREATE FUNCTION myapp_limits_private.app_limits_check_soft(
  IN limitname citext,
  IN user_id uuid DEFAULT jwt_public.current_user_id()
) RETURNS boolean AS $EOFCODE$
DECLARE
  rec myapp_limits_public.app_limits;
BEGIN
  UPDATE myapp_limits_public.app_limits AS l SET
  num = 0, period_credits = 0, max = plan_max + purchased_credits, window_start = pg_catalog.now()
  WHERE
    (l.name = app_limits_check_soft.limitname AND l.actor_id = app_limits_check_soft.user_id) AND (l.window_duration IS NOT NULL AND (l.window_start + l.window_duration) <= pg_catalog.now());
  SELECT *
  FROM myapp_limits_public.app_limits
  WHERE
    name = app_limits_check_soft.limitname AND actor_id = app_limits_check_soft.user_id INTO rec;
  IF NOT (FOUND) OR rec.soft_max IS NULL THEN
    RETURN false;
  END IF;
  IF rec.soft_max >= 0 AND rec.num >= rec.soft_max THEN
    RETURN true;
  ELSE
    RETURN false;
  END IF;
  RETURN false;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE TABLE myapp_limits_public.app_limit_warnings ();

ALTER TABLE myapp_limits_public.app_limit_warnings 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_limits_public.app_limit_warnings IS 'Warning configuration for soft limits. Each row defines a warning threshold and the job task to enqueue when usage approaches it.';

ALTER TABLE myapp_limits_public.app_limit_warnings 
  ADD COLUMN id uuid;

ALTER TABLE myapp_limits_public.app_limit_warnings 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_limits_public.app_limit_warnings 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_limits_public.app_limit_warnings 
  ADD CONSTRAINT app_limit_warnings_pkey PRIMARY KEY (id);

ALTER TABLE myapp_limits_public.app_limit_warnings 
  ADD COLUMN name citext;

ALTER TABLE myapp_limits_public.app_limit_warnings 
  ALTER COLUMN name SET NOT NULL;

COMMENT ON COLUMN myapp_limits_public.app_limit_warnings.name IS 'Limit name this warning applies to (must match a default_limits entry)';

ALTER TABLE myapp_limits_public.app_limit_warnings 
  ADD COLUMN warning_type citext;

ALTER TABLE myapp_limits_public.app_limit_warnings 
  ALTER COLUMN warning_type SET NOT NULL;

COMMENT ON COLUMN myapp_limits_public.app_limit_warnings.warning_type IS 'Threshold type: absolute (fixed count) or percentage (of max)';

ALTER TABLE myapp_limits_public.app_limit_warnings 
  ADD COLUMN threshold_value bigint;

ALTER TABLE myapp_limits_public.app_limit_warnings 
  ALTER COLUMN threshold_value SET NOT NULL;

COMMENT ON COLUMN myapp_limits_public.app_limit_warnings.threshold_value IS 'Threshold value — either an absolute count or a percentage (1-100) depending on warning_type';

ALTER TABLE myapp_limits_public.app_limit_warnings 
  ADD COLUMN task_identifier text;

ALTER TABLE myapp_limits_public.app_limit_warnings 
  ALTER COLUMN task_identifier SET NOT NULL;

COMMENT ON COLUMN myapp_limits_public.app_limit_warnings.task_identifier IS 'Job task name to enqueue when warning fires (e.g. email:limit_warning, notification:approaching_limit)';

ALTER TABLE myapp_limits_public.app_limit_warnings 
  ADD CONSTRAINT app_limit_warnings_name_key 
    UNIQUE (name);

CREATE TABLE myapp_limits_private.app_limit_warning_state ();

ALTER TABLE myapp_limits_private.app_limit_warning_state 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_limits_private.app_limit_warning_state IS 'Tracks which warnings have been sent to avoid duplicate notifications. One row per warning config per actor.';

ALTER TABLE myapp_limits_private.app_limit_warning_state 
  ADD COLUMN id uuid;

ALTER TABLE myapp_limits_private.app_limit_warning_state 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_limits_private.app_limit_warning_state 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_limits_private.app_limit_warning_state 
  ADD CONSTRAINT app_limit_warning_states_pkey PRIMARY KEY (id);

ALTER TABLE myapp_limits_private.app_limit_warning_state 
  ADD COLUMN warning_id uuid;

ALTER TABLE myapp_limits_private.app_limit_warning_state 
  ALTER COLUMN warning_id SET NOT NULL;

COMMENT ON COLUMN myapp_limits_private.app_limit_warning_state.warning_id IS 'Reference to the limit_warnings config row that triggered this warning';

ALTER TABLE myapp_limits_private.app_limit_warning_state 
  ADD CONSTRAINT app_limit_warning_states_warning_id_fkey
    FOREIGN KEY(warning_id)
    REFERENCES myapp_limits_public.app_limit_warnings (id)
    ON DELETE CASCADE;

ALTER TABLE myapp_limits_private.app_limit_warning_state 
  ADD COLUMN actor_id uuid;

ALTER TABLE myapp_limits_private.app_limit_warning_state 
  ALTER COLUMN actor_id SET NOT NULL;

COMMENT ON COLUMN myapp_limits_private.app_limit_warning_state.actor_id IS 'User who was warned';

ALTER TABLE myapp_limits_private.app_limit_warning_state 
  ADD CONSTRAINT app_limit_warning_states_actor_id_fkey
    FOREIGN KEY(actor_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE CASCADE;

CREATE INDEX app_limit_warning_states_actor_id_idx ON myapp_limits_private.app_limit_warning_state (actor_id);

ALTER TABLE myapp_limits_private.app_limit_warning_state 
  ADD COLUMN warned_at timestamptz;

ALTER TABLE myapp_limits_private.app_limit_warning_state 
  ALTER COLUMN warned_at SET NOT NULL;

COMMENT ON COLUMN myapp_limits_private.app_limit_warning_state.warned_at IS 'Timestamp when the warning was sent';

ALTER TABLE myapp_limits_private.app_limit_warning_state 
  ADD CONSTRAINT app_limit_warning_states_warning_id_actor_id_key 
    UNIQUE (warning_id, actor_id);

CREATE FUNCTION myapp_limits_public.seed_app_limit_defaults(
  IN defaults jsonb
) RETURNS boolean AS $EOFCODE$
DECLARE
  v_item jsonb;
BEGIN
  IF seed_app_limit_defaults.defaults IS NULL THEN
    PERFORM errors.raise_error('SEED_LIMIT_DEFAULTS_REQUIRED');
  END IF;
  FOR v_item IN SELECT jsonb_array_elements(seed_app_limit_defaults.defaults) LOOP
    INSERT INTO myapp_limits_public.app_limit_defaults (
      name,
      max
    )
    VALUES
      ((v_item->>'name')::citext, (v_item->>'max')::bigint)
    ON CONFLICT ON CONSTRAINT app_limit_defaults_name_key DO UPDATE SET
    max = EXCLUDED.max;
  END LOOP;
  RETURN true;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE;

CREATE FUNCTION myapp_limits_public.seed_app_limit_caps_defaults(
  IN defaults jsonb
) RETURNS boolean AS $EOFCODE$
DECLARE
  v_item jsonb;
BEGIN
  IF seed_app_limit_caps_defaults.defaults IS NULL THEN
    PERFORM errors.raise_error('SEED_CAP_DEFAULTS_REQUIRED');
  END IF;
  FOR v_item IN SELECT jsonb_array_elements(seed_app_limit_caps_defaults.defaults) LOOP
    INSERT INTO myapp_limits_public.app_limit_caps_defaults (
      name,
      max
    )
    VALUES
      ((v_item->>'name')::citext, (v_item->>'max')::bigint)
    ON CONFLICT ON CONSTRAINT app_limit_caps_defaults_name_key DO UPDATE SET
    max = EXCLUDED.max;
  END LOOP;
  RETURN true;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE;

CREATE SCHEMA myapp_memberships_private;

GRANT USAGE ON SCHEMA myapp_memberships_private TO administrator;

GRANT USAGE ON SCHEMA myapp_memberships_private TO authenticated;

GRANT USAGE ON SCHEMA myapp_memberships_private TO anonymous;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_memberships_private
  GRANT ALL ON TABLES TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_memberships_private
  GRANT USAGE ON SEQUENCES TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_memberships_private
  GRANT ALL ON FUNCTIONS TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_memberships_private
  GRANT ALL ON FUNCTIONS TO authenticated;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_memberships_private
  GRANT USAGE ON SEQUENCES TO authenticated;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_memberships_private
  GRANT ALL ON FUNCTIONS TO anonymous;

CREATE TABLE myapp_memberships_public.app_memberships ();

ALTER TABLE myapp_memberships_public.app_memberships 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_memberships_public.app_memberships IS 'Tracks membership records linking actors to entities with permission bitmasks, ownership, and admin status';

ALTER TABLE myapp_memberships_public.app_memberships 
  ADD COLUMN id uuid;

ALTER TABLE myapp_memberships_public.app_memberships 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_memberships_public.app_memberships 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_memberships_public.app_memberships 
  ADD CONSTRAINT app_memberships_pkey PRIMARY KEY (id);

ALTER TABLE myapp_memberships_public.app_memberships 
  ADD COLUMN created_at timestamptz;

ALTER TABLE myapp_memberships_public.app_memberships 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE myapp_memberships_public.app_memberships 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE myapp_memberships_public.app_memberships 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE TRIGGER timestamps_tg
  BEFORE INSERT OR UPDATE
  ON myapp_memberships_public.app_memberships
  FOR EACH ROW
  EXECUTE PROCEDURE stamps.timestamps();

CREATE INDEX app_memberships_created_at_idx ON myapp_memberships_public.app_memberships (created_at);

CREATE INDEX app_memberships_updated_at_idx ON myapp_memberships_public.app_memberships (updated_at);

ALTER TABLE myapp_memberships_public.app_memberships 
  ADD COLUMN created_by uuid;

ALTER TABLE myapp_memberships_public.app_memberships 
  ADD COLUMN updated_by uuid;

CREATE FUNCTION myapp_memberships_public.app_memberships_peoplestamps() RETURNS trigger AS $EOFCODE$
BEGIN
  IF TG_OP = 'INSERT' THEN
    SELECT jwt_public.current_user_id() INTO NEW.created_by;
    SELECT jwt_public.current_user_id() INTO NEW.updated_by;
  ELSIF TG_OP = 'UPDATE' THEN
    SELECT OLD.created_by INTO NEW.created_by;
    SELECT jwt_public.current_user_id() INTO NEW.updated_by;
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE;

CREATE TRIGGER peoplestamps_tg
  BEFORE INSERT OR UPDATE
  ON myapp_memberships_public.app_memberships
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_memberships_public.app_memberships_peoplestamps();

CREATE INDEX app_memberships_created_by_idx ON myapp_memberships_public.app_memberships (created_by);

CREATE INDEX app_memberships_updated_by_idx ON myapp_memberships_public.app_memberships (updated_by);

CREATE TABLE myapp_memberships_public.app_membership_defaults ();

ALTER TABLE myapp_memberships_public.app_membership_defaults 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_memberships_public.app_membership_defaults IS 'Default membership settings per entity, controlling initial approval and verification state for new members';

ALTER TABLE myapp_memberships_public.app_membership_defaults 
  ADD COLUMN id uuid;

ALTER TABLE myapp_memberships_public.app_membership_defaults 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_memberships_public.app_membership_defaults 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_memberships_public.app_membership_defaults 
  ADD CONSTRAINT app_membership_defaults_pkey PRIMARY KEY (id);

ALTER TABLE myapp_memberships_public.app_membership_defaults 
  ADD COLUMN created_at timestamptz;

ALTER TABLE myapp_memberships_public.app_membership_defaults 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE myapp_memberships_public.app_membership_defaults 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE myapp_memberships_public.app_membership_defaults 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE TRIGGER timestamps_tg
  BEFORE INSERT OR UPDATE
  ON myapp_memberships_public.app_membership_defaults
  FOR EACH ROW
  EXECUTE PROCEDURE stamps.timestamps();

CREATE INDEX app_membership_defaults_created_at_idx ON myapp_memberships_public.app_membership_defaults (created_at);

CREATE INDEX app_membership_defaults_updated_at_idx ON myapp_memberships_public.app_membership_defaults (updated_at);

ALTER TABLE myapp_memberships_public.app_membership_defaults 
  ADD COLUMN created_by uuid;

ALTER TABLE myapp_memberships_public.app_membership_defaults 
  ADD COLUMN updated_by uuid;

CREATE FUNCTION myapp_memberships_public.app_membership_defaults_peoplestamps() RETURNS trigger AS $EOFCODE$
BEGIN
  IF TG_OP = 'INSERT' THEN
    SELECT jwt_public.current_user_id() INTO NEW.created_by;
    SELECT jwt_public.current_user_id() INTO NEW.updated_by;
  ELSIF TG_OP = 'UPDATE' THEN
    SELECT OLD.created_by INTO NEW.created_by;
    SELECT jwt_public.current_user_id() INTO NEW.updated_by;
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE;

CREATE TRIGGER peoplestamps_tg
  BEFORE INSERT OR UPDATE
  ON myapp_memberships_public.app_membership_defaults
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_memberships_public.app_membership_defaults_peoplestamps();

CREATE INDEX app_membership_defaults_created_by_idx ON myapp_memberships_public.app_membership_defaults (created_by);

CREATE INDEX app_membership_defaults_updated_by_idx ON myapp_memberships_public.app_membership_defaults (updated_by);

CREATE TABLE myapp_memberships_private.app_memberships_sprt ();

ALTER TABLE myapp_memberships_private.app_memberships_sprt 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_memberships_private.app_memberships_sprt IS 'Security Predicate Resolution Table (SPRT). Denormalized lookup table used by RLS policies for fast permission checks without recursive queries';

ALTER TABLE myapp_memberships_private.app_memberships_sprt 
  ADD COLUMN is_owner boolean;

ALTER TABLE myapp_memberships_private.app_memberships_sprt 
  ALTER COLUMN is_owner SET NOT NULL;

ALTER TABLE myapp_memberships_private.app_memberships_sprt 
  ALTER COLUMN is_owner SET DEFAULT false;

COMMENT ON COLUMN myapp_memberships_private.app_memberships_sprt.is_owner IS 'Whether the actor is the owner of the entity';

ALTER TABLE myapp_memberships_private.app_memberships_sprt 
  ADD COLUMN is_admin boolean;

ALTER TABLE myapp_memberships_private.app_memberships_sprt 
  ALTER COLUMN is_admin SET NOT NULL;

ALTER TABLE myapp_memberships_private.app_memberships_sprt 
  ALTER COLUMN is_admin SET DEFAULT false;

COMMENT ON COLUMN myapp_memberships_private.app_memberships_sprt.is_admin IS 'Whether the actor has admin privileges on the entity';

ALTER TABLE myapp_memberships_private.app_memberships_sprt 
  ADD COLUMN permissions pg_catalog.bit(64);

ALTER TABLE myapp_memberships_private.app_memberships_sprt 
  ALTER COLUMN permissions SET NOT NULL;

ALTER TABLE myapp_memberships_private.app_memberships_sprt 
  ALTER COLUMN permissions SET DEFAULT CAST(lpad('', 64, '0') AS pg_catalog.bit(64));

COMMENT ON COLUMN myapp_memberships_private.app_memberships_sprt.permissions IS 'Resolved permission bitmask for this actor-entity pair, used by RLS policies for access control';

ALTER TABLE myapp_memberships_private.app_memberships_sprt 
  ADD COLUMN actor_id uuid;

ALTER TABLE myapp_memberships_private.app_memberships_sprt 
  ALTER COLUMN actor_id SET NOT NULL;

COMMENT ON COLUMN myapp_memberships_private.app_memberships_sprt.actor_id IS 'References the user whose permissions are being resolved';

CREATE UNIQUE INDEX app_memberships_sprts_actor_id_idx ON myapp_memberships_private.app_memberships_sprt (actor_id) INCLUDE (permissions, is_owner, is_admin);

GRANT SELECT ON myapp_memberships_private.app_memberships_sprt TO PUBLIC;

ALTER TABLE myapp_memberships_public.app_membership_defaults 
  ADD COLUMN is_approved boolean;

ALTER TABLE myapp_memberships_public.app_membership_defaults 
  ALTER COLUMN is_approved SET NOT NULL;

ALTER TABLE myapp_memberships_public.app_membership_defaults 
  ALTER COLUMN is_approved SET DEFAULT true;

COMMENT ON COLUMN myapp_memberships_public.app_membership_defaults.is_approved IS 'Whether new members are automatically approved upon joining';

ALTER TABLE myapp_memberships_public.app_membership_defaults 
  ADD COLUMN is_verified boolean;

ALTER TABLE myapp_memberships_public.app_membership_defaults 
  ALTER COLUMN is_verified SET NOT NULL;

ALTER TABLE myapp_memberships_public.app_membership_defaults 
  ALTER COLUMN is_verified SET DEFAULT false;

COMMENT ON COLUMN myapp_memberships_public.app_membership_defaults.is_verified IS 'Whether new members are automatically verified upon joining';

INSERT INTO myapp_memberships_public.app_membership_defaults (
  is_verified,
  is_approved
) VALUES
  (CAST('f' AS boolean), CAST('f' AS boolean));

ALTER TABLE myapp_memberships_public.app_memberships 
  ADD COLUMN is_approved boolean;

ALTER TABLE myapp_memberships_public.app_memberships 
  ALTER COLUMN is_approved SET NOT NULL;

ALTER TABLE myapp_memberships_public.app_memberships 
  ALTER COLUMN is_approved SET DEFAULT false;

COMMENT ON COLUMN myapp_memberships_public.app_memberships.is_approved IS 'Whether this membership has been approved by an admin';

ALTER TABLE myapp_memberships_public.app_memberships 
  ADD COLUMN is_banned boolean;

ALTER TABLE myapp_memberships_public.app_memberships 
  ALTER COLUMN is_banned SET NOT NULL;

ALTER TABLE myapp_memberships_public.app_memberships 
  ALTER COLUMN is_banned SET DEFAULT false;

COMMENT ON COLUMN myapp_memberships_public.app_memberships.is_banned IS 'Whether this member has been banned from the entity';

ALTER TABLE myapp_memberships_public.app_memberships 
  ADD COLUMN is_disabled boolean;

ALTER TABLE myapp_memberships_public.app_memberships 
  ALTER COLUMN is_disabled SET NOT NULL;

ALTER TABLE myapp_memberships_public.app_memberships 
  ALTER COLUMN is_disabled SET DEFAULT false;

COMMENT ON COLUMN myapp_memberships_public.app_memberships.is_disabled IS 'Whether this membership is temporarily disabled';

ALTER TABLE myapp_memberships_public.app_memberships 
  ADD COLUMN is_verified boolean;

ALTER TABLE myapp_memberships_public.app_memberships 
  ALTER COLUMN is_verified SET NOT NULL;

ALTER TABLE myapp_memberships_public.app_memberships 
  ALTER COLUMN is_verified SET DEFAULT false;

COMMENT ON COLUMN myapp_memberships_public.app_memberships.is_verified IS 'Whether this member has been verified (e.g. email confirmation)';

ALTER TABLE myapp_memberships_public.app_memberships 
  ADD COLUMN is_active boolean;

ALTER TABLE myapp_memberships_public.app_memberships 
  ALTER COLUMN is_active SET NOT NULL;

ALTER TABLE myapp_memberships_public.app_memberships 
  ALTER COLUMN is_active SET DEFAULT false;

COMMENT ON COLUMN myapp_memberships_public.app_memberships.is_active IS 'Computed field indicating the membership is approved, verified, not banned, and not disabled';

ALTER TABLE myapp_memberships_public.app_memberships 
  ADD COLUMN is_owner boolean;

ALTER TABLE myapp_memberships_public.app_memberships 
  ALTER COLUMN is_owner SET NOT NULL;

ALTER TABLE myapp_memberships_public.app_memberships 
  ALTER COLUMN is_owner SET DEFAULT false;

COMMENT ON COLUMN myapp_memberships_public.app_memberships.is_owner IS 'Whether the actor is the owner of this entity';

ALTER TABLE myapp_memberships_public.app_memberships 
  ADD COLUMN is_admin boolean;

ALTER TABLE myapp_memberships_public.app_memberships 
  ALTER COLUMN is_admin SET NOT NULL;

ALTER TABLE myapp_memberships_public.app_memberships 
  ALTER COLUMN is_admin SET DEFAULT false;

COMMENT ON COLUMN myapp_memberships_public.app_memberships.is_admin IS 'Whether the actor has admin privileges on this entity';

ALTER TABLE myapp_memberships_public.app_memberships 
  ADD COLUMN permissions pg_catalog.bit(64);

ALTER TABLE myapp_memberships_public.app_memberships 
  ALTER COLUMN permissions SET NOT NULL;

ALTER TABLE myapp_memberships_public.app_memberships 
  ALTER COLUMN permissions SET DEFAULT CAST(lpad('', 64, '0') AS pg_catalog.bit(64));

COMMENT ON COLUMN myapp_memberships_public.app_memberships.permissions IS 'Aggregated permission bitmask combining profile-based and directly granted permissions';

ALTER TABLE myapp_memberships_public.app_memberships 
  ADD COLUMN granted pg_catalog.bit(64);

ALTER TABLE myapp_memberships_public.app_memberships 
  ALTER COLUMN granted SET NOT NULL;

ALTER TABLE myapp_memberships_public.app_memberships 
  ALTER COLUMN granted SET DEFAULT CAST(lpad('', 64, '0') AS pg_catalog.bit(64));

COMMENT ON COLUMN myapp_memberships_public.app_memberships.granted IS 'Bitmask of permissions directly granted to this member (not from profiles)';

ALTER TABLE myapp_memberships_public.app_memberships 
  ADD COLUMN actor_id uuid;

ALTER TABLE myapp_memberships_public.app_memberships 
  ALTER COLUMN actor_id SET NOT NULL;

COMMENT ON COLUMN myapp_memberships_public.app_memberships.actor_id IS 'References the user who holds this membership';

ALTER TABLE myapp_memberships_public.app_memberships 
  ADD CONSTRAINT app_memberships_actor_id_fkey
    FOREIGN KEY(actor_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE CASCADE;

ALTER TABLE myapp_memberships_public.app_memberships 
  ADD CONSTRAINT app_memberships_actor_id_key 
    UNIQUE (actor_id);

CREATE FUNCTION myapp_memberships_private.app_memberships_insert_sprt_tg() RETURNS trigger AS $EOFCODE$
BEGIN
  IF NEW.is_owner IS true THEN
    new.is_admin := true;
    new.is_approved := true;
    new.is_verified := true;
    new.is_disabled := false;
    new.is_banned := false;
  END IF;
  new.is_active := ((NEW.is_approved IS true AND NEW.is_verified IS true) AND NEW.is_disabled IS false) AND NEW.is_banned IS false;
  IF NEW.is_active IS TRUE THEN
    INSERT INTO myapp_memberships_private.app_memberships_sprt (
      is_owner,
      is_admin,
      permissions,
      actor_id
    )
    VALUES
      (NEW.is_owner, NEW.is_admin, CASE 
          WHEN (NEW.is_owner IS TRUE OR NEW.is_admin IS TRUE) AND (NEW.permissions IS NULL OR NEW.permissions = (lpad('', (bit_length(NEW.permissions))::int, '0'))::pg_catalog.varbit) THEN (lpad('', (bit_length(NEW.permissions))::int, '1'))::pg_catalog.varbit 
          ELSE NEW.permissions 
        END, NEW.actor_id);
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION myapp_memberships_private.app_memberships_update_sprt_tg() RETURNS trigger AS $EOFCODE$
DECLARE
  v_num_updated int;
BEGIN
  IF NEW.is_owner IS true THEN
    new.is_admin := true;
    new.is_approved := true;
    new.is_verified := true;
    new.is_disabled := false;
    new.is_banned := false;
  END IF;
  new.is_active := ((NEW.is_approved IS true AND NEW.is_verified IS true) AND NEW.is_disabled IS false) AND NEW.is_banned IS false;
  IF NEW.is_active IS FALSE THEN
    DELETE FROM myapp_memberships_private.app_memberships_sprt
    WHERE
      actor_id = NEW.actor_id;
  ELSE
    INSERT INTO myapp_memberships_private.app_memberships_sprt (
      is_owner,
      is_admin,
      permissions,
      actor_id
    )
    VALUES
      (NEW.is_owner, NEW.is_admin, CASE 
          WHEN (NEW.is_owner IS TRUE OR NEW.is_admin IS TRUE) AND (NEW.permissions IS NULL OR NEW.permissions = (lpad('', (bit_length(NEW.permissions))::int, '0'))::pg_catalog.varbit) THEN (lpad('', (bit_length(NEW.permissions))::int, '1'))::pg_catalog.varbit 
          ELSE NEW.permissions 
        END, NEW.actor_id)
    ON CONFLICT (actor_id) DO UPDATE SET
    is_owner = EXCLUDED.is_owner, is_admin = EXCLUDED.is_admin, permissions = EXCLUDED.permissions;
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION myapp_memberships_private.app_memberships_delete_sprt_tg() RETURNS trigger AS $EOFCODE$
DECLARE
  v_num_updated int;
BEGIN
  DELETE FROM myapp_memberships_private.app_memberships_sprt
  WHERE
    actor_id = OLD.actor_id;
  RETURN OLD;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION myapp_memberships_private.app_memberships_perm_check(
  perm text,
  actor_id uuid DEFAULT jwt_public.current_user_id()
) RETURNS boolean AS $EOFCODE$
SELECT
  EXISTS (SELECT 1
  FROM myapp_memberships_public.app_memberships AS m, myapp_permissions_public.app_permissions AS p
  WHERE
    (p.name = perm AND (m.permissions & p.bitstr) = p.bitstr) AND m.actor_id = app_memberships_perm_check.actor_id)
$EOFCODE$ LANGUAGE sql STABLE SECURITY DEFINER;

CREATE FUNCTION myapp_memberships_private.app_memberships_mask_check(
  mask pg_catalog.varbit,
  actor_id uuid DEFAULT jwt_public.current_user_id()
) RETURNS boolean AS $EOFCODE$
SELECT
  EXISTS (SELECT 1
  FROM myapp_memberships_public.app_memberships AS m
  WHERE
    (m.permissions & mask) = mask AND m.actor_id = app_memberships_mask_check.actor_id)
$EOFCODE$ LANGUAGE sql STABLE SECURITY DEFINER;

CREATE TABLE myapp_memberships_public.app_admin_grants ();

ALTER TABLE myapp_memberships_public.app_admin_grants 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_memberships_public.app_admin_grants IS 'Records of admin role grants and revocations between members';

ALTER TABLE myapp_memberships_public.app_admin_grants 
  ADD COLUMN id uuid;

ALTER TABLE myapp_memberships_public.app_admin_grants 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_memberships_public.app_admin_grants 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_memberships_public.app_admin_grants 
  ADD CONSTRAINT app_admin_grants_pkey PRIMARY KEY (id);

ALTER TABLE myapp_memberships_public.app_admin_grants 
  ADD COLUMN is_grant boolean;

ALTER TABLE myapp_memberships_public.app_admin_grants 
  ALTER COLUMN is_grant SET NOT NULL;

ALTER TABLE myapp_memberships_public.app_admin_grants 
  ALTER COLUMN is_grant SET DEFAULT true;

COMMENT ON COLUMN myapp_memberships_public.app_admin_grants.is_grant IS 'True to grant admin, false to revoke admin';

ALTER TABLE myapp_memberships_public.app_admin_grants 
  ADD COLUMN actor_id uuid;

COMMENT ON COLUMN myapp_memberships_public.app_admin_grants.actor_id IS 'The member receiving or losing the admin grant; NULL if user was deleted';

ALTER TABLE myapp_memberships_public.app_admin_grants 
  ADD CONSTRAINT app_admin_grants_actor_id_fkey
    FOREIGN KEY(actor_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE SET NULL;

CREATE INDEX app_admin_grants_actor_id_idx ON myapp_memberships_public.app_admin_grants (actor_id);

ALTER TABLE myapp_memberships_public.app_admin_grants 
  ADD COLUMN grantor_id uuid;

ALTER TABLE myapp_memberships_public.app_admin_grants 
  ALTER COLUMN grantor_id SET DEFAULT jwt_public.current_user_id();

ALTER TABLE myapp_memberships_public.app_admin_grants 
  ADD CONSTRAINT app_admin_grants_grantor_id_fkey
    FOREIGN KEY(grantor_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE SET NULL;

CREATE INDEX app_admin_grants_grantor_id_idx ON myapp_memberships_public.app_admin_grants (grantor_id);

ALTER TABLE myapp_memberships_public.app_admin_grants 
  ADD COLUMN created_at timestamptz;

ALTER TABLE myapp_memberships_public.app_admin_grants 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE myapp_memberships_public.app_admin_grants 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE myapp_memberships_public.app_admin_grants 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE TRIGGER timestamps_tg
  BEFORE INSERT OR UPDATE
  ON myapp_memberships_public.app_admin_grants
  FOR EACH ROW
  EXECUTE PROCEDURE stamps.timestamps();

CREATE INDEX app_admin_grants_created_at_idx ON myapp_memberships_public.app_admin_grants (created_at);

CREATE INDEX app_admin_grants_updated_at_idx ON myapp_memberships_public.app_admin_grants (updated_at);

CREATE TABLE myapp_memberships_public.app_owner_grants ();

ALTER TABLE myapp_memberships_public.app_owner_grants 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_memberships_public.app_owner_grants IS 'Records of ownership transfers and grants between members';

ALTER TABLE myapp_memberships_public.app_owner_grants 
  ADD COLUMN id uuid;

ALTER TABLE myapp_memberships_public.app_owner_grants 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_memberships_public.app_owner_grants 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_memberships_public.app_owner_grants 
  ADD CONSTRAINT app_owner_grants_pkey PRIMARY KEY (id);

ALTER TABLE myapp_memberships_public.app_owner_grants 
  ADD COLUMN is_grant boolean;

ALTER TABLE myapp_memberships_public.app_owner_grants 
  ALTER COLUMN is_grant SET NOT NULL;

ALTER TABLE myapp_memberships_public.app_owner_grants 
  ALTER COLUMN is_grant SET DEFAULT true;

COMMENT ON COLUMN myapp_memberships_public.app_owner_grants.is_grant IS 'True to grant ownership, false to revoke ownership';

ALTER TABLE myapp_memberships_public.app_owner_grants 
  ADD COLUMN actor_id uuid;

COMMENT ON COLUMN myapp_memberships_public.app_owner_grants.actor_id IS 'The member receiving or losing the ownership grant; NULL if user was deleted';

ALTER TABLE myapp_memberships_public.app_owner_grants 
  ADD CONSTRAINT app_owner_grants_actor_id_fkey
    FOREIGN KEY(actor_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE SET NULL;

CREATE INDEX app_owner_grants_actor_id_idx ON myapp_memberships_public.app_owner_grants (actor_id);

ALTER TABLE myapp_memberships_public.app_owner_grants 
  ADD COLUMN grantor_id uuid;

ALTER TABLE myapp_memberships_public.app_owner_grants 
  ALTER COLUMN grantor_id SET DEFAULT jwt_public.current_user_id();

ALTER TABLE myapp_memberships_public.app_owner_grants 
  ADD CONSTRAINT app_owner_grants_grantor_id_fkey
    FOREIGN KEY(grantor_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE SET NULL;

CREATE INDEX app_owner_grants_grantor_id_idx ON myapp_memberships_public.app_owner_grants (grantor_id);

ALTER TABLE myapp_memberships_public.app_owner_grants 
  ADD COLUMN created_at timestamptz;

ALTER TABLE myapp_memberships_public.app_owner_grants 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE myapp_memberships_public.app_owner_grants 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE myapp_memberships_public.app_owner_grants 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE TRIGGER timestamps_tg
  BEFORE INSERT OR UPDATE
  ON myapp_memberships_public.app_owner_grants
  FOR EACH ROW
  EXECUTE PROCEDURE stamps.timestamps();

CREATE INDEX app_owner_grants_created_at_idx ON myapp_memberships_public.app_owner_grants (created_at);

CREATE INDEX app_owner_grants_updated_at_idx ON myapp_memberships_public.app_owner_grants (updated_at);

CREATE TABLE myapp_memberships_public.app_grants ();

ALTER TABLE myapp_memberships_public.app_grants 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_memberships_public.app_grants IS 'Records of individual permission grants and revocations for members via bitmask';

ALTER TABLE myapp_memberships_public.app_grants 
  ADD COLUMN id uuid;

ALTER TABLE myapp_memberships_public.app_grants 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_memberships_public.app_grants 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_memberships_public.app_grants 
  ADD CONSTRAINT app_grants_pkey PRIMARY KEY (id);

ALTER TABLE myapp_memberships_public.app_grants 
  ADD COLUMN permissions pg_catalog.bit(64);

ALTER TABLE myapp_memberships_public.app_grants 
  ALTER COLUMN permissions SET NOT NULL;

ALTER TABLE myapp_memberships_public.app_grants 
  ALTER COLUMN permissions SET DEFAULT CAST(lpad('', 64, '0') AS pg_catalog.bit(64));

COMMENT ON COLUMN myapp_memberships_public.app_grants.permissions IS 'Bitmask of permissions being granted or revoked';

ALTER TABLE myapp_memberships_public.app_grants 
  ADD COLUMN is_grant boolean;

ALTER TABLE myapp_memberships_public.app_grants 
  ALTER COLUMN is_grant SET NOT NULL;

ALTER TABLE myapp_memberships_public.app_grants 
  ALTER COLUMN is_grant SET DEFAULT true;

COMMENT ON COLUMN myapp_memberships_public.app_grants.is_grant IS 'True to grant the permissions, false to revoke them';

ALTER TABLE myapp_memberships_public.app_grants 
  ADD COLUMN actor_id uuid;

COMMENT ON COLUMN myapp_memberships_public.app_grants.actor_id IS 'The member receiving or losing the permission grant; NULL if user was deleted';

ALTER TABLE myapp_memberships_public.app_grants 
  ADD CONSTRAINT app_grants_actor_id_fkey
    FOREIGN KEY(actor_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE SET NULL;

CREATE INDEX app_grants_actor_id_idx ON myapp_memberships_public.app_grants (actor_id);

ALTER TABLE myapp_memberships_public.app_grants 
  ADD COLUMN grantor_id uuid;

ALTER TABLE myapp_memberships_public.app_grants 
  ALTER COLUMN grantor_id SET DEFAULT jwt_public.current_user_id();

ALTER TABLE myapp_memberships_public.app_grants 
  ADD CONSTRAINT app_grants_grantor_id_fkey
    FOREIGN KEY(grantor_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE SET NULL;

CREATE INDEX app_grants_grantor_id_idx ON myapp_memberships_public.app_grants (grantor_id);

ALTER TABLE myapp_memberships_public.app_grants 
  ADD COLUMN created_at timestamptz;

ALTER TABLE myapp_memberships_public.app_grants 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE myapp_memberships_public.app_grants 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE myapp_memberships_public.app_grants 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE TRIGGER timestamps_tg
  BEFORE INSERT OR UPDATE
  ON myapp_memberships_public.app_grants
  FOR EACH ROW
  EXECUTE PROCEDURE stamps.timestamps();

CREATE INDEX app_grants_created_at_idx ON myapp_memberships_public.app_grants (created_at);

CREATE INDEX app_grants_updated_at_idx ON myapp_memberships_public.app_grants (updated_at);

CREATE TABLE myapp_memberships_public.app_permission_default_permissions ();

ALTER TABLE myapp_memberships_public.app_permission_default_permissions 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_memberships_public.app_permission_default_permissions IS 'Join table linking permission defaults to individual permissions; recompute trigger rebuilds the defaults bitmask';

ALTER TABLE myapp_memberships_public.app_permission_default_permissions 
  ADD COLUMN id uuid;

ALTER TABLE myapp_memberships_public.app_permission_default_permissions 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_memberships_public.app_permission_default_permissions 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_memberships_public.app_permission_default_permissions 
  ADD CONSTRAINT app_permission_default_permissions_pkey PRIMARY KEY (id);

ALTER TABLE myapp_memberships_public.app_permission_default_permissions 
  ADD COLUMN permission_id uuid;

ALTER TABLE myapp_memberships_public.app_permission_default_permissions 
  ALTER COLUMN permission_id SET NOT NULL;

COMMENT ON COLUMN myapp_memberships_public.app_permission_default_permissions.permission_id IS 'References the permission included in the defaults bundle';

ALTER TABLE myapp_memberships_public.app_permission_default_permissions 
  ADD CONSTRAINT app_permission_default_permissions_permission_id_fkey
    FOREIGN KEY(permission_id)
    REFERENCES myapp_permissions_public.app_permissions (id)
    ON DELETE CASCADE;

ALTER TABLE myapp_memberships_public.app_permission_default_permissions 
  ADD CONSTRAINT app_permission_default_permissions_permission_id_key 
    UNIQUE (permission_id);

ALTER TABLE myapp_memberships_public.app_permission_default_permissions 
  ADD COLUMN created_at timestamptz;

ALTER TABLE myapp_memberships_public.app_permission_default_permissions 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE myapp_memberships_public.app_permission_default_permissions 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE myapp_memberships_public.app_permission_default_permissions 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE TRIGGER timestamps_tg
  BEFORE INSERT OR UPDATE
  ON myapp_memberships_public.app_permission_default_permissions
  FOR EACH ROW
  EXECUTE PROCEDURE stamps.timestamps();

CREATE INDEX app_permission_default_permissions_created_at_idx ON myapp_memberships_public.app_permission_default_permissions (created_at);

CREATE INDEX app_permission_default_permissions_updated_at_idx ON myapp_memberships_public.app_permission_default_permissions (updated_at);

CREATE TABLE myapp_memberships_public.app_permission_default_grants ();

ALTER TABLE myapp_memberships_public.app_permission_default_grants 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_memberships_public.app_permission_default_grants IS 'Audit log of permission additions and removals from the defaults bitmask';

ALTER TABLE myapp_memberships_public.app_permission_default_grants 
  ADD COLUMN id uuid;

ALTER TABLE myapp_memberships_public.app_permission_default_grants 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_memberships_public.app_permission_default_grants 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_memberships_public.app_permission_default_grants 
  ADD CONSTRAINT app_permission_default_grants_pkey PRIMARY KEY (id);

ALTER TABLE myapp_memberships_public.app_permission_default_grants 
  ADD COLUMN permission_id uuid;

ALTER TABLE myapp_memberships_public.app_permission_default_grants 
  ALTER COLUMN permission_id SET NOT NULL;

COMMENT ON COLUMN myapp_memberships_public.app_permission_default_grants.permission_id IS 'References the permission being added to or removed from defaults';

ALTER TABLE myapp_memberships_public.app_permission_default_grants 
  ADD CONSTRAINT app_permission_default_grants_permission_id_fkey
    FOREIGN KEY(permission_id)
    REFERENCES myapp_permissions_public.app_permissions (id)
    ON DELETE CASCADE;

CREATE INDEX app_permission_default_grants_permission_id_idx ON myapp_memberships_public.app_permission_default_grants (permission_id);

ALTER TABLE myapp_memberships_public.app_permission_default_grants 
  ADD COLUMN is_grant boolean;

ALTER TABLE myapp_memberships_public.app_permission_default_grants 
  ALTER COLUMN is_grant SET NOT NULL;

ALTER TABLE myapp_memberships_public.app_permission_default_grants 
  ALTER COLUMN is_grant SET DEFAULT true;

COMMENT ON COLUMN myapp_memberships_public.app_permission_default_grants.is_grant IS 'True to add the permission to defaults, false to remove it';

ALTER TABLE myapp_memberships_public.app_permission_default_grants 
  ADD COLUMN grantor_id uuid;

ALTER TABLE myapp_memberships_public.app_permission_default_grants 
  ALTER COLUMN grantor_id SET DEFAULT jwt_public.current_user_id();

ALTER TABLE myapp_memberships_public.app_permission_default_grants 
  ADD CONSTRAINT app_permission_default_grants_grantor_id_fkey
    FOREIGN KEY(grantor_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE SET NULL;

CREATE INDEX app_permission_default_grants_grantor_id_idx ON myapp_memberships_public.app_permission_default_grants (grantor_id);

ALTER TABLE myapp_memberships_public.app_permission_default_grants 
  ADD COLUMN created_at timestamptz;

ALTER TABLE myapp_memberships_public.app_permission_default_grants 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE myapp_memberships_public.app_permission_default_grants 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE myapp_memberships_public.app_permission_default_grants 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE TRIGGER timestamps_tg
  BEFORE INSERT OR UPDATE
  ON myapp_memberships_public.app_permission_default_grants
  FOR EACH ROW
  EXECUTE PROCEDURE stamps.timestamps();

CREATE INDEX app_permission_default_grants_created_at_idx ON myapp_memberships_public.app_permission_default_grants (created_at);

CREATE INDEX app_permission_default_grants_updated_at_idx ON myapp_memberships_public.app_permission_default_grants (updated_at);

CREATE FUNCTION myapp_memberships_private.app_memberships_itg() RETURNS trigger AS $EOFCODE$
DECLARE
  bitlen int := bit_length(NEW.permissions);
  defaults bit varying;
  memdefs myapp_memberships_public.app_membership_defaults;
BEGIN
  SELECT *
  FROM myapp_memberships_public.app_membership_defaults AS t
  LIMIT
  1 INTO memdefs;
  IF FOUND THEN
    new.is_approved := memdefs.is_approved;
    new.is_verified := memdefs.is_verified;
  END IF;
  IF NEW.is_owner IS true THEN
    new.is_admin := true;
    new.is_approved := true;
    new.is_verified := true;
    new.is_disabled := false;
    new.is_banned := false;
  END IF;
  new.is_active := ((NEW.is_approved IS true AND NEW.is_verified IS true) AND NEW.is_disabled IS false) AND NEW.is_banned IS false;
  SELECT permissions
  FROM myapp_permissions_public.app_permission_defaults AS t
  LIMIT
  1 INTO defaults;
  IF NOT (FOUND) THEN
    new.granted := lpad('', bitlen::int, '0');
  ELSE
    new.granted := defaults;
  END IF;
  IF NEW.is_admin IS true OR NEW.is_owner IS true THEN
    new.permissions := lpad('', bitlen::int, '1');
  ELSE
    new.permissions := NEW.granted;
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE TRIGGER _00010_app_memberships_itrg
  BEFORE INSERT
  ON myapp_memberships_public.app_memberships
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_memberships_private.app_memberships_itg();

CREATE FUNCTION myapp_memberships_private.app_memberships_utg() RETURNS trigger AS $EOFCODE$
DECLARE
  bitlen int := bit_length(NEW.permissions);
BEGIN
  IF NEW.is_owner IS true THEN
    new.is_admin := true;
    new.is_approved := true;
    new.is_verified := true;
    new.is_disabled := false;
    new.is_banned := false;
  END IF;
  new.is_active := ((NEW.is_approved IS true AND NEW.is_verified IS true) AND NEW.is_disabled IS false) AND NEW.is_banned IS false;
  IF NEW.is_admin IS true OR NEW.is_owner IS true THEN
    new.permissions := lpad('', bitlen::int, '1');
  ELSE
    new.permissions := NEW.granted;
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE TRIGGER _00010_app_memberships_utrg
  BEFORE UPDATE
  ON myapp_memberships_public.app_memberships
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_memberships_private.app_memberships_utg();

CREATE TRIGGER _00020_app_memberships_insert_sprt
  AFTER INSERT
  ON myapp_memberships_public.app_memberships
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_memberships_private.app_memberships_insert_sprt_tg();

CREATE TRIGGER _00020_app_memberships_update_sprt
  AFTER UPDATE
  ON myapp_memberships_public.app_memberships
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_memberships_private.app_memberships_update_sprt_tg();

CREATE TRIGGER _99999_app_memberships_delete_sprt
  AFTER DELETE
  ON myapp_memberships_public.app_memberships
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_memberships_private.app_memberships_delete_sprt_tg();

CREATE FUNCTION myapp_memberships_private.app_mbr_create() RETURNS trigger AS $EOFCODE$
BEGIN
  IF NEW.type = 3 THEN
    RETURN NEW;
  END IF;
  INSERT INTO myapp_memberships_public.app_memberships (
    actor_id
  )
  VALUES
    (NEW.id);
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE TRIGGER app_mbr_trg
  AFTER INSERT
  ON myapp_users_public.users
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_memberships_private.app_mbr_create();

CREATE FUNCTION myapp_memberships_private.app_grants_apply_tg() RETURNS trigger AS $EOFCODE$
BEGIN
  IF NEW.is_grant IS TRUE THEN
    UPDATE myapp_memberships_public.app_memberships SET
    granted = granted | NEW.permissions
    WHERE
      actor_id = NEW.actor_id;
  ELSE
    UPDATE myapp_memberships_public.app_memberships SET
    granted = granted & (~NEW.permissions)
    WHERE
      actor_id = NEW.actor_id;
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE TRIGGER app_grants_insert_trg
  BEFORE INSERT
  ON myapp_memberships_public.app_grants
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_memberships_private.app_grants_apply_tg();

CREATE FUNCTION myapp_memberships_private.app_admin_grants_apply_tg() RETURNS trigger AS $EOFCODE$
BEGIN
  IF NEW.is_grant IS TRUE THEN
    UPDATE myapp_memberships_public.app_memberships SET
    is_admin = true
    WHERE
      actor_id = NEW.actor_id;
  ELSE
    UPDATE myapp_memberships_public.app_memberships SET
    is_admin = false
    WHERE
      actor_id = NEW.actor_id AND is_owner = false;
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE TRIGGER app_admin_grants_insert_trg
  BEFORE INSERT
  ON myapp_memberships_public.app_admin_grants
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_memberships_private.app_admin_grants_apply_tg();

CREATE FUNCTION myapp_memberships_private.app_owner_grants_apply_tg() RETURNS trigger AS $EOFCODE$
BEGIN
  IF NEW.is_grant IS TRUE THEN
    UPDATE myapp_memberships_public.app_memberships SET
    is_owner = true
    WHERE
      actor_id = NEW.actor_id;
  ELSE
    UPDATE myapp_memberships_public.app_memberships SET
    is_owner = false
    WHERE
      actor_id = NEW.actor_id;
    IF (SELECT
      count(*) < 1
    FROM myapp_memberships_public.app_memberships
    WHERE
      is_owner = true) THEN
      RAISE EXCEPTION 'REQUIRES_ONE_OWNER';
    END IF;
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE TRIGGER app_owner_grants_insert_trg
  BEFORE INSERT
  ON myapp_memberships_public.app_owner_grants
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_memberships_private.app_owner_grants_apply_tg();

CREATE FUNCTION myapp_memberships_private.app_permission_default_grants_apply_tg() RETURNS trigger AS $EOFCODE$
BEGIN
  IF NEW.is_grant IS TRUE THEN
    INSERT INTO myapp_memberships_public.app_permission_default_permissions (
      permission_id
    )
    VALUES
      (NEW.permission_id)
    ON CONFLICT (permission_id) DO NOTHING;
  ELSE
    DELETE FROM myapp_memberships_public.app_permission_default_permissions
    WHERE
      permission_id = NEW.permission_id;
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE;

CREATE TRIGGER app_permission_default_grants_insert_trg
  BEFORE INSERT
  ON myapp_memberships_public.app_permission_default_grants
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_memberships_private.app_permission_default_grants_apply_tg();

CREATE FUNCTION myapp_memberships_private.app_permission_default_permissions_recompute_tg() RETURNS trigger AS $EOFCODE$
DECLARE
  v_permissions bit(64);
BEGIN
  SELECT coalesce(bit_or(p.bitstr), (lpad('', 64, '0'))::bit(64)::bit(64))
  FROM myapp_memberships_public.app_permission_default_permissions AS pp INNER JOIN myapp_permissions_public.app_permissions AS p ON p.id = pp.permission_id INTO v_permissions;
  UPDATE myapp_permissions_public.app_permission_defaults SET
  permissions = v_permissions;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE TRIGGER app_permission_default_permissions_recompute_trg
  BEFORE INSERT OR DELETE OR UPDATE
  ON myapp_memberships_public.app_permission_default_permissions
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_memberships_private.app_permission_default_permissions_recompute_tg();

CREATE TRIGGER app_membership_defaults_insert_trg
  BEFORE INSERT
  ON myapp_memberships_public.app_membership_defaults
  FOR EACH ROW
  EXECUTE PROCEDURE utils.ensure_singleton();

INSERT INTO myapp_permissions_public.app_permissions (
  bitnum,
  name,
  description
) VALUES
  (1, 'admin_members', 'Manage members of the app.'),
  (2, 'create_invites', 'Create invites for the app.'),
  (3, 'admin_invites', 'Approve invites of the app.'),
  (4, 'send_approved_invites', 'Invites sent by this user are pre-approved.'),
  (5, 'create_entity', 'Create organization entities.'),
  (6, 'admin_limits', 'Manage limits within the app.'),
  (7, 'admin_permissions', 'Manage permissions within the app.'),
  (8, 'admin_levels', 'Manage levels of the app.'),
  (9, 'manage_identity_providers', 'Manage identity providers for the app.'),
  (10, 'assign_profiles', 'Assign profiles (roles) to invites for the app.'),
  (11, 'add_credits', 'Add credits to limits and billing meters.'),
  (12, 'manage_secrets', 'Manage encrypted secrets for the app.');

CREATE SCHEMA myapp_profiles_public;

GRANT USAGE ON SCHEMA myapp_profiles_public TO administrator;

GRANT USAGE ON SCHEMA myapp_profiles_public TO authenticated;

GRANT USAGE ON SCHEMA myapp_profiles_public TO anonymous;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_profiles_public
  GRANT ALL ON TABLES TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_profiles_public
  GRANT USAGE ON SEQUENCES TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_profiles_public
  GRANT ALL ON FUNCTIONS TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_profiles_public
  GRANT ALL ON FUNCTIONS TO authenticated;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_profiles_public
  GRANT USAGE ON SEQUENCES TO authenticated;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_profiles_public
  GRANT ALL ON FUNCTIONS TO anonymous;

CREATE SCHEMA myapp_profiles_private;

GRANT USAGE ON SCHEMA myapp_profiles_private TO administrator;

GRANT USAGE ON SCHEMA myapp_profiles_private TO authenticated;

GRANT USAGE ON SCHEMA myapp_profiles_private TO anonymous;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_profiles_private
  GRANT ALL ON TABLES TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_profiles_private
  GRANT USAGE ON SEQUENCES TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_profiles_private
  GRANT ALL ON FUNCTIONS TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_profiles_private
  GRANT ALL ON FUNCTIONS TO authenticated;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_profiles_private
  GRANT USAGE ON SEQUENCES TO authenticated;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_profiles_private
  GRANT ALL ON FUNCTIONS TO anonymous;

CREATE TABLE myapp_profiles_public.app_profiles ();

ALTER TABLE myapp_profiles_public.app_profiles 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_profiles_public.app_profiles IS 'Named permission bundles (roles) that group multiple permissions into reusable profiles';

ALTER TABLE myapp_profiles_public.app_profiles 
  ADD COLUMN id uuid;

ALTER TABLE myapp_profiles_public.app_profiles 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_profiles_public.app_profiles 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_profiles_public.app_profiles 
  ADD CONSTRAINT app_profiles_pkey PRIMARY KEY (id);

ALTER TABLE myapp_profiles_public.app_profiles 
  ADD COLUMN name citext;

ALTER TABLE myapp_profiles_public.app_profiles 
  ALTER COLUMN name SET NOT NULL;

COMMENT ON COLUMN myapp_profiles_public.app_profiles.name IS 'Display name for this profile (e.g. Admin, Editor, Viewer)';

ALTER TABLE myapp_profiles_public.app_profiles 
  ADD COLUMN slug text;

ALTER TABLE myapp_profiles_public.app_profiles 
  ALTER COLUMN slug SET NOT NULL;

COMMENT ON COLUMN myapp_profiles_public.app_profiles.slug IS 'URL-safe identifier for this profile, used in API references';

ALTER TABLE myapp_profiles_public.app_profiles 
  ADD COLUMN description text;

COMMENT ON COLUMN myapp_profiles_public.app_profiles.description IS 'Human-readable description of this profile and its intended use';

ALTER TABLE myapp_profiles_public.app_profiles 
  ADD COLUMN permissions pg_catalog.bit(64);

ALTER TABLE myapp_profiles_public.app_profiles 
  ALTER COLUMN permissions SET NOT NULL;

ALTER TABLE myapp_profiles_public.app_profiles 
  ALTER COLUMN permissions SET DEFAULT CAST(lpad('', 64, '0') AS pg_catalog.bit(64));

COMMENT ON COLUMN myapp_profiles_public.app_profiles.permissions IS 'Pre-computed permission bitmask aggregating all permissions in this profile';

ALTER TABLE myapp_profiles_public.app_profiles 
  ADD COLUMN is_system boolean;

ALTER TABLE myapp_profiles_public.app_profiles 
  ALTER COLUMN is_system SET NOT NULL;

ALTER TABLE myapp_profiles_public.app_profiles 
  ALTER COLUMN is_system SET DEFAULT false;

COMMENT ON COLUMN myapp_profiles_public.app_profiles.is_system IS 'System profiles are built-in and cannot be deleted or renamed by users';

ALTER TABLE myapp_profiles_public.app_profiles 
  ADD COLUMN is_default boolean;

ALTER TABLE myapp_profiles_public.app_profiles 
  ALTER COLUMN is_default SET NOT NULL;

ALTER TABLE myapp_profiles_public.app_profiles 
  ALTER COLUMN is_default SET DEFAULT false;

COMMENT ON COLUMN myapp_profiles_public.app_profiles.is_default IS 'The default profile is automatically assigned to new members when they join';

ALTER TABLE myapp_profiles_public.app_profiles 
  ADD COLUMN created_at timestamptz;

ALTER TABLE myapp_profiles_public.app_profiles 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE myapp_profiles_public.app_profiles 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE myapp_profiles_public.app_profiles 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE TRIGGER timestamps_tg
  BEFORE INSERT OR UPDATE
  ON myapp_profiles_public.app_profiles
  FOR EACH ROW
  EXECUTE PROCEDURE stamps.timestamps();

CREATE INDEX app_profiles_created_at_idx ON myapp_profiles_public.app_profiles (created_at);

CREATE INDEX app_profiles_updated_at_idx ON myapp_profiles_public.app_profiles (updated_at);

ALTER TABLE myapp_profiles_public.app_profiles 
  ADD CONSTRAINT app_profiles_name_key 
    UNIQUE (name);

ALTER TABLE myapp_profiles_public.app_profiles 
  ADD CONSTRAINT app_profiles_slug_key 
    UNIQUE (slug);

CREATE INDEX app_profiles_is_default_idx ON myapp_profiles_public.app_profiles (is_default);

CREATE UNIQUE INDEX app_profiles_default_uniq ON myapp_profiles_public.app_profiles ((CAST(true AS boolean))) WHERE is_default = true;

CREATE TABLE myapp_profiles_public.app_profile_permissions ();

ALTER TABLE myapp_profiles_public.app_profile_permissions 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_profiles_public.app_profile_permissions IS 'Join table linking profiles to individual permissions they include';

ALTER TABLE myapp_profiles_public.app_profile_permissions 
  ADD COLUMN id uuid;

ALTER TABLE myapp_profiles_public.app_profile_permissions 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_profiles_public.app_profile_permissions 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_profiles_public.app_profile_permissions 
  ADD CONSTRAINT app_profile_permissions_pkey PRIMARY KEY (id);

ALTER TABLE myapp_profiles_public.app_profile_permissions 
  ADD COLUMN profile_id uuid;

ALTER TABLE myapp_profiles_public.app_profile_permissions 
  ALTER COLUMN profile_id SET NOT NULL;

COMMENT ON COLUMN myapp_profiles_public.app_profile_permissions.profile_id IS 'References the profile this permission belongs to';

ALTER TABLE myapp_profiles_public.app_profile_permissions 
  ADD CONSTRAINT app_profile_permissions_profile_id_fkey
    FOREIGN KEY(profile_id)
    REFERENCES myapp_profiles_public.app_profiles (id)
    ON DELETE CASCADE;

ALTER TABLE myapp_profiles_public.app_profile_permissions 
  ADD COLUMN permission_id uuid;

ALTER TABLE myapp_profiles_public.app_profile_permissions 
  ALTER COLUMN permission_id SET NOT NULL;

COMMENT ON COLUMN myapp_profiles_public.app_profile_permissions.permission_id IS 'References the permission included in this profile';

ALTER TABLE myapp_profiles_public.app_profile_permissions 
  ADD CONSTRAINT app_profile_permissions_permission_id_fkey
    FOREIGN KEY(permission_id)
    REFERENCES myapp_permissions_public.app_permissions (id)
    ON DELETE CASCADE;

CREATE INDEX app_profile_permissions_permission_id_idx ON myapp_profiles_public.app_profile_permissions (permission_id);

ALTER TABLE myapp_profiles_public.app_profile_permissions 
  ADD CONSTRAINT app_profile_permissions_profile_id_permission_id_key 
    UNIQUE (profile_id, permission_id);

CREATE INDEX app_profile_permissions_profile_id_idx ON myapp_profiles_public.app_profile_permissions (profile_id);

ALTER TABLE myapp_profiles_public.app_profile_permissions 
  ADD COLUMN created_at timestamptz;

ALTER TABLE myapp_profiles_public.app_profile_permissions 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE myapp_profiles_public.app_profile_permissions 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE myapp_profiles_public.app_profile_permissions 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE TRIGGER timestamps_tg
  BEFORE INSERT OR UPDATE
  ON myapp_profiles_public.app_profile_permissions
  FOR EACH ROW
  EXECUTE PROCEDURE stamps.timestamps();

CREATE INDEX app_profile_permissions_created_at_idx ON myapp_profiles_public.app_profile_permissions (created_at);

CREATE INDEX app_profile_permissions_updated_at_idx ON myapp_profiles_public.app_profile_permissions (updated_at);

CREATE TABLE myapp_profiles_public.app_profile_grants ();

ALTER TABLE myapp_profiles_public.app_profile_grants 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_profiles_public.app_profile_grants IS 'Audit log of profile assignments and revocations for members';

ALTER TABLE myapp_profiles_public.app_profile_grants 
  ADD COLUMN id uuid;

ALTER TABLE myapp_profiles_public.app_profile_grants 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_profiles_public.app_profile_grants 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_profiles_public.app_profile_grants 
  ADD CONSTRAINT app_profile_grants_pkey PRIMARY KEY (id);

ALTER TABLE myapp_profiles_public.app_profile_grants 
  ADD COLUMN membership_id uuid;

COMMENT ON COLUMN myapp_profiles_public.app_profile_grants.membership_id IS 'References the membership that received or lost this profile; NULL if membership was deleted';

ALTER TABLE myapp_profiles_public.app_profile_grants 
  ADD CONSTRAINT app_profile_grants_membership_id_fkey
    FOREIGN KEY(membership_id)
    REFERENCES myapp_memberships_public.app_memberships (id)
    ON DELETE SET NULL;

ALTER TABLE myapp_profiles_public.app_profile_grants 
  ADD COLUMN profile_id uuid;

COMMENT ON COLUMN myapp_profiles_public.app_profile_grants.profile_id IS 'References the profile being assigned; NULL indicates the profile was removed';

ALTER TABLE myapp_profiles_public.app_profile_grants 
  ADD CONSTRAINT app_profile_grants_profile_id_fkey
    FOREIGN KEY(profile_id)
    REFERENCES myapp_profiles_public.app_profiles (id)
    ON DELETE SET NULL;

ALTER TABLE myapp_profiles_public.app_profile_grants 
  ADD COLUMN grantor_id uuid;

ALTER TABLE myapp_profiles_public.app_profile_grants 
  ALTER COLUMN grantor_id SET DEFAULT jwt_public.current_user_id();

ALTER TABLE myapp_profiles_public.app_profile_grants 
  ADD CONSTRAINT app_profile_grants_grantor_id_fkey
    FOREIGN KEY(grantor_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE SET NULL;

CREATE INDEX app_profile_grants_grantor_id_idx ON myapp_profiles_public.app_profile_grants (grantor_id);

ALTER TABLE myapp_profiles_public.app_profile_grants 
  ADD COLUMN is_grant boolean;

ALTER TABLE myapp_profiles_public.app_profile_grants 
  ALTER COLUMN is_grant SET NOT NULL;

ALTER TABLE myapp_profiles_public.app_profile_grants 
  ALTER COLUMN is_grant SET DEFAULT true;

COMMENT ON COLUMN myapp_profiles_public.app_profile_grants.is_grant IS 'True to assign the profile, false to revoke it';

CREATE INDEX app_profile_grants_membership_id_idx ON myapp_profiles_public.app_profile_grants (membership_id);

CREATE INDEX app_profile_grants_profile_id_idx ON myapp_profiles_public.app_profile_grants (profile_id);

ALTER TABLE myapp_profiles_public.app_profile_grants 
  ADD COLUMN created_at timestamptz;

ALTER TABLE myapp_profiles_public.app_profile_grants 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE myapp_profiles_public.app_profile_grants 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE myapp_profiles_public.app_profile_grants 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE TRIGGER timestamps_tg
  BEFORE INSERT OR UPDATE
  ON myapp_profiles_public.app_profile_grants
  FOR EACH ROW
  EXECUTE PROCEDURE stamps.timestamps();

CREATE INDEX app_profile_grants_created_at_idx ON myapp_profiles_public.app_profile_grants (created_at);

CREATE INDEX app_profile_grants_updated_at_idx ON myapp_profiles_public.app_profile_grants (updated_at);

CREATE TABLE myapp_profiles_public.app_profile_definition_grants ();

ALTER TABLE myapp_profiles_public.app_profile_definition_grants 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_profiles_public.app_profile_definition_grants IS 'Audit log of permission additions and removals from profile definitions';

ALTER TABLE myapp_profiles_public.app_profile_definition_grants 
  ADD COLUMN id uuid;

ALTER TABLE myapp_profiles_public.app_profile_definition_grants 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_profiles_public.app_profile_definition_grants 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_profiles_public.app_profile_definition_grants 
  ADD CONSTRAINT app_profile_definition_grants_pkey PRIMARY KEY (id);

ALTER TABLE myapp_profiles_public.app_profile_definition_grants 
  ADD COLUMN profile_id uuid;

COMMENT ON COLUMN myapp_profiles_public.app_profile_definition_grants.profile_id IS 'References the profile whose definition was modified; NULL if profile was deleted';

ALTER TABLE myapp_profiles_public.app_profile_definition_grants 
  ADD CONSTRAINT app_profile_definition_grants_profile_id_fkey
    FOREIGN KEY(profile_id)
    REFERENCES myapp_profiles_public.app_profiles (id)
    ON DELETE SET NULL;

ALTER TABLE myapp_profiles_public.app_profile_definition_grants 
  ADD COLUMN permission_id uuid;

COMMENT ON COLUMN myapp_profiles_public.app_profile_definition_grants.permission_id IS 'References the permission that was added to or removed from the profile; NULL if permission was deleted';

ALTER TABLE myapp_profiles_public.app_profile_definition_grants 
  ADD CONSTRAINT app_profile_definition_grants_permission_id_fkey
    FOREIGN KEY(permission_id)
    REFERENCES myapp_permissions_public.app_permissions (id)
    ON DELETE SET NULL;

ALTER TABLE myapp_profiles_public.app_profile_definition_grants 
  ADD COLUMN grantor_id uuid;

ALTER TABLE myapp_profiles_public.app_profile_definition_grants 
  ALTER COLUMN grantor_id SET DEFAULT jwt_public.current_user_id();

ALTER TABLE myapp_profiles_public.app_profile_definition_grants 
  ADD CONSTRAINT app_profile_definition_grants_grantor_id_fkey
    FOREIGN KEY(grantor_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE SET NULL;

CREATE INDEX app_profile_definition_grants_grantor_id_idx ON myapp_profiles_public.app_profile_definition_grants (grantor_id);

ALTER TABLE myapp_profiles_public.app_profile_definition_grants 
  ADD COLUMN is_grant boolean;

ALTER TABLE myapp_profiles_public.app_profile_definition_grants 
  ALTER COLUMN is_grant SET NOT NULL;

ALTER TABLE myapp_profiles_public.app_profile_definition_grants 
  ALTER COLUMN is_grant SET DEFAULT true;

COMMENT ON COLUMN myapp_profiles_public.app_profile_definition_grants.is_grant IS 'True to add the permission to the profile, false to remove it';

CREATE INDEX app_profile_definition_grants_profile_id_idx ON myapp_profiles_public.app_profile_definition_grants (profile_id);

CREATE INDEX app_profile_definition_grants_permission_id_idx ON myapp_profiles_public.app_profile_definition_grants (permission_id);

ALTER TABLE myapp_profiles_public.app_profile_definition_grants 
  ADD COLUMN created_at timestamptz;

ALTER TABLE myapp_profiles_public.app_profile_definition_grants 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE myapp_profiles_public.app_profile_definition_grants 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE myapp_profiles_public.app_profile_definition_grants 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE TRIGGER timestamps_tg
  BEFORE INSERT OR UPDATE
  ON myapp_profiles_public.app_profile_definition_grants
  FOR EACH ROW
  EXECUTE PROCEDURE stamps.timestamps();

CREATE INDEX app_profile_definition_grants_created_at_idx ON myapp_profiles_public.app_profile_definition_grants (created_at);

CREATE INDEX app_profile_definition_grants_updated_at_idx ON myapp_profiles_public.app_profile_definition_grants (updated_at);

ALTER TABLE myapp_memberships_public.app_memberships 
  ADD COLUMN profile_id uuid;

ALTER TABLE myapp_memberships_public.app_memberships 
  ADD CONSTRAINT app_memberships_profile_id_fkey
    FOREIGN KEY(profile_id)
    REFERENCES myapp_profiles_public.app_profiles (id)
    ON DELETE SET NULL;

CREATE INDEX app_memberships_profile_id_idx ON myapp_memberships_public.app_memberships (profile_id);

CREATE FUNCTION myapp_profiles_private.app_profile_grants_apply_tg() RETURNS trigger AS $EOFCODE$
BEGIN
  IF NEW.is_grant IS TRUE AND NEW.profile_id IS NOT NULL THEN
    UPDATE myapp_memberships_public.app_memberships SET
    profile_id = NEW.profile_id
    WHERE
      id = NEW.membership_id;
  ELSIF NEW.is_grant IS FALSE THEN
    UPDATE myapp_memberships_public.app_memberships SET
    profile_id = NULL
    WHERE
      id = NEW.membership_id;
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE TRIGGER app_profile_grants_apply_trg
  AFTER INSERT
  ON myapp_profiles_public.app_profile_grants
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_profiles_private.app_profile_grants_apply_tg();

CREATE FUNCTION myapp_profiles_private.app_profile_definition_grants_apply_tg() RETURNS trigger AS $EOFCODE$
BEGIN
  IF NEW.is_grant IS TRUE THEN
    INSERT INTO myapp_profiles_public.app_profile_permissions (
      profile_id,
      permission_id
    )
    VALUES
      (NEW.profile_id, NEW.permission_id)
    ON CONFLICT (profile_id, permission_id) DO NOTHING;
  ELSE
    DELETE FROM myapp_profiles_public.app_profile_permissions
    WHERE
      profile_id = NEW.profile_id AND permission_id = NEW.permission_id;
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE TRIGGER app_profile_definition_grants_apply_trg
  AFTER INSERT
  ON myapp_profiles_public.app_profile_definition_grants
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_profiles_private.app_profile_definition_grants_apply_tg();

CREATE FUNCTION myapp_profiles_private.app_profile_permissions_recompute_tg() RETURNS trigger AS $EOFCODE$
DECLARE
  v_profile_id uuid;
  v_permissions bit(64);
BEGIN
  IF TG_OP = 'DELETE' THEN
    SELECT OLD.profile_id INTO v_profile_id;
  ELSE
    SELECT NEW.profile_id INTO v_profile_id;
  END IF;
  SELECT coalesce(bit_or(p.bitstr), (lpad('', 64, '0'))::bit(64)::bit(64))
  FROM myapp_profiles_public.app_profile_permissions AS pp INNER JOIN myapp_permissions_public.app_permissions AS p ON p.id = pp.permission_id
  WHERE
    pp.profile_id = v_profile_id INTO v_permissions;
  UPDATE myapp_profiles_public.app_profiles SET
  permissions = v_permissions
  WHERE
    id = v_profile_id;
  IF TG_OP = 'DELETE' THEN
    RETURN OLD;
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE TRIGGER app_profile_permissions_recompute_trg
  AFTER INSERT OR DELETE OR UPDATE
  ON myapp_profiles_public.app_profile_permissions
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_profiles_private.app_profile_permissions_recompute_tg();

CREATE FUNCTION myapp_profiles_private.app_memberships_profile_sync_tg() RETURNS trigger AS $EOFCODE$
DECLARE
  v_profile_permissions bit(64);
BEGIN
  IF NEW.is_admin IS TRUE OR NEW.is_owner IS TRUE THEN
    RETURN NEW;
  END IF;
  IF NEW.profile_id IS NOT NULL THEN
    SELECT permissions
    FROM myapp_profiles_public.app_profiles
    WHERE
      id = NEW.profile_id INTO v_profile_permissions;
    IF FOUND AND v_profile_permissions IS NOT NULL THEN
      new.permissions := NEW.granted | v_profile_permissions;
    ELSE
      new.permissions := NEW.granted;
    END IF;
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE;

CREATE TRIGGER _00015_app_memberships_profile_sync_itrg
  BEFORE INSERT
  ON myapp_memberships_public.app_memberships
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_profiles_private.app_memberships_profile_sync_tg();

CREATE TRIGGER _00015_app_memberships_profile_sync_utrg
  BEFORE UPDATE
  ON myapp_memberships_public.app_memberships
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_profiles_private.app_memberships_profile_sync_tg();

CREATE FUNCTION myapp_profiles_private.app_profiles_cascade_tg() RETURNS trigger AS $EOFCODE$
BEGIN
  IF OLD.permissions IS DISTINCT FROM NEW.permissions THEN
    UPDATE myapp_memberships_public.app_memberships SET
    profile_id = profile_id
    WHERE
      profile_id = NEW.id;
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE TRIGGER app_profiles_cascade_trg
  AFTER UPDATE
  ON myapp_profiles_public.app_profiles
  FOR EACH ROW
  WHEN (old.permissions IS DISTINCT FROM new.permissions)
  EXECUTE PROCEDURE myapp_profiles_private.app_profiles_cascade_tg();

CREATE FUNCTION myapp_profiles_private.app_memberships_default_profile_tg() RETURNS trigger AS $EOFCODE$
DECLARE
  v_default_profile_id uuid;
BEGIN
  IF NEW.profile_id IS NULL THEN
    SELECT id
    FROM myapp_profiles_public.app_profiles
    WHERE
      is_default = true
    LIMIT
    1 INTO v_default_profile_id;
    IF FOUND THEN
      SELECT v_default_profile_id INTO NEW.profile_id;
    END IF;
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE;

CREATE TRIGGER _00000_app_memberships_default_profile_trg
  BEFORE INSERT
  ON myapp_memberships_public.app_memberships
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_profiles_private.app_memberships_default_profile_tg();

CREATE TABLE myapp_profiles_public.app_profile_templates ();

ALTER TABLE myapp_profiles_public.app_profile_templates 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_profiles_public.app_profile_templates IS 'Template profiles that are automatically seeded into new entities when created';

ALTER TABLE myapp_profiles_public.app_profile_templates 
  ADD COLUMN id uuid;

ALTER TABLE myapp_profiles_public.app_profile_templates 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_profiles_public.app_profile_templates 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_profiles_public.app_profile_templates 
  ADD CONSTRAINT app_profile_templates_pkey PRIMARY KEY (id);

ALTER TABLE myapp_profiles_public.app_profile_templates 
  ADD COLUMN name citext;

ALTER TABLE myapp_profiles_public.app_profile_templates 
  ALTER COLUMN name SET NOT NULL;

COMMENT ON COLUMN myapp_profiles_public.app_profile_templates.name IS 'Display name for the template profile (e.g. Admin, Editor, Viewer)';

ALTER TABLE myapp_profiles_public.app_profile_templates 
  ADD COLUMN slug text;

ALTER TABLE myapp_profiles_public.app_profile_templates 
  ALTER COLUMN slug SET NOT NULL;

COMMENT ON COLUMN myapp_profiles_public.app_profile_templates.slug IS 'URL-safe identifier for the template profile';

ALTER TABLE myapp_profiles_public.app_profile_templates 
  ADD COLUMN description text;

COMMENT ON COLUMN myapp_profiles_public.app_profile_templates.description IS 'Human-readable description of this template profile';

ALTER TABLE myapp_profiles_public.app_profile_templates 
  ADD COLUMN permissions pg_catalog.bit(64);

ALTER TABLE myapp_profiles_public.app_profile_templates 
  ALTER COLUMN permissions SET NOT NULL;

ALTER TABLE myapp_profiles_public.app_profile_templates 
  ALTER COLUMN permissions SET DEFAULT CAST(lpad('', 64, '0') AS pg_catalog.bit(64));

COMMENT ON COLUMN myapp_profiles_public.app_profile_templates.permissions IS 'Pre-computed permission bitmask for the seeded profile';

ALTER TABLE myapp_profiles_public.app_profile_templates 
  ADD COLUMN is_default boolean;

ALTER TABLE myapp_profiles_public.app_profile_templates 
  ALTER COLUMN is_default SET NOT NULL;

ALTER TABLE myapp_profiles_public.app_profile_templates 
  ALTER COLUMN is_default SET DEFAULT false;

COMMENT ON COLUMN myapp_profiles_public.app_profile_templates.is_default IS 'Whether the seeded profile should be the default for new members';

ALTER TABLE myapp_profiles_public.app_profile_templates 
  ADD COLUMN created_at timestamptz;

ALTER TABLE myapp_profiles_public.app_profile_templates 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE myapp_profiles_public.app_profile_templates 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE myapp_profiles_public.app_profile_templates 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE TRIGGER timestamps_tg
  BEFORE INSERT OR UPDATE
  ON myapp_profiles_public.app_profile_templates
  FOR EACH ROW
  EXECUTE PROCEDURE stamps.timestamps();

CREATE INDEX app_profile_templates_created_at_idx ON myapp_profiles_public.app_profile_templates (created_at);

CREATE INDEX app_profile_templates_updated_at_idx ON myapp_profiles_public.app_profile_templates (updated_at);

ALTER TABLE myapp_profiles_public.app_profile_templates 
  ADD CONSTRAINT app_profile_templates_name_key 
    UNIQUE (name);

ALTER TABLE myapp_profiles_public.app_profile_templates 
  ADD CONSTRAINT app_profile_templates_slug_key 
    UNIQUE (slug);

CREATE UNIQUE INDEX app_profile_templates_default_uniq ON myapp_profiles_public.app_profile_templates ((CAST(true AS boolean))) WHERE is_default = true;

CREATE INDEX app_profile_templates_is_default_idx ON myapp_profiles_public.app_profile_templates (is_default);

GRANT INSERT ON myapp_permissions_public.app_permissions TO authenticated;

GRANT UPDATE ON myapp_permissions_public.app_permissions TO authenticated;

GRANT DELETE ON myapp_permissions_public.app_permissions TO authenticated;

CREATE POLICY auth_ins_app_mem
  ON myapp_permissions_public.app_permissions
  AS PERMISSIVE
  FOR INSERT
  TO authenticated
  WITH CHECK (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000000001000000') = '0000000000000000000000000000000000000000000000000000000001000000')
  );

CREATE POLICY auth_upd_app_mem
  ON myapp_permissions_public.app_permissions
  AS PERMISSIVE
  FOR UPDATE
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000000001000000') = '0000000000000000000000000000000000000000000000000000000001000000')
  );

CREATE POLICY auth_del_app_mem
  ON myapp_permissions_public.app_permissions
  AS PERMISSIVE
  FOR DELETE
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000000001000000') = '0000000000000000000000000000000000000000000000000000000001000000')
  );

ALTER TABLE myapp_permissions_public.app_permission_defaults 
  ENABLE ROW LEVEL SECURITY;

GRANT INSERT ON myapp_permissions_public.app_permission_defaults TO authenticated;

GRANT SELECT ON myapp_permissions_public.app_permission_defaults TO authenticated;

GRANT DELETE ON myapp_permissions_public.app_permission_defaults TO authenticated;

CREATE POLICY auth_sel_all_all
  ON myapp_permissions_public.app_permission_defaults
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    true
  );

CREATE POLICY auth_ins_app_mem
  ON myapp_permissions_public.app_permission_defaults
  AS PERMISSIVE
  FOR INSERT
  TO authenticated
  WITH CHECK (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000000001000000') = '0000000000000000000000000000000000000000000000000000000001000000')
  );

CREATE POLICY auth_del_app_mem
  ON myapp_permissions_public.app_permission_defaults
  AS PERMISSIVE
  FOR DELETE
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000000001000000') = '0000000000000000000000000000000000000000000000000000000001000000')
  );

ALTER TABLE myapp_limits_public.app_limits 
  ENABLE ROW LEVEL SECURITY;

GRANT INSERT ON myapp_limits_public.app_limits TO authenticated;

GRANT SELECT ON myapp_limits_public.app_limits TO authenticated;

GRANT UPDATE ON myapp_limits_public.app_limits TO authenticated;

GRANT DELETE ON myapp_limits_public.app_limits TO authenticated;

CREATE POLICY auth_ins_app_mem
  ON myapp_limits_public.app_limits
  AS PERMISSIVE
  FOR INSERT
  TO authenticated
  WITH CHECK (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000100000') = '0000000000000000000000000000000000000000000000000000000000100000')
  );

CREATE POLICY auth_sel_app_mem
  ON myapp_limits_public.app_limits
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000100000') = '0000000000000000000000000000000000000000000000000000000000100000')
  );

CREATE POLICY auth_upd_app_mem
  ON myapp_limits_public.app_limits
  AS PERMISSIVE
  FOR UPDATE
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000100000') = '0000000000000000000000000000000000000000000000000000000000100000')
  );

CREATE POLICY auth_del_app_mem
  ON myapp_limits_public.app_limits
  AS PERMISSIVE
  FOR DELETE
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000100000') = '0000000000000000000000000000000000000000000000000000000000100000')
  );

CREATE POLICY auth_sel_own
  ON myapp_limits_public.app_limits
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    actor_id = jwt_public.current_principal_id()
  );

CREATE POLICY auth_ins_app_mem
  ON myapp_limits_public.app_limit_credits
  AS PERMISSIVE
  FOR INSERT
  TO authenticated
  WITH CHECK (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000010000000000') = '0000000000000000000000000000000000000000000000000000010000000000')
  );

CREATE POLICY auth_sel_app_mem
  ON myapp_limits_public.app_limit_credits
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000010000000000') = '0000000000000000000000000000000000000000000000000000010000000000')
  );

CREATE POLICY auth_sel_app_mem
  ON myapp_limits_public.app_limit_events
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000100000') = '0000000000000000000000000000000000000000000000000000000000100000')
  );

CREATE POLICY auth_sel_app_mem
  ON myapp_limits_public.app_limit_credit_codes
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000010000000000') = '0000000000000000000000000000000000000000000000000000010000000000')
  );

CREATE POLICY auth_ins_app_mem
  ON myapp_limits_public.app_limit_credit_codes
  AS PERMISSIVE
  FOR INSERT
  TO authenticated
  WITH CHECK (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000010000000000') = '0000000000000000000000000000000000000000000000000000010000000000')
  );

CREATE POLICY auth_upd_app_mem
  ON myapp_limits_public.app_limit_credit_codes
  AS PERMISSIVE
  FOR UPDATE
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000010000000000') = '0000000000000000000000000000000000000000000000000000010000000000')
  );

CREATE POLICY auth_del_app_mem
  ON myapp_limits_public.app_limit_credit_codes
  AS PERMISSIVE
  FOR DELETE
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000010000000000') = '0000000000000000000000000000000000000000000000000000010000000000')
  );

CREATE POLICY auth_sel_app_mem
  ON myapp_limits_public.app_limit_credit_code_items
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000010000000000') = '0000000000000000000000000000000000000000000000000000010000000000')
  );

CREATE POLICY auth_ins_app_mem
  ON myapp_limits_public.app_limit_credit_code_items
  AS PERMISSIVE
  FOR INSERT
  TO authenticated
  WITH CHECK (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000010000000000') = '0000000000000000000000000000000000000000000000000000010000000000')
  );

CREATE POLICY auth_upd_app_mem
  ON myapp_limits_public.app_limit_credit_code_items
  AS PERMISSIVE
  FOR UPDATE
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000010000000000') = '0000000000000000000000000000000000000000000000000000010000000000')
  );

CREATE POLICY auth_del_app_mem
  ON myapp_limits_public.app_limit_credit_code_items
  AS PERMISSIVE
  FOR DELETE
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000010000000000') = '0000000000000000000000000000000000000000000000000000010000000000')
  );

CREATE POLICY auth_sel_adm
  ON myapp_limits_public.app_limit_credit_redemptions
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000010000000000') = '0000000000000000000000000000000000000000000000000000010000000000')
  );

ALTER TABLE myapp_limits_public.app_limit_defaults 
  ENABLE ROW LEVEL SECURITY;

GRANT INSERT ON myapp_limits_public.app_limit_defaults TO authenticated;

GRANT SELECT ON myapp_limits_public.app_limit_defaults TO authenticated;

GRANT UPDATE ON myapp_limits_public.app_limit_defaults TO authenticated;

GRANT DELETE ON myapp_limits_public.app_limit_defaults TO authenticated;

CREATE POLICY auth_ins_app_mem
  ON myapp_limits_public.app_limit_defaults
  AS PERMISSIVE
  FOR INSERT
  TO authenticated
  WITH CHECK (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000100000') = '0000000000000000000000000000000000000000000000000000000000100000')
  );

CREATE POLICY auth_sel_app_mem
  ON myapp_limits_public.app_limit_defaults
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000100000') = '0000000000000000000000000000000000000000000000000000000000100000')
  );

CREATE POLICY auth_upd_app_mem
  ON myapp_limits_public.app_limit_defaults
  AS PERMISSIVE
  FOR UPDATE
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000100000') = '0000000000000000000000000000000000000000000000000000000000100000')
  );

CREATE POLICY auth_del_app_mem
  ON myapp_limits_public.app_limit_defaults
  AS PERMISSIVE
  FOR DELETE
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000100000') = '0000000000000000000000000000000000000000000000000000000000100000')
  );

ALTER TABLE myapp_limits_public.app_limit_caps_defaults 
  ENABLE ROW LEVEL SECURITY;

GRANT SELECT ON myapp_limits_public.app_limit_caps_defaults TO authenticated;

CREATE POLICY auth_sel_app_mem
  ON myapp_limits_public.app_limit_caps_defaults
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id())
  );

GRANT INSERT ON myapp_limits_public.app_limit_caps_defaults TO authenticated;

GRANT UPDATE ON myapp_limits_public.app_limit_caps_defaults TO authenticated;

GRANT DELETE ON myapp_limits_public.app_limit_caps_defaults TO authenticated;

CREATE POLICY auth_ins_app_mem
  ON myapp_limits_public.app_limit_caps_defaults
  AS PERMISSIVE
  FOR INSERT
  TO authenticated
  WITH CHECK (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000100000') = '0000000000000000000000000000000000000000000000000000000000100000')
  );

CREATE POLICY auth_upd_app_mem
  ON myapp_limits_public.app_limit_caps_defaults
  AS PERMISSIVE
  FOR UPDATE
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000100000') = '0000000000000000000000000000000000000000000000000000000000100000')
  );

CREATE POLICY auth_del_app_mem
  ON myapp_limits_public.app_limit_caps_defaults
  AS PERMISSIVE
  FOR DELETE
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000100000') = '0000000000000000000000000000000000000000000000000000000000100000')
  );

ALTER TABLE myapp_limits_public.app_limit_caps 
  ENABLE ROW LEVEL SECURITY;

GRANT INSERT ON myapp_limits_public.app_limit_caps TO authenticated;

GRANT SELECT ON myapp_limits_public.app_limit_caps TO authenticated;

GRANT UPDATE ON myapp_limits_public.app_limit_caps TO authenticated;

GRANT DELETE ON myapp_limits_public.app_limit_caps TO authenticated;

CREATE POLICY auth_ins_app_mem
  ON myapp_limits_public.app_limit_caps
  AS PERMISSIVE
  FOR INSERT
  TO authenticated
  WITH CHECK (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000100000') = '0000000000000000000000000000000000000000000000000000000000100000')
  );

CREATE POLICY auth_sel_app_mem
  ON myapp_limits_public.app_limit_caps
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000100000') = '0000000000000000000000000000000000000000000000000000000000100000')
  );

CREATE POLICY auth_upd_app_mem
  ON myapp_limits_public.app_limit_caps
  AS PERMISSIVE
  FOR UPDATE
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000100000') = '0000000000000000000000000000000000000000000000000000000000100000')
  );

CREATE POLICY auth_del_app_mem
  ON myapp_limits_public.app_limit_caps
  AS PERMISSIVE
  FOR DELETE
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000100000') = '0000000000000000000000000000000000000000000000000000000000100000')
  );

ALTER TABLE myapp_memberships_public.app_memberships 
  ENABLE ROW LEVEL SECURITY;

GRANT SELECT ON myapp_memberships_public.app_memberships TO authenticated;

GRANT UPDATE ( is_banned, is_approved, is_verified, is_disabled ) ON myapp_memberships_public.app_memberships TO authenticated;

CREATE POLICY auth_sel_app_mem
  ON myapp_memberships_public.app_memberships
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000000001') = '0000000000000000000000000000000000000000000000000000000000000001')
  );

CREATE POLICY auth_upd_app_mem
  ON myapp_memberships_public.app_memberships
  AS PERMISSIVE
  FOR UPDATE
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000000001') = '0000000000000000000000000000000000000000000000000000000000000001')
  );

CREATE POLICY auth_del_app_mem
  ON myapp_memberships_public.app_memberships
  AS PERMISSIVE
  FOR DELETE
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000000001') = '0000000000000000000000000000000000000000000000000000000000000001')
  );

CREATE POLICY auth_sel_own
  ON myapp_memberships_public.app_memberships
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    actor_id = jwt_public.current_principal_id()
  );

ALTER TABLE myapp_memberships_public.app_membership_defaults 
  ENABLE ROW LEVEL SECURITY;

GRANT INSERT ON myapp_memberships_public.app_membership_defaults TO authenticated;

GRANT SELECT ON myapp_memberships_public.app_membership_defaults TO authenticated;

GRANT UPDATE ON myapp_memberships_public.app_membership_defaults TO authenticated;

GRANT DELETE ON myapp_memberships_public.app_membership_defaults TO authenticated;

CREATE POLICY auth_ins_app_mem
  ON myapp_memberships_public.app_membership_defaults
  AS PERMISSIVE
  FOR INSERT
  TO authenticated
  WITH CHECK (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000000001') = '0000000000000000000000000000000000000000000000000000000000000001')
  );

CREATE POLICY auth_sel_app_mem
  ON myapp_memberships_public.app_membership_defaults
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000000001') = '0000000000000000000000000000000000000000000000000000000000000001')
  );

CREATE POLICY auth_upd_app_mem
  ON myapp_memberships_public.app_membership_defaults
  AS PERMISSIVE
  FOR UPDATE
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000000001') = '0000000000000000000000000000000000000000000000000000000000000001')
  );

CREATE POLICY auth_del_app_mem
  ON myapp_memberships_public.app_membership_defaults
  AS PERMISSIVE
  FOR DELETE
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000000001') = '0000000000000000000000000000000000000000000000000000000000000001')
  );

ALTER TABLE myapp_memberships_public.app_grants 
  ENABLE ROW LEVEL SECURITY;

GRANT INSERT ON myapp_memberships_public.app_grants TO authenticated;

GRANT SELECT ON myapp_memberships_public.app_grants TO authenticated;

CREATE POLICY auth_ins_app_mem
  ON myapp_memberships_public.app_grants
  AS PERMISSIVE
  FOR INSERT
  TO authenticated
  WITH CHECK (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000000001') = '0000000000000000000000000000000000000000000000000000000000000001')
  );

CREATE POLICY auth_sel_app_mem
  ON myapp_memberships_public.app_grants
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000000001') = '0000000000000000000000000000000000000000000000000000000000000001')
  );

ALTER TABLE myapp_memberships_public.app_admin_grants 
  ENABLE ROW LEVEL SECURITY;

GRANT INSERT ON myapp_memberships_public.app_admin_grants TO authenticated;

GRANT SELECT ON myapp_memberships_public.app_admin_grants TO authenticated;

CREATE POLICY auth_ins_app_mem
  ON myapp_memberships_public.app_admin_grants
  AS PERMISSIVE
  FOR INSERT
  TO authenticated
  WITH CHECK (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND app_sprt.is_admin IS TRUE)
  );

CREATE POLICY auth_sel_app_mem
  ON myapp_memberships_public.app_admin_grants
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND app_sprt.is_admin IS TRUE)
  );

ALTER TABLE myapp_memberships_public.app_owner_grants 
  ENABLE ROW LEVEL SECURITY;

GRANT INSERT ON myapp_memberships_public.app_owner_grants TO authenticated;

GRANT SELECT ON myapp_memberships_public.app_owner_grants TO authenticated;

CREATE POLICY auth_ins_app_mem
  ON myapp_memberships_public.app_owner_grants
  AS PERMISSIVE
  FOR INSERT
  TO authenticated
  WITH CHECK (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND app_sprt.is_owner IS TRUE)
  );

CREATE POLICY auth_sel_app_mem
  ON myapp_memberships_public.app_owner_grants
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND app_sprt.is_owner IS TRUE)
  );

ALTER TABLE myapp_memberships_public.app_permission_default_permissions 
  ENABLE ROW LEVEL SECURITY;

GRANT SELECT ON myapp_memberships_public.app_permission_default_permissions TO authenticated;

GRANT INSERT ON myapp_memberships_public.app_permission_default_permissions TO authenticated;

GRANT DELETE ON myapp_memberships_public.app_permission_default_permissions TO authenticated;

CREATE POLICY auth_sel_all_all
  ON myapp_memberships_public.app_permission_default_permissions
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    true
  );

CREATE POLICY auth_ins_app_mem
  ON myapp_memberships_public.app_permission_default_permissions
  AS PERMISSIVE
  FOR INSERT
  TO authenticated
  WITH CHECK (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000000001000000') = '0000000000000000000000000000000000000000000000000000000001000000')
  );

CREATE POLICY auth_del_app_mem
  ON myapp_memberships_public.app_permission_default_permissions
  AS PERMISSIVE
  FOR DELETE
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000000001000000') = '0000000000000000000000000000000000000000000000000000000001000000')
  );

ALTER TABLE myapp_memberships_public.app_permission_default_grants 
  ENABLE ROW LEVEL SECURITY;

GRANT SELECT ON myapp_memberships_public.app_permission_default_grants TO authenticated;

GRANT INSERT ON myapp_memberships_public.app_permission_default_grants TO authenticated;

CREATE POLICY auth_sel_all_all
  ON myapp_memberships_public.app_permission_default_grants
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    true
  );

CREATE POLICY auth_ins_app_mem
  ON myapp_memberships_public.app_permission_default_grants
  AS PERMISSIVE
  FOR INSERT
  TO authenticated
  WITH CHECK (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000000001000000') = '0000000000000000000000000000000000000000000000000000000001000000')
  );

ALTER TABLE myapp_profiles_public.app_profiles 
  ENABLE ROW LEVEL SECURITY;

GRANT SELECT ON myapp_profiles_public.app_profiles TO authenticated;

GRANT INSERT ON myapp_profiles_public.app_profiles TO authenticated;

GRANT UPDATE ( name, slug, description, is_system, is_default ) ON myapp_profiles_public.app_profiles TO authenticated;

GRANT DELETE ON myapp_profiles_public.app_profiles TO authenticated;

CREATE POLICY auth_sel_app_mem
  ON myapp_profiles_public.app_profiles
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id())
  );

CREATE POLICY auth_ins_app_mem
  ON myapp_profiles_public.app_profiles
  AS PERMISSIVE
  FOR INSERT
  TO authenticated
  WITH CHECK (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000000001000000') = '0000000000000000000000000000000000000000000000000000000001000000')
  );

CREATE POLICY auth_upd_com
  ON myapp_profiles_public.app_profiles
  AS PERMISSIVE
  FOR UPDATE
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      (app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000000001000000') = '0000000000000000000000000000000000000000000000000000000001000000'))
      AND is_system IS FALSE
  );

CREATE POLICY auth_del_com
  ON myapp_profiles_public.app_profiles
  AS PERMISSIVE
  FOR DELETE
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      (app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000000001000000') = '0000000000000000000000000000000000000000000000000000000001000000'))
      AND is_system IS FALSE
  );

ALTER TABLE myapp_profiles_public.app_profile_permissions 
  ENABLE ROW LEVEL SECURITY;

GRANT SELECT ON myapp_profiles_public.app_profile_permissions TO authenticated;

GRANT INSERT ON myapp_profiles_public.app_profile_permissions TO authenticated;

GRANT UPDATE ON myapp_profiles_public.app_profile_permissions TO authenticated;

GRANT DELETE ON myapp_profiles_public.app_profile_permissions TO authenticated;

CREATE POLICY auth_sel_app_mem
  ON myapp_profiles_public.app_profile_permissions
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id())
  );

CREATE POLICY auth_ins_app_mem
  ON myapp_profiles_public.app_profile_permissions
  AS PERMISSIVE
  FOR INSERT
  TO authenticated
  WITH CHECK (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000000001000000') = '0000000000000000000000000000000000000000000000000000000001000000')
  );

CREATE POLICY auth_upd_app_mem
  ON myapp_profiles_public.app_profile_permissions
  AS PERMISSIVE
  FOR UPDATE
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000000001000000') = '0000000000000000000000000000000000000000000000000000000001000000')
  );

CREATE POLICY auth_del_app_mem
  ON myapp_profiles_public.app_profile_permissions
  AS PERMISSIVE
  FOR DELETE
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000000001000000') = '0000000000000000000000000000000000000000000000000000000001000000')
  );

ALTER TABLE myapp_profiles_public.app_profile_grants 
  ENABLE ROW LEVEL SECURITY;

GRANT SELECT ON myapp_profiles_public.app_profile_grants TO authenticated;

GRANT INSERT ON myapp_profiles_public.app_profile_grants TO authenticated;

CREATE POLICY auth_sel_app_mem
  ON myapp_profiles_public.app_profile_grants
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000000001') = '0000000000000000000000000000000000000000000000000000000000000001')
  );

CREATE POLICY auth_ins_app_mem
  ON myapp_profiles_public.app_profile_grants
  AS PERMISSIVE
  FOR INSERT
  TO authenticated
  WITH CHECK (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000000001') = '0000000000000000000000000000000000000000000000000000000000000001')
  );

ALTER TABLE myapp_profiles_public.app_profile_definition_grants 
  ENABLE ROW LEVEL SECURITY;

GRANT SELECT ON myapp_profiles_public.app_profile_definition_grants TO authenticated;

GRANT INSERT ON myapp_profiles_public.app_profile_definition_grants TO authenticated;

CREATE POLICY auth_sel_app_mem
  ON myapp_profiles_public.app_profile_definition_grants
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000000001000000') = '0000000000000000000000000000000000000000000000000000000001000000')
  );

CREATE POLICY auth_ins_app_mem
  ON myapp_profiles_public.app_profile_definition_grants
  AS PERMISSIVE
  FOR INSERT
  TO authenticated
  WITH CHECK (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000000001000000') = '0000000000000000000000000000000000000000000000000000000001000000')
  );

CREATE TABLE myapp_permissions_public.org_permissions ();

ALTER TABLE myapp_permissions_public.org_permissions 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_permissions_public.org_permissions IS 'Defines available permissions as named bits within a bitmask, used by the RBAC system for access control';

ALTER TABLE myapp_permissions_public.org_permissions 
  ADD COLUMN id uuid;

ALTER TABLE myapp_permissions_public.org_permissions 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_permissions_public.org_permissions 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_permissions_public.org_permissions 
  ADD CONSTRAINT org_permissions_pkey PRIMARY KEY (id);

ALTER TABLE myapp_permissions_public.org_permissions 
  ADD COLUMN name citext;

COMMENT ON COLUMN myapp_permissions_public.org_permissions.name IS 'Human-readable permission name (e.g. read, write, manage)';

ALTER TABLE myapp_permissions_public.org_permissions 
  ADD CONSTRAINT org_permissions_name_key 
    UNIQUE (name);

ALTER TABLE myapp_permissions_public.org_permissions 
  ADD COLUMN bitnum int;

ALTER TABLE myapp_permissions_public.org_permissions 
  ADD CONSTRAINT org_permissions_bitnum_chk 
    CHECK (
    bitnum >= 1
      AND bitnum <= 64
  );

COMMENT ON COLUMN myapp_permissions_public.org_permissions.bitnum IS 'Position of this permission in the bitmask (1-indexed), must be unique per permission set';

ALTER TABLE myapp_permissions_public.org_permissions 
  ADD CONSTRAINT org_permissions_bitnum_key 
    UNIQUE (bitnum);

ALTER TABLE myapp_permissions_public.org_permissions 
  ADD COLUMN bitstr pg_catalog.bit(64);

ALTER TABLE myapp_permissions_public.org_permissions 
  ALTER COLUMN bitstr SET NOT NULL;

ALTER TABLE myapp_permissions_public.org_permissions 
  ALTER COLUMN bitstr SET DEFAULT CAST(lpad('', 64, '0') AS pg_catalog.bit(64));

COMMENT ON COLUMN myapp_permissions_public.org_permissions.bitstr IS 'Pre-computed bitmask with only this permission bit set, used for bitwise OR/AND operations';

ALTER TABLE myapp_permissions_public.org_permissions 
  ADD COLUMN description text;

COMMENT ON COLUMN myapp_permissions_public.org_permissions.description IS 'Human-readable description of what this permission allows';

ALTER TABLE myapp_permissions_public.org_permissions 
  ENABLE ROW LEVEL SECURITY;

GRANT SELECT ON myapp_permissions_public.org_permissions TO authenticated;

CREATE POLICY auth_sel_all_all
  ON myapp_permissions_public.org_permissions
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    true
  );

CREATE FUNCTION myapp_permissions_public.org_permissions_get_padded_mask(
  mask pg_catalog.varbit
) RETURNS pg_catalog.varbit AS $EOFCODE$
SELECT utils.bitmask_pad(mask, 64, '0')
$EOFCODE$ LANGUAGE sql IMMUTABLE SECURITY INVOKER;

CREATE FUNCTION myapp_permissions_public.org_permissions_get_by_mask(
  mask pg_catalog.varbit
) RETURNS SETOF myapp_permissions_public.org_permissions AS $EOFCODE$
SELECT *
FROM myapp_permissions_public.org_permissions
WHERE
  (bitstr & myapp_permissions_public.org_permissions_get_padded_mask(mask)) = bitstr
$EOFCODE$ LANGUAGE sql STABLE SECURITY INVOKER;

CREATE FUNCTION myapp_permissions_public.org_permissions_get_mask(
  ids uuid[]
) RETURNS pg_catalog.varbit AS $EOFCODE$
SELECT bit_or(bitstr)
FROM myapp_permissions_public.org_permissions
WHERE
  id = ANY( ids )
$EOFCODE$ LANGUAGE sql STABLE SECURITY INVOKER;

CREATE FUNCTION myapp_permissions_public.org_permissions_get_mask_by_names(
  names citext[]
) RETURNS pg_catalog.varbit AS $EOFCODE$
SELECT bit_or(bitstr)
FROM myapp_permissions_public.org_permissions
WHERE
  name = ANY( names )
$EOFCODE$ LANGUAGE sql STABLE SECURITY INVOKER;

CREATE FUNCTION myapp_permissions_private.org_permissions_bitnum_tg() RETURNS trigger AS $EOFCODE$
DECLARE
  bitlen int := bit_length(NEW.bitstr);
BEGIN
  NEW.bitstr := (lpad('', bitlen - NEW.bitnum, '0') || '1') || lpad('', NEW.bitnum - 1, '0');
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY INVOKER;

CREATE TRIGGER org_permissions_insert_trg
  BEFORE INSERT
  ON myapp_permissions_public.org_permissions
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_permissions_private.org_permissions_bitnum_tg();

CREATE TABLE myapp_permissions_public.org_permission_defaults ();

ALTER TABLE myapp_permissions_public.org_permission_defaults 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_permissions_public.org_permission_defaults IS 'Stores the default permission bitmask assigned to new members upon joining';

ALTER TABLE myapp_permissions_public.org_permission_defaults 
  ADD COLUMN id uuid;

ALTER TABLE myapp_permissions_public.org_permission_defaults 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_permissions_public.org_permission_defaults 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_permissions_public.org_permission_defaults 
  ADD CONSTRAINT org_permission_defaults_pkey PRIMARY KEY (id);

ALTER TABLE myapp_permissions_public.org_permission_defaults 
  ADD COLUMN permissions pg_catalog.bit(64);

ALTER TABLE myapp_permissions_public.org_permission_defaults 
  ALTER COLUMN permissions SET NOT NULL;

ALTER TABLE myapp_permissions_public.org_permission_defaults 
  ALTER COLUMN permissions SET DEFAULT CAST(lpad('', 64, '0') AS pg_catalog.bit(64));

COMMENT ON COLUMN myapp_permissions_public.org_permission_defaults.permissions IS 'Default permission bitmask applied to new members';

ALTER TABLE myapp_permissions_public.org_permission_defaults 
  ADD COLUMN entity_id uuid;

ALTER TABLE myapp_permissions_public.org_permission_defaults 
  ALTER COLUMN entity_id SET NOT NULL;

COMMENT ON COLUMN myapp_permissions_public.org_permission_defaults.entity_id IS 'References the entity these default permissions apply to';

ALTER TABLE myapp_permissions_public.org_permission_defaults 
  ADD CONSTRAINT org_permission_defaults_entity_id_fkey
    FOREIGN KEY(entity_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE CASCADE;

CREATE INDEX org_permission_defaults_entity_id_idx ON myapp_permissions_public.org_permission_defaults (entity_id);

CREATE TABLE myapp_limits_public.org_limits ();

ALTER TABLE myapp_limits_public.org_limits 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_limits_public.org_limits IS 'Tracks per-actor usage counts against configurable maximum limits';

ALTER TABLE myapp_limits_public.org_limits 
  ADD COLUMN id uuid;

ALTER TABLE myapp_limits_public.org_limits 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_limits_public.org_limits 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_limits_public.org_limits 
  ADD CONSTRAINT org_limits_pkey PRIMARY KEY (id);

ALTER TABLE myapp_limits_public.org_limits 
  ADD COLUMN name citext;

COMMENT ON COLUMN myapp_limits_public.org_limits.name IS 'Name identifier of the limit being tracked';

ALTER TABLE myapp_limits_public.org_limits 
  ADD COLUMN actor_id uuid;

ALTER TABLE myapp_limits_public.org_limits 
  ALTER COLUMN actor_id SET NOT NULL;

COMMENT ON COLUMN myapp_limits_public.org_limits.actor_id IS 'User whose usage is being tracked against this limit';

ALTER TABLE myapp_limits_public.org_limits 
  ADD CONSTRAINT org_limits_actor_id_fkey
    FOREIGN KEY(actor_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE CASCADE;

CREATE INDEX org_limits_actor_id_idx ON myapp_limits_public.org_limits (actor_id);

ALTER TABLE myapp_limits_public.org_limits 
  ADD COLUMN num bigint;

COMMENT ON COLUMN myapp_limits_public.org_limits.num IS 'Current usage count for this actor and limit';

ALTER TABLE myapp_limits_public.org_limits 
  ADD COLUMN max bigint;

COMMENT ON COLUMN myapp_limits_public.org_limits.max IS 'Maximum allowed usage; negative means unlimited. Modified by plans, credits, and achievements.';

ALTER TABLE myapp_limits_public.org_limits 
  ADD COLUMN soft_max bigint;

COMMENT ON COLUMN myapp_limits_public.org_limits.soft_max IS 'Soft limit threshold for warnings; NULL means no soft limit. When num >= soft_max, consumers should warn but still allow until max is reached.';

ALTER TABLE myapp_limits_public.org_limits 
  ADD COLUMN window_start timestamptz;

COMMENT ON COLUMN myapp_limits_public.org_limits.window_start IS 'Start of the current metering window; NULL means no time window';

ALTER TABLE myapp_limits_public.org_limits 
  ADD COLUMN window_duration interval;

COMMENT ON COLUMN myapp_limits_public.org_limits.window_duration IS 'Duration of the metering window (e.g. 1 day, 1 month); NULL means no time window';

ALTER TABLE myapp_limits_public.org_limits 
  ADD COLUMN plan_max bigint;

ALTER TABLE myapp_limits_public.org_limits 
  ALTER COLUMN plan_max SET DEFAULT 0;

COMMENT ON COLUMN myapp_limits_public.org_limits.plan_max IS 'Ceiling set by the active plan via apply_plan(). Window reset does not change this value.';

ALTER TABLE myapp_limits_public.org_limits 
  ADD COLUMN purchased_credits bigint;

ALTER TABLE myapp_limits_public.org_limits 
  ALTER COLUMN purchased_credits SET DEFAULT 0;

COMMENT ON COLUMN myapp_limits_public.org_limits.purchased_credits IS 'Permanent credits from purchases, admin grants, or lifetime rewards. Survives window reset.';

ALTER TABLE myapp_limits_public.org_limits 
  ADD COLUMN period_credits bigint;

ALTER TABLE myapp_limits_public.org_limits 
  ALTER COLUMN period_credits SET DEFAULT 0;

COMMENT ON COLUMN myapp_limits_public.org_limits.period_credits IS 'Temporary credits for the current billing window. Resets to 0 on window expiry.';

ALTER TABLE myapp_limits_public.org_limits 
  ADD COLUMN entity_id uuid;

ALTER TABLE myapp_limits_public.org_limits 
  ALTER COLUMN entity_id SET NOT NULL;

ALTER TABLE myapp_limits_public.org_limits 
  ADD CONSTRAINT org_limits_entity_id_fkey
    FOREIGN KEY(entity_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE CASCADE;

CREATE INDEX org_limits_entity_id_idx ON myapp_limits_public.org_limits (entity_id);

ALTER TABLE myapp_limits_public.org_limits 
  ADD CONSTRAINT org_limits_name_actor_id_entity_id_key 
    UNIQUE (name, actor_id, entity_id);

ALTER TABLE myapp_limits_public.org_limits 
  ADD COLUMN organization_id uuid;

COMMENT ON COLUMN myapp_limits_public.org_limits.organization_id IS 'Resolved billable organization via get_organization_id';

ALTER TABLE myapp_limits_public.org_limits 
  ADD COLUMN entity_type text;

COMMENT ON COLUMN myapp_limits_public.org_limits.entity_type IS 'Entity type prefix (org, team, app, etc.) for interpreting entity_id';

CREATE TABLE myapp_limits_public.org_limit_defaults ();

ALTER TABLE myapp_limits_public.org_limit_defaults 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_limits_public.org_limit_defaults IS 'Default maximum values for each named limit, applied when no per-actor override exists';

ALTER TABLE myapp_limits_public.org_limit_defaults 
  ADD COLUMN id uuid;

ALTER TABLE myapp_limits_public.org_limit_defaults 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_limits_public.org_limit_defaults 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_limits_public.org_limit_defaults 
  ADD CONSTRAINT org_limit_defaults_pkey PRIMARY KEY (id);

ALTER TABLE myapp_limits_public.org_limit_defaults 
  ADD COLUMN name citext;

ALTER TABLE myapp_limits_public.org_limit_defaults 
  ALTER COLUMN name SET NOT NULL;

COMMENT ON COLUMN myapp_limits_public.org_limit_defaults.name IS 'Name identifier of the limit this default applies to';

ALTER TABLE myapp_limits_public.org_limit_defaults 
  ADD COLUMN max bigint;

COMMENT ON COLUMN myapp_limits_public.org_limit_defaults.max IS 'Default maximum usage allowed for this limit';

ALTER TABLE myapp_limits_public.org_limit_defaults 
  ADD COLUMN soft_max bigint;

COMMENT ON COLUMN myapp_limits_public.org_limit_defaults.soft_max IS 'Default soft limit threshold for warnings; NULL means no soft limit';

ALTER TABLE myapp_limits_public.org_limit_defaults 
  ADD CONSTRAINT org_limit_defaults_name_key 
    UNIQUE (name);

CREATE FUNCTION myapp_limits_private.org_limits_inc(
  IN limitname citext,
  IN entity_id uuid,
  IN actor_id uuid DEFAULT jwt_public.current_user_id(),
  IN amount bigint DEFAULT 1
) RETURNS boolean AS $EOFCODE$
DECLARE
  max_default bigint := 0;
BEGIN
  SELECT max
  FROM myapp_limits_public.org_limit_defaults
  WHERE
    name = org_limits_inc.limitname INTO max_default;
  IF NOT (FOUND) THEN
    max_default := 0;
  END IF;
  INSERT INTO myapp_limits_public.org_limits (
    name,
    num,
    max,
    actor_id,
    entity_id
  )
  VALUES
    (org_limits_inc.limitname, 0, max_default, org_limits_inc.actor_id, org_limits_inc.entity_id)
  ON CONFLICT ON CONSTRAINT org_limits_name_actor_id_entity_id_key DO NOTHING;
  UPDATE myapp_limits_public.org_limits AS l SET
  num = 0, period_credits = 0, max = plan_max + purchased_credits, window_start = pg_catalog.now()
  WHERE
    ((l.name = org_limits_inc.limitname AND l.actor_id = org_limits_inc.actor_id) AND l.entity_id = org_limits_inc.entity_id) AND (l.window_duration IS NOT NULL AND (l.window_start + l.window_duration) <= pg_catalog.now());
  UPDATE myapp_limits_public.org_limits AS l SET
  num = num + org_limits_inc.amount
  WHERE
    ((l.name = org_limits_inc.limitname AND l.actor_id = org_limits_inc.actor_id) AND l.entity_id = org_limits_inc.entity_id) AND (l.max < 0 OR l.max >= (l.num + org_limits_inc.amount));
  IF FOUND THEN
    RETURN true;
  ELSE
    RETURN false;
  END IF;
  RETURN false;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION myapp_limits_private.org_limits_dec(
  IN limitname citext,
  IN entity_id uuid,
  IN actor_id uuid DEFAULT jwt_public.current_user_id(),
  IN amount bigint DEFAULT 1
) RETURNS boolean AS $EOFCODE$
DECLARE
  max_default bigint := 0;
BEGIN
  SELECT max
  FROM myapp_limits_public.org_limit_defaults
  WHERE
    name = org_limits_dec.limitname INTO max_default;
  IF NOT (FOUND) THEN
    max_default := 0;
  END IF;
  INSERT INTO myapp_limits_public.org_limits (
    name,
    num,
    max,
    actor_id,
    entity_id
  )
  VALUES
    (org_limits_dec.limitname, 0, max_default, org_limits_dec.actor_id, org_limits_dec.entity_id)
  ON CONFLICT ON CONSTRAINT org_limits_name_actor_id_entity_id_key DO NOTHING;
  UPDATE myapp_limits_public.org_limits AS l SET
  num = GREATEST(num - org_limits_dec.amount, 0)
  WHERE
    (l.name = org_limits_dec.limitname AND l.actor_id = org_limits_dec.actor_id) AND l.entity_id = org_limits_dec.entity_id;
  RETURN true;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION myapp_limits_private.org_limits_inc_tg() RETURNS trigger AS $EOFCODE$
DECLARE
  limit_ok boolean;
  actor_id uuid;
  limitname citext;
BEGIN
  IF tg_nargs < 1 THEN
    RAISE EXCEPTION 'LIMIT_TRIGGER_ARGS (%)', tg_name;
  ELSIF tg_nargs = 1 THEN
    limitname := (tg_argv)[0];
    limit_ok := myapp_limits_private.org_limits_inc(limitname);
  ELSIF tg_nargs >= 2 THEN
    limitname := (tg_argv)[0];
    EXECUTE pg_catalog.format('SELECT ($1).%s', (tg_argv)[1]) INTO actor_id USING NEW;
    limit_ok := myapp_limits_private.org_limits_inc(limitname, actor_id);
  END IF;
  IF limit_ok = false THEN
    RAISE EXCEPTION 'LIMIT_REACHED';
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE;

CREATE FUNCTION myapp_limits_private.org_limits_dec_tg() RETURNS trigger AS $EOFCODE$
DECLARE
  actor_id uuid;
  limitname citext;
BEGIN
  IF tg_nargs < 1 THEN
    RAISE EXCEPTION 'LIMIT_TRIGGER_ARGS (%)', tg_name;
  ELSIF tg_nargs = 1 THEN
    limitname := (tg_argv)[0];
    PERFORM myapp_limits_private.org_limits_dec(limitname);
  ELSIF tg_nargs >= 2 THEN
    limitname := (tg_argv)[0];
    EXECUTE pg_catalog.format('SELECT ($1).%s', (tg_argv)[1]) INTO actor_id USING OLD;
    PERFORM myapp_limits_private.org_limits_dec(limitname, actor_id);
  END IF;
  RETURN OLD;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE;

CREATE FUNCTION myapp_limits_private.org_limits_upd_tg() RETURNS trigger AS $EOFCODE$
DECLARE
  limit_ok boolean;
  old_actor_id uuid;
  new_actor_id uuid;
  limitname citext;
BEGIN
  IF tg_nargs < 1 THEN
    RAISE EXCEPTION 'LIMIT_TRIGGER_ARGS (%)', tg_name;
  ELSIF tg_nargs = 1 THEN
    RAISE EXCEPTION 'LIMIT_TRIGGER_ARGS (%)', tg_name;
  ELSIF tg_nargs >= 2 THEN
    limitname := (tg_argv)[0];
    EXECUTE pg_catalog.format('SELECT ($1).%s', (tg_argv)[1]) INTO new_actor_id USING NEW;
    EXECUTE pg_catalog.format('SELECT ($1).%s', (tg_argv)[1]) INTO old_actor_id USING OLD;
    PERFORM myapp_limits_private.org_limits_dec(limitname, old_actor_id);
    limit_ok := myapp_limits_private.org_limits_inc(limitname, new_actor_id);
  END IF;
  IF limit_ok = false THEN
    RAISE EXCEPTION 'LIMIT_REACHED';
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE;

CREATE TABLE myapp_limits_public.org_limit_credits ();

ALTER TABLE myapp_limits_public.org_limit_credits 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_limits_public.org_limit_credits IS 'Append-only ledger of credit grants that automatically update limit ceilings';

ALTER TABLE myapp_limits_public.org_limit_credits 
  ADD COLUMN id uuid;

ALTER TABLE myapp_limits_public.org_limit_credits 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_limits_public.org_limit_credits 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_limits_public.org_limit_credits 
  ADD CONSTRAINT org_limit_credits_pkey PRIMARY KEY (id);

ALTER TABLE myapp_limits_public.org_limit_credits 
  ADD COLUMN default_limit_id uuid;

ALTER TABLE myapp_limits_public.org_limit_credits 
  ALTER COLUMN default_limit_id SET NOT NULL;

COMMENT ON COLUMN myapp_limits_public.org_limit_credits.default_limit_id IS 'FK to default_limits — which limit definition this credit applies to';

ALTER TABLE myapp_limits_public.org_limit_credits 
  ADD CONSTRAINT org_limit_credits_default_limit_id_fkey
    FOREIGN KEY(default_limit_id)
    REFERENCES myapp_limits_public.org_limit_defaults (id)
    ON DELETE RESTRICT;

CREATE INDEX org_limit_credits_default_limit_id_idx ON myapp_limits_public.org_limit_credits (default_limit_id);

ALTER TABLE myapp_limits_public.org_limit_credits 
  ADD COLUMN actor_id uuid;

COMMENT ON COLUMN myapp_limits_public.org_limit_credits.actor_id IS 'User this credit is for; NULL for aggregate entity-level credits';

ALTER TABLE myapp_limits_public.org_limit_credits 
  ADD CONSTRAINT org_limit_credits_actor_id_fkey
    FOREIGN KEY(actor_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE CASCADE;

CREATE INDEX org_limit_credits_actor_id_idx ON myapp_limits_public.org_limit_credits (actor_id);

ALTER TABLE myapp_limits_public.org_limit_credits 
  ADD COLUMN entity_id uuid;

COMMENT ON COLUMN myapp_limits_public.org_limit_credits.entity_id IS 'Entity this credit applies to; NULL for actor-only credits';

ALTER TABLE myapp_limits_public.org_limit_credits 
  ADD CONSTRAINT org_limit_credits_entity_id_fkey
    FOREIGN KEY(entity_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE CASCADE;

CREATE INDEX org_limit_credits_entity_id_idx ON myapp_limits_public.org_limit_credits (entity_id);

ALTER TABLE myapp_limits_public.org_limit_credits 
  ADD COLUMN organization_id uuid;

COMMENT ON COLUMN myapp_limits_public.org_limit_credits.organization_id IS 'Resolved billable organization via get_organization_id';

ALTER TABLE myapp_limits_public.org_limit_credits 
  ADD COLUMN entity_type text;

COMMENT ON COLUMN myapp_limits_public.org_limit_credits.entity_type IS 'Membership prefix identifying the entity kind (org, team, app)';

ALTER TABLE myapp_limits_public.org_limit_credits 
  ADD COLUMN amount bigint;

ALTER TABLE myapp_limits_public.org_limit_credits 
  ALTER COLUMN amount SET NOT NULL;

COMMENT ON COLUMN myapp_limits_public.org_limit_credits.amount IS 'Number of credits to grant (positive to add, negative to revoke)';

ALTER TABLE myapp_limits_public.org_limit_credits 
  ADD COLUMN credit_type text;

ALTER TABLE myapp_limits_public.org_limit_credits 
  ALTER COLUMN credit_type SET NOT NULL;

ALTER TABLE myapp_limits_public.org_limit_credits 
  ALTER COLUMN credit_type SET DEFAULT 'permanent';

COMMENT ON COLUMN myapp_limits_public.org_limit_credits.credit_type IS 'Credit durability: permanent (survives window reset) or period (resets on window expiry)';

ALTER TABLE myapp_limits_public.org_limit_credits 
  ADD COLUMN reason text;

COMMENT ON COLUMN myapp_limits_public.org_limit_credits.reason IS 'Optional reason for the credit grant (promo code, admin grant, etc.)';

ALTER TABLE myapp_limits_public.org_limit_credits 
  ENABLE ROW LEVEL SECURITY;

GRANT INSERT ON myapp_limits_public.org_limit_credits TO authenticated;

GRANT SELECT ON myapp_limits_public.org_limit_credits TO authenticated;

CREATE POLICY auth_sel_own
  ON myapp_limits_public.org_limit_credits
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    actor_id = jwt_public.current_principal_id()
  );

CREATE FUNCTION myapp_limits_private.org_limit_credits_apply_tg_fn() RETURNS trigger AS $EOFCODE$
DECLARE
  v_limit_name text;
BEGIN
  SELECT name
  FROM myapp_limits_public.org_limit_defaults
  WHERE
    id = NEW.default_limit_id INTO v_limit_name;
  IF NOT (FOUND) THEN
    RAISE WARNING 'INVALID_DEFAULT_LIMIT_ID';
  END IF;
  IF NEW.credit_type = 'permanent' THEN
    UPDATE myapp_limits_public.org_limits SET
    purchased_credits = purchased_credits + NEW.amount, max = ((plan_max + purchased_credits) + NEW.amount) + period_credits
    WHERE
      name = v_limit_name AND actor_id = NEW.actor_id;
  ELSE
    UPDATE myapp_limits_public.org_limits SET
    period_credits = period_credits + NEW.amount, max = (plan_max + purchased_credits) + (period_credits + NEW.amount)
    WHERE
      name = v_limit_name AND actor_id = NEW.actor_id;
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE TRIGGER _00100_org_limit_credits_apply_tg
  AFTER INSERT
  ON myapp_limits_public.org_limit_credits
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_limits_private.org_limit_credits_apply_tg_fn();

CREATE FUNCTION myapp_limits_private.org_limits_check(
  IN limitname citext,
  IN amount bigint DEFAULT 1,
  IN user_id uuid DEFAULT jwt_public.current_user_id()
) RETURNS boolean AS $EOFCODE$
DECLARE
  max_default bigint := 0;
  rec myapp_limits_public.org_limits;
BEGIN
  SELECT max
  FROM myapp_limits_public.org_limit_defaults
  WHERE
    name = org_limits_check.limitname INTO max_default;
  IF NOT (FOUND) THEN
    max_default := 0;
  END IF;
  INSERT INTO myapp_limits_public.org_limits (
    name,
    num,
    max,
    actor_id
  )
  VALUES
    (org_limits_check.limitname, 0, max_default, org_limits_check.user_id)
  ON CONFLICT ON CONSTRAINT org_limits_name_actor_id_key DO NOTHING;
  UPDATE myapp_limits_public.org_limits AS l SET
  num = 0, period_credits = 0, max = plan_max + purchased_credits, window_start = pg_catalog.now()
  WHERE
    (l.name = org_limits_check.limitname AND l.actor_id = org_limits_check.user_id) AND (l.window_duration IS NOT NULL AND (l.window_start + l.window_duration) <= pg_catalog.now());
  SELECT *
  FROM myapp_limits_public.org_limits
  WHERE
    name = org_limits_check.limitname AND actor_id = org_limits_check.user_id
  FOR UPDATE INTO rec;
  IF rec.max < 0 OR rec.max >= (rec.num + org_limits_check.amount) THEN
    RETURN true;
  ELSE
    RETURN false;
  END IF;
  RETURN false;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION myapp_limits_private.org_limits_modify(
  IN limitname citext,
  IN delta bigint,
  IN reason text DEFAULT '',
  IN user_id uuid DEFAULT jwt_public.current_user_id()
) RETURNS boolean AS $EOFCODE$
DECLARE
  max_default bigint := 0;
BEGIN
  SELECT max
  FROM myapp_limits_public.org_limit_defaults
  WHERE
    name = org_limits_modify.limitname INTO max_default;
  IF NOT (FOUND) THEN
    max_default := 0;
  END IF;
  INSERT INTO myapp_limits_public.org_limits (
    name,
    num,
    max,
    actor_id
  )
  VALUES
    (org_limits_modify.limitname, 0, max_default, org_limits_modify.user_id)
  ON CONFLICT ON CONSTRAINT org_limits_name_actor_id_key DO NOTHING;
  UPDATE myapp_limits_public.org_limits SET
  max = max + org_limits_modify.delta
  WHERE
    name = org_limits_modify.limitname AND actor_id = org_limits_modify.user_id;
  RETURN true;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE TABLE myapp_limits_public.org_limit_aggregates ();

ALTER TABLE myapp_limits_public.org_limit_aggregates 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_limits_public.org_limit_aggregates IS 'Tracks aggregate entity-level usage counts (org-wide caps, no per-user breakdown)';

ALTER TABLE myapp_limits_public.org_limit_aggregates 
  ADD COLUMN id uuid;

ALTER TABLE myapp_limits_public.org_limit_aggregates 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_limits_public.org_limit_aggregates 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_limits_public.org_limit_aggregates 
  ADD CONSTRAINT org_limit_aggregates_pkey PRIMARY KEY (id);

ALTER TABLE myapp_limits_public.org_limit_aggregates 
  ADD COLUMN name citext;

COMMENT ON COLUMN myapp_limits_public.org_limit_aggregates.name IS 'Name identifier of the aggregate limit being tracked';

ALTER TABLE myapp_limits_public.org_limit_aggregates 
  ADD COLUMN entity_id uuid;

ALTER TABLE myapp_limits_public.org_limit_aggregates 
  ALTER COLUMN entity_id SET NOT NULL;

COMMENT ON COLUMN myapp_limits_public.org_limit_aggregates.entity_id IS 'Entity (org) whose aggregate usage is being tracked';

ALTER TABLE myapp_limits_public.org_limit_aggregates 
  ADD CONSTRAINT org_limit_aggregates_entity_id_fkey
    FOREIGN KEY(entity_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE CASCADE;

CREATE INDEX org_limit_aggregates_entity_id_idx ON myapp_limits_public.org_limit_aggregates (entity_id);

ALTER TABLE myapp_limits_public.org_limit_aggregates 
  ADD COLUMN num bigint;

COMMENT ON COLUMN myapp_limits_public.org_limit_aggregates.num IS 'Current aggregate usage count for this entity and limit';

ALTER TABLE myapp_limits_public.org_limit_aggregates 
  ADD COLUMN max bigint;

COMMENT ON COLUMN myapp_limits_public.org_limit_aggregates.max IS 'Maximum allowed aggregate usage; negative means unlimited';

ALTER TABLE myapp_limits_public.org_limit_aggregates 
  ADD COLUMN soft_max bigint;

COMMENT ON COLUMN myapp_limits_public.org_limit_aggregates.soft_max IS 'Soft limit threshold for warnings; NULL means no soft limit';

ALTER TABLE myapp_limits_public.org_limit_aggregates 
  ADD COLUMN window_start timestamptz;

COMMENT ON COLUMN myapp_limits_public.org_limit_aggregates.window_start IS 'Start of the current metering window; NULL means no time window';

ALTER TABLE myapp_limits_public.org_limit_aggregates 
  ADD COLUMN window_duration interval;

COMMENT ON COLUMN myapp_limits_public.org_limit_aggregates.window_duration IS 'Duration of the metering window (e.g. 1 day, 1 month); NULL means no time window';

ALTER TABLE myapp_limits_public.org_limit_aggregates 
  ADD COLUMN plan_max bigint;

ALTER TABLE myapp_limits_public.org_limit_aggregates 
  ALTER COLUMN plan_max SET DEFAULT 0;

COMMENT ON COLUMN myapp_limits_public.org_limit_aggregates.plan_max IS 'Ceiling set by the active plan via apply_plan(). Window reset does not change this value.';

ALTER TABLE myapp_limits_public.org_limit_aggregates 
  ADD COLUMN purchased_credits bigint;

ALTER TABLE myapp_limits_public.org_limit_aggregates 
  ALTER COLUMN purchased_credits SET DEFAULT 0;

COMMENT ON COLUMN myapp_limits_public.org_limit_aggregates.purchased_credits IS 'Permanent credits from purchases, admin grants, or lifetime rewards. Survives window reset.';

ALTER TABLE myapp_limits_public.org_limit_aggregates 
  ADD COLUMN period_credits bigint;

ALTER TABLE myapp_limits_public.org_limit_aggregates 
  ALTER COLUMN period_credits SET DEFAULT 0;

COMMENT ON COLUMN myapp_limits_public.org_limit_aggregates.period_credits IS 'Temporary credits for the current billing window. Resets to 0 on window expiry.';

ALTER TABLE myapp_limits_public.org_limit_aggregates 
  ADD COLUMN reserved bigint;

ALTER TABLE myapp_limits_public.org_limit_aggregates 
  ALTER COLUMN reserved SET DEFAULT 0;

COMMENT ON COLUMN myapp_limits_public.org_limit_aggregates.reserved IS 'Capacity reserved by child entities in budgeted allocation mode. Available = max - num - reserved.';

ALTER TABLE myapp_limits_public.org_limit_aggregates 
  ADD COLUMN organization_id uuid;

COMMENT ON COLUMN myapp_limits_public.org_limit_aggregates.organization_id IS 'Resolved billable organization via get_organization_id';

ALTER TABLE myapp_limits_public.org_limit_aggregates 
  ADD COLUMN entity_type text;

COMMENT ON COLUMN myapp_limits_public.org_limit_aggregates.entity_type IS 'Entity type prefix (org, team, app, etc.) for interpreting entity_id';

ALTER TABLE myapp_limits_public.org_limit_aggregates 
  ADD CONSTRAINT org_limit_aggregates_name_entity_id_key 
    UNIQUE (name, entity_id);

CREATE FUNCTION myapp_limits_private.org_limit_aggregates_inc(
  IN limitname citext,
  IN entity_id uuid,
  IN amount bigint DEFAULT 1
) RETURNS boolean AS $EOFCODE$
DECLARE
  max_default bigint := 0;
BEGIN
  SELECT max
  FROM myapp_limits_public.org_limit_defaults
  WHERE
    name = org_limit_aggregates_inc.limitname INTO max_default;
  IF NOT (FOUND) THEN
    max_default := 0;
  END IF;
  INSERT INTO myapp_limits_public.org_limit_aggregates (
    name,
    num,
    max,
    entity_id
  )
  VALUES
    (org_limit_aggregates_inc.limitname, 0, max_default, org_limit_aggregates_inc.entity_id)
  ON CONFLICT ON CONSTRAINT org_limit_aggregates_name_entity_id_key DO NOTHING;
  UPDATE myapp_limits_public.org_limit_aggregates AS l SET
  num = 0, period_credits = 0, max = plan_max + purchased_credits, window_start = pg_catalog.now()
  WHERE
    (l.name = org_limit_aggregates_inc.limitname AND l.entity_id = org_limit_aggregates_inc.entity_id) AND (l.window_duration IS NOT NULL AND (l.window_start + l.window_duration) <= pg_catalog.now());
  UPDATE myapp_limits_public.org_limit_aggregates AS l SET
  num = num + org_limit_aggregates_inc.amount
  WHERE
    (l.name = org_limit_aggregates_inc.limitname AND l.entity_id = org_limit_aggregates_inc.entity_id) AND (l.max < 0 OR l.max >= (l.num + org_limit_aggregates_inc.amount));
  IF FOUND THEN
    RETURN true;
  ELSE
    RETURN false;
  END IF;
  RETURN false;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION myapp_limits_private.org_limit_aggregates_dec(
  IN limitname citext,
  IN entity_id uuid,
  IN amount bigint DEFAULT 1
) RETURNS boolean AS $EOFCODE$
DECLARE
  max_default bigint := 0;
BEGIN
  SELECT max
  FROM myapp_limits_public.org_limit_defaults
  WHERE
    name = org_limit_aggregates_dec.limitname INTO max_default;
  IF NOT (FOUND) THEN
    max_default := 0;
  END IF;
  INSERT INTO myapp_limits_public.org_limit_aggregates (
    name,
    num,
    max,
    entity_id
  )
  VALUES
    (org_limit_aggregates_dec.limitname, 0, max_default, org_limit_aggregates_dec.entity_id)
  ON CONFLICT ON CONSTRAINT org_limit_aggregates_name_entity_id_key DO NOTHING;
  UPDATE myapp_limits_public.org_limit_aggregates AS l SET
  num = GREATEST(num - org_limit_aggregates_dec.amount, 0)
  WHERE
    l.name = org_limit_aggregates_dec.limitname AND l.entity_id = org_limit_aggregates_dec.entity_id;
  RETURN true;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION myapp_limits_private.org_limit_aggregates_check(
  IN limitname citext,
  IN entity_id uuid,
  IN amount bigint DEFAULT 1
) RETURNS boolean AS $EOFCODE$
DECLARE
  max_default bigint := 0;
  rec myapp_limits_public.org_limit_aggregates;
BEGIN
  SELECT max
  FROM myapp_limits_public.org_limit_defaults
  WHERE
    name = org_limit_aggregates_check.limitname INTO max_default;
  IF NOT (FOUND) THEN
    max_default := 0;
  END IF;
  INSERT INTO myapp_limits_public.org_limit_aggregates (
    name,
    num,
    max,
    entity_id
  )
  VALUES
    (org_limit_aggregates_check.limitname, 0, max_default, org_limit_aggregates_check.entity_id)
  ON CONFLICT ON CONSTRAINT org_limit_aggregates_name_entity_id_key DO NOTHING;
  UPDATE myapp_limits_public.org_limit_aggregates AS l SET
  num = 0, period_credits = 0, max = plan_max + purchased_credits, window_start = pg_catalog.now()
  WHERE
    (l.name = org_limit_aggregates_check.limitname AND l.entity_id = org_limit_aggregates_check.entity_id) AND (l.window_duration IS NOT NULL AND (l.window_start + l.window_duration) <= pg_catalog.now());
  SELECT *
  FROM myapp_limits_public.org_limit_aggregates
  WHERE
    name = org_limit_aggregates_check.limitname AND org_limit_aggregates.entity_id = org_limit_aggregates_check.entity_id
  FOR UPDATE INTO rec;
  IF rec.max < 0 OR rec.max >= (rec.num + org_limit_aggregates_check.amount) THEN
    RETURN true;
  ELSE
    RETURN false;
  END IF;
  RETURN false;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION myapp_limits_private.org_limit_aggregates_modify(
  IN limitname citext,
  IN entity_id uuid,
  IN delta bigint,
  IN reason text DEFAULT ''
) RETURNS boolean AS $EOFCODE$
DECLARE
  max_default bigint := 0;
BEGIN
  SELECT max
  FROM myapp_limits_public.org_limit_defaults
  WHERE
    name = org_limit_aggregates_modify.limitname INTO max_default;
  IF NOT (FOUND) THEN
    max_default := 0;
  END IF;
  INSERT INTO myapp_limits_public.org_limit_aggregates (
    name,
    num,
    max,
    entity_id
  )
  VALUES
    (org_limit_aggregates_modify.limitname, 0, max_default, org_limit_aggregates_modify.entity_id)
  ON CONFLICT ON CONSTRAINT org_limit_aggregates_name_entity_id_key DO NOTHING;
  UPDATE myapp_limits_public.org_limit_aggregates SET
  max = max + org_limit_aggregates_modify.delta
  WHERE
    name = org_limit_aggregates_modify.limitname AND org_limit_aggregates.entity_id = org_limit_aggregates_modify.entity_id;
  RETURN true;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION myapp_limits_private.org_limit_aggregates_inc_tg() RETURNS trigger AS $EOFCODE$
DECLARE
  limit_ok boolean;
  actor_id uuid;
  limitname citext;
BEGIN
  IF tg_nargs < 1 THEN
    RAISE EXCEPTION 'LIMIT_TRIGGER_ARGS (%)', tg_name;
  ELSIF tg_nargs = 1 THEN
    limitname := (tg_argv)[0];
    limit_ok := myapp_limits_private.org_limit_aggregates_inc(limitname);
  ELSIF tg_nargs >= 2 THEN
    limitname := (tg_argv)[0];
    EXECUTE pg_catalog.format('SELECT ($1).%s', (tg_argv)[1]) INTO actor_id USING NEW;
    limit_ok := myapp_limits_private.org_limit_aggregates_inc(limitname, actor_id);
  END IF;
  IF limit_ok = false THEN
    RAISE EXCEPTION 'LIMIT_REACHED';
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE;

CREATE FUNCTION myapp_limits_private.org_limit_aggregates_dec_tg() RETURNS trigger AS $EOFCODE$
DECLARE
  actor_id uuid;
  limitname citext;
BEGIN
  IF tg_nargs < 1 THEN
    RAISE EXCEPTION 'LIMIT_TRIGGER_ARGS (%)', tg_name;
  ELSIF tg_nargs = 1 THEN
    limitname := (tg_argv)[0];
    PERFORM myapp_limits_private.org_limit_aggregates_dec(limitname);
  ELSIF tg_nargs >= 2 THEN
    limitname := (tg_argv)[0];
    EXECUTE pg_catalog.format('SELECT ($1).%s', (tg_argv)[1]) INTO actor_id USING OLD;
    PERFORM myapp_limits_private.org_limit_aggregates_dec(limitname, actor_id);
  END IF;
  RETURN OLD;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE;

CREATE FUNCTION myapp_limits_private.org_limit_aggregates_upd_tg() RETURNS trigger AS $EOFCODE$
DECLARE
  limit_ok boolean;
  old_actor_id uuid;
  new_actor_id uuid;
  limitname citext;
BEGIN
  IF tg_nargs < 1 THEN
    RAISE EXCEPTION 'LIMIT_TRIGGER_ARGS (%)', tg_name;
  ELSIF tg_nargs = 1 THEN
    RAISE EXCEPTION 'LIMIT_TRIGGER_ARGS (%)', tg_name;
  ELSIF tg_nargs >= 2 THEN
    limitname := (tg_argv)[0];
    EXECUTE pg_catalog.format('SELECT ($1).%s', (tg_argv)[1]) INTO new_actor_id USING NEW;
    EXECUTE pg_catalog.format('SELECT ($1).%s', (tg_argv)[1]) INTO old_actor_id USING OLD;
    PERFORM myapp_limits_private.org_limit_aggregates_dec(limitname, old_actor_id);
    limit_ok := myapp_limits_private.org_limit_aggregates_inc(limitname, new_actor_id);
  END IF;
  IF limit_ok = false THEN
    RAISE EXCEPTION 'LIMIT_REACHED';
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE;

CREATE FUNCTION myapp_limits_private.org_limit_aggregates_transfer_quota(
  IN limitname citext,
  IN source_entity_id uuid,
  IN dest_entity_id uuid,
  IN amount bigint
) RETURNS boolean AS $EOFCODE$
DECLARE
  max_default bigint := 0;
  rec myapp_limits_public.org_limit_aggregates;
BEGIN
  SELECT max
  FROM myapp_limits_public.org_limit_defaults
  WHERE
    name = org_limit_aggregates_transfer_quota.limitname INTO max_default;
  IF NOT (FOUND) THEN
    max_default := 0;
  END IF;
  INSERT INTO myapp_limits_public.org_limit_aggregates (
    name,
    num,
    max,
    entity_id
  )
  VALUES
    (org_limit_aggregates_transfer_quota.limitname, 0, max_default, org_limit_aggregates_transfer_quota.source_entity_id)
  ON CONFLICT ON CONSTRAINT org_limit_aggregates_name_entity_id_key DO NOTHING;
  INSERT INTO myapp_limits_public.org_limit_aggregates (
    name,
    num,
    max,
    entity_id
  )
  VALUES
    (org_limit_aggregates_transfer_quota.limitname, 0, max_default, org_limit_aggregates_transfer_quota.dest_entity_id)
  ON CONFLICT ON CONSTRAINT org_limit_aggregates_name_entity_id_key DO NOTHING;
  SELECT *
  FROM myapp_limits_public.org_limit_aggregates
  WHERE
    name = org_limit_aggregates_transfer_quota.limitname AND entity_id = org_limit_aggregates_transfer_quota.source_entity_id
  FOR UPDATE INTO rec;
  IF NOT (FOUND) THEN
    RETURN false;
  END IF;
  IF rec.max >= 0 AND rec.max < org_limit_aggregates_transfer_quota.amount THEN
    RETURN false;
  END IF;
  UPDATE myapp_limits_public.org_limit_aggregates SET
  max = max - org_limit_aggregates_transfer_quota.amount
  WHERE
    name = org_limit_aggregates_transfer_quota.limitname AND entity_id = org_limit_aggregates_transfer_quota.source_entity_id;
  UPDATE myapp_limits_public.org_limit_aggregates SET
  max = max + org_limit_aggregates_transfer_quota.amount
  WHERE
    name = org_limit_aggregates_transfer_quota.limitname AND entity_id = org_limit_aggregates_transfer_quota.dest_entity_id;
  RETURN true;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE TABLE myapp_limits_public.org_limit_events (
  created_at timestamptz NOT NULL DEFAULT now()
) PARTITION BY RANGE (created_at);

ALTER TABLE myapp_limits_public.org_limit_events 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_limits_public.org_limit_events IS 'Append-only log of limit events for historical reporting and audit';

ALTER TABLE myapp_limits_public.org_limit_events 
  ADD COLUMN id uuid;

ALTER TABLE myapp_limits_public.org_limit_events 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_limits_public.org_limit_events 
  ALTER COLUMN id SET DEFAULT uuidv7();

COMMENT ON COLUMN myapp_limits_public.org_limit_events.id IS 'Unique identifier for each limit event';

ALTER TABLE myapp_limits_public.org_limit_events 
  ADD COLUMN name citext;

COMMENT ON COLUMN myapp_limits_public.org_limit_events.name IS 'Limit name this event applies to';

ALTER TABLE myapp_limits_public.org_limit_events 
  ADD COLUMN actor_id uuid;

COMMENT ON COLUMN myapp_limits_public.org_limit_events.actor_id IS 'User who triggered this event; NULL for system/aggregate events';

ALTER TABLE myapp_limits_public.org_limit_events 
  ADD COLUMN entity_id uuid;

COMMENT ON COLUMN myapp_limits_public.org_limit_events.entity_id IS 'Entity this event applies to; NULL for app-level events';

ALTER TABLE myapp_limits_public.org_limit_events 
  ADD COLUMN organization_id uuid;

COMMENT ON COLUMN myapp_limits_public.org_limit_events.organization_id IS 'Resolved billable organization via get_organization_id; NULL for app-level events';

ALTER TABLE myapp_limits_public.org_limit_events 
  ADD COLUMN entity_type text;

COMMENT ON COLUMN myapp_limits_public.org_limit_events.entity_type IS 'Entity type prefix (org, team, app, etc.) for interpreting entity_id';

ALTER TABLE myapp_limits_public.org_limit_events 
  ADD COLUMN event_type text;

COMMENT ON COLUMN myapp_limits_public.org_limit_events.event_type IS 'Event type: inc, dec, check, modify, transfer, apply_plan, reset';

ALTER TABLE myapp_limits_public.org_limit_events 
  ADD COLUMN delta bigint;

COMMENT ON COLUMN myapp_limits_public.org_limit_events.delta IS 'Change amount: positive for increment, negative for decrement';

ALTER TABLE myapp_limits_public.org_limit_events 
  ADD COLUMN num_before bigint;

COMMENT ON COLUMN myapp_limits_public.org_limit_events.num_before IS 'Usage count before this event';

ALTER TABLE myapp_limits_public.org_limit_events 
  ADD COLUMN num_after bigint;

COMMENT ON COLUMN myapp_limits_public.org_limit_events.num_after IS 'Usage count after this event';

ALTER TABLE myapp_limits_public.org_limit_events 
  ADD COLUMN max_at_event bigint;

COMMENT ON COLUMN myapp_limits_public.org_limit_events.max_at_event IS 'Max limit ceiling at the time of this event';

ALTER TABLE myapp_limits_public.org_limit_events 
  ADD COLUMN reason text;

COMMENT ON COLUMN myapp_limits_public.org_limit_events.reason IS 'Optional reason or source: achievement, invite, plan_change, purchase, etc.';

ALTER TABLE myapp_limits_public.org_limit_events 
  ADD CONSTRAINT org_limit_events_pkey PRIMARY KEY (created_at, id);

ALTER TABLE myapp_limits_public.org_limit_events 
  ENABLE ROW LEVEL SECURITY;

GRANT INSERT ON myapp_limits_public.org_limit_events TO authenticated;

GRANT SELECT ON myapp_limits_public.org_limit_events TO authenticated;

CREATE POLICY auth_sel_own
  ON myapp_limits_public.org_limit_events
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    actor_id = jwt_public.current_principal_id()
  );

INSERT INTO metaschema_public.partition (
  id,
  database_id,
  table_id,
  strategy,
  partition_key_id,
  "interval",
  retention,
  retention_keep_table,
  premake,
  naming_pattern
) VALUES
  ('efaef7c0-2c07-4943-bdaa-4736f8c950c1', '019fb68d-023e-72ec-b6fc-33d15bd99e09', '019fb68d-17e2-7ecd-ba69-623975ddc468', 'range', '019fb68d-1806-7a89-ab88-20869d8622f2', '1 month', '12 months', true, 2, '{parent}_{bounds}') ON CONFLICT (table_id) DO NOTHING;

CREATE FUNCTION myapp_limits_private.org_limits_audit_tg_fn() RETURNS trigger AS $EOFCODE$
BEGIN
  INSERT INTO myapp_limits_public.org_limit_events (
    name,
    actor_id,
    event_type,
    delta,
    num_before,
    num_after,
    max_at_event
  )
  VALUES
    (NEW.name, NEW.actor_id, CASE 
        WHEN OLD IS NOT NULL AND NEW.max <> OLD.max THEN 'modify' 
        WHEN (NEW.num - (COALESCE(OLD.num, 0))) >= 0 THEN 'inc' 
        ELSE 'dec' 
      END, NEW.num - (COALESCE(OLD.num, 0)), COALESCE(OLD.num, 0), NEW.num, NEW.max);
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE TRIGGER _99999_org_limits_audit_tg
  BEFORE INSERT OR UPDATE
  ON myapp_limits_public.org_limits
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_limits_private.org_limits_audit_tg_fn();

CREATE FUNCTION myapp_limits_private.org_limit_aggregates_audit_tg_fn() RETURNS trigger AS $EOFCODE$
BEGIN
  INSERT INTO myapp_limits_public.org_limit_events (
    name,
    entity_id,
    event_type,
    delta,
    num_before,
    num_after,
    max_at_event
  )
  VALUES
    (NEW.name, NEW.entity_id, CASE 
        WHEN OLD IS NOT NULL AND NEW.max <> OLD.max THEN 'modify' 
        WHEN (NEW.num - (COALESCE(OLD.num, 0))) >= 0 THEN 'inc' 
        ELSE 'dec' 
      END, NEW.num - (COALESCE(OLD.num, 0)), COALESCE(OLD.num, 0), NEW.num, NEW.max);
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE TRIGGER _99999_org_limit_aggregates_audit_tg
  BEFORE INSERT OR UPDATE
  ON myapp_limits_public.org_limit_aggregates
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_limits_private.org_limit_aggregates_audit_tg_fn();

CREATE TABLE myapp_limits_public.org_limit_caps_defaults ();

ALTER TABLE myapp_limits_public.org_limit_caps_defaults 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_limits_public.org_limit_caps_defaults IS 'Default cap values for static configuration limits (max file size, feature flags, etc.). Not metered — just read by consumers.';

ALTER TABLE myapp_limits_public.org_limit_caps_defaults 
  ADD COLUMN id uuid;

ALTER TABLE myapp_limits_public.org_limit_caps_defaults 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_limits_public.org_limit_caps_defaults 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_limits_public.org_limit_caps_defaults 
  ADD CONSTRAINT org_limit_caps_defaults_pkey PRIMARY KEY (id);

ALTER TABLE myapp_limits_public.org_limit_caps_defaults 
  ADD COLUMN name citext;

ALTER TABLE myapp_limits_public.org_limit_caps_defaults 
  ALTER COLUMN name SET NOT NULL;

COMMENT ON COLUMN myapp_limits_public.org_limit_caps_defaults.name IS 'Name identifier of the cap (e.g. max_file_upload_size, advanced_analytics)';

ALTER TABLE myapp_limits_public.org_limit_caps_defaults 
  ADD COLUMN max bigint;

ALTER TABLE myapp_limits_public.org_limit_caps_defaults 
  ALTER COLUMN max SET NOT NULL;

ALTER TABLE myapp_limits_public.org_limit_caps_defaults 
  ALTER COLUMN max SET DEFAULT 0;

COMMENT ON COLUMN myapp_limits_public.org_limit_caps_defaults.max IS 'Default cap value. For feature flags: 0=disabled, 1=enabled. For size caps: the limit in bytes/units.';

ALTER TABLE myapp_limits_public.org_limit_caps_defaults 
  ADD CONSTRAINT org_limit_caps_defaults_name_key 
    UNIQUE (name);

CREATE TABLE myapp_limits_public.org_limit_caps ();

ALTER TABLE myapp_limits_public.org_limit_caps 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_limits_public.org_limit_caps IS 'Per-entity cap overrides. Allows specific orgs/entities to have different cap values than the scope default.';

ALTER TABLE myapp_limits_public.org_limit_caps 
  ADD COLUMN id uuid;

ALTER TABLE myapp_limits_public.org_limit_caps 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_limits_public.org_limit_caps 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_limits_public.org_limit_caps 
  ADD CONSTRAINT org_limit_caps_pkey PRIMARY KEY (id);

ALTER TABLE myapp_limits_public.org_limit_caps 
  ADD COLUMN name citext;

ALTER TABLE myapp_limits_public.org_limit_caps 
  ALTER COLUMN name SET NOT NULL;

COMMENT ON COLUMN myapp_limits_public.org_limit_caps.name IS 'Name identifier of the cap being overridden';

ALTER TABLE myapp_limits_public.org_limit_caps 
  ADD COLUMN entity_id uuid;

ALTER TABLE myapp_limits_public.org_limit_caps 
  ALTER COLUMN entity_id SET NOT NULL;

COMMENT ON COLUMN myapp_limits_public.org_limit_caps.entity_id IS 'Entity this cap override applies to';

ALTER TABLE myapp_limits_public.org_limit_caps 
  ADD COLUMN max bigint;

ALTER TABLE myapp_limits_public.org_limit_caps 
  ALTER COLUMN max SET NOT NULL;

ALTER TABLE myapp_limits_public.org_limit_caps 
  ALTER COLUMN max SET DEFAULT 0;

COMMENT ON COLUMN myapp_limits_public.org_limit_caps.max IS 'Override cap value for this entity';

ALTER TABLE myapp_limits_public.org_limit_caps 
  ADD CONSTRAINT org_limit_caps_name_entity_id_key 
    UNIQUE (name, entity_id);

CREATE FUNCTION myapp_limits_private.org_limits_cap_check_tg_fn() RETURNS trigger AS $EOFCODE$
DECLARE
  v_cap_name citext;
  v_entity_id uuid;
  v_cap_value bigint;
BEGIN
  IF tg_nargs < 2 THEN
    RAISE EXCEPTION 'CAP_CHECK_TRIGGER_ARGS (%)', tg_name;
  END IF;
  v_entity_id := (tg_argv)[0];
  EXECUTE pg_catalog.format('SELECT ($1).%s', (tg_argv)[1]) INTO v_entity_id USING NEW;
  SELECT myapp_limits_private.org_limits_resolve_cap(v_cap_name, v_entity_id) INTO v_cap_value;
  IF pg_catalog.coalesce(v_cap_value, 0) <= 0 THEN
    RAISE EXCEPTION 'FEATURE_DISABLED (%)', v_cap_name;
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY INVOKER;

CREATE FUNCTION myapp_limits_private.org_limits_resolve_cap(
  IN cap_name citext,
  IN entity_id uuid
) RETURNS bigint AS $EOFCODE$
DECLARE
  v_cap_value bigint;
BEGIN
  SELECT max
  FROM myapp_limits_public.org_limit_caps
  WHERE
    name = org_limits_resolve_cap.cap_name AND org_limit_caps.entity_id = org_limits_resolve_cap.entity_id INTO v_cap_value;
  IF v_cap_value IS NULL THEN
    SELECT max
    FROM myapp_limits_public.org_limit_caps_defaults
    WHERE
      name = org_limits_resolve_cap.cap_name INTO v_cap_value;
  END IF;
  RETURN COALESCE(v_cap_value, 0::bigint);
END;
$EOFCODE$ LANGUAGE plpgsql STABLE SECURITY DEFINER;

CREATE FUNCTION myapp_limits_private.org_limits_check_soft(
  IN limitname citext,
  IN user_id uuid DEFAULT jwt_public.current_user_id()
) RETURNS boolean AS $EOFCODE$
DECLARE
  rec myapp_limits_public.org_limits;
BEGIN
  UPDATE myapp_limits_public.org_limits AS l SET
  num = 0, period_credits = 0, max = plan_max + purchased_credits, window_start = pg_catalog.now()
  WHERE
    (l.name = org_limits_check_soft.limitname AND l.actor_id = org_limits_check_soft.user_id) AND (l.window_duration IS NOT NULL AND (l.window_start + l.window_duration) <= pg_catalog.now());
  SELECT *
  FROM myapp_limits_public.org_limits
  WHERE
    name = org_limits_check_soft.limitname AND actor_id = org_limits_check_soft.user_id INTO rec;
  IF NOT (FOUND) OR rec.soft_max IS NULL THEN
    RETURN false;
  END IF;
  IF rec.soft_max >= 0 AND rec.num >= rec.soft_max THEN
    RETURN true;
  ELSE
    RETURN false;
  END IF;
  RETURN false;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION myapp_limits_private.org_limit_aggregates_check_soft(
  IN limitname citext,
  IN entity_id uuid
) RETURNS boolean AS $EOFCODE$
DECLARE
  rec myapp_limits_public.org_limit_aggregates;
BEGIN
  UPDATE myapp_limits_public.org_limit_aggregates AS l SET
  num = 0, period_credits = 0, max = plan_max + purchased_credits, window_start = pg_catalog.now()
  WHERE
    (l.name = org_limit_aggregates_check_soft.limitname AND l.entity_id = org_limit_aggregates_check_soft.entity_id) AND (l.window_duration IS NOT NULL AND (l.window_start + l.window_duration) <= pg_catalog.now());
  SELECT *
  FROM myapp_limits_public.org_limit_aggregates
  WHERE
    name = org_limit_aggregates_check_soft.limitname AND org_limit_aggregates.entity_id = org_limit_aggregates_check_soft.entity_id INTO rec;
  IF NOT (FOUND) OR rec.soft_max IS NULL THEN
    RETURN false;
  END IF;
  IF rec.soft_max >= 0 AND rec.num >= rec.soft_max THEN
    RETURN true;
  ELSE
    RETURN false;
  END IF;
  RETURN false;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE TABLE myapp_limits_public.org_limit_warnings ();

ALTER TABLE myapp_limits_public.org_limit_warnings 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_limits_public.org_limit_warnings IS 'Warning configuration for soft limits. Each row defines a warning threshold and the job task to enqueue when usage approaches it.';

ALTER TABLE myapp_limits_public.org_limit_warnings 
  ADD COLUMN id uuid;

ALTER TABLE myapp_limits_public.org_limit_warnings 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_limits_public.org_limit_warnings 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_limits_public.org_limit_warnings 
  ADD CONSTRAINT org_limit_warnings_pkey PRIMARY KEY (id);

ALTER TABLE myapp_limits_public.org_limit_warnings 
  ADD COLUMN name citext;

ALTER TABLE myapp_limits_public.org_limit_warnings 
  ALTER COLUMN name SET NOT NULL;

COMMENT ON COLUMN myapp_limits_public.org_limit_warnings.name IS 'Limit name this warning applies to (must match a default_limits entry)';

ALTER TABLE myapp_limits_public.org_limit_warnings 
  ADD COLUMN warning_type citext;

ALTER TABLE myapp_limits_public.org_limit_warnings 
  ALTER COLUMN warning_type SET NOT NULL;

COMMENT ON COLUMN myapp_limits_public.org_limit_warnings.warning_type IS 'Threshold type: absolute (fixed count) or percentage (of max)';

ALTER TABLE myapp_limits_public.org_limit_warnings 
  ADD COLUMN threshold_value bigint;

ALTER TABLE myapp_limits_public.org_limit_warnings 
  ALTER COLUMN threshold_value SET NOT NULL;

COMMENT ON COLUMN myapp_limits_public.org_limit_warnings.threshold_value IS 'Threshold value — either an absolute count or a percentage (1-100) depending on warning_type';

ALTER TABLE myapp_limits_public.org_limit_warnings 
  ADD COLUMN task_identifier text;

ALTER TABLE myapp_limits_public.org_limit_warnings 
  ALTER COLUMN task_identifier SET NOT NULL;

COMMENT ON COLUMN myapp_limits_public.org_limit_warnings.task_identifier IS 'Job task name to enqueue when warning fires (e.g. email:limit_warning, notification:approaching_limit)';

ALTER TABLE myapp_limits_public.org_limit_warnings 
  ADD COLUMN entity_id uuid;

COMMENT ON COLUMN myapp_limits_public.org_limit_warnings.entity_id IS 'Per-entity override (NULL = scope default for all entities)';

ALTER TABLE myapp_limits_public.org_limit_warnings 
  ADD CONSTRAINT org_limit_warnings_entity_id_fkey
    FOREIGN KEY(entity_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE CASCADE;

CREATE INDEX org_limit_warnings_entity_id_idx ON myapp_limits_public.org_limit_warnings (entity_id);

ALTER TABLE myapp_limits_public.org_limit_warnings 
  ADD CONSTRAINT org_limit_warnings_name_entity_id_key 
    UNIQUE (name, entity_id);

CREATE TABLE myapp_limits_private.org_limit_warning_state ();

ALTER TABLE myapp_limits_private.org_limit_warning_state 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_limits_private.org_limit_warning_state IS 'Tracks which warnings have been sent to avoid duplicate notifications. One row per warning config per actor.';

ALTER TABLE myapp_limits_private.org_limit_warning_state 
  ADD COLUMN id uuid;

ALTER TABLE myapp_limits_private.org_limit_warning_state 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_limits_private.org_limit_warning_state 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_limits_private.org_limit_warning_state 
  ADD CONSTRAINT org_limit_warning_states_pkey PRIMARY KEY (id);

ALTER TABLE myapp_limits_private.org_limit_warning_state 
  ADD COLUMN warning_id uuid;

ALTER TABLE myapp_limits_private.org_limit_warning_state 
  ALTER COLUMN warning_id SET NOT NULL;

COMMENT ON COLUMN myapp_limits_private.org_limit_warning_state.warning_id IS 'Reference to the limit_warnings config row that triggered this warning';

ALTER TABLE myapp_limits_private.org_limit_warning_state 
  ADD CONSTRAINT org_limit_warning_states_warning_id_fkey
    FOREIGN KEY(warning_id)
    REFERENCES myapp_limits_public.org_limit_warnings (id)
    ON DELETE CASCADE;

ALTER TABLE myapp_limits_private.org_limit_warning_state 
  ADD COLUMN actor_id uuid;

ALTER TABLE myapp_limits_private.org_limit_warning_state 
  ALTER COLUMN actor_id SET NOT NULL;

COMMENT ON COLUMN myapp_limits_private.org_limit_warning_state.actor_id IS 'User who was warned';

ALTER TABLE myapp_limits_private.org_limit_warning_state 
  ADD CONSTRAINT org_limit_warning_states_actor_id_fkey
    FOREIGN KEY(actor_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE CASCADE;

CREATE INDEX org_limit_warning_states_actor_id_idx ON myapp_limits_private.org_limit_warning_state (actor_id);

ALTER TABLE myapp_limits_private.org_limit_warning_state 
  ADD COLUMN warned_at timestamptz;

ALTER TABLE myapp_limits_private.org_limit_warning_state 
  ALTER COLUMN warned_at SET NOT NULL;

COMMENT ON COLUMN myapp_limits_private.org_limit_warning_state.warned_at IS 'Timestamp when the warning was sent';

ALTER TABLE myapp_limits_private.org_limit_warning_state 
  ADD COLUMN entity_id uuid;

COMMENT ON COLUMN myapp_limits_private.org_limit_warning_state.entity_id IS 'Entity context for org-scoped warnings';

ALTER TABLE myapp_limits_private.org_limit_warning_state 
  ADD CONSTRAINT org_limit_warning_states_entity_id_fkey
    FOREIGN KEY(entity_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE CASCADE;

CREATE INDEX org_limit_warning_states_entity_id_idx ON myapp_limits_private.org_limit_warning_state (entity_id);

ALTER TABLE myapp_limits_private.org_limit_warning_state 
  ADD CONSTRAINT org_limit_warning_states_warning_id_actor_id_entity_id_key 
    UNIQUE (warning_id, actor_id, entity_id);

CREATE FUNCTION myapp_limits_public.seed_org_limit_defaults(
  IN defaults jsonb
) RETURNS boolean AS $EOFCODE$
DECLARE
  v_item jsonb;
BEGIN
  IF seed_org_limit_defaults.defaults IS NULL THEN
    PERFORM errors.raise_error('SEED_LIMIT_DEFAULTS_REQUIRED');
  END IF;
  FOR v_item IN SELECT jsonb_array_elements(seed_org_limit_defaults.defaults) LOOP
    INSERT INTO myapp_limits_public.org_limit_defaults (
      name,
      max
    )
    VALUES
      ((v_item->>'name')::citext, (v_item->>'max')::bigint)
    ON CONFLICT ON CONSTRAINT org_limit_defaults_name_key DO UPDATE SET
    max = EXCLUDED.max;
  END LOOP;
  RETURN true;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE;

CREATE FUNCTION myapp_limits_public.seed_org_limit_caps_defaults(
  IN defaults jsonb
) RETURNS boolean AS $EOFCODE$
DECLARE
  v_item jsonb;
BEGIN
  IF seed_org_limit_caps_defaults.defaults IS NULL THEN
    PERFORM errors.raise_error('SEED_CAP_DEFAULTS_REQUIRED');
  END IF;
  FOR v_item IN SELECT jsonb_array_elements(seed_org_limit_caps_defaults.defaults) LOOP
    INSERT INTO myapp_limits_public.org_limit_caps_defaults (
      name,
      max
    )
    VALUES
      ((v_item->>'name')::citext, (v_item->>'max')::bigint)
    ON CONFLICT ON CONSTRAINT org_limit_caps_defaults_name_key DO UPDATE SET
    max = EXCLUDED.max;
  END LOOP;
  RETURN true;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE;

CREATE TABLE myapp_memberships_public.org_memberships ();

ALTER TABLE myapp_memberships_public.org_memberships 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_memberships_public.org_memberships IS 'Tracks membership records linking actors to entities with permission bitmasks, ownership, and admin status';

ALTER TABLE myapp_memberships_public.org_memberships 
  ADD COLUMN id uuid;

ALTER TABLE myapp_memberships_public.org_memberships 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_memberships_public.org_memberships 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_memberships_public.org_memberships 
  ADD CONSTRAINT org_memberships_pkey PRIMARY KEY (id);

ALTER TABLE myapp_memberships_public.org_memberships 
  ADD COLUMN created_at timestamptz;

ALTER TABLE myapp_memberships_public.org_memberships 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE myapp_memberships_public.org_memberships 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE myapp_memberships_public.org_memberships 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE TRIGGER timestamps_tg
  BEFORE INSERT OR UPDATE
  ON myapp_memberships_public.org_memberships
  FOR EACH ROW
  EXECUTE PROCEDURE stamps.timestamps();

CREATE INDEX org_memberships_created_at_idx ON myapp_memberships_public.org_memberships (created_at);

CREATE INDEX org_memberships_updated_at_idx ON myapp_memberships_public.org_memberships (updated_at);

ALTER TABLE myapp_memberships_public.org_memberships 
  ADD COLUMN created_by uuid;

ALTER TABLE myapp_memberships_public.org_memberships 
  ADD COLUMN updated_by uuid;

CREATE FUNCTION myapp_memberships_public.org_memberships_peoplestamps() RETURNS trigger AS $EOFCODE$
BEGIN
  IF TG_OP = 'INSERT' THEN
    SELECT jwt_public.current_user_id() INTO NEW.created_by;
    SELECT jwt_public.current_user_id() INTO NEW.updated_by;
  ELSIF TG_OP = 'UPDATE' THEN
    SELECT OLD.created_by INTO NEW.created_by;
    SELECT jwt_public.current_user_id() INTO NEW.updated_by;
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE;

CREATE TRIGGER peoplestamps_tg
  BEFORE INSERT OR UPDATE
  ON myapp_memberships_public.org_memberships
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_memberships_public.org_memberships_peoplestamps();

CREATE INDEX org_memberships_created_by_idx ON myapp_memberships_public.org_memberships (created_by);

CREATE INDEX org_memberships_updated_by_idx ON myapp_memberships_public.org_memberships (updated_by);

CREATE TABLE myapp_memberships_public.org_membership_defaults ();

ALTER TABLE myapp_memberships_public.org_membership_defaults 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_memberships_public.org_membership_defaults IS 'Default membership settings per entity, controlling initial approval and verification state for new members';

ALTER TABLE myapp_memberships_public.org_membership_defaults 
  ADD COLUMN id uuid;

ALTER TABLE myapp_memberships_public.org_membership_defaults 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_memberships_public.org_membership_defaults 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_memberships_public.org_membership_defaults 
  ADD CONSTRAINT org_membership_defaults_pkey PRIMARY KEY (id);

ALTER TABLE myapp_memberships_public.org_membership_defaults 
  ADD COLUMN created_at timestamptz;

ALTER TABLE myapp_memberships_public.org_membership_defaults 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE myapp_memberships_public.org_membership_defaults 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE myapp_memberships_public.org_membership_defaults 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE TRIGGER timestamps_tg
  BEFORE INSERT OR UPDATE
  ON myapp_memberships_public.org_membership_defaults
  FOR EACH ROW
  EXECUTE PROCEDURE stamps.timestamps();

CREATE INDEX org_membership_defaults_created_at_idx ON myapp_memberships_public.org_membership_defaults (created_at);

CREATE INDEX org_membership_defaults_updated_at_idx ON myapp_memberships_public.org_membership_defaults (updated_at);

ALTER TABLE myapp_memberships_public.org_membership_defaults 
  ADD COLUMN created_by uuid;

ALTER TABLE myapp_memberships_public.org_membership_defaults 
  ADD COLUMN updated_by uuid;

CREATE FUNCTION myapp_memberships_public.org_membership_defaults_peoplestamps() RETURNS trigger AS $EOFCODE$
BEGIN
  IF TG_OP = 'INSERT' THEN
    SELECT jwt_public.current_user_id() INTO NEW.created_by;
    SELECT jwt_public.current_user_id() INTO NEW.updated_by;
  ELSIF TG_OP = 'UPDATE' THEN
    SELECT OLD.created_by INTO NEW.created_by;
    SELECT jwt_public.current_user_id() INTO NEW.updated_by;
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE;

CREATE TRIGGER peoplestamps_tg
  BEFORE INSERT OR UPDATE
  ON myapp_memberships_public.org_membership_defaults
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_memberships_public.org_membership_defaults_peoplestamps();

CREATE INDEX org_membership_defaults_created_by_idx ON myapp_memberships_public.org_membership_defaults (created_by);

CREATE INDEX org_membership_defaults_updated_by_idx ON myapp_memberships_public.org_membership_defaults (updated_by);

CREATE TABLE myapp_memberships_private.org_memberships_sprt ();

ALTER TABLE myapp_memberships_private.org_memberships_sprt 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_memberships_private.org_memberships_sprt IS 'Security Predicate Resolution Table (SPRT). Denormalized lookup table used by RLS policies for fast permission checks without recursive queries';

ALTER TABLE myapp_memberships_private.org_memberships_sprt 
  ADD COLUMN is_owner boolean;

ALTER TABLE myapp_memberships_private.org_memberships_sprt 
  ALTER COLUMN is_owner SET NOT NULL;

ALTER TABLE myapp_memberships_private.org_memberships_sprt 
  ALTER COLUMN is_owner SET DEFAULT false;

COMMENT ON COLUMN myapp_memberships_private.org_memberships_sprt.is_owner IS 'Whether the actor is the owner of the entity';

ALTER TABLE myapp_memberships_private.org_memberships_sprt 
  ADD COLUMN is_admin boolean;

ALTER TABLE myapp_memberships_private.org_memberships_sprt 
  ALTER COLUMN is_admin SET NOT NULL;

ALTER TABLE myapp_memberships_private.org_memberships_sprt 
  ALTER COLUMN is_admin SET DEFAULT false;

COMMENT ON COLUMN myapp_memberships_private.org_memberships_sprt.is_admin IS 'Whether the actor has admin privileges on the entity';

ALTER TABLE myapp_memberships_private.org_memberships_sprt 
  ADD COLUMN permissions pg_catalog.bit(64);

ALTER TABLE myapp_memberships_private.org_memberships_sprt 
  ALTER COLUMN permissions SET NOT NULL;

ALTER TABLE myapp_memberships_private.org_memberships_sprt 
  ALTER COLUMN permissions SET DEFAULT CAST(lpad('', 64, '0') AS pg_catalog.bit(64));

COMMENT ON COLUMN myapp_memberships_private.org_memberships_sprt.permissions IS 'Resolved permission bitmask for this actor-entity pair, used by RLS policies for access control';

ALTER TABLE myapp_memberships_private.org_memberships_sprt 
  ADD COLUMN actor_id uuid;

ALTER TABLE myapp_memberships_private.org_memberships_sprt 
  ALTER COLUMN actor_id SET NOT NULL;

COMMENT ON COLUMN myapp_memberships_private.org_memberships_sprt.actor_id IS 'References the user whose permissions are being resolved';

ALTER TABLE myapp_memberships_private.org_memberships_sprt 
  ADD COLUMN entity_id uuid;

ALTER TABLE myapp_memberships_private.org_memberships_sprt 
  ALTER COLUMN entity_id SET NOT NULL;

COMMENT ON COLUMN myapp_memberships_private.org_memberships_sprt.entity_id IS 'References the entity (org or group) this permission resolution applies to';

ALTER TABLE myapp_memberships_private.org_memberships_sprt 
  ADD COLUMN is_read_only boolean;

ALTER TABLE myapp_memberships_private.org_memberships_sprt 
  ALTER COLUMN is_read_only SET NOT NULL;

ALTER TABLE myapp_memberships_private.org_memberships_sprt 
  ALTER COLUMN is_read_only SET DEFAULT false;

COMMENT ON COLUMN myapp_memberships_private.org_memberships_sprt.is_read_only IS 'Whether the actor has read-only access to this entity (blocks mutations when true)';

CREATE UNIQUE INDEX org_memberships_sprts_actor_id_entity_id_idx ON myapp_memberships_private.org_memberships_sprt (actor_id, entity_id) INCLUDE (permissions);

CREATE INDEX org_memberships_sprts_actor_id_idx ON myapp_memberships_private.org_memberships_sprt (actor_id) INCLUDE (permissions, is_owner, is_admin, is_read_only);

CREATE INDEX org_memberships_sprts_entity_id_idx ON myapp_memberships_private.org_memberships_sprt (entity_id) INCLUDE (permissions, is_owner, is_admin, is_read_only);

GRANT SELECT ON myapp_memberships_private.org_memberships_sprt TO PUBLIC;

ALTER TABLE myapp_memberships_public.org_membership_defaults 
  ADD COLUMN is_approved boolean;

ALTER TABLE myapp_memberships_public.org_membership_defaults 
  ALTER COLUMN is_approved SET NOT NULL;

ALTER TABLE myapp_memberships_public.org_membership_defaults 
  ALTER COLUMN is_approved SET DEFAULT true;

COMMENT ON COLUMN myapp_memberships_public.org_membership_defaults.is_approved IS 'Whether new members are automatically approved upon joining';

ALTER TABLE myapp_memberships_public.org_membership_defaults 
  ADD COLUMN entity_id uuid;

ALTER TABLE myapp_memberships_public.org_membership_defaults 
  ALTER COLUMN entity_id SET NOT NULL;

COMMENT ON COLUMN myapp_memberships_public.org_membership_defaults.entity_id IS 'References the entity these membership defaults apply to';

ALTER TABLE myapp_memberships_public.org_membership_defaults 
  ADD CONSTRAINT org_membership_defaults_entity_id_fkey
    FOREIGN KEY(entity_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE CASCADE;

ALTER TABLE myapp_memberships_public.org_membership_defaults 
  ADD CONSTRAINT org_membership_defaults_entity_id_key 
    UNIQUE (entity_id);

CREATE TABLE myapp_memberships_public.org_membership_settings ();

ALTER TABLE myapp_memberships_public.org_membership_settings 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_memberships_public.org_membership_settings IS 'Per-entity settings for the memberships module';

ALTER TABLE myapp_memberships_public.org_membership_settings 
  ADD COLUMN id uuid;

ALTER TABLE myapp_memberships_public.org_membership_settings 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_memberships_public.org_membership_settings 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_memberships_public.org_membership_settings 
  ADD CONSTRAINT org_membership_settings_pkey PRIMARY KEY (id);

ALTER TABLE myapp_memberships_public.org_membership_settings 
  ADD COLUMN created_at timestamptz;

ALTER TABLE myapp_memberships_public.org_membership_settings 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE myapp_memberships_public.org_membership_settings 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE myapp_memberships_public.org_membership_settings 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE TRIGGER timestamps_tg
  BEFORE INSERT OR UPDATE
  ON myapp_memberships_public.org_membership_settings
  FOR EACH ROW
  EXECUTE PROCEDURE stamps.timestamps();

CREATE INDEX org_membership_settings_created_at_idx ON myapp_memberships_public.org_membership_settings (created_at);

CREATE INDEX org_membership_settings_updated_at_idx ON myapp_memberships_public.org_membership_settings (updated_at);

ALTER TABLE myapp_memberships_public.org_membership_settings 
  ADD COLUMN created_by uuid;

ALTER TABLE myapp_memberships_public.org_membership_settings 
  ADD COLUMN updated_by uuid;

CREATE FUNCTION myapp_memberships_public.org_membership_settings_peoplestamps() RETURNS trigger AS $EOFCODE$
BEGIN
  IF TG_OP = 'INSERT' THEN
    SELECT jwt_public.current_user_id() INTO NEW.created_by;
    SELECT jwt_public.current_user_id() INTO NEW.updated_by;
  ELSIF TG_OP = 'UPDATE' THEN
    SELECT OLD.created_by INTO NEW.created_by;
    SELECT jwt_public.current_user_id() INTO NEW.updated_by;
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE;

CREATE TRIGGER peoplestamps_tg
  BEFORE INSERT OR UPDATE
  ON myapp_memberships_public.org_membership_settings
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_memberships_public.org_membership_settings_peoplestamps();

CREATE INDEX org_membership_settings_created_by_idx ON myapp_memberships_public.org_membership_settings (created_by);

CREATE INDEX org_membership_settings_updated_by_idx ON myapp_memberships_public.org_membership_settings (updated_by);

ALTER TABLE myapp_memberships_public.org_membership_settings 
  ADD COLUMN entity_id uuid;

ALTER TABLE myapp_memberships_public.org_membership_settings 
  ALTER COLUMN entity_id SET NOT NULL;

COMMENT ON COLUMN myapp_memberships_public.org_membership_settings.entity_id IS 'References the entity these settings apply to';

ALTER TABLE myapp_memberships_public.org_membership_settings 
  ADD CONSTRAINT org_membership_settings_entity_id_fkey
    FOREIGN KEY(entity_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE CASCADE;

ALTER TABLE myapp_memberships_public.org_membership_settings 
  ADD CONSTRAINT org_membership_settings_entity_id_key 
    UNIQUE (entity_id);

CREATE FUNCTION myapp_memberships_private.org_membership_settings_seed_fn() RETURNS trigger AS $EOFCODE$
BEGIN
  INSERT INTO myapp_memberships_public.org_membership_settings (
    entity_id
  )
  VALUES
    (NEW.id);
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE TRIGGER _00050_users_org_membership_settings_seed_trg
  AFTER INSERT
  ON myapp_users_public.users
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_memberships_private.org_membership_settings_seed_fn();

ALTER TABLE myapp_memberships_public.org_membership_settings 
  ADD COLUMN delete_member_cascade_children boolean;

ALTER TABLE myapp_memberships_public.org_membership_settings 
  ALTER COLUMN delete_member_cascade_children SET NOT NULL;

ALTER TABLE myapp_memberships_public.org_membership_settings 
  ALTER COLUMN delete_member_cascade_children SET DEFAULT false;

COMMENT ON COLUMN myapp_memberships_public.org_membership_settings.delete_member_cascade_children IS 'When a member is deleted, whether to cascade-remove their descendant-entity memberships';

ALTER TABLE myapp_memberships_public.org_membership_settings 
  ADD COLUMN create_child_cascade_owners boolean;

ALTER TABLE myapp_memberships_public.org_membership_settings 
  ALTER COLUMN create_child_cascade_owners SET NOT NULL;

ALTER TABLE myapp_memberships_public.org_membership_settings 
  ALTER COLUMN create_child_cascade_owners SET DEFAULT true;

COMMENT ON COLUMN myapp_memberships_public.org_membership_settings.create_child_cascade_owners IS 'When a child entity is created, whether to auto-add existing org-level owners as child-entity owners';

ALTER TABLE myapp_memberships_public.org_membership_settings 
  ADD COLUMN create_child_cascade_admins boolean;

ALTER TABLE myapp_memberships_public.org_membership_settings 
  ALTER COLUMN create_child_cascade_admins SET NOT NULL;

ALTER TABLE myapp_memberships_public.org_membership_settings 
  ALTER COLUMN create_child_cascade_admins SET DEFAULT true;

COMMENT ON COLUMN myapp_memberships_public.org_membership_settings.create_child_cascade_admins IS 'When a child entity is created, whether to auto-add existing org-level admins as child-entity admins';

ALTER TABLE myapp_memberships_public.org_membership_settings 
  ADD COLUMN create_child_cascade_members boolean;

ALTER TABLE myapp_memberships_public.org_membership_settings 
  ALTER COLUMN create_child_cascade_members SET NOT NULL;

ALTER TABLE myapp_memberships_public.org_membership_settings 
  ALTER COLUMN create_child_cascade_members SET DEFAULT false;

COMMENT ON COLUMN myapp_memberships_public.org_membership_settings.create_child_cascade_members IS 'When a child entity is created, whether to auto-add existing org-level members (non-admin, non-owner) as child-entity members';

ALTER TABLE myapp_memberships_public.org_membership_settings 
  ADD COLUMN allow_external_members boolean;

ALTER TABLE myapp_memberships_public.org_membership_settings 
  ALTER COLUMN allow_external_members SET NOT NULL;

ALTER TABLE myapp_memberships_public.org_membership_settings 
  ALTER COLUMN allow_external_members SET DEFAULT true;

COMMENT ON COLUMN myapp_memberships_public.org_membership_settings.allow_external_members IS 'Whether descendants of this org may admit members who are not already org members (outside-collaborators toggle)';

ALTER TABLE myapp_memberships_public.org_membership_settings 
  ADD COLUMN invite_profile_assignment_mode text;

ALTER TABLE myapp_memberships_public.org_membership_settings 
  ALTER COLUMN invite_profile_assignment_mode SET NOT NULL;

ALTER TABLE myapp_memberships_public.org_membership_settings 
  ALTER COLUMN invite_profile_assignment_mode SET DEFAULT 'strict';

COMMENT ON COLUMN myapp_memberships_public.org_membership_settings.invite_profile_assignment_mode IS 'Controls how profile assignment on invites is validated: strict (permission + subset check), permission_only (permission only), or subset_only (subset check only)';

ALTER TABLE myapp_memberships_public.org_membership_settings 
  ADD COLUMN populate_member_email boolean;

ALTER TABLE myapp_memberships_public.org_membership_settings 
  ALTER COLUMN populate_member_email SET NOT NULL;

ALTER TABLE myapp_memberships_public.org_membership_settings 
  ALTER COLUMN populate_member_email SET DEFAULT true;

COMMENT ON COLUMN myapp_memberships_public.org_membership_settings.populate_member_email IS 'Whether member_profiles.email is snapshot on join and kept synced with the user''s primary email. When FALSE, the email field is left blank and never synced from the user''s primary email.';

ALTER TABLE myapp_memberships_public.org_memberships 
  ADD COLUMN is_approved boolean;

ALTER TABLE myapp_memberships_public.org_memberships 
  ALTER COLUMN is_approved SET NOT NULL;

ALTER TABLE myapp_memberships_public.org_memberships 
  ALTER COLUMN is_approved SET DEFAULT false;

COMMENT ON COLUMN myapp_memberships_public.org_memberships.is_approved IS 'Whether this membership has been approved by an admin';

ALTER TABLE myapp_memberships_public.org_memberships 
  ADD COLUMN is_banned boolean;

ALTER TABLE myapp_memberships_public.org_memberships 
  ALTER COLUMN is_banned SET NOT NULL;

ALTER TABLE myapp_memberships_public.org_memberships 
  ALTER COLUMN is_banned SET DEFAULT false;

COMMENT ON COLUMN myapp_memberships_public.org_memberships.is_banned IS 'Whether this member has been banned from the entity';

ALTER TABLE myapp_memberships_public.org_memberships 
  ADD COLUMN is_disabled boolean;

ALTER TABLE myapp_memberships_public.org_memberships 
  ALTER COLUMN is_disabled SET NOT NULL;

ALTER TABLE myapp_memberships_public.org_memberships 
  ALTER COLUMN is_disabled SET DEFAULT false;

COMMENT ON COLUMN myapp_memberships_public.org_memberships.is_disabled IS 'Whether this membership is temporarily disabled';

ALTER TABLE myapp_memberships_public.org_memberships 
  ADD COLUMN is_active boolean;

ALTER TABLE myapp_memberships_public.org_memberships 
  ALTER COLUMN is_active SET NOT NULL;

ALTER TABLE myapp_memberships_public.org_memberships 
  ALTER COLUMN is_active SET DEFAULT false;

COMMENT ON COLUMN myapp_memberships_public.org_memberships.is_active IS 'Computed field indicating the membership is approved, verified, not banned, and not disabled';

ALTER TABLE myapp_memberships_public.org_memberships 
  ADD COLUMN is_external boolean;

ALTER TABLE myapp_memberships_public.org_memberships 
  ALTER COLUMN is_external SET NOT NULL;

ALTER TABLE myapp_memberships_public.org_memberships 
  ALTER COLUMN is_external SET DEFAULT false;

COMMENT ON COLUMN myapp_memberships_public.org_memberships.is_external IS 'Whether this member is external (not a member of the parent scope). External members may have restricted permissions.';

ALTER TABLE myapp_memberships_public.org_memberships 
  ADD COLUMN is_owner boolean;

ALTER TABLE myapp_memberships_public.org_memberships 
  ALTER COLUMN is_owner SET NOT NULL;

ALTER TABLE myapp_memberships_public.org_memberships 
  ALTER COLUMN is_owner SET DEFAULT false;

COMMENT ON COLUMN myapp_memberships_public.org_memberships.is_owner IS 'Whether the actor is the owner of this entity';

ALTER TABLE myapp_memberships_public.org_memberships 
  ADD COLUMN is_admin boolean;

ALTER TABLE myapp_memberships_public.org_memberships 
  ALTER COLUMN is_admin SET NOT NULL;

ALTER TABLE myapp_memberships_public.org_memberships 
  ALTER COLUMN is_admin SET DEFAULT false;

COMMENT ON COLUMN myapp_memberships_public.org_memberships.is_admin IS 'Whether the actor has admin privileges on this entity';

ALTER TABLE myapp_memberships_public.org_memberships 
  ADD COLUMN permissions pg_catalog.bit(64);

ALTER TABLE myapp_memberships_public.org_memberships 
  ALTER COLUMN permissions SET NOT NULL;

ALTER TABLE myapp_memberships_public.org_memberships 
  ALTER COLUMN permissions SET DEFAULT CAST(lpad('', 64, '0') AS pg_catalog.bit(64));

COMMENT ON COLUMN myapp_memberships_public.org_memberships.permissions IS 'Aggregated permission bitmask combining profile-based and directly granted permissions';

ALTER TABLE myapp_memberships_public.org_memberships 
  ADD COLUMN granted pg_catalog.bit(64);

ALTER TABLE myapp_memberships_public.org_memberships 
  ALTER COLUMN granted SET NOT NULL;

ALTER TABLE myapp_memberships_public.org_memberships 
  ALTER COLUMN granted SET DEFAULT CAST(lpad('', 64, '0') AS pg_catalog.bit(64));

COMMENT ON COLUMN myapp_memberships_public.org_memberships.granted IS 'Bitmask of permissions directly granted to this member (not from profiles)';

ALTER TABLE myapp_memberships_public.org_memberships 
  ADD COLUMN actor_id uuid;

ALTER TABLE myapp_memberships_public.org_memberships 
  ALTER COLUMN actor_id SET NOT NULL;

COMMENT ON COLUMN myapp_memberships_public.org_memberships.actor_id IS 'References the user who holds this membership';

ALTER TABLE myapp_memberships_public.org_memberships 
  ADD CONSTRAINT org_memberships_actor_id_fkey
    FOREIGN KEY(actor_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE CASCADE;

ALTER TABLE myapp_memberships_public.org_memberships 
  ADD COLUMN entity_id uuid;

ALTER TABLE myapp_memberships_public.org_memberships 
  ALTER COLUMN entity_id SET NOT NULL;

COMMENT ON COLUMN myapp_memberships_public.org_memberships.entity_id IS 'References the entity (org or group) this membership belongs to';

ALTER TABLE myapp_memberships_public.org_memberships 
  ADD CONSTRAINT org_memberships_entity_id_fkey
    FOREIGN KEY(entity_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE CASCADE;

ALTER TABLE myapp_memberships_public.org_memberships 
  ADD CONSTRAINT org_memberships_actor_id_entity_id_key 
    UNIQUE (actor_id, entity_id);

CREATE INDEX org_memberships_actor_id_idx ON myapp_memberships_public.org_memberships (actor_id);

CREATE INDEX org_memberships_entity_id_idx ON myapp_memberships_public.org_memberships (entity_id);

ALTER TABLE myapp_memberships_public.org_memberships 
  ADD COLUMN is_read_only boolean;

ALTER TABLE myapp_memberships_public.org_memberships 
  ALTER COLUMN is_read_only SET NOT NULL;

ALTER TABLE myapp_memberships_public.org_memberships 
  ALTER COLUMN is_read_only SET DEFAULT false;

COMMENT ON COLUMN myapp_memberships_public.org_memberships.is_read_only IS 'Whether this member has read-only access (blocks mutations when true)';

CREATE TABLE myapp_memberships_public.org_members ();

ALTER TABLE myapp_memberships_public.org_members 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_memberships_public.org_members IS 'Simplified view of active members in an entity, used for listing who belongs to an org or group';

ALTER TABLE myapp_memberships_public.org_members 
  ADD COLUMN id uuid;

ALTER TABLE myapp_memberships_public.org_members 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_memberships_public.org_members 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_memberships_public.org_members 
  ADD CONSTRAINT org_members_pkey PRIMARY KEY (id);

ALTER TABLE myapp_memberships_public.org_members 
  ADD COLUMN is_admin boolean;

ALTER TABLE myapp_memberships_public.org_members 
  ALTER COLUMN is_admin SET NOT NULL;

ALTER TABLE myapp_memberships_public.org_members 
  ALTER COLUMN is_admin SET DEFAULT false;

COMMENT ON COLUMN myapp_memberships_public.org_members.is_admin IS 'Whether this member has admin privileges';

ALTER TABLE myapp_memberships_public.org_members 
  ADD COLUMN actor_id uuid;

ALTER TABLE myapp_memberships_public.org_members 
  ALTER COLUMN actor_id SET NOT NULL;

COMMENT ON COLUMN myapp_memberships_public.org_members.actor_id IS 'References the user who is a member';

ALTER TABLE myapp_memberships_public.org_members 
  ADD CONSTRAINT org_members_actor_id_fkey
    FOREIGN KEY(actor_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE CASCADE;

ALTER TABLE myapp_memberships_public.org_members 
  ADD COLUMN entity_id uuid;

ALTER TABLE myapp_memberships_public.org_members 
  ALTER COLUMN entity_id SET NOT NULL;

COMMENT ON COLUMN myapp_memberships_public.org_members.entity_id IS 'References the entity (org or group) this member belongs to';

ALTER TABLE myapp_memberships_public.org_members 
  ADD CONSTRAINT org_members_entity_id_fkey
    FOREIGN KEY(entity_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE CASCADE;

ALTER TABLE myapp_memberships_public.org_members 
  ADD CONSTRAINT org_members_actor_id_entity_id_key 
    UNIQUE (actor_id, entity_id);

CREATE INDEX org_members_actor_id_idx ON myapp_memberships_public.org_members (actor_id);

CREATE INDEX org_members_entity_id_idx ON myapp_memberships_public.org_members (entity_id);

CREATE FUNCTION myapp_memberships_private.org_memberships_insert_sprt_tg() RETURNS trigger AS $EOFCODE$
DECLARE
  has_active_parent boolean;
BEGIN
  IF NEW.is_owner IS true THEN
    new.is_admin := true;
    new.is_approved := true;
    new.is_disabled := false;
    new.is_banned := false;
    new.is_read_only := false;
  END IF;
  new.is_active := (NEW.is_approved IS true AND NEW.is_disabled IS false) AND NEW.is_banned IS false;
  IF NEW.is_active IS TRUE THEN
    SELECT
      EXISTS (SELECT 1
      FROM myapp_memberships_private.app_memberships_sprt
      WHERE
        actor_id = NEW.actor_id) INTO has_active_parent;
    IF has_active_parent IS TRUE THEN
      INSERT INTO myapp_memberships_private.org_memberships_sprt (
        is_owner,
        is_admin,
        permissions,
        actor_id,
        entity_id,
        is_read_only
      )
      VALUES
        (NEW.is_owner, NEW.is_admin, CASE 
            WHEN (NEW.is_owner IS TRUE OR NEW.is_admin IS TRUE) AND (NEW.permissions IS NULL OR NEW.permissions = (lpad('', (bit_length(NEW.permissions))::int, '0'))::pg_catalog.varbit) THEN (lpad('', (bit_length(NEW.permissions))::int, '1'))::pg_catalog.varbit 
            ELSE NEW.permissions 
          END, NEW.actor_id, NEW.entity_id, NEW.is_read_only);
      INSERT INTO myapp_memberships_public.org_members (
        is_admin,
        actor_id,
        entity_id
      )
      VALUES
        (NEW.is_admin, NEW.actor_id, NEW.entity_id);
    END IF;
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION myapp_memberships_private.org_memberships_update_sprt_tg() RETURNS trigger AS $EOFCODE$
DECLARE
  v_num_updated int;
  has_active_parent boolean;
BEGIN
  IF NEW.is_owner IS true THEN
    new.is_admin := true;
    new.is_approved := true;
    new.is_disabled := false;
    new.is_banned := false;
    new.is_read_only := false;
  END IF;
  new.is_active := (NEW.is_approved IS true AND NEW.is_disabled IS false) AND NEW.is_banned IS false;
  IF NEW.is_active IS FALSE THEN
    DELETE FROM myapp_memberships_private.org_memberships_sprt
    WHERE
      actor_id = NEW.actor_id AND entity_id = NEW.entity_id;
    DELETE FROM myapp_memberships_public.org_members
    WHERE
      actor_id = NEW.actor_id AND entity_id = NEW.entity_id;
  ELSE
    SELECT
      EXISTS (SELECT 1
      FROM myapp_memberships_private.app_memberships_sprt
      WHERE
        actor_id = NEW.actor_id) INTO has_active_parent;
    IF has_active_parent IS TRUE THEN
      INSERT INTO myapp_memberships_private.org_memberships_sprt (
        is_owner,
        is_admin,
        permissions,
        actor_id,
        entity_id,
        is_read_only
      )
      VALUES
        (NEW.is_owner, NEW.is_admin, CASE 
            WHEN (NEW.is_owner IS TRUE OR NEW.is_admin IS TRUE) AND (NEW.permissions IS NULL OR NEW.permissions = (lpad('', (bit_length(NEW.permissions))::int, '0'))::pg_catalog.varbit) THEN (lpad('', (bit_length(NEW.permissions))::int, '1'))::pg_catalog.varbit 
            ELSE NEW.permissions 
          END, NEW.actor_id, NEW.entity_id, NEW.is_read_only)
      ON CONFLICT (actor_id, entity_id) DO UPDATE SET
      is_owner = EXCLUDED.is_owner, is_admin = EXCLUDED.is_admin, permissions = EXCLUDED.permissions, is_read_only = EXCLUDED.is_read_only;
      INSERT INTO myapp_memberships_public.org_members (
        is_admin,
        actor_id,
        entity_id
      )
      VALUES
        (NEW.is_admin, NEW.actor_id, NEW.entity_id)
      ON CONFLICT (actor_id, entity_id) DO NOTHING;
    ELSE
      DELETE FROM myapp_memberships_private.org_memberships_sprt
      WHERE
        actor_id = NEW.actor_id AND entity_id = NEW.entity_id;
      DELETE FROM myapp_memberships_public.org_members
      WHERE
        actor_id = NEW.actor_id AND entity_id = NEW.entity_id;
    END IF;
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION myapp_memberships_private.org_memberships_delete_sprt_tg() RETURNS trigger AS $EOFCODE$
DECLARE
  v_num_updated int;
BEGIN
  DELETE FROM myapp_memberships_private.org_memberships_sprt
  WHERE
    actor_id = OLD.actor_id AND entity_id = OLD.entity_id;
  DELETE FROM myapp_memberships_public.org_members
  WHERE
    actor_id = OLD.actor_id AND entity_id = OLD.entity_id;
  RETURN OLD;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION myapp_memberships_private.app_memberships_sprt_to_org_memberships_sprt_tg() RETURNS trigger AS $EOFCODE$
BEGIN
  IF TG_OP = 'DELETE' THEN
    BEGIN
      DELETE FROM myapp_memberships_private.org_memberships_sprt
      WHERE
        actor_id = OLD.actor_id;
      DELETE FROM myapp_memberships_public.org_members
      WHERE
        actor_id = OLD.actor_id;
    EXCEPTION
      WHEN undefined_table THEN
        SELECT NULL;
    END;
    RETURN OLD;
  END IF;
  IF TG_OP = 'UPDATE' THEN
    BEGIN
      DELETE FROM myapp_memberships_private.org_memberships_sprt
      WHERE
        actor_id = OLD.actor_id;
      DELETE FROM myapp_memberships_public.org_members
      WHERE
        actor_id = OLD.actor_id;
      INSERT INTO myapp_memberships_private.org_memberships_sprt (
        is_owner,
        is_admin,
        permissions,
        actor_id,
        entity_id,
        is_read_only
      )
      SELECT
        m.is_owner,
        m.is_admin,
        m.permissions,
        m.actor_id,
        m.entity_id,
        m.is_read_only
      FROM myapp_memberships_public.org_memberships AS m
      WHERE
        m.actor_id = NEW.actor_id AND m.is_active IS TRUE
      ON CONFLICT (actor_id, entity_id) DO UPDATE SET
      is_owner = EXCLUDED.is_owner, is_admin = EXCLUDED.is_admin, permissions = EXCLUDED.permissions, is_read_only = EXCLUDED.is_read_only;
      INSERT INTO myapp_memberships_public.org_members (
        is_admin,
        actor_id,
        entity_id
      )
      SELECT
        m.is_admin,
        m.actor_id,
        m.entity_id
      FROM myapp_memberships_public.org_memberships AS m
      WHERE
        m.actor_id = NEW.actor_id AND m.is_active IS TRUE
      ON CONFLICT (actor_id, entity_id) DO NOTHING;
    EXCEPTION
      WHEN undefined_table THEN
        SELECT NULL;
    END;
    RETURN NEW;
  END IF;
  IF TG_OP = 'INSERT' THEN
    BEGIN
      INSERT INTO myapp_memberships_private.org_memberships_sprt (
        is_owner,
        is_admin,
        permissions,
        actor_id,
        entity_id,
        is_read_only
      )
      SELECT
        m.is_owner,
        m.is_admin,
        m.permissions,
        m.actor_id,
        m.entity_id,
        m.is_read_only
      FROM myapp_memberships_public.org_memberships AS m
      WHERE
        m.actor_id = NEW.actor_id AND m.is_active IS TRUE
      ON CONFLICT (actor_id, entity_id) DO UPDATE SET
      is_owner = EXCLUDED.is_owner, is_admin = EXCLUDED.is_admin, permissions = EXCLUDED.permissions, is_read_only = EXCLUDED.is_read_only;
      INSERT INTO myapp_memberships_public.org_members (
        is_admin,
        actor_id,
        entity_id
      )
      SELECT
        m.is_admin,
        m.actor_id,
        m.entity_id
      FROM myapp_memberships_public.org_memberships AS m
      WHERE
        m.actor_id = NEW.actor_id AND m.is_active IS TRUE
      ON CONFLICT (actor_id, entity_id) DO NOTHING;
    EXCEPTION
      WHEN undefined_table THEN
        SELECT NULL;
    END;
    RETURN NEW;
  END IF;
  RETURN NULL;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE TRIGGER _00030_app_memberships_sprt_to_org_memberships_sprt
  AFTER INSERT OR DELETE OR UPDATE
  ON myapp_memberships_private.app_memberships_sprt
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_memberships_private.app_memberships_sprt_to_org_memberships_sprt_tg();

CREATE FUNCTION myapp_memberships_private.org_memberships_perm_check(
  perm text,
  entity_id uuid,
  actor_id uuid DEFAULT jwt_public.current_user_id()
) RETURNS boolean AS $EOFCODE$
SELECT
  EXISTS (SELECT 1
  FROM myapp_memberships_public.org_memberships AS m, myapp_permissions_public.org_permissions AS p
  WHERE
    ((p.name = perm AND (m.permissions & p.bitstr) = p.bitstr) AND m.entity_id = org_memberships_perm_check.entity_id) AND m.actor_id = org_memberships_perm_check.actor_id)
$EOFCODE$ LANGUAGE sql STABLE SECURITY DEFINER;

CREATE FUNCTION myapp_memberships_private.org_memberships_mask_check(
  mask pg_catalog.varbit,
  entity_id uuid,
  actor_id uuid DEFAULT jwt_public.current_user_id()
) RETURNS boolean AS $EOFCODE$
SELECT
  EXISTS (SELECT 1
  FROM myapp_memberships_public.org_memberships AS m
  WHERE
    ((m.permissions & mask) = mask AND m.entity_id = org_memberships_mask_check.entity_id) AND m.actor_id = org_memberships_mask_check.actor_id)
$EOFCODE$ LANGUAGE sql STABLE SECURITY DEFINER;

CREATE FUNCTION myapp_memberships_private.org_memberships_perm_ids(
  IN perm text
) RETURNS uuid[] AS $EOFCODE$
SELECT array_agg(m.entity_id)
FROM myapp_memberships_public.org_memberships AS m, myapp_permissions_public.org_permissions AS p
WHERE
  (p.name = perm AND (m.permissions & p.bitstr) = p.bitstr) AND m.actor_id = jwt_public.current_user_id()
$EOFCODE$ LANGUAGE sql STABLE SECURITY DEFINER;

CREATE FUNCTION myapp_memberships_private.org_memberships_mask_ids(
  IN mask pg_catalog.bit(64)
) RETURNS uuid[] AS $EOFCODE$
SELECT array_agg(m.entity_id)
FROM myapp_memberships_public.org_memberships AS m
WHERE
  (m.permissions & mask) = mask AND m.actor_id = jwt_public.current_user_id()
$EOFCODE$ LANGUAGE sql STABLE SECURITY DEFINER;

CREATE FUNCTION myapp_memberships_private.org_memberships_ids() RETURNS uuid[] AS $EOFCODE$
SELECT array_agg(m.entity_id)
FROM myapp_memberships_public.org_memberships AS m
WHERE
  m.actor_id = jwt_public.current_user_id()
$EOFCODE$ LANGUAGE sql STABLE SECURITY DEFINER;

CREATE TABLE myapp_memberships_public.org_admin_grants ();

ALTER TABLE myapp_memberships_public.org_admin_grants 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_memberships_public.org_admin_grants IS 'Records of admin role grants and revocations between members';

ALTER TABLE myapp_memberships_public.org_admin_grants 
  ADD COLUMN id uuid;

ALTER TABLE myapp_memberships_public.org_admin_grants 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_memberships_public.org_admin_grants 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_memberships_public.org_admin_grants 
  ADD CONSTRAINT org_admin_grants_pkey PRIMARY KEY (id);

ALTER TABLE myapp_memberships_public.org_admin_grants 
  ADD COLUMN is_grant boolean;

ALTER TABLE myapp_memberships_public.org_admin_grants 
  ALTER COLUMN is_grant SET NOT NULL;

ALTER TABLE myapp_memberships_public.org_admin_grants 
  ALTER COLUMN is_grant SET DEFAULT true;

COMMENT ON COLUMN myapp_memberships_public.org_admin_grants.is_grant IS 'True to grant admin, false to revoke admin';

ALTER TABLE myapp_memberships_public.org_admin_grants 
  ADD COLUMN actor_id uuid;

COMMENT ON COLUMN myapp_memberships_public.org_admin_grants.actor_id IS 'The member receiving or losing the admin grant; NULL if user was deleted';

ALTER TABLE myapp_memberships_public.org_admin_grants 
  ADD CONSTRAINT org_admin_grants_actor_id_fkey
    FOREIGN KEY(actor_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE SET NULL;

CREATE INDEX org_admin_grants_actor_id_idx ON myapp_memberships_public.org_admin_grants (actor_id);

ALTER TABLE myapp_memberships_public.org_admin_grants 
  ADD COLUMN entity_id uuid;

ALTER TABLE myapp_memberships_public.org_admin_grants 
  ALTER COLUMN entity_id SET NOT NULL;

COMMENT ON COLUMN myapp_memberships_public.org_admin_grants.entity_id IS 'The entity (org or group) this admin grant applies to';

ALTER TABLE myapp_memberships_public.org_admin_grants 
  ADD CONSTRAINT org_admin_grants_entity_id_fkey
    FOREIGN KEY(entity_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE CASCADE;

CREATE INDEX org_admin_grants_entity_id_idx ON myapp_memberships_public.org_admin_grants (entity_id);

ALTER TABLE myapp_memberships_public.org_admin_grants 
  ADD COLUMN grantor_id uuid;

ALTER TABLE myapp_memberships_public.org_admin_grants 
  ALTER COLUMN grantor_id SET DEFAULT jwt_public.current_user_id();

ALTER TABLE myapp_memberships_public.org_admin_grants 
  ADD CONSTRAINT org_admin_grants_grantor_id_fkey
    FOREIGN KEY(grantor_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE SET NULL;

CREATE INDEX org_admin_grants_grantor_id_idx ON myapp_memberships_public.org_admin_grants (grantor_id);

ALTER TABLE myapp_memberships_public.org_admin_grants 
  ADD COLUMN created_at timestamptz;

ALTER TABLE myapp_memberships_public.org_admin_grants 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE myapp_memberships_public.org_admin_grants 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE myapp_memberships_public.org_admin_grants 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE TRIGGER timestamps_tg
  BEFORE INSERT OR UPDATE
  ON myapp_memberships_public.org_admin_grants
  FOR EACH ROW
  EXECUTE PROCEDURE stamps.timestamps();

CREATE INDEX org_admin_grants_created_at_idx ON myapp_memberships_public.org_admin_grants (created_at);

CREATE INDEX org_admin_grants_updated_at_idx ON myapp_memberships_public.org_admin_grants (updated_at);

CREATE TABLE myapp_memberships_public.org_owner_grants ();

ALTER TABLE myapp_memberships_public.org_owner_grants 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_memberships_public.org_owner_grants IS 'Records of ownership transfers and grants between members';

ALTER TABLE myapp_memberships_public.org_owner_grants 
  ADD COLUMN id uuid;

ALTER TABLE myapp_memberships_public.org_owner_grants 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_memberships_public.org_owner_grants 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_memberships_public.org_owner_grants 
  ADD CONSTRAINT org_owner_grants_pkey PRIMARY KEY (id);

ALTER TABLE myapp_memberships_public.org_owner_grants 
  ADD COLUMN is_grant boolean;

ALTER TABLE myapp_memberships_public.org_owner_grants 
  ALTER COLUMN is_grant SET NOT NULL;

ALTER TABLE myapp_memberships_public.org_owner_grants 
  ALTER COLUMN is_grant SET DEFAULT true;

COMMENT ON COLUMN myapp_memberships_public.org_owner_grants.is_grant IS 'True to grant ownership, false to revoke ownership';

ALTER TABLE myapp_memberships_public.org_owner_grants 
  ADD COLUMN actor_id uuid;

COMMENT ON COLUMN myapp_memberships_public.org_owner_grants.actor_id IS 'The member receiving or losing the ownership grant; NULL if user was deleted';

ALTER TABLE myapp_memberships_public.org_owner_grants 
  ADD CONSTRAINT org_owner_grants_actor_id_fkey
    FOREIGN KEY(actor_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE SET NULL;

CREATE INDEX org_owner_grants_actor_id_idx ON myapp_memberships_public.org_owner_grants (actor_id);

ALTER TABLE myapp_memberships_public.org_owner_grants 
  ADD COLUMN entity_id uuid;

ALTER TABLE myapp_memberships_public.org_owner_grants 
  ALTER COLUMN entity_id SET NOT NULL;

COMMENT ON COLUMN myapp_memberships_public.org_owner_grants.entity_id IS 'The entity (org or group) this ownership grant applies to';

ALTER TABLE myapp_memberships_public.org_owner_grants 
  ADD CONSTRAINT org_owner_grants_entity_id_fkey
    FOREIGN KEY(entity_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE CASCADE;

CREATE INDEX org_owner_grants_entity_id_idx ON myapp_memberships_public.org_owner_grants (entity_id);

ALTER TABLE myapp_memberships_public.org_owner_grants 
  ADD COLUMN grantor_id uuid;

ALTER TABLE myapp_memberships_public.org_owner_grants 
  ALTER COLUMN grantor_id SET DEFAULT jwt_public.current_user_id();

ALTER TABLE myapp_memberships_public.org_owner_grants 
  ADD CONSTRAINT org_owner_grants_grantor_id_fkey
    FOREIGN KEY(grantor_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE SET NULL;

CREATE INDEX org_owner_grants_grantor_id_idx ON myapp_memberships_public.org_owner_grants (grantor_id);

ALTER TABLE myapp_memberships_public.org_owner_grants 
  ADD COLUMN created_at timestamptz;

ALTER TABLE myapp_memberships_public.org_owner_grants 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE myapp_memberships_public.org_owner_grants 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE myapp_memberships_public.org_owner_grants 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE TRIGGER timestamps_tg
  BEFORE INSERT OR UPDATE
  ON myapp_memberships_public.org_owner_grants
  FOR EACH ROW
  EXECUTE PROCEDURE stamps.timestamps();

CREATE INDEX org_owner_grants_created_at_idx ON myapp_memberships_public.org_owner_grants (created_at);

CREATE INDEX org_owner_grants_updated_at_idx ON myapp_memberships_public.org_owner_grants (updated_at);

CREATE TABLE myapp_memberships_public.org_member_profiles ();

ALTER TABLE myapp_memberships_public.org_member_profiles 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_memberships_public.org_member_profiles IS 'Per-membership profile information visible to other entity members (display name, email, title, bio, avatar)';

ALTER TABLE myapp_memberships_public.org_member_profiles 
  ADD COLUMN id uuid;

ALTER TABLE myapp_memberships_public.org_member_profiles 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_memberships_public.org_member_profiles 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_memberships_public.org_member_profiles 
  ADD CONSTRAINT org_member_profiles_pkey PRIMARY KEY (id);

ALTER TABLE myapp_memberships_public.org_member_profiles 
  ADD COLUMN created_at timestamptz;

ALTER TABLE myapp_memberships_public.org_member_profiles 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE myapp_memberships_public.org_member_profiles 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE myapp_memberships_public.org_member_profiles 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE TRIGGER timestamps_tg
  BEFORE INSERT OR UPDATE
  ON myapp_memberships_public.org_member_profiles
  FOR EACH ROW
  EXECUTE PROCEDURE stamps.timestamps();

CREATE INDEX org_member_profiles_created_at_idx ON myapp_memberships_public.org_member_profiles (created_at);

CREATE INDEX org_member_profiles_updated_at_idx ON myapp_memberships_public.org_member_profiles (updated_at);

ALTER TABLE myapp_memberships_public.org_member_profiles 
  ADD COLUMN membership_id uuid;

ALTER TABLE myapp_memberships_public.org_member_profiles 
  ALTER COLUMN membership_id SET NOT NULL;

COMMENT ON COLUMN myapp_memberships_public.org_member_profiles.membership_id IS 'References the membership this profile belongs to (1:1)';

ALTER TABLE myapp_memberships_public.org_member_profiles 
  ADD CONSTRAINT org_member_profiles_membership_id_fkey
    FOREIGN KEY(membership_id)
    REFERENCES myapp_memberships_public.org_memberships (id)
    ON DELETE CASCADE;

ALTER TABLE myapp_memberships_public.org_member_profiles 
  ADD CONSTRAINT org_member_profiles_membership_id_key 
    UNIQUE (membership_id);

ALTER TABLE myapp_memberships_public.org_member_profiles 
  ADD COLUMN entity_id uuid;

ALTER TABLE myapp_memberships_public.org_member_profiles 
  ALTER COLUMN entity_id SET NOT NULL;

COMMENT ON COLUMN myapp_memberships_public.org_member_profiles.entity_id IS 'References the entity this profile belongs to (used for RLS lookups)';

ALTER TABLE myapp_memberships_public.org_member_profiles 
  ADD CONSTRAINT org_member_profiles_entity_id_fkey
    FOREIGN KEY(entity_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE CASCADE;

CREATE INDEX org_member_profiles_entity_id_idx ON myapp_memberships_public.org_member_profiles (entity_id);

ALTER TABLE myapp_memberships_public.org_member_profiles 
  ADD COLUMN actor_id uuid;

ALTER TABLE myapp_memberships_public.org_member_profiles 
  ALTER COLUMN actor_id SET NOT NULL;

COMMENT ON COLUMN myapp_memberships_public.org_member_profiles.actor_id IS 'References the user who owns this profile (for self-edit RLS)';

ALTER TABLE myapp_memberships_public.org_member_profiles 
  ADD CONSTRAINT org_member_profiles_actor_id_fkey
    FOREIGN KEY(actor_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE CASCADE;

CREATE INDEX org_member_profiles_actor_id_idx ON myapp_memberships_public.org_member_profiles (actor_id);

ALTER TABLE myapp_memberships_public.org_member_profiles 
  ADD COLUMN display_name text;

ALTER TABLE myapp_memberships_public.org_member_profiles 
  ALTER COLUMN display_name SET DEFAULT '';

COMMENT ON COLUMN myapp_memberships_public.org_member_profiles.display_name IS 'Display name shown to other entity members';

ALTER TABLE myapp_memberships_public.org_member_profiles 
  ADD COLUMN email text;

ALTER TABLE myapp_memberships_public.org_member_profiles 
  ALTER COLUMN email SET DEFAULT '';

COMMENT ON COLUMN myapp_memberships_public.org_member_profiles.email IS 'Email address visible to other entity members (auto-populated from verified primary email)';

ALTER TABLE myapp_memberships_public.org_member_profiles 
  ADD COLUMN title text;

ALTER TABLE myapp_memberships_public.org_member_profiles 
  ALTER COLUMN title SET DEFAULT '';

COMMENT ON COLUMN myapp_memberships_public.org_member_profiles.title IS 'Job title or role description visible to other entity members';

ALTER TABLE myapp_memberships_public.org_member_profiles 
  ADD COLUMN bio text;

ALTER TABLE myapp_memberships_public.org_member_profiles 
  ALTER COLUMN bio SET DEFAULT '';

COMMENT ON COLUMN myapp_memberships_public.org_member_profiles.bio IS 'Short biography visible to other entity members';

ALTER TABLE myapp_memberships_public.org_member_profiles 
  ADD COLUMN profile_picture image;

COMMENT ON COLUMN myapp_memberships_public.org_member_profiles.profile_picture IS 'Profile picture visible to other entity members';

ALTER TABLE myapp_memberships_public.org_member_profiles 
  ADD CONSTRAINT org_member_profiles_actor_id_entity_id_key 
    UNIQUE (actor_id, entity_id);

CREATE FUNCTION myapp_memberships_private.org_memberships_member_profile_tg() RETURNS trigger AS $EOFCODE$
DECLARE
  v_populate_email boolean := true;
BEGIN
  SELECT s.populate_member_email
  FROM myapp_memberships_public.org_membership_settings AS s
  WHERE
    s.entity_id = NEW.entity_id
  LIMIT
  1 INTO v_populate_email;
  IF NOT (v_populate_email) THEN
    INSERT INTO myapp_memberships_public.org_member_profiles (
      membership_id,
      entity_id,
      actor_id
    )
    VALUES
      (NEW.id, NEW.entity_id, NEW.actor_id);
    RETURN NEW;
  END IF;
  INSERT INTO myapp_memberships_public.org_member_profiles (
    membership_id,
    entity_id,
    actor_id,
    display_name,
    profile_picture
  )
  SELECT
    NEW.id,
    NEW.entity_id,
    NEW.actor_id,
    COALESCE(u.display_name, ''),
    u.profile_picture
  FROM myapp_users_public.users AS u
  WHERE
    u.id = NEW.actor_id
  LIMIT
  1;
  IF NOT (FOUND) THEN
    INSERT INTO myapp_memberships_public.org_member_profiles (
      membership_id,
      entity_id,
      actor_id
    )
    VALUES
      (NEW.id, NEW.entity_id, NEW.actor_id);
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE TRIGGER _00030_org_memberships_member_profile
  AFTER INSERT
  ON myapp_memberships_public.org_memberships
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_memberships_private.org_memberships_member_profile_tg();

CREATE TABLE myapp_memberships_public.org_grants ();

ALTER TABLE myapp_memberships_public.org_grants 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_memberships_public.org_grants IS 'Records of individual permission grants and revocations for members via bitmask';

ALTER TABLE myapp_memberships_public.org_grants 
  ADD COLUMN id uuid;

ALTER TABLE myapp_memberships_public.org_grants 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_memberships_public.org_grants 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_memberships_public.org_grants 
  ADD CONSTRAINT org_grants_pkey PRIMARY KEY (id);

ALTER TABLE myapp_memberships_public.org_grants 
  ADD COLUMN permissions pg_catalog.bit(64);

ALTER TABLE myapp_memberships_public.org_grants 
  ALTER COLUMN permissions SET NOT NULL;

ALTER TABLE myapp_memberships_public.org_grants 
  ALTER COLUMN permissions SET DEFAULT CAST(lpad('', 64, '0') AS pg_catalog.bit(64));

COMMENT ON COLUMN myapp_memberships_public.org_grants.permissions IS 'Bitmask of permissions being granted or revoked';

ALTER TABLE myapp_memberships_public.org_grants 
  ADD COLUMN is_grant boolean;

ALTER TABLE myapp_memberships_public.org_grants 
  ALTER COLUMN is_grant SET NOT NULL;

ALTER TABLE myapp_memberships_public.org_grants 
  ALTER COLUMN is_grant SET DEFAULT true;

COMMENT ON COLUMN myapp_memberships_public.org_grants.is_grant IS 'True to grant the permissions, false to revoke them';

ALTER TABLE myapp_memberships_public.org_grants 
  ADD COLUMN actor_id uuid;

COMMENT ON COLUMN myapp_memberships_public.org_grants.actor_id IS 'The member receiving or losing the permission grant; NULL if user was deleted';

ALTER TABLE myapp_memberships_public.org_grants 
  ADD CONSTRAINT org_grants_actor_id_fkey
    FOREIGN KEY(actor_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE SET NULL;

CREATE INDEX org_grants_actor_id_idx ON myapp_memberships_public.org_grants (actor_id);

ALTER TABLE myapp_memberships_public.org_grants 
  ADD COLUMN entity_id uuid;

ALTER TABLE myapp_memberships_public.org_grants 
  ALTER COLUMN entity_id SET NOT NULL;

COMMENT ON COLUMN myapp_memberships_public.org_grants.entity_id IS 'The entity (org or group) this permission grant applies to';

ALTER TABLE myapp_memberships_public.org_grants 
  ADD CONSTRAINT org_grants_entity_id_fkey
    FOREIGN KEY(entity_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE CASCADE;

CREATE INDEX org_grants_entity_id_idx ON myapp_memberships_public.org_grants (entity_id);

ALTER TABLE myapp_memberships_public.org_grants 
  ADD COLUMN grantor_id uuid;

ALTER TABLE myapp_memberships_public.org_grants 
  ALTER COLUMN grantor_id SET DEFAULT jwt_public.current_user_id();

ALTER TABLE myapp_memberships_public.org_grants 
  ADD CONSTRAINT org_grants_grantor_id_fkey
    FOREIGN KEY(grantor_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE SET NULL;

CREATE INDEX org_grants_grantor_id_idx ON myapp_memberships_public.org_grants (grantor_id);

ALTER TABLE myapp_memberships_public.org_grants 
  ADD COLUMN created_at timestamptz;

ALTER TABLE myapp_memberships_public.org_grants 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE myapp_memberships_public.org_grants 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE myapp_memberships_public.org_grants 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE TRIGGER timestamps_tg
  BEFORE INSERT OR UPDATE
  ON myapp_memberships_public.org_grants
  FOR EACH ROW
  EXECUTE PROCEDURE stamps.timestamps();

CREATE INDEX org_grants_created_at_idx ON myapp_memberships_public.org_grants (created_at);

CREATE INDEX org_grants_updated_at_idx ON myapp_memberships_public.org_grants (updated_at);

CREATE TABLE myapp_memberships_public.org_permission_default_permissions ();

ALTER TABLE myapp_memberships_public.org_permission_default_permissions 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_memberships_public.org_permission_default_permissions IS 'Join table linking permission defaults to individual permissions; recompute trigger rebuilds the defaults bitmask';

ALTER TABLE myapp_memberships_public.org_permission_default_permissions 
  ADD COLUMN id uuid;

ALTER TABLE myapp_memberships_public.org_permission_default_permissions 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_memberships_public.org_permission_default_permissions 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_memberships_public.org_permission_default_permissions 
  ADD CONSTRAINT org_permission_default_permissions_pkey PRIMARY KEY (id);

ALTER TABLE myapp_memberships_public.org_permission_default_permissions 
  ADD COLUMN permission_id uuid;

ALTER TABLE myapp_memberships_public.org_permission_default_permissions 
  ALTER COLUMN permission_id SET NOT NULL;

COMMENT ON COLUMN myapp_memberships_public.org_permission_default_permissions.permission_id IS 'References the permission included in the defaults bundle';

ALTER TABLE myapp_memberships_public.org_permission_default_permissions 
  ADD CONSTRAINT org_permission_default_permissions_permission_id_fkey
    FOREIGN KEY(permission_id)
    REFERENCES myapp_permissions_public.org_permissions (id)
    ON DELETE CASCADE;

ALTER TABLE myapp_memberships_public.org_permission_default_permissions 
  ADD COLUMN entity_id uuid;

ALTER TABLE myapp_memberships_public.org_permission_default_permissions 
  ALTER COLUMN entity_id SET NOT NULL;

COMMENT ON COLUMN myapp_memberships_public.org_permission_default_permissions.entity_id IS 'Scopes this default permission to a specific entity';

ALTER TABLE myapp_memberships_public.org_permission_default_permissions 
  ADD CONSTRAINT org_permission_default_permissions_entity_id_fkey
    FOREIGN KEY(entity_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE CASCADE;

CREATE UNIQUE INDEX org_permission_default_permissions_permission_id_entity_id_idx ON myapp_memberships_public.org_permission_default_permissions (permission_id, entity_id);

CREATE INDEX org_permission_default_permissions_entity_id_idx ON myapp_memberships_public.org_permission_default_permissions (entity_id);

ALTER TABLE myapp_memberships_public.org_permission_default_permissions 
  ADD COLUMN created_at timestamptz;

ALTER TABLE myapp_memberships_public.org_permission_default_permissions 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE myapp_memberships_public.org_permission_default_permissions 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE myapp_memberships_public.org_permission_default_permissions 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE TRIGGER timestamps_tg
  BEFORE INSERT OR UPDATE
  ON myapp_memberships_public.org_permission_default_permissions
  FOR EACH ROW
  EXECUTE PROCEDURE stamps.timestamps();

CREATE INDEX org_permission_default_permissions_created_at_idx ON myapp_memberships_public.org_permission_default_permissions (created_at);

CREATE INDEX org_permission_default_permissions_updated_at_idx ON myapp_memberships_public.org_permission_default_permissions (updated_at);

CREATE TABLE myapp_memberships_public.org_permission_default_grants ();

ALTER TABLE myapp_memberships_public.org_permission_default_grants 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_memberships_public.org_permission_default_grants IS 'Audit log of permission additions and removals from the defaults bitmask';

ALTER TABLE myapp_memberships_public.org_permission_default_grants 
  ADD COLUMN id uuid;

ALTER TABLE myapp_memberships_public.org_permission_default_grants 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_memberships_public.org_permission_default_grants 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_memberships_public.org_permission_default_grants 
  ADD CONSTRAINT org_permission_default_grants_pkey PRIMARY KEY (id);

ALTER TABLE myapp_memberships_public.org_permission_default_grants 
  ADD COLUMN permission_id uuid;

ALTER TABLE myapp_memberships_public.org_permission_default_grants 
  ALTER COLUMN permission_id SET NOT NULL;

COMMENT ON COLUMN myapp_memberships_public.org_permission_default_grants.permission_id IS 'References the permission being added to or removed from defaults';

ALTER TABLE myapp_memberships_public.org_permission_default_grants 
  ADD CONSTRAINT org_permission_default_grants_permission_id_fkey
    FOREIGN KEY(permission_id)
    REFERENCES myapp_permissions_public.org_permissions (id)
    ON DELETE CASCADE;

CREATE INDEX org_permission_default_grants_permission_id_idx ON myapp_memberships_public.org_permission_default_grants (permission_id);

ALTER TABLE myapp_memberships_public.org_permission_default_grants 
  ADD COLUMN is_grant boolean;

ALTER TABLE myapp_memberships_public.org_permission_default_grants 
  ALTER COLUMN is_grant SET NOT NULL;

ALTER TABLE myapp_memberships_public.org_permission_default_grants 
  ALTER COLUMN is_grant SET DEFAULT true;

COMMENT ON COLUMN myapp_memberships_public.org_permission_default_grants.is_grant IS 'True to add the permission to defaults, false to remove it';

ALTER TABLE myapp_memberships_public.org_permission_default_grants 
  ADD COLUMN grantor_id uuid;

ALTER TABLE myapp_memberships_public.org_permission_default_grants 
  ALTER COLUMN grantor_id SET DEFAULT jwt_public.current_user_id();

ALTER TABLE myapp_memberships_public.org_permission_default_grants 
  ADD CONSTRAINT org_permission_default_grants_grantor_id_fkey
    FOREIGN KEY(grantor_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE SET NULL;

CREATE INDEX org_permission_default_grants_grantor_id_idx ON myapp_memberships_public.org_permission_default_grants (grantor_id);

ALTER TABLE myapp_memberships_public.org_permission_default_grants 
  ADD COLUMN entity_id uuid;

ALTER TABLE myapp_memberships_public.org_permission_default_grants 
  ALTER COLUMN entity_id SET NOT NULL;

COMMENT ON COLUMN myapp_memberships_public.org_permission_default_grants.entity_id IS 'Scopes this audit entry to a specific entity';

ALTER TABLE myapp_memberships_public.org_permission_default_grants 
  ADD CONSTRAINT org_permission_default_grants_entity_id_fkey
    FOREIGN KEY(entity_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE CASCADE;

CREATE INDEX org_permission_default_grants_entity_id_idx ON myapp_memberships_public.org_permission_default_grants (entity_id);

ALTER TABLE myapp_memberships_public.org_permission_default_grants 
  ADD COLUMN created_at timestamptz;

ALTER TABLE myapp_memberships_public.org_permission_default_grants 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE myapp_memberships_public.org_permission_default_grants 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE myapp_memberships_public.org_permission_default_grants 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE TRIGGER timestamps_tg
  BEFORE INSERT OR UPDATE
  ON myapp_memberships_public.org_permission_default_grants
  FOR EACH ROW
  EXECUTE PROCEDURE stamps.timestamps();

CREATE INDEX org_permission_default_grants_created_at_idx ON myapp_memberships_public.org_permission_default_grants (created_at);

CREATE INDEX org_permission_default_grants_updated_at_idx ON myapp_memberships_public.org_permission_default_grants (updated_at);

CREATE FUNCTION myapp_memberships_private.org_memberships_itg() RETURNS trigger AS $EOFCODE$
DECLARE
  bitlen int := bit_length(NEW.permissions);
  defaults bit varying;
  memdefs myapp_memberships_public.org_membership_defaults;
BEGIN
  SELECT *
  FROM myapp_memberships_public.org_membership_defaults AS t
  WHERE
    t.entity_id = NEW.entity_id INTO memdefs;
  IF FOUND THEN
    new.is_approved := memdefs.is_approved;
  END IF;
  IF NEW.is_owner IS true THEN
    new.is_admin := true;
    new.is_approved := true;
    new.is_disabled := false;
    new.is_banned := false;
    new.is_read_only := false;
  END IF;
  IF NEW.is_admin IS true THEN
    new.is_read_only := false;
  END IF;
  new.is_active := (NEW.is_approved IS true AND NEW.is_disabled IS false) AND NEW.is_banned IS false;
  SELECT permissions
  FROM myapp_permissions_public.org_permission_defaults AS t
  WHERE
    t.entity_id = NEW.entity_id INTO defaults;
  IF NOT (FOUND) THEN
    new.granted := lpad('', bitlen::int, '0');
  ELSE
    new.granted := defaults;
  END IF;
  IF NEW.is_admin IS true OR NEW.is_owner IS true THEN
    new.permissions := lpad('', bitlen::int, '1');
  ELSE
    new.permissions := NEW.granted;
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE TRIGGER _00010_org_memberships_itrg
  BEFORE INSERT
  ON myapp_memberships_public.org_memberships
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_memberships_private.org_memberships_itg();

CREATE FUNCTION myapp_memberships_private.org_memberships_utg() RETURNS trigger AS $EOFCODE$
DECLARE
  bitlen int := bit_length(NEW.permissions);
BEGIN
  IF NEW.is_owner IS true THEN
    new.is_admin := true;
    new.is_approved := true;
    new.is_disabled := false;
    new.is_banned := false;
    new.is_read_only := false;
  END IF;
  IF NEW.is_admin IS true THEN
    new.is_read_only := false;
  END IF;
  new.is_active := (NEW.is_approved IS true AND NEW.is_disabled IS false) AND NEW.is_banned IS false;
  IF NEW.is_admin IS true OR NEW.is_owner IS true THEN
    new.permissions := lpad('', bitlen::int, '1');
  ELSE
    new.permissions := NEW.granted;
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE TRIGGER _00010_org_memberships_utrg
  BEFORE UPDATE
  ON myapp_memberships_public.org_memberships
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_memberships_private.org_memberships_utg();

CREATE TRIGGER _00020_org_memberships_insert_sprt
  AFTER INSERT
  ON myapp_memberships_public.org_memberships
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_memberships_private.org_memberships_insert_sprt_tg();

CREATE TRIGGER _00020_org_memberships_update_sprt
  AFTER UPDATE
  ON myapp_memberships_public.org_memberships
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_memberships_private.org_memberships_update_sprt_tg();

CREATE TRIGGER _99999_org_memberships_delete_sprt
  AFTER DELETE
  ON myapp_memberships_public.org_memberships
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_memberships_private.org_memberships_delete_sprt_tg();

CREATE FUNCTION myapp_memberships_private.org_memberships_dtg() RETURNS trigger AS $EOFCODE$
BEGIN
  IF (SELECT
    NOT (EXISTS (SELECT 1
    FROM myapp_memberships_public.org_memberships
    WHERE
      (entity_id = OLD.entity_id AND is_owner = true) AND actor_id <> OLD.actor_id))) THEN
    IF (SELECT
      count(*) > 0
    FROM myapp_memberships_public.org_memberships
    WHERE
      entity_id = OLD.entity_id AND actor_id <> OLD.actor_id) THEN
      RAISE EXCEPTION 'REQUIRES_ONE_OWNER';
    END IF;
  END IF;
  RETURN OLD;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE TRIGGER _99990_org_memberships_owners_chk
  BEFORE DELETE
  ON myapp_memberships_public.org_memberships
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_memberships_private.org_memberships_dtg();

CREATE FUNCTION myapp_memberships_private.org_mbr_create() RETURNS trigger AS $EOFCODE$
DECLARE
  owner_id uuid := jwt_public.current_user_id();
BEGIN
  IF NEW.type = 1 THEN
    INSERT INTO myapp_memberships_public.org_memberships (
      is_owner,
      actor_id,
      entity_id
    )
    VALUES
      (true, NEW.id, NEW.id);
  ELSIF owner_id IS NOT NULL THEN
    INSERT INTO myapp_memberships_public.org_memberships (
      is_owner,
      actor_id,
      entity_id
    )
    VALUES
      (true, owner_id, NEW.id);
    INSERT INTO myapp_memberships_public.org_membership_defaults (
      entity_id
    )
    VALUES
      (NEW.id);
    INSERT INTO myapp_permissions_public.org_permission_defaults (
      permissions,
      entity_id
    )
    VALUES
      (myapp_permissions_public.org_permissions_get_mask_by_names(ARRAY['send_approved_invites', 'create_invites']::citext[]), NEW.id);
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE TRIGGER org_mbr_trg
  AFTER INSERT
  ON myapp_users_public.users
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_memberships_private.org_mbr_create();

CREATE FUNCTION myapp_memberships_private.org_grants_apply_tg() RETURNS trigger AS $EOFCODE$
BEGIN
  IF NEW.is_grant IS TRUE THEN
    UPDATE myapp_memberships_public.org_memberships SET
    granted = granted | NEW.permissions
    WHERE
      actor_id = NEW.actor_id AND entity_id = NEW.entity_id;
  ELSE
    UPDATE myapp_memberships_public.org_memberships SET
    granted = granted & (~NEW.permissions)
    WHERE
      actor_id = NEW.actor_id AND entity_id = NEW.entity_id;
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE TRIGGER org_grants_insert_trg
  BEFORE INSERT
  ON myapp_memberships_public.org_grants
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_memberships_private.org_grants_apply_tg();

CREATE FUNCTION myapp_memberships_private.org_admin_grants_apply_tg() RETURNS trigger AS $EOFCODE$
BEGIN
  IF NEW.is_grant IS TRUE THEN
    UPDATE myapp_memberships_public.org_memberships SET
    is_admin = true
    WHERE
      actor_id = NEW.actor_id AND entity_id = NEW.entity_id;
  ELSE
    UPDATE myapp_memberships_public.org_memberships SET
    is_admin = false
    WHERE
      (actor_id = NEW.actor_id AND entity_id = NEW.entity_id) AND is_owner = false;
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE TRIGGER org_admin_grants_insert_trg
  BEFORE INSERT
  ON myapp_memberships_public.org_admin_grants
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_memberships_private.org_admin_grants_apply_tg();

CREATE FUNCTION myapp_memberships_private.org_owner_grants_apply_tg() RETURNS trigger AS $EOFCODE$
BEGIN
  IF NEW.is_grant IS TRUE THEN
    UPDATE myapp_memberships_public.org_memberships SET
    is_owner = true
    WHERE
      actor_id = NEW.actor_id AND entity_id = NEW.entity_id;
  ELSE
    UPDATE myapp_memberships_public.org_memberships SET
    is_owner = false
    WHERE
      actor_id = NEW.actor_id AND entity_id = NEW.entity_id;
    IF (SELECT
      count(*) < 1
    FROM myapp_memberships_public.org_memberships
    WHERE
      is_owner = true AND entity_id = NEW.entity_id) THEN
      RAISE EXCEPTION 'REQUIRES_ONE_OWNER';
    END IF;
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE TRIGGER org_owner_grants_insert_trg
  BEFORE INSERT
  ON myapp_memberships_public.org_owner_grants
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_memberships_private.org_owner_grants_apply_tg();

CREATE FUNCTION myapp_memberships_private.org_permission_default_grants_apply_tg() RETURNS trigger AS $EOFCODE$
BEGIN
  IF NEW.is_grant IS TRUE THEN
    INSERT INTO myapp_memberships_public.org_permission_default_permissions (
      permission_id,
      entity_id
    )
    VALUES
      (NEW.permission_id, NEW.entity_id)
    ON CONFLICT (permission_id, entity_id) DO NOTHING;
  ELSE
    DELETE FROM myapp_memberships_public.org_permission_default_permissions
    WHERE
      permission_id = NEW.permission_id AND entity_id = NEW.entity_id;
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE;

CREATE TRIGGER org_permission_default_grants_insert_trg
  BEFORE INSERT
  ON myapp_memberships_public.org_permission_default_grants
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_memberships_private.org_permission_default_grants_apply_tg();

CREATE FUNCTION myapp_memberships_private.org_permission_default_permissions_recompute_tg() RETURNS trigger AS $EOFCODE$
DECLARE
  v_entity_id uuid;
  v_permissions bit(64);
BEGIN
  IF TG_OP = 'DELETE' THEN
    SELECT OLD.entity_id INTO v_entity_id;
  ELSE
    SELECT NEW.entity_id INTO v_entity_id;
  END IF;
  SELECT coalesce(bit_or(p.bitstr), (lpad('', 64, '0'))::bit(64)::bit(64))
  FROM myapp_memberships_public.org_permission_default_permissions AS pp INNER JOIN myapp_permissions_public.org_permissions AS p ON p.id = pp.permission_id
  WHERE
    pp.entity_id = v_entity_id INTO v_permissions;
  UPDATE myapp_permissions_public.org_permission_defaults SET
  permissions = v_permissions
  WHERE
    entity_id = v_entity_id;
  IF TG_OP = 'DELETE' THEN
    RETURN OLD;
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE TRIGGER org_permission_default_permissions_recompute_trg
  BEFORE INSERT OR DELETE OR UPDATE
  ON myapp_memberships_public.org_permission_default_permissions
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_memberships_private.org_permission_default_permissions_recompute_tg();

INSERT INTO myapp_permissions_public.org_permissions (
  bitnum,
  name,
  description
) VALUES
  (1, 'admin_members', 'Manage members of the organization.'),
  (2, 'create_invites', 'Create invites for the organization.'),
  (3, 'admin_invites', 'Manage invites of the organization.'),
  (4, 'send_approved_invites', 'Invites sent by this user are pre-approved.'),
  (5, 'create_entity', 'Create child entities.'),
  (6, 'admin_limits', 'Manage limits within the organization.'),
  (7, 'admin_permissions', 'Manage permissions within the organization.'),
  (8, 'admin_levels', 'Manage levels of the organization.'),
  (9, 'admin_account', 'Manage account of the organization.'),
  (10, 'assign_profiles', 'Assign profiles (roles) to invites for the organization.'),
  (11, 'manage_secrets', 'Manage encrypted secrets for the organization.'),
  (12, 'manage_database', 'Manage database schema definitions (tables, fields, views, etc.).'),
  (13, 'manage_services', 'Manage API configuration (endpoints, CORS, auth settings, etc.).'),
  (14, 'manage_sites', 'Manage sites, apps, domains, and site configuration.'),
  (15, 'manage_domains', 'Manage custom domain ownership verification and certificate issuance.'),
  (16, 'export_code', 'Export database DDL/code and migration/action history.');

CREATE TABLE myapp_profiles_public.org_profiles ();

ALTER TABLE myapp_profiles_public.org_profiles 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_profiles_public.org_profiles IS 'Named permission bundles (roles) that group multiple permissions into reusable profiles';

ALTER TABLE myapp_profiles_public.org_profiles 
  ADD COLUMN id uuid;

ALTER TABLE myapp_profiles_public.org_profiles 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_profiles_public.org_profiles 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_profiles_public.org_profiles 
  ADD CONSTRAINT org_profiles_pkey PRIMARY KEY (id);

ALTER TABLE myapp_profiles_public.org_profiles 
  ADD COLUMN name citext;

ALTER TABLE myapp_profiles_public.org_profiles 
  ALTER COLUMN name SET NOT NULL;

COMMENT ON COLUMN myapp_profiles_public.org_profiles.name IS 'Display name for this profile (e.g. Admin, Editor, Viewer)';

ALTER TABLE myapp_profiles_public.org_profiles 
  ADD COLUMN slug text;

ALTER TABLE myapp_profiles_public.org_profiles 
  ALTER COLUMN slug SET NOT NULL;

COMMENT ON COLUMN myapp_profiles_public.org_profiles.slug IS 'URL-safe identifier for this profile, used in API references';

ALTER TABLE myapp_profiles_public.org_profiles 
  ADD COLUMN description text;

COMMENT ON COLUMN myapp_profiles_public.org_profiles.description IS 'Human-readable description of this profile and its intended use';

ALTER TABLE myapp_profiles_public.org_profiles 
  ADD COLUMN permissions pg_catalog.bit(64);

ALTER TABLE myapp_profiles_public.org_profiles 
  ALTER COLUMN permissions SET NOT NULL;

ALTER TABLE myapp_profiles_public.org_profiles 
  ALTER COLUMN permissions SET DEFAULT CAST(lpad('', 64, '0') AS pg_catalog.bit(64));

COMMENT ON COLUMN myapp_profiles_public.org_profiles.permissions IS 'Pre-computed permission bitmask aggregating all permissions in this profile';

ALTER TABLE myapp_profiles_public.org_profiles 
  ADD COLUMN is_system boolean;

ALTER TABLE myapp_profiles_public.org_profiles 
  ALTER COLUMN is_system SET NOT NULL;

ALTER TABLE myapp_profiles_public.org_profiles 
  ALTER COLUMN is_system SET DEFAULT false;

COMMENT ON COLUMN myapp_profiles_public.org_profiles.is_system IS 'System profiles are built-in and cannot be deleted or renamed by users';

ALTER TABLE myapp_profiles_public.org_profiles 
  ADD COLUMN is_default boolean;

ALTER TABLE myapp_profiles_public.org_profiles 
  ALTER COLUMN is_default SET NOT NULL;

ALTER TABLE myapp_profiles_public.org_profiles 
  ALTER COLUMN is_default SET DEFAULT false;

COMMENT ON COLUMN myapp_profiles_public.org_profiles.is_default IS 'The default profile is automatically assigned to new members when they join';

ALTER TABLE myapp_profiles_public.org_profiles 
  ADD COLUMN created_at timestamptz;

ALTER TABLE myapp_profiles_public.org_profiles 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE myapp_profiles_public.org_profiles 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE myapp_profiles_public.org_profiles 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE TRIGGER timestamps_tg
  BEFORE INSERT OR UPDATE
  ON myapp_profiles_public.org_profiles
  FOR EACH ROW
  EXECUTE PROCEDURE stamps.timestamps();

CREATE INDEX org_profiles_created_at_idx ON myapp_profiles_public.org_profiles (created_at);

CREATE INDEX org_profiles_updated_at_idx ON myapp_profiles_public.org_profiles (updated_at);

ALTER TABLE myapp_profiles_public.org_profiles 
  ADD COLUMN entity_id uuid;

COMMENT ON COLUMN myapp_profiles_public.org_profiles.entity_id IS 'Scopes this profile to a specific entity; NULL means it is a global profile';

ALTER TABLE myapp_profiles_public.org_profiles 
  ADD CONSTRAINT org_profiles_entity_id_fkey
    FOREIGN KEY(entity_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE CASCADE;

CREATE INDEX org_profiles_entity_id_idx ON myapp_profiles_public.org_profiles (entity_id);

ALTER TABLE myapp_profiles_public.org_profiles 
  ADD CONSTRAINT org_profiles_name_entity_id_key 
    UNIQUE (name, entity_id);

ALTER TABLE myapp_profiles_public.org_profiles 
  ADD CONSTRAINT org_profiles_slug_entity_id_key 
    UNIQUE (slug, entity_id);

CREATE INDEX org_profiles_is_default_idx ON myapp_profiles_public.org_profiles (is_default);

CREATE UNIQUE INDEX org_profiles_default_global_uniq ON myapp_profiles_public.org_profiles ((CAST(true AS boolean))) WHERE is_default = true
  AND entity_id IS NULL;

CREATE UNIQUE INDEX org_profiles_default_entity_uniq ON myapp_profiles_public.org_profiles (entity_id) WHERE is_default = true
  AND entity_id IS NOT NULL;

CREATE TABLE myapp_profiles_public.org_profile_permissions ();

ALTER TABLE myapp_profiles_public.org_profile_permissions 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_profiles_public.org_profile_permissions IS 'Join table linking profiles to individual permissions they include';

ALTER TABLE myapp_profiles_public.org_profile_permissions 
  ADD COLUMN id uuid;

ALTER TABLE myapp_profiles_public.org_profile_permissions 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_profiles_public.org_profile_permissions 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_profiles_public.org_profile_permissions 
  ADD CONSTRAINT org_profile_permissions_pkey PRIMARY KEY (id);

ALTER TABLE myapp_profiles_public.org_profile_permissions 
  ADD COLUMN profile_id uuid;

ALTER TABLE myapp_profiles_public.org_profile_permissions 
  ALTER COLUMN profile_id SET NOT NULL;

COMMENT ON COLUMN myapp_profiles_public.org_profile_permissions.profile_id IS 'References the profile this permission belongs to';

ALTER TABLE myapp_profiles_public.org_profile_permissions 
  ADD CONSTRAINT org_profile_permissions_profile_id_fkey
    FOREIGN KEY(profile_id)
    REFERENCES myapp_profiles_public.org_profiles (id)
    ON DELETE CASCADE;

ALTER TABLE myapp_profiles_public.org_profile_permissions 
  ADD COLUMN permission_id uuid;

ALTER TABLE myapp_profiles_public.org_profile_permissions 
  ALTER COLUMN permission_id SET NOT NULL;

COMMENT ON COLUMN myapp_profiles_public.org_profile_permissions.permission_id IS 'References the permission included in this profile';

ALTER TABLE myapp_profiles_public.org_profile_permissions 
  ADD CONSTRAINT org_profile_permissions_permission_id_fkey
    FOREIGN KEY(permission_id)
    REFERENCES myapp_permissions_public.org_permissions (id)
    ON DELETE CASCADE;

CREATE INDEX org_profile_permissions_permission_id_idx ON myapp_profiles_public.org_profile_permissions (permission_id);

ALTER TABLE myapp_profiles_public.org_profile_permissions 
  ADD CONSTRAINT org_profile_permissions_profile_id_permission_id_key 
    UNIQUE (profile_id, permission_id);

CREATE INDEX org_profile_permissions_profile_id_idx ON myapp_profiles_public.org_profile_permissions (profile_id);

ALTER TABLE myapp_profiles_public.org_profile_permissions 
  ADD COLUMN created_at timestamptz;

ALTER TABLE myapp_profiles_public.org_profile_permissions 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE myapp_profiles_public.org_profile_permissions 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE myapp_profiles_public.org_profile_permissions 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE TRIGGER timestamps_tg
  BEFORE INSERT OR UPDATE
  ON myapp_profiles_public.org_profile_permissions
  FOR EACH ROW
  EXECUTE PROCEDURE stamps.timestamps();

CREATE INDEX org_profile_permissions_created_at_idx ON myapp_profiles_public.org_profile_permissions (created_at);

CREATE INDEX org_profile_permissions_updated_at_idx ON myapp_profiles_public.org_profile_permissions (updated_at);

CREATE TABLE myapp_profiles_public.org_profile_grants ();

ALTER TABLE myapp_profiles_public.org_profile_grants 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_profiles_public.org_profile_grants IS 'Audit log of profile assignments and revocations for members';

ALTER TABLE myapp_profiles_public.org_profile_grants 
  ADD COLUMN id uuid;

ALTER TABLE myapp_profiles_public.org_profile_grants 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_profiles_public.org_profile_grants 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_profiles_public.org_profile_grants 
  ADD CONSTRAINT org_profile_grants_pkey PRIMARY KEY (id);

ALTER TABLE myapp_profiles_public.org_profile_grants 
  ADD COLUMN membership_id uuid;

COMMENT ON COLUMN myapp_profiles_public.org_profile_grants.membership_id IS 'References the membership that received or lost this profile; NULL if membership was deleted';

ALTER TABLE myapp_profiles_public.org_profile_grants 
  ADD CONSTRAINT org_profile_grants_membership_id_fkey
    FOREIGN KEY(membership_id)
    REFERENCES myapp_memberships_public.org_memberships (id)
    ON DELETE SET NULL;

ALTER TABLE myapp_profiles_public.org_profile_grants 
  ADD COLUMN profile_id uuid;

COMMENT ON COLUMN myapp_profiles_public.org_profile_grants.profile_id IS 'References the profile being assigned; NULL indicates the profile was removed';

ALTER TABLE myapp_profiles_public.org_profile_grants 
  ADD CONSTRAINT org_profile_grants_profile_id_fkey
    FOREIGN KEY(profile_id)
    REFERENCES myapp_profiles_public.org_profiles (id)
    ON DELETE SET NULL;

ALTER TABLE myapp_profiles_public.org_profile_grants 
  ADD COLUMN entity_id uuid;

COMMENT ON COLUMN myapp_profiles_public.org_profile_grants.entity_id IS 'The entity (org or group) scope for this profile grant';

ALTER TABLE myapp_profiles_public.org_profile_grants 
  ADD CONSTRAINT org_profile_grants_entity_id_fkey
    FOREIGN KEY(entity_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE CASCADE;

CREATE INDEX org_profile_grants_entity_id_idx ON myapp_profiles_public.org_profile_grants (entity_id);

ALTER TABLE myapp_profiles_public.org_profile_grants 
  ADD COLUMN grantor_id uuid;

ALTER TABLE myapp_profiles_public.org_profile_grants 
  ALTER COLUMN grantor_id SET DEFAULT jwt_public.current_user_id();

ALTER TABLE myapp_profiles_public.org_profile_grants 
  ADD CONSTRAINT org_profile_grants_grantor_id_fkey
    FOREIGN KEY(grantor_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE SET NULL;

CREATE INDEX org_profile_grants_grantor_id_idx ON myapp_profiles_public.org_profile_grants (grantor_id);

ALTER TABLE myapp_profiles_public.org_profile_grants 
  ADD COLUMN is_grant boolean;

ALTER TABLE myapp_profiles_public.org_profile_grants 
  ALTER COLUMN is_grant SET NOT NULL;

ALTER TABLE myapp_profiles_public.org_profile_grants 
  ALTER COLUMN is_grant SET DEFAULT true;

COMMENT ON COLUMN myapp_profiles_public.org_profile_grants.is_grant IS 'True to assign the profile, false to revoke it';

CREATE INDEX org_profile_grants_membership_id_idx ON myapp_profiles_public.org_profile_grants (membership_id);

CREATE INDEX org_profile_grants_profile_id_idx ON myapp_profiles_public.org_profile_grants (profile_id);

ALTER TABLE myapp_profiles_public.org_profile_grants 
  ADD COLUMN created_at timestamptz;

ALTER TABLE myapp_profiles_public.org_profile_grants 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE myapp_profiles_public.org_profile_grants 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE myapp_profiles_public.org_profile_grants 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE TRIGGER timestamps_tg
  BEFORE INSERT OR UPDATE
  ON myapp_profiles_public.org_profile_grants
  FOR EACH ROW
  EXECUTE PROCEDURE stamps.timestamps();

CREATE INDEX org_profile_grants_created_at_idx ON myapp_profiles_public.org_profile_grants (created_at);

CREATE INDEX org_profile_grants_updated_at_idx ON myapp_profiles_public.org_profile_grants (updated_at);

CREATE TABLE myapp_profiles_public.org_profile_definition_grants ();

ALTER TABLE myapp_profiles_public.org_profile_definition_grants 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_profiles_public.org_profile_definition_grants IS 'Audit log of permission additions and removals from profile definitions';

ALTER TABLE myapp_profiles_public.org_profile_definition_grants 
  ADD COLUMN id uuid;

ALTER TABLE myapp_profiles_public.org_profile_definition_grants 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_profiles_public.org_profile_definition_grants 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_profiles_public.org_profile_definition_grants 
  ADD CONSTRAINT org_profile_definition_grants_pkey PRIMARY KEY (id);

ALTER TABLE myapp_profiles_public.org_profile_definition_grants 
  ADD COLUMN profile_id uuid;

COMMENT ON COLUMN myapp_profiles_public.org_profile_definition_grants.profile_id IS 'References the profile whose definition was modified; NULL if profile was deleted';

ALTER TABLE myapp_profiles_public.org_profile_definition_grants 
  ADD CONSTRAINT org_profile_definition_grants_profile_id_fkey
    FOREIGN KEY(profile_id)
    REFERENCES myapp_profiles_public.org_profiles (id)
    ON DELETE SET NULL;

ALTER TABLE myapp_profiles_public.org_profile_definition_grants 
  ADD COLUMN permission_id uuid;

COMMENT ON COLUMN myapp_profiles_public.org_profile_definition_grants.permission_id IS 'References the permission that was added to or removed from the profile; NULL if permission was deleted';

ALTER TABLE myapp_profiles_public.org_profile_definition_grants 
  ADD CONSTRAINT org_profile_definition_grants_permission_id_fkey
    FOREIGN KEY(permission_id)
    REFERENCES myapp_permissions_public.org_permissions (id)
    ON DELETE SET NULL;

ALTER TABLE myapp_profiles_public.org_profile_definition_grants 
  ADD COLUMN grantor_id uuid;

ALTER TABLE myapp_profiles_public.org_profile_definition_grants 
  ALTER COLUMN grantor_id SET DEFAULT jwt_public.current_user_id();

ALTER TABLE myapp_profiles_public.org_profile_definition_grants 
  ADD CONSTRAINT org_profile_definition_grants_grantor_id_fkey
    FOREIGN KEY(grantor_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE SET NULL;

CREATE INDEX org_profile_definition_grants_grantor_id_idx ON myapp_profiles_public.org_profile_definition_grants (grantor_id);

ALTER TABLE myapp_profiles_public.org_profile_definition_grants 
  ADD COLUMN is_grant boolean;

ALTER TABLE myapp_profiles_public.org_profile_definition_grants 
  ALTER COLUMN is_grant SET NOT NULL;

ALTER TABLE myapp_profiles_public.org_profile_definition_grants 
  ALTER COLUMN is_grant SET DEFAULT true;

COMMENT ON COLUMN myapp_profiles_public.org_profile_definition_grants.is_grant IS 'True to add the permission to the profile, false to remove it';

CREATE INDEX org_profile_definition_grants_profile_id_idx ON myapp_profiles_public.org_profile_definition_grants (profile_id);

CREATE INDEX org_profile_definition_grants_permission_id_idx ON myapp_profiles_public.org_profile_definition_grants (permission_id);

ALTER TABLE myapp_profiles_public.org_profile_definition_grants 
  ADD COLUMN created_at timestamptz;

ALTER TABLE myapp_profiles_public.org_profile_definition_grants 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE myapp_profiles_public.org_profile_definition_grants 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE myapp_profiles_public.org_profile_definition_grants 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE TRIGGER timestamps_tg
  BEFORE INSERT OR UPDATE
  ON myapp_profiles_public.org_profile_definition_grants
  FOR EACH ROW
  EXECUTE PROCEDURE stamps.timestamps();

CREATE INDEX org_profile_definition_grants_created_at_idx ON myapp_profiles_public.org_profile_definition_grants (created_at);

CREATE INDEX org_profile_definition_grants_updated_at_idx ON myapp_profiles_public.org_profile_definition_grants (updated_at);

ALTER TABLE myapp_memberships_public.org_memberships 
  ADD COLUMN profile_id uuid;

ALTER TABLE myapp_memberships_public.org_memberships 
  ADD CONSTRAINT org_memberships_profile_id_fkey
    FOREIGN KEY(profile_id)
    REFERENCES myapp_profiles_public.org_profiles (id)
    ON DELETE SET NULL;

CREATE INDEX org_memberships_profile_id_idx ON myapp_memberships_public.org_memberships (profile_id);

CREATE FUNCTION myapp_profiles_private.org_profile_grants_apply_tg() RETURNS trigger AS $EOFCODE$
BEGIN
  IF NEW.is_grant IS TRUE AND NEW.profile_id IS NOT NULL THEN
    UPDATE myapp_memberships_public.org_memberships SET
    profile_id = NEW.profile_id
    WHERE
      id = NEW.membership_id;
  ELSIF NEW.is_grant IS FALSE THEN
    UPDATE myapp_memberships_public.org_memberships SET
    profile_id = NULL
    WHERE
      id = NEW.membership_id;
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE TRIGGER org_profile_grants_apply_trg
  AFTER INSERT
  ON myapp_profiles_public.org_profile_grants
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_profiles_private.org_profile_grants_apply_tg();

CREATE FUNCTION myapp_profiles_private.org_profile_definition_grants_apply_tg() RETURNS trigger AS $EOFCODE$
BEGIN
  IF NEW.is_grant IS TRUE THEN
    INSERT INTO myapp_profiles_public.org_profile_permissions (
      profile_id,
      permission_id
    )
    VALUES
      (NEW.profile_id, NEW.permission_id)
    ON CONFLICT (profile_id, permission_id) DO NOTHING;
  ELSE
    DELETE FROM myapp_profiles_public.org_profile_permissions
    WHERE
      profile_id = NEW.profile_id AND permission_id = NEW.permission_id;
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE TRIGGER org_profile_definition_grants_apply_trg
  AFTER INSERT
  ON myapp_profiles_public.org_profile_definition_grants
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_profiles_private.org_profile_definition_grants_apply_tg();

CREATE FUNCTION myapp_profiles_private.org_profile_permissions_recompute_tg() RETURNS trigger AS $EOFCODE$
DECLARE
  v_profile_id uuid;
  v_permissions bit(64);
BEGIN
  IF TG_OP = 'DELETE' THEN
    SELECT OLD.profile_id INTO v_profile_id;
  ELSE
    SELECT NEW.profile_id INTO v_profile_id;
  END IF;
  SELECT coalesce(bit_or(p.bitstr), (lpad('', 64, '0'))::bit(64)::bit(64))
  FROM myapp_profiles_public.org_profile_permissions AS pp INNER JOIN myapp_permissions_public.org_permissions AS p ON p.id = pp.permission_id
  WHERE
    pp.profile_id = v_profile_id INTO v_permissions;
  UPDATE myapp_profiles_public.org_profiles SET
  permissions = v_permissions
  WHERE
    id = v_profile_id;
  IF TG_OP = 'DELETE' THEN
    RETURN OLD;
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE TRIGGER org_profile_permissions_recompute_trg
  AFTER INSERT OR DELETE OR UPDATE
  ON myapp_profiles_public.org_profile_permissions
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_profiles_private.org_profile_permissions_recompute_tg();

CREATE FUNCTION myapp_profiles_private.org_memberships_profile_sync_tg() RETURNS trigger AS $EOFCODE$
DECLARE
  v_profile_permissions bit(64);
BEGIN
  IF NEW.is_admin IS TRUE OR NEW.is_owner IS TRUE THEN
    RETURN NEW;
  END IF;
  IF NEW.profile_id IS NOT NULL THEN
    SELECT permissions
    FROM myapp_profiles_public.org_profiles
    WHERE
      id = NEW.profile_id INTO v_profile_permissions;
    IF FOUND AND v_profile_permissions IS NOT NULL THEN
      new.permissions := NEW.granted | v_profile_permissions;
    ELSE
      new.permissions := NEW.granted;
    END IF;
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE;

CREATE TRIGGER _00015_org_memberships_profile_sync_itrg
  BEFORE INSERT
  ON myapp_memberships_public.org_memberships
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_profiles_private.org_memberships_profile_sync_tg();

CREATE TRIGGER _00015_org_memberships_profile_sync_utrg
  BEFORE UPDATE
  ON myapp_memberships_public.org_memberships
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_profiles_private.org_memberships_profile_sync_tg();

CREATE FUNCTION myapp_profiles_private.org_profiles_cascade_tg() RETURNS trigger AS $EOFCODE$
BEGIN
  IF OLD.permissions IS DISTINCT FROM NEW.permissions THEN
    UPDATE myapp_memberships_public.org_memberships SET
    profile_id = profile_id
    WHERE
      profile_id = NEW.id;
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE TRIGGER org_profiles_cascade_trg
  AFTER UPDATE
  ON myapp_profiles_public.org_profiles
  FOR EACH ROW
  WHEN (old.permissions IS DISTINCT FROM new.permissions)
  EXECUTE PROCEDURE myapp_profiles_private.org_profiles_cascade_tg();

CREATE FUNCTION myapp_profiles_private.org_memberships_default_profile_tg() RETURNS trigger AS $EOFCODE$
DECLARE
  v_default_profile_id uuid;
BEGIN
  IF NEW.profile_id IS NULL THEN
    SELECT id
    FROM myapp_profiles_public.org_profiles
    WHERE
      is_default = true AND entity_id = NEW.entity_id
    LIMIT
    1 INTO v_default_profile_id;
    IF FOUND THEN
      SELECT v_default_profile_id INTO NEW.profile_id;
    END IF;
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE;

CREATE TRIGGER _00000_org_memberships_default_profile_trg
  BEFORE INSERT
  ON myapp_memberships_public.org_memberships
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_profiles_private.org_memberships_default_profile_tg();

CREATE TABLE myapp_profiles_public.org_profile_templates ();

ALTER TABLE myapp_profiles_public.org_profile_templates 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_profiles_public.org_profile_templates IS 'Template profiles that are automatically seeded into new entities when created';

ALTER TABLE myapp_profiles_public.org_profile_templates 
  ADD COLUMN id uuid;

ALTER TABLE myapp_profiles_public.org_profile_templates 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_profiles_public.org_profile_templates 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_profiles_public.org_profile_templates 
  ADD CONSTRAINT org_profile_templates_pkey PRIMARY KEY (id);

ALTER TABLE myapp_profiles_public.org_profile_templates 
  ADD COLUMN name citext;

ALTER TABLE myapp_profiles_public.org_profile_templates 
  ALTER COLUMN name SET NOT NULL;

COMMENT ON COLUMN myapp_profiles_public.org_profile_templates.name IS 'Display name for the template profile (e.g. Admin, Editor, Viewer)';

ALTER TABLE myapp_profiles_public.org_profile_templates 
  ADD COLUMN slug text;

ALTER TABLE myapp_profiles_public.org_profile_templates 
  ALTER COLUMN slug SET NOT NULL;

COMMENT ON COLUMN myapp_profiles_public.org_profile_templates.slug IS 'URL-safe identifier for the template profile';

ALTER TABLE myapp_profiles_public.org_profile_templates 
  ADD COLUMN description text;

COMMENT ON COLUMN myapp_profiles_public.org_profile_templates.description IS 'Human-readable description of this template profile';

ALTER TABLE myapp_profiles_public.org_profile_templates 
  ADD COLUMN permissions pg_catalog.bit(64);

ALTER TABLE myapp_profiles_public.org_profile_templates 
  ALTER COLUMN permissions SET NOT NULL;

ALTER TABLE myapp_profiles_public.org_profile_templates 
  ALTER COLUMN permissions SET DEFAULT CAST(lpad('', 64, '0') AS pg_catalog.bit(64));

COMMENT ON COLUMN myapp_profiles_public.org_profile_templates.permissions IS 'Pre-computed permission bitmask for the seeded profile';

ALTER TABLE myapp_profiles_public.org_profile_templates 
  ADD COLUMN is_default boolean;

ALTER TABLE myapp_profiles_public.org_profile_templates 
  ALTER COLUMN is_default SET NOT NULL;

ALTER TABLE myapp_profiles_public.org_profile_templates 
  ALTER COLUMN is_default SET DEFAULT false;

COMMENT ON COLUMN myapp_profiles_public.org_profile_templates.is_default IS 'Whether the seeded profile should be the default for new members';

ALTER TABLE myapp_profiles_public.org_profile_templates 
  ADD COLUMN created_at timestamptz;

ALTER TABLE myapp_profiles_public.org_profile_templates 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE myapp_profiles_public.org_profile_templates 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE myapp_profiles_public.org_profile_templates 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE TRIGGER timestamps_tg
  BEFORE INSERT OR UPDATE
  ON myapp_profiles_public.org_profile_templates
  FOR EACH ROW
  EXECUTE PROCEDURE stamps.timestamps();

CREATE INDEX org_profile_templates_created_at_idx ON myapp_profiles_public.org_profile_templates (created_at);

CREATE INDEX org_profile_templates_updated_at_idx ON myapp_profiles_public.org_profile_templates (updated_at);

ALTER TABLE myapp_profiles_public.org_profile_templates 
  ADD CONSTRAINT org_profile_templates_name_key 
    UNIQUE (name);

ALTER TABLE myapp_profiles_public.org_profile_templates 
  ADD CONSTRAINT org_profile_templates_slug_key 
    UNIQUE (slug);

CREATE UNIQUE INDEX org_profile_templates_default_uniq ON myapp_profiles_public.org_profile_templates ((CAST(true AS boolean))) WHERE is_default = true;

CREATE INDEX org_profile_templates_is_default_idx ON myapp_profiles_public.org_profile_templates (is_default);

CREATE FUNCTION myapp_profiles_private.org_profile_templates_seed_fn() RETURNS trigger AS $EOFCODE$
BEGIN
  INSERT INTO myapp_profiles_public.org_profiles (
    name,
    slug,
    description,
    permissions,
    is_default,
    entity_id
  )
  SELECT
    t.name,
    t.slug,
    t.description,
    t.permissions,
    t.is_default,
    NEW.id
  FROM myapp_profiles_public.org_profile_templates AS t;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE TRIGGER _00060_users_org_profile_templates_seed_trg
  AFTER INSERT
  ON myapp_users_public.users
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_profiles_private.org_profile_templates_seed_fn();

CREATE TABLE myapp_memberships_public.org_chart_edges ();

ALTER TABLE myapp_memberships_public.org_chart_edges 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_memberships_public.org_chart_edges IS 'Organizational chart edges defining parent-child reporting relationships between members within an entity';

ALTER TABLE myapp_memberships_public.org_chart_edges 
  ADD COLUMN id uuid;

ALTER TABLE myapp_memberships_public.org_chart_edges 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_memberships_public.org_chart_edges 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_memberships_public.org_chart_edges 
  ADD CONSTRAINT org_chart_edges_pkey PRIMARY KEY (id);

ALTER TABLE myapp_memberships_public.org_chart_edges 
  ADD COLUMN created_at timestamptz;

ALTER TABLE myapp_memberships_public.org_chart_edges 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE myapp_memberships_public.org_chart_edges 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE myapp_memberships_public.org_chart_edges 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE TRIGGER timestamps_tg
  BEFORE INSERT OR UPDATE
  ON myapp_memberships_public.org_chart_edges
  FOR EACH ROW
  EXECUTE PROCEDURE stamps.timestamps();

CREATE INDEX org_chart_edges_created_at_idx ON myapp_memberships_public.org_chart_edges (created_at);

CREATE INDEX org_chart_edges_updated_at_idx ON myapp_memberships_public.org_chart_edges (updated_at);

ALTER TABLE myapp_memberships_public.org_chart_edges 
  ADD COLUMN entity_id uuid;

ALTER TABLE myapp_memberships_public.org_chart_edges 
  ALTER COLUMN entity_id SET NOT NULL;

COMMENT ON COLUMN myapp_memberships_public.org_chart_edges.entity_id IS 'Organization this hierarchy edge belongs to';

ALTER TABLE myapp_memberships_public.org_chart_edges 
  ADD CONSTRAINT org_chart_edges_entity_id_fkey
    FOREIGN KEY(entity_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE CASCADE;

ALTER TABLE myapp_memberships_public.org_chart_edges 
  ADD COLUMN child_id uuid;

ALTER TABLE myapp_memberships_public.org_chart_edges 
  ALTER COLUMN child_id SET NOT NULL;

COMMENT ON COLUMN myapp_memberships_public.org_chart_edges.child_id IS 'User ID of the subordinate (employee) in this reporting relationship';

ALTER TABLE myapp_memberships_public.org_chart_edges 
  ADD CONSTRAINT org_chart_edges_child_id_fkey
    FOREIGN KEY(child_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE CASCADE;

ALTER TABLE myapp_memberships_public.org_chart_edges 
  ADD COLUMN parent_id uuid;

COMMENT ON COLUMN myapp_memberships_public.org_chart_edges.parent_id IS 'User ID of the manager; NULL indicates a top-level position with no direct report';

ALTER TABLE myapp_memberships_public.org_chart_edges 
  ADD CONSTRAINT org_chart_edges_parent_id_fkey
    FOREIGN KEY(parent_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE SET NULL;

ALTER TABLE myapp_memberships_public.org_chart_edges 
  ADD COLUMN position_title text;

COMMENT ON COLUMN myapp_memberships_public.org_chart_edges.position_title IS 'Job title or role name for this position in the org chart';

ALTER TABLE myapp_memberships_public.org_chart_edges 
  ADD COLUMN position_level int;

COMMENT ON COLUMN myapp_memberships_public.org_chart_edges.position_level IS 'Numeric seniority level for this position (higher = more senior)';

ALTER TABLE myapp_memberships_public.org_chart_edges 
  ADD CONSTRAINT org_chart_edges_entity_id_child_id_key 
    UNIQUE (entity_id, child_id);

CREATE INDEX org_chart_edges_entity_id_idx ON myapp_memberships_public.org_chart_edges (entity_id);

CREATE INDEX org_chart_edges_parent_id_idx ON myapp_memberships_public.org_chart_edges (parent_id);

CREATE INDEX org_chart_edges_child_id_idx ON myapp_memberships_public.org_chart_edges (child_id);

ALTER TABLE myapp_memberships_public.org_chart_edges 
  ADD CONSTRAINT org_chart_edges_child_id_parent_id_chk 
    CHECK (child_id <> parent_id);

CREATE TABLE myapp_memberships_private.org_hierarchy_sprts ();

ALTER TABLE myapp_memberships_private.org_hierarchy_sprts 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_memberships_private.org_hierarchy_sprts IS 'Transitive closure support table for fast ancestor/descendant lookups; rebuilt automatically by triggers';

ALTER TABLE myapp_memberships_private.org_hierarchy_sprts 
  ADD COLUMN entity_id uuid;

ALTER TABLE myapp_memberships_private.org_hierarchy_sprts 
  ALTER COLUMN entity_id SET NOT NULL;

COMMENT ON COLUMN myapp_memberships_private.org_hierarchy_sprts.entity_id IS 'Organization this closure row belongs to';

ALTER TABLE myapp_memberships_private.org_hierarchy_sprts 
  ADD COLUMN ancestor_id uuid;

ALTER TABLE myapp_memberships_private.org_hierarchy_sprts 
  ALTER COLUMN ancestor_id SET NOT NULL;

COMMENT ON COLUMN myapp_memberships_private.org_hierarchy_sprts.ancestor_id IS 'User ID of the ancestor (manager) in the transitive path';

ALTER TABLE myapp_memberships_private.org_hierarchy_sprts 
  ADD COLUMN descendant_id uuid;

ALTER TABLE myapp_memberships_private.org_hierarchy_sprts 
  ALTER COLUMN descendant_id SET NOT NULL;

COMMENT ON COLUMN myapp_memberships_private.org_hierarchy_sprts.descendant_id IS 'User ID of the descendant (subordinate) in the transitive path';

ALTER TABLE myapp_memberships_private.org_hierarchy_sprts 
  ADD COLUMN depth int;

ALTER TABLE myapp_memberships_private.org_hierarchy_sprts 
  ALTER COLUMN depth SET NOT NULL;

COMMENT ON COLUMN myapp_memberships_private.org_hierarchy_sprts.depth IS 'Number of edges between ancestor and descendant (0 = self-reference)';

ALTER TABLE myapp_memberships_private.org_hierarchy_sprts 
  ADD CONSTRAINT org_hierarchy_sprts_pkey PRIMARY KEY (entity_id, ancestor_id, descendant_id);

CREATE INDEX org_hierarchy_sprts_entity_id_ancestor_id_idx ON myapp_memberships_private.org_hierarchy_sprts (entity_id, ancestor_id) INCLUDE (depth);

CREATE INDEX org_hierarchy_sprts_entity_id_descendant_id_idx ON myapp_memberships_private.org_hierarchy_sprts (entity_id, descendant_id) INCLUDE (depth);

CREATE INDEX org_hierarchy_sprts_ancestor_id_idx ON myapp_memberships_private.org_hierarchy_sprts (ancestor_id);

CREATE INDEX org_hierarchy_sprts_descendant_id_idx ON myapp_memberships_private.org_hierarchy_sprts (descendant_id);

CREATE TABLE myapp_memberships_public.org_chart_edge_grants ();

ALTER TABLE myapp_memberships_public.org_chart_edge_grants 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_memberships_public.org_chart_edge_grants IS 'Append-only log of hierarchy edge grants and revocations; triggers apply changes to the edges table';

ALTER TABLE myapp_memberships_public.org_chart_edge_grants 
  ADD COLUMN id uuid;

ALTER TABLE myapp_memberships_public.org_chart_edge_grants 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_memberships_public.org_chart_edge_grants 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_memberships_public.org_chart_edge_grants 
  ADD CONSTRAINT org_chart_edge_grants_pkey PRIMARY KEY (id);

ALTER TABLE myapp_memberships_public.org_chart_edge_grants 
  ADD COLUMN entity_id uuid;

ALTER TABLE myapp_memberships_public.org_chart_edge_grants 
  ALTER COLUMN entity_id SET NOT NULL;

COMMENT ON COLUMN myapp_memberships_public.org_chart_edge_grants.entity_id IS 'Organization this grant applies to';

ALTER TABLE myapp_memberships_public.org_chart_edge_grants 
  ADD CONSTRAINT org_chart_edge_grants_entity_id_fkey
    FOREIGN KEY(entity_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE CASCADE;

ALTER TABLE myapp_memberships_public.org_chart_edge_grants 
  ADD COLUMN child_id uuid;

ALTER TABLE myapp_memberships_public.org_chart_edge_grants 
  ALTER COLUMN child_id SET NOT NULL;

COMMENT ON COLUMN myapp_memberships_public.org_chart_edge_grants.child_id IS 'User ID of the subordinate being placed in the hierarchy';

ALTER TABLE myapp_memberships_public.org_chart_edge_grants 
  ADD CONSTRAINT org_chart_edge_grants_child_id_fkey
    FOREIGN KEY(child_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE CASCADE;

ALTER TABLE myapp_memberships_public.org_chart_edge_grants 
  ADD COLUMN parent_id uuid;

COMMENT ON COLUMN myapp_memberships_public.org_chart_edge_grants.parent_id IS 'User ID of the manager being assigned; NULL for top-level positions';

ALTER TABLE myapp_memberships_public.org_chart_edge_grants 
  ADD CONSTRAINT org_chart_edge_grants_parent_id_fkey
    FOREIGN KEY(parent_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE SET NULL;

ALTER TABLE myapp_memberships_public.org_chart_edge_grants 
  ADD COLUMN grantor_id uuid;

COMMENT ON COLUMN myapp_memberships_public.org_chart_edge_grants.grantor_id IS 'User ID of the admin who performed this grant or revocation; NULL if grantor was deleted';

ALTER TABLE myapp_memberships_public.org_chart_edge_grants 
  ADD CONSTRAINT org_chart_edge_grants_grantor_id_fkey
    FOREIGN KEY(grantor_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE SET NULL;

ALTER TABLE myapp_memberships_public.org_chart_edge_grants 
  ADD COLUMN is_grant boolean;

ALTER TABLE myapp_memberships_public.org_chart_edge_grants 
  ALTER COLUMN is_grant SET NOT NULL;

ALTER TABLE myapp_memberships_public.org_chart_edge_grants 
  ALTER COLUMN is_grant SET DEFAULT true;

COMMENT ON COLUMN myapp_memberships_public.org_chart_edge_grants.is_grant IS 'TRUE to add/update the edge, FALSE to remove it';

ALTER TABLE myapp_memberships_public.org_chart_edge_grants 
  ADD COLUMN position_title text;

COMMENT ON COLUMN myapp_memberships_public.org_chart_edge_grants.position_title IS 'Job title or role name being assigned in this grant';

ALTER TABLE myapp_memberships_public.org_chart_edge_grants 
  ADD COLUMN position_level int;

COMMENT ON COLUMN myapp_memberships_public.org_chart_edge_grants.position_level IS 'Numeric seniority level being assigned in this grant';

ALTER TABLE myapp_memberships_public.org_chart_edge_grants 
  ADD COLUMN created_at timestamptz;

ALTER TABLE myapp_memberships_public.org_chart_edge_grants 
  ALTER COLUMN created_at SET NOT NULL;

ALTER TABLE myapp_memberships_public.org_chart_edge_grants 
  ALTER COLUMN created_at SET DEFAULT now();

COMMENT ON COLUMN myapp_memberships_public.org_chart_edge_grants.created_at IS 'Timestamp when this grant or revocation was recorded';

CREATE INDEX org_chart_edge_grants_entity_id_idx ON myapp_memberships_public.org_chart_edge_grants (entity_id);

CREATE INDEX org_chart_edge_grants_child_id_idx ON myapp_memberships_public.org_chart_edge_grants (child_id);

CREATE INDEX org_chart_edge_grants_parent_id_idx ON myapp_memberships_public.org_chart_edge_grants (parent_id);

CREATE INDEX org_chart_edge_grants_grantor_id_idx ON myapp_memberships_public.org_chart_edge_grants (grantor_id);

CREATE FUNCTION myapp_memberships_private.org_rebuild_org_hierarchy_sprt(
  IN target_entity_id uuid
) RETURNS void AS $EOFCODE$
BEGIN
  DELETE FROM myapp_memberships_private.org_hierarchy_sprts
  WHERE
    entity_id = target_entity_id;
  INSERT INTO myapp_memberships_private.org_hierarchy_sprts (
    entity_id,
    ancestor_id,
    descendant_id,
    depth
  )
  WITH RECURSIVE 
    hierarchy AS (SELECT
      entity_id,
      child_id AS ancestor_id,
      child_id AS descendant_id,
      0 AS depth
  FROM myapp_memberships_public.org_chart_edges
  WHERE
      entity_id = target_entity_id
  UNION
  ALL
  SELECT
      h.entity_id,
      e.parent_id AS ancestor_id,
      h.descendant_id AS descendant_id,
      h.depth + 1 AS depth
  FROM hierarchy AS h INNER JOIN myapp_memberships_public.org_chart_edges AS e ON e.entity_id = h.entity_id AND e.child_id = h.ancestor_id
  WHERE
      e.parent_id IS NOT NULL AND h.depth <= 99)
  SELECT DISTINCT
    entity_id,
    ancestor_id,
    descendant_id,
    depth
  FROM hierarchy;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION myapp_memberships_private.org_org_chart_edge_grants_apply_tg() RETURNS trigger AS $EOFCODE$
BEGIN
  IF NEW.is_grant IS TRUE THEN
    INSERT INTO myapp_memberships_public.org_chart_edges (
      entity_id,
      child_id,
      parent_id,
      position_title,
      position_level,
      created_at,
      updated_at
    )
    VALUES
      (NEW.entity_id, NEW.child_id, NEW.parent_id, NEW.position_title, NEW.position_level, now(), now())
    ON CONFLICT (entity_id, child_id) DO UPDATE SET
    parent_id = EXCLUDED.parent_id, position_title = EXCLUDED.position_title, position_level = EXCLUDED.position_level, updated_at = now();
  ELSE
    DELETE FROM myapp_memberships_public.org_chart_edges
    WHERE
      entity_id = NEW.entity_id AND child_id = NEW.child_id;
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE TRIGGER _00010_org_edge_grants_apply
  AFTER INSERT
  ON myapp_memberships_public.org_chart_edge_grants
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_memberships_private.org_org_chart_edge_grants_apply_tg();

CREATE FUNCTION myapp_memberships_private.org_org_chart_edge_insert_tg() RETURNS trigger AS $EOFCODE$
BEGIN
  PERFORM myapp_memberships_private.org_rebuild_org_hierarchy_sprt(d.entity_id)
  FROM (SELECT DISTINCT entity_id
  FROM new_rows) AS d;
  RETURN NULL;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE TRIGGER _99990_org_edge_insert_sprt
  AFTER INSERT
  ON myapp_memberships_public.org_chart_edges
  REFERENCING NEW TABLE AS new_rows
  FOR EACH STATEMENT
  EXECUTE PROCEDURE myapp_memberships_private.org_org_chart_edge_insert_tg();

CREATE FUNCTION myapp_memberships_private.org_org_chart_edge_update_tg() RETURNS trigger AS $EOFCODE$
BEGIN
  PERFORM myapp_memberships_private.org_rebuild_org_hierarchy_sprt(d.entity_id)
  FROM (SELECT entity_id
  FROM old_rows
  UNION
  SELECT entity_id
  FROM new_rows) AS d;
  RETURN NULL;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE TRIGGER _99990_org_edge_update_sprt
  AFTER UPDATE
  ON myapp_memberships_public.org_chart_edges
  REFERENCING OLD TABLE AS old_rows NEW TABLE AS new_rows
  FOR EACH STATEMENT
  EXECUTE PROCEDURE myapp_memberships_private.org_org_chart_edge_update_tg();

CREATE FUNCTION myapp_memberships_private.org_org_chart_edge_delete_tg() RETURNS trigger AS $EOFCODE$
BEGIN
  PERFORM myapp_memberships_private.org_rebuild_org_hierarchy_sprt(d.entity_id)
  FROM (SELECT DISTINCT entity_id
  FROM old_rows) AS d;
  RETURN NULL;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE TRIGGER _99990_org_edge_delete_sprt
  AFTER DELETE
  ON myapp_memberships_public.org_chart_edges
  REFERENCING OLD TABLE AS old_rows
  FOR EACH STATEMENT
  EXECUTE PROCEDURE myapp_memberships_private.org_org_chart_edge_delete_tg();

CREATE FUNCTION myapp_memberships_private.org_org_chart_validate_no_cycle_tg() RETURNS trigger AS $EOFCODE$
DECLARE
  v_has_cycle boolean;
BEGIN
  IF NEW.parent_id IS NULL THEN
    RETURN NEW;
  END IF;
  WITH RECURSIVE 
    ancestors AS (SELECT
      parent_id,
      child_id,
      1 AS depth
  FROM myapp_memberships_public.org_chart_edges
  WHERE
      child_id = NEW.parent_id AND entity_id = NEW.entity_id
  UNION
  ALL
  SELECT
      e.parent_id,
      e.child_id,
      a.depth + 1 AS depth
  FROM ancestors AS a INNER JOIN myapp_memberships_public.org_chart_edges AS e ON e.child_id = a.parent_id AND e.entity_id = NEW.entity_id
  WHERE
      a.depth <= 99)
  SELECT
    EXISTS (SELECT 1
    FROM ancestors
    WHERE
      parent_id = NEW.child_id) INTO v_has_cycle;
  IF v_has_cycle THEN
    RAISE EXCEPTION 'HIERARCHY_CYCLE_DETECTED: Setting % as parent of % would create a cycle', NEW.parent_id, NEW.child_id;
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY INVOKER;

CREATE TRIGGER _00010_org_validate_no_cycle_insert
  BEFORE INSERT
  ON myapp_memberships_public.org_chart_edges
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_memberships_private.org_org_chart_validate_no_cycle_tg();

CREATE TRIGGER _00010_org_validate_no_cycle_update
  BEFORE UPDATE
  ON myapp_memberships_public.org_chart_edges
  FOR EACH ROW
  WHEN (old.parent_id IS DISTINCT FROM new.parent_id)
  EXECUTE PROCEDURE myapp_memberships_private.org_org_chart_validate_no_cycle_tg();

CREATE FUNCTION myapp_memberships_private.org_org_chart_validate_active_member_tg() RETURNS trigger AS $EOFCODE$
DECLARE
  v_is_active boolean;
BEGIN
  SELECT
    (m.is_approved IS TRUE AND m.is_disabled IS FALSE) AND m.is_banned IS FALSE
  FROM myapp_memberships_public.org_memberships AS m
  WHERE
    m.entity_id = NEW.entity_id AND m.actor_id = NEW.child_id INTO v_is_active;
  IF v_is_active IS NOT TRUE THEN
    RAISE EXCEPTION 'HIERARCHY_INACTIVE_MEMBER: Cannot add user % to hierarchy - user must be an active member of the organization first', NEW.child_id;
  END IF;
  IF NEW.parent_id IS NOT NULL THEN
    SELECT
      (m.is_approved IS TRUE AND m.is_disabled IS FALSE) AND m.is_banned IS FALSE
    FROM myapp_memberships_public.org_memberships AS m
    WHERE
      m.entity_id = NEW.entity_id AND m.actor_id = NEW.parent_id INTO v_is_active;
    IF v_is_active IS NOT TRUE THEN
      RAISE EXCEPTION 'HIERARCHY_INACTIVE_MEMBER: Cannot set user % as parent - user must be an active member of the organization', NEW.parent_id;
    END IF;
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE TRIGGER _00015_org_validate_active_member_insert
  BEFORE INSERT
  ON myapp_memberships_public.org_chart_edges
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_memberships_private.org_org_chart_validate_active_member_tg();

CREATE TRIGGER _00015_org_validate_active_member_update
  BEFORE UPDATE
  ON myapp_memberships_public.org_chart_edges
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_memberships_private.org_org_chart_validate_active_member_tg();

CREATE FUNCTION myapp_memberships_private.org_membership_validate_not_in_hierarchy_tg() RETURNS trigger AS $EOFCODE$
DECLARE
  v_old_is_active boolean;
  v_new_is_active boolean;
  v_in_hierarchy boolean;
BEGIN
  v_old_is_active := (OLD.is_approved IS TRUE AND OLD.is_disabled IS FALSE) AND OLD.is_banned IS FALSE;
  v_new_is_active := (NEW.is_approved IS TRUE AND NEW.is_disabled IS FALSE) AND NEW.is_banned IS FALSE;
  IF v_old_is_active IS TRUE AND v_new_is_active IS NOT TRUE THEN
    SELECT
      EXISTS (SELECT 1
      FROM myapp_memberships_public.org_chart_edges AS e
      WHERE
        e.entity_id = NEW.entity_id AND (e.child_id = NEW.actor_id OR e.parent_id = NEW.actor_id)) INTO v_in_hierarchy;
    IF v_in_hierarchy THEN
      RAISE EXCEPTION 'HIERARCHY_MEMBER_IN_USE: Cannot deactivate user % - user must be removed from the organization hierarchy first', NEW.actor_id;
    END IF;
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE TRIGGER _00020_org_validate_not_in_hierarchy
  BEFORE UPDATE
  ON myapp_memberships_public.org_memberships
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_memberships_private.org_membership_validate_not_in_hierarchy_tg();

CREATE FUNCTION myapp_memberships_public.org_get_subordinates(
  IN target_entity_id uuid,
  IN target_user_id uuid,
  IN max_depth int DEFAULT NULL
) RETURNS TABLE (
  user_id uuid,
  depth int
) AS $EOFCODE$
BEGIN
  RETURN QUERY SELECT
    descendant_id AS user_id,
    h.depth
  FROM myapp_memberships_private.org_hierarchy_sprts AS h
  WHERE
    ((h.entity_id = target_entity_id AND h.ancestor_id = target_user_id) AND h.descendant_id <> target_user_id) AND (max_depth IS NULL OR h.depth <= max_depth);
END;
$EOFCODE$ LANGUAGE plpgsql STABLE SECURITY DEFINER;

CREATE FUNCTION myapp_memberships_public.org_get_managers(
  IN target_entity_id uuid,
  IN target_user_id uuid,
  IN max_depth int DEFAULT NULL
) RETURNS TABLE (
  user_id uuid,
  depth int
) AS $EOFCODE$
BEGIN
  RETURN QUERY SELECT
    ancestor_id AS user_id,
    h.depth
  FROM myapp_memberships_private.org_hierarchy_sprts AS h
  WHERE
    ((h.entity_id = target_entity_id AND h.descendant_id = target_user_id) AND h.ancestor_id <> target_user_id) AND (max_depth IS NULL OR h.depth <= max_depth);
END;
$EOFCODE$ LANGUAGE plpgsql STABLE SECURITY DEFINER;

CREATE FUNCTION myapp_memberships_public.org_is_manager_of(
  IN target_entity_id uuid,
  IN manager_id uuid,
  IN user_id uuid,
  IN max_depth int DEFAULT NULL
) RETURNS boolean AS $EOFCODE$
BEGIN
  RETURN EXISTS (SELECT 1
  FROM myapp_memberships_private.org_hierarchy_sprts AS h
  WHERE
    ((h.entity_id = target_entity_id AND h.ancestor_id = manager_id) AND (h.descendant_id = user_id AND h.ancestor_id <> h.descendant_id)) AND (max_depth IS NULL OR h.depth <= max_depth));
END;
$EOFCODE$ LANGUAGE plpgsql STABLE SECURITY DEFINER;

INSERT INTO myapp_permissions_public.org_permissions (
  bitnum,
  name,
  description
) VALUES
  (17, 'manage_hierarchy', 'Manage organizational chart structure and reporting relationships.');

ALTER TABLE myapp_memberships_public.org_chart_edges 
  ENABLE ROW LEVEL SECURITY;

GRANT SELECT ON myapp_memberships_public.org_chart_edges TO authenticated;

GRANT INSERT ON myapp_memberships_public.org_chart_edges TO authenticated;

GRANT UPDATE ON myapp_memberships_public.org_chart_edges TO authenticated;

GRANT DELETE ON myapp_memberships_public.org_chart_edges TO authenticated;

CREATE POLICY auth_sel_ent_mem
  ON myapp_memberships_public.org_chart_edges
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    entity_id IN (SELECT org_sprt.entity_id
    FROM myapp_memberships_private.org_memberships_sprt AS org_sprt
    WHERE
      org_sprt.actor_id = jwt_public.current_principal_id())
  );

CREATE POLICY auth_ins_ent_mem
  ON myapp_memberships_public.org_chart_edges
  AS PERMISSIVE
  FOR INSERT
  TO authenticated
  WITH CHECK (
    entity_id IN (SELECT org_sprt.entity_id
    FROM myapp_memberships_private.org_memberships_sprt AS org_sprt
    WHERE
      org_sprt.actor_id = jwt_public.current_principal_id()
      AND (org_sprt.permissions & '0000000000000000000000000000000000000000000000010000000000000000') = '0000000000000000000000000000000000000000000000010000000000000000')
  );

CREATE POLICY auth_upd_ent_mem
  ON myapp_memberships_public.org_chart_edges
  AS PERMISSIVE
  FOR UPDATE
  TO authenticated
  USING (
    entity_id IN (SELECT org_sprt.entity_id
    FROM myapp_memberships_private.org_memberships_sprt AS org_sprt
    WHERE
      org_sprt.actor_id = jwt_public.current_principal_id()
      AND (org_sprt.permissions & '0000000000000000000000000000000000000000000000010000000000000000') = '0000000000000000000000000000000000000000000000010000000000000000')
  );

CREATE POLICY auth_del_ent_mem
  ON myapp_memberships_public.org_chart_edges
  AS PERMISSIVE
  FOR DELETE
  TO authenticated
  USING (
    entity_id IN (SELECT org_sprt.entity_id
    FROM myapp_memberships_private.org_memberships_sprt AS org_sprt
    WHERE
      org_sprt.actor_id = jwt_public.current_principal_id()
      AND (org_sprt.permissions & '0000000000000000000000000000000000000000000000010000000000000000') = '0000000000000000000000000000000000000000000000010000000000000000')
  );

ALTER TABLE myapp_memberships_public.org_chart_edge_grants 
  ENABLE ROW LEVEL SECURITY;

GRANT SELECT ON myapp_memberships_public.org_chart_edge_grants TO authenticated;

GRANT INSERT ON myapp_memberships_public.org_chart_edge_grants TO authenticated;

CREATE POLICY auth_sel_ent_mem
  ON myapp_memberships_public.org_chart_edge_grants
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    entity_id IN (SELECT org_sprt.entity_id
    FROM myapp_memberships_private.org_memberships_sprt AS org_sprt
    WHERE
      org_sprt.actor_id = jwt_public.current_principal_id()
      AND (org_sprt.permissions & '0000000000000000000000000000000000000000000000010000000000000000') = '0000000000000000000000000000000000000000000000010000000000000000')
  );

CREATE POLICY auth_ins_ent_mem
  ON myapp_memberships_public.org_chart_edge_grants
  AS PERMISSIVE
  FOR INSERT
  TO authenticated
  WITH CHECK (
    entity_id IN (SELECT org_sprt.entity_id
    FROM myapp_memberships_private.org_memberships_sprt AS org_sprt
    WHERE
      org_sprt.actor_id = jwt_public.current_principal_id()
      AND (org_sprt.permissions & '0000000000000000000000000000000000000000000000010000000000000000') = '0000000000000000000000000000000000000000000000010000000000000000')
  );

GRANT SELECT ON myapp_memberships_private.org_hierarchy_sprts TO authenticated;

GRANT INSERT ON myapp_permissions_public.org_permissions TO authenticated;

GRANT UPDATE ON myapp_permissions_public.org_permissions TO authenticated;

GRANT DELETE ON myapp_permissions_public.org_permissions TO authenticated;

CREATE POLICY auth_ins_app_mem
  ON myapp_permissions_public.org_permissions
  AS PERMISSIVE
  FOR INSERT
  TO authenticated
  WITH CHECK (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000000001000000') = '0000000000000000000000000000000000000000000000000000000001000000')
  );

CREATE POLICY auth_upd_app_mem
  ON myapp_permissions_public.org_permissions
  AS PERMISSIVE
  FOR UPDATE
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000000001000000') = '0000000000000000000000000000000000000000000000000000000001000000')
  );

CREATE POLICY auth_del_app_mem
  ON myapp_permissions_public.org_permissions
  AS PERMISSIVE
  FOR DELETE
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000000001000000') = '0000000000000000000000000000000000000000000000000000000001000000')
  );

ALTER TABLE myapp_permissions_public.org_permission_defaults 
  ENABLE ROW LEVEL SECURITY;

GRANT INSERT ON myapp_permissions_public.org_permission_defaults TO authenticated;

GRANT SELECT ON myapp_permissions_public.org_permission_defaults TO authenticated;

GRANT DELETE ON myapp_permissions_public.org_permission_defaults TO authenticated;

CREATE POLICY auth_ins_ent_mem
  ON myapp_permissions_public.org_permission_defaults
  AS PERMISSIVE
  FOR INSERT
  TO authenticated
  WITH CHECK (
    entity_id IN (SELECT org_sprt.entity_id
    FROM myapp_memberships_private.org_memberships_sprt AS org_sprt
    WHERE
      org_sprt.actor_id = jwt_public.current_principal_id()
      AND (org_sprt.permissions & '0000000000000000000000000000000000000000000000000000000001000000') = '0000000000000000000000000000000000000000000000000000000001000000')
  );

CREATE POLICY auth_sel_ent_mem
  ON myapp_permissions_public.org_permission_defaults
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    entity_id IN (SELECT org_sprt.entity_id
    FROM myapp_memberships_private.org_memberships_sprt AS org_sprt
    WHERE
      org_sprt.actor_id = jwt_public.current_principal_id()
      AND (org_sprt.permissions & '0000000000000000000000000000000000000000000000000000000001000000') = '0000000000000000000000000000000000000000000000000000000001000000')
  );

CREATE POLICY auth_del_ent_mem
  ON myapp_permissions_public.org_permission_defaults
  AS PERMISSIVE
  FOR DELETE
  TO authenticated
  USING (
    entity_id IN (SELECT org_sprt.entity_id
    FROM myapp_memberships_private.org_memberships_sprt AS org_sprt
    WHERE
      org_sprt.actor_id = jwt_public.current_principal_id()
      AND (org_sprt.permissions & '0000000000000000000000000000000000000000000000000000000001000000') = '0000000000000000000000000000000000000000000000000000000001000000')
  );

ALTER TABLE myapp_limits_public.org_limits 
  ENABLE ROW LEVEL SECURITY;

GRANT INSERT ON myapp_limits_public.org_limits TO authenticated;

GRANT SELECT ON myapp_limits_public.org_limits TO authenticated;

GRANT UPDATE ON myapp_limits_public.org_limits TO authenticated;

GRANT DELETE ON myapp_limits_public.org_limits TO authenticated;

CREATE POLICY auth_ins_ent_mem
  ON myapp_limits_public.org_limits
  AS PERMISSIVE
  FOR INSERT
  TO authenticated
  WITH CHECK (
    entity_id IN (SELECT org_sprt.entity_id
    FROM myapp_memberships_private.org_memberships_sprt AS org_sprt
    WHERE
      org_sprt.actor_id = jwt_public.current_principal_id()
      AND (org_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000000001') = '0000000000000000000000000000000000000000000000000000000000000001')
  );

CREATE POLICY auth_sel_ent_mem
  ON myapp_limits_public.org_limits
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    entity_id IN (SELECT org_sprt.entity_id
    FROM myapp_memberships_private.org_memberships_sprt AS org_sprt
    WHERE
      org_sprt.actor_id = jwt_public.current_principal_id()
      AND (org_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000000001') = '0000000000000000000000000000000000000000000000000000000000000001')
  );

CREATE POLICY auth_upd_ent_mem
  ON myapp_limits_public.org_limits
  AS PERMISSIVE
  FOR UPDATE
  TO authenticated
  USING (
    entity_id IN (SELECT org_sprt.entity_id
    FROM myapp_memberships_private.org_memberships_sprt AS org_sprt
    WHERE
      org_sprt.actor_id = jwt_public.current_principal_id()
      AND (org_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000000001') = '0000000000000000000000000000000000000000000000000000000000000001')
  );

CREATE POLICY auth_del_ent_mem
  ON myapp_limits_public.org_limits
  AS PERMISSIVE
  FOR DELETE
  TO authenticated
  USING (
    entity_id IN (SELECT org_sprt.entity_id
    FROM myapp_memberships_private.org_memberships_sprt AS org_sprt
    WHERE
      org_sprt.actor_id = jwt_public.current_principal_id()
      AND (org_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000000001') = '0000000000000000000000000000000000000000000000000000000000000001')
  );

CREATE POLICY auth_sel_own
  ON myapp_limits_public.org_limits
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    actor_id = jwt_public.current_principal_id()
  );

CREATE POLICY auth_sel_ent_mem
  ON myapp_limits_public.org_limit_credits
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    entity_id IN (SELECT org_sprt.entity_id
    FROM myapp_memberships_private.org_memberships_sprt AS org_sprt
    WHERE
      org_sprt.actor_id = jwt_public.current_principal_id()
      AND (org_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000100000') = '0000000000000000000000000000000000000000000000000000000000100000')
  );

CREATE POLICY auth_sel_ent_mem
  ON myapp_limits_public.org_limit_events
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    entity_id IN (SELECT org_sprt.entity_id
    FROM myapp_memberships_private.org_memberships_sprt AS org_sprt
    WHERE
      org_sprt.actor_id = jwt_public.current_principal_id()
      AND (org_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000100000') = '0000000000000000000000000000000000000000000000000000000000100000')
  );

CREATE POLICY auth_ins_ent_mem
  ON myapp_limits_public.app_limit_credit_redemptions
  AS PERMISSIVE
  FOR INSERT
  TO authenticated
  WITH CHECK (
    entity_id IN (SELECT org_sprt.entity_id
    FROM myapp_memberships_private.org_memberships_sprt AS org_sprt
    WHERE
      org_sprt.actor_id = jwt_public.current_principal_id())
  );

CREATE POLICY auth_sel_own
  ON myapp_limits_public.app_limit_credit_redemptions
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    entity_id IN (SELECT org_sprt.entity_id
    FROM myapp_memberships_private.org_memberships_sprt AS org_sprt
    WHERE
      org_sprt.actor_id = jwt_public.current_principal_id())
  );

ALTER TABLE myapp_limits_public.org_limit_defaults 
  ENABLE ROW LEVEL SECURITY;

GRANT INSERT ON myapp_limits_public.org_limit_defaults TO authenticated;

GRANT SELECT ON myapp_limits_public.org_limit_defaults TO authenticated;

GRANT UPDATE ON myapp_limits_public.org_limit_defaults TO authenticated;

GRANT DELETE ON myapp_limits_public.org_limit_defaults TO authenticated;

CREATE POLICY auth_ins_app_mem
  ON myapp_limits_public.org_limit_defaults
  AS PERMISSIVE
  FOR INSERT
  TO authenticated
  WITH CHECK (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000100000') = '0000000000000000000000000000000000000000000000000000000000100000')
  );

CREATE POLICY auth_sel_app_mem
  ON myapp_limits_public.org_limit_defaults
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000100000') = '0000000000000000000000000000000000000000000000000000000000100000')
  );

CREATE POLICY auth_upd_app_mem
  ON myapp_limits_public.org_limit_defaults
  AS PERMISSIVE
  FOR UPDATE
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000100000') = '0000000000000000000000000000000000000000000000000000000000100000')
  );

CREATE POLICY auth_del_app_mem
  ON myapp_limits_public.org_limit_defaults
  AS PERMISSIVE
  FOR DELETE
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000100000') = '0000000000000000000000000000000000000000000000000000000000100000')
  );

ALTER TABLE myapp_limits_public.org_limit_aggregates 
  ENABLE ROW LEVEL SECURITY;

GRANT INSERT ON myapp_limits_public.org_limit_aggregates TO authenticated;

GRANT SELECT ON myapp_limits_public.org_limit_aggregates TO authenticated;

GRANT UPDATE ON myapp_limits_public.org_limit_aggregates TO authenticated;

GRANT DELETE ON myapp_limits_public.org_limit_aggregates TO authenticated;

CREATE POLICY auth_sel_ent_mem
  ON myapp_limits_public.org_limit_aggregates
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    entity_id IN (SELECT org_sprt.entity_id
    FROM myapp_memberships_private.org_memberships_sprt AS org_sprt
    WHERE
      org_sprt.actor_id = jwt_public.current_principal_id()
      AND (org_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000000001') = '0000000000000000000000000000000000000000000000000000000000000001')
  );

CREATE POLICY auth_ins_admin
  ON myapp_limits_public.org_limit_aggregates
  AS PERMISSIVE
  FOR INSERT
  TO authenticated
  WITH CHECK (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.is_admin IS TRUE
      OR app_sprt.is_owner IS TRUE))
  );

CREATE POLICY auth_sel_admin
  ON myapp_limits_public.org_limit_aggregates
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.is_admin IS TRUE
      OR app_sprt.is_owner IS TRUE))
  );

CREATE POLICY auth_upd_admin
  ON myapp_limits_public.org_limit_aggregates
  AS PERMISSIVE
  FOR UPDATE
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.is_admin IS TRUE
      OR app_sprt.is_owner IS TRUE))
  );

CREATE POLICY auth_del_admin
  ON myapp_limits_public.org_limit_aggregates
  AS PERMISSIVE
  FOR DELETE
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.is_admin IS TRUE
      OR app_sprt.is_owner IS TRUE))
  );

ALTER TABLE myapp_limits_public.org_limit_caps_defaults 
  ENABLE ROW LEVEL SECURITY;

GRANT SELECT ON myapp_limits_public.org_limit_caps_defaults TO authenticated;

CREATE POLICY auth_sel_app_mem
  ON myapp_limits_public.org_limit_caps_defaults
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id())
  );

GRANT INSERT ON myapp_limits_public.org_limit_caps_defaults TO authenticated;

GRANT UPDATE ON myapp_limits_public.org_limit_caps_defaults TO authenticated;

GRANT DELETE ON myapp_limits_public.org_limit_caps_defaults TO authenticated;

CREATE POLICY auth_ins_app_mem
  ON myapp_limits_public.org_limit_caps_defaults
  AS PERMISSIVE
  FOR INSERT
  TO authenticated
  WITH CHECK (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000100000') = '0000000000000000000000000000000000000000000000000000000000100000')
  );

CREATE POLICY auth_upd_app_mem
  ON myapp_limits_public.org_limit_caps_defaults
  AS PERMISSIVE
  FOR UPDATE
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000100000') = '0000000000000000000000000000000000000000000000000000000000100000')
  );

CREATE POLICY auth_del_app_mem
  ON myapp_limits_public.org_limit_caps_defaults
  AS PERMISSIVE
  FOR DELETE
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000100000') = '0000000000000000000000000000000000000000000000000000000000100000')
  );

ALTER TABLE myapp_limits_public.org_limit_caps 
  ENABLE ROW LEVEL SECURITY;

GRANT SELECT ON myapp_limits_public.org_limit_caps TO authenticated;

CREATE POLICY auth_sel_ent_mem
  ON myapp_limits_public.org_limit_caps
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    entity_id IN (SELECT org_sprt.entity_id
    FROM myapp_memberships_private.org_memberships_sprt AS org_sprt
    WHERE
      org_sprt.actor_id = jwt_public.current_principal_id())
  );

GRANT INSERT ON myapp_limits_public.org_limit_caps TO authenticated;

GRANT UPDATE ON myapp_limits_public.org_limit_caps TO authenticated;

GRANT DELETE ON myapp_limits_public.org_limit_caps TO authenticated;

CREATE POLICY auth_ins_admin
  ON myapp_limits_public.org_limit_caps
  AS PERMISSIVE
  FOR INSERT
  TO authenticated
  WITH CHECK (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.is_admin IS TRUE
      OR app_sprt.is_owner IS TRUE))
  );

CREATE POLICY auth_upd_admin
  ON myapp_limits_public.org_limit_caps
  AS PERMISSIVE
  FOR UPDATE
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.is_admin IS TRUE
      OR app_sprt.is_owner IS TRUE))
  );

CREATE POLICY auth_del_admin
  ON myapp_limits_public.org_limit_caps
  AS PERMISSIVE
  FOR DELETE
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.is_admin IS TRUE
      OR app_sprt.is_owner IS TRUE))
  );

ALTER TABLE myapp_memberships_public.org_members 
  ENABLE ROW LEVEL SECURITY;

GRANT SELECT ON myapp_memberships_public.org_members TO authenticated;

CREATE POLICY auth_sel_ent_mem
  ON myapp_memberships_public.org_members
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    entity_id IN (SELECT org_sprt.entity_id
    FROM myapp_memberships_private.org_memberships_sprt AS org_sprt
    WHERE
      org_sprt.actor_id = jwt_public.current_principal_id())
  );

ALTER TABLE myapp_memberships_public.org_memberships 
  ENABLE ROW LEVEL SECURITY;

GRANT SELECT ON myapp_memberships_public.org_memberships TO authenticated;

GRANT DELETE ON myapp_memberships_public.org_memberships TO authenticated;

GRANT INSERT ( actor_id, entity_id ) ON myapp_memberships_public.org_memberships TO authenticated;

GRANT UPDATE ( is_banned, is_approved, is_disabled, is_read_only ) ON myapp_memberships_public.org_memberships TO authenticated;

CREATE POLICY auth_ins_ent_mem
  ON myapp_memberships_public.org_memberships
  AS PERMISSIVE
  FOR INSERT
  TO authenticated
  WITH CHECK (
    entity_id IN (SELECT org_sprt.entity_id
    FROM myapp_memberships_private.org_memberships_sprt AS org_sprt
    WHERE
      org_sprt.actor_id = jwt_public.current_principal_id()
      AND (org_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000000001') = '0000000000000000000000000000000000000000000000000000000000000001')
  );

CREATE POLICY auth_sel_ent_mem
  ON myapp_memberships_public.org_memberships
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    entity_id IN (SELECT org_sprt.entity_id
    FROM myapp_memberships_private.org_memberships_sprt AS org_sprt
    WHERE
      org_sprt.actor_id = jwt_public.current_principal_id()
      AND (org_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000000001') = '0000000000000000000000000000000000000000000000000000000000000001')
  );

CREATE POLICY auth_upd_ent_mem
  ON myapp_memberships_public.org_memberships
  AS PERMISSIVE
  FOR UPDATE
  TO authenticated
  USING (
    entity_id IN (SELECT org_sprt.entity_id
    FROM myapp_memberships_private.org_memberships_sprt AS org_sprt
    WHERE
      org_sprt.actor_id = jwt_public.current_principal_id()
      AND (org_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000000001') = '0000000000000000000000000000000000000000000000000000000000000001')
  );

CREATE POLICY auth_del_ent_mem
  ON myapp_memberships_public.org_memberships
  AS PERMISSIVE
  FOR DELETE
  TO authenticated
  USING (
    entity_id IN (SELECT org_sprt.entity_id
    FROM myapp_memberships_private.org_memberships_sprt AS org_sprt
    WHERE
      org_sprt.actor_id = jwt_public.current_principal_id()
      AND (org_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000000001') = '0000000000000000000000000000000000000000000000000000000000000001')
  );

CREATE POLICY auth_ins_own
  ON myapp_memberships_public.org_memberships
  AS PERMISSIVE
  FOR INSERT
  TO authenticated
  WITH CHECK (
    actor_id = jwt_public.current_principal_id()
  );

CREATE POLICY auth_sel_own
  ON myapp_memberships_public.org_memberships
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    actor_id = jwt_public.current_principal_id()
  );

CREATE POLICY auth_del_delete_own
  ON myapp_memberships_public.org_memberships
  AS PERMISSIVE
  FOR DELETE
  TO authenticated
  USING (
    actor_id = jwt_public.current_principal_id()
      AND is_banned IS FALSE
  );

ALTER TABLE myapp_memberships_public.org_membership_defaults 
  ENABLE ROW LEVEL SECURITY;

GRANT INSERT ON myapp_memberships_public.org_membership_defaults TO authenticated;

GRANT SELECT ON myapp_memberships_public.org_membership_defaults TO authenticated;

GRANT UPDATE ON myapp_memberships_public.org_membership_defaults TO authenticated;

GRANT DELETE ON myapp_memberships_public.org_membership_defaults TO authenticated;

CREATE POLICY auth_ins_ent_mem
  ON myapp_memberships_public.org_membership_defaults
  AS PERMISSIVE
  FOR INSERT
  TO authenticated
  WITH CHECK (
    entity_id IN (SELECT org_sprt.entity_id
    FROM myapp_memberships_private.org_memberships_sprt AS org_sprt
    WHERE
      org_sprt.actor_id = jwt_public.current_principal_id()
      AND (org_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000000001') = '0000000000000000000000000000000000000000000000000000000000000001')
  );

CREATE POLICY auth_sel_ent_mem
  ON myapp_memberships_public.org_membership_defaults
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    entity_id IN (SELECT org_sprt.entity_id
    FROM myapp_memberships_private.org_memberships_sprt AS org_sprt
    WHERE
      org_sprt.actor_id = jwt_public.current_principal_id()
      AND (org_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000000001') = '0000000000000000000000000000000000000000000000000000000000000001')
  );

CREATE POLICY auth_upd_ent_mem
  ON myapp_memberships_public.org_membership_defaults
  AS PERMISSIVE
  FOR UPDATE
  TO authenticated
  USING (
    entity_id IN (SELECT org_sprt.entity_id
    FROM myapp_memberships_private.org_memberships_sprt AS org_sprt
    WHERE
      org_sprt.actor_id = jwt_public.current_principal_id()
      AND (org_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000000001') = '0000000000000000000000000000000000000000000000000000000000000001')
  );

CREATE POLICY auth_del_ent_mem
  ON myapp_memberships_public.org_membership_defaults
  AS PERMISSIVE
  FOR DELETE
  TO authenticated
  USING (
    entity_id IN (SELECT org_sprt.entity_id
    FROM myapp_memberships_private.org_memberships_sprt AS org_sprt
    WHERE
      org_sprt.actor_id = jwt_public.current_principal_id()
      AND (org_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000000001') = '0000000000000000000000000000000000000000000000000000000000000001')
  );

ALTER TABLE myapp_memberships_public.org_membership_settings 
  ENABLE ROW LEVEL SECURITY;

GRANT SELECT ON myapp_memberships_public.org_membership_settings TO authenticated;

GRANT UPDATE ON myapp_memberships_public.org_membership_settings TO authenticated;

CREATE POLICY auth_sel_ent_mem
  ON myapp_memberships_public.org_membership_settings
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    entity_id IN (SELECT org_sprt.entity_id
    FROM myapp_memberships_private.org_memberships_sprt AS org_sprt
    WHERE
      org_sprt.actor_id = jwt_public.current_principal_id()
      AND (org_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000000001') = '0000000000000000000000000000000000000000000000000000000000000001')
  );

CREATE POLICY auth_upd_ent_mem
  ON myapp_memberships_public.org_membership_settings
  AS PERMISSIVE
  FOR UPDATE
  TO authenticated
  USING (
    entity_id IN (SELECT org_sprt.entity_id
    FROM myapp_memberships_private.org_memberships_sprt AS org_sprt
    WHERE
      org_sprt.actor_id = jwt_public.current_principal_id()
      AND (org_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000000001') = '0000000000000000000000000000000000000000000000000000000000000001')
  );

ALTER TABLE myapp_memberships_public.org_grants 
  ENABLE ROW LEVEL SECURITY;

GRANT INSERT ON myapp_memberships_public.org_grants TO authenticated;

GRANT SELECT ON myapp_memberships_public.org_grants TO authenticated;

CREATE POLICY auth_ins_ent_mem
  ON myapp_memberships_public.org_grants
  AS PERMISSIVE
  FOR INSERT
  TO authenticated
  WITH CHECK (
    entity_id IN (SELECT org_sprt.entity_id
    FROM myapp_memberships_private.org_memberships_sprt AS org_sprt
    WHERE
      org_sprt.actor_id = jwt_public.current_principal_id()
      AND (org_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000000001') = '0000000000000000000000000000000000000000000000000000000000000001')
  );

CREATE POLICY auth_sel_ent_mem
  ON myapp_memberships_public.org_grants
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    entity_id IN (SELECT org_sprt.entity_id
    FROM myapp_memberships_private.org_memberships_sprt AS org_sprt
    WHERE
      org_sprt.actor_id = jwt_public.current_principal_id()
      AND (org_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000000001') = '0000000000000000000000000000000000000000000000000000000000000001')
  );

ALTER TABLE myapp_memberships_public.org_admin_grants 
  ENABLE ROW LEVEL SECURITY;

GRANT INSERT ON myapp_memberships_public.org_admin_grants TO authenticated;

GRANT SELECT ON myapp_memberships_public.org_admin_grants TO authenticated;

CREATE POLICY auth_ins_ent_mem
  ON myapp_memberships_public.org_admin_grants
  AS PERMISSIVE
  FOR INSERT
  TO authenticated
  WITH CHECK (
    entity_id IN (SELECT org_sprt.entity_id
    FROM myapp_memberships_private.org_memberships_sprt AS org_sprt
    WHERE
      org_sprt.actor_id = jwt_public.current_principal_id()
      AND org_sprt.is_admin IS TRUE)
  );

CREATE POLICY auth_sel_ent_mem
  ON myapp_memberships_public.org_admin_grants
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    entity_id IN (SELECT org_sprt.entity_id
    FROM myapp_memberships_private.org_memberships_sprt AS org_sprt
    WHERE
      org_sprt.actor_id = jwt_public.current_principal_id()
      AND org_sprt.is_admin IS TRUE)
  );

ALTER TABLE myapp_memberships_public.org_owner_grants 
  ENABLE ROW LEVEL SECURITY;

GRANT INSERT ON myapp_memberships_public.org_owner_grants TO authenticated;

GRANT SELECT ON myapp_memberships_public.org_owner_grants TO authenticated;

CREATE POLICY auth_ins_ent_mem
  ON myapp_memberships_public.org_owner_grants
  AS PERMISSIVE
  FOR INSERT
  TO authenticated
  WITH CHECK (
    entity_id IN (SELECT org_sprt.entity_id
    FROM myapp_memberships_private.org_memberships_sprt AS org_sprt
    WHERE
      org_sprt.actor_id = jwt_public.current_principal_id()
      AND org_sprt.is_owner IS TRUE)
  );

CREATE POLICY auth_sel_ent_mem
  ON myapp_memberships_public.org_owner_grants
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    entity_id IN (SELECT org_sprt.entity_id
    FROM myapp_memberships_private.org_memberships_sprt AS org_sprt
    WHERE
      org_sprt.actor_id = jwt_public.current_principal_id()
      AND org_sprt.is_owner IS TRUE)
  );

ALTER TABLE myapp_memberships_public.org_permission_default_permissions 
  ENABLE ROW LEVEL SECURITY;

GRANT SELECT ON myapp_memberships_public.org_permission_default_permissions TO authenticated;

GRANT INSERT ON myapp_memberships_public.org_permission_default_permissions TO authenticated;

GRANT DELETE ON myapp_memberships_public.org_permission_default_permissions TO authenticated;

CREATE POLICY auth_sel_ent_mem
  ON myapp_memberships_public.org_permission_default_permissions
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    entity_id IN (SELECT org_sprt.entity_id
    FROM myapp_memberships_private.org_memberships_sprt AS org_sprt
    WHERE
      org_sprt.actor_id = jwt_public.current_principal_id()
      AND (org_sprt.permissions & '0000000000000000000000000000000000000000000000000000000001000000') = '0000000000000000000000000000000000000000000000000000000001000000')
  );

CREATE POLICY auth_ins_ent_mem
  ON myapp_memberships_public.org_permission_default_permissions
  AS PERMISSIVE
  FOR INSERT
  TO authenticated
  WITH CHECK (
    entity_id IN (SELECT org_sprt.entity_id
    FROM myapp_memberships_private.org_memberships_sprt AS org_sprt
    WHERE
      org_sprt.actor_id = jwt_public.current_principal_id()
      AND (org_sprt.permissions & '0000000000000000000000000000000000000000000000000000000001000000') = '0000000000000000000000000000000000000000000000000000000001000000')
  );

CREATE POLICY auth_del_ent_mem
  ON myapp_memberships_public.org_permission_default_permissions
  AS PERMISSIVE
  FOR DELETE
  TO authenticated
  USING (
    entity_id IN (SELECT org_sprt.entity_id
    FROM myapp_memberships_private.org_memberships_sprt AS org_sprt
    WHERE
      org_sprt.actor_id = jwt_public.current_principal_id()
      AND (org_sprt.permissions & '0000000000000000000000000000000000000000000000000000000001000000') = '0000000000000000000000000000000000000000000000000000000001000000')
  );

ALTER TABLE myapp_memberships_public.org_permission_default_grants 
  ENABLE ROW LEVEL SECURITY;

GRANT SELECT ON myapp_memberships_public.org_permission_default_grants TO authenticated;

GRANT INSERT ON myapp_memberships_public.org_permission_default_grants TO authenticated;

CREATE POLICY auth_sel_ent_mem
  ON myapp_memberships_public.org_permission_default_grants
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    entity_id IN (SELECT org_sprt.entity_id
    FROM myapp_memberships_private.org_memberships_sprt AS org_sprt
    WHERE
      org_sprt.actor_id = jwt_public.current_principal_id()
      AND (org_sprt.permissions & '0000000000000000000000000000000000000000000000000000000001000000') = '0000000000000000000000000000000000000000000000000000000001000000')
  );

CREATE POLICY auth_ins_ent_mem
  ON myapp_memberships_public.org_permission_default_grants
  AS PERMISSIVE
  FOR INSERT
  TO authenticated
  WITH CHECK (
    entity_id IN (SELECT org_sprt.entity_id
    FROM myapp_memberships_private.org_memberships_sprt AS org_sprt
    WHERE
      org_sprt.actor_id = jwt_public.current_principal_id()
      AND (org_sprt.permissions & '0000000000000000000000000000000000000000000000000000000001000000') = '0000000000000000000000000000000000000000000000000000000001000000')
  );

ALTER TABLE myapp_profiles_public.org_profiles 
  ENABLE ROW LEVEL SECURITY;

GRANT SELECT ON myapp_profiles_public.org_profiles TO authenticated;

GRANT INSERT ON myapp_profiles_public.org_profiles TO authenticated;

GRANT UPDATE ( name, slug, description, is_system, is_default ) ON myapp_profiles_public.org_profiles TO authenticated;

GRANT DELETE ON myapp_profiles_public.org_profiles TO authenticated;

CREATE POLICY auth_sel_com
  ON myapp_profiles_public.org_profiles
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    entity_id IN (SELECT org_sprt.entity_id
    FROM myapp_memberships_private.org_memberships_sprt AS org_sprt
    WHERE
      org_sprt.actor_id = jwt_public.current_principal_id())
      OR entity_id IS NULL
  );

CREATE POLICY auth_ins_ent_mem
  ON myapp_profiles_public.org_profiles
  AS PERMISSIVE
  FOR INSERT
  TO authenticated
  WITH CHECK (
    entity_id IN (SELECT org_sprt.entity_id
    FROM myapp_memberships_private.org_memberships_sprt AS org_sprt
    WHERE
      org_sprt.actor_id = jwt_public.current_principal_id()
      AND (org_sprt.permissions & '0000000000000000000000000000000000000000000000000000000001000000') = '0000000000000000000000000000000000000000000000000000000001000000')
  );

CREATE POLICY auth_upd_com
  ON myapp_profiles_public.org_profiles
  AS PERMISSIVE
  FOR UPDATE
  TO authenticated
  USING (
    entity_id IN (SELECT org_sprt.entity_id
    FROM myapp_memberships_private.org_memberships_sprt AS org_sprt
    WHERE
      (org_sprt.actor_id = jwt_public.current_principal_id()
      AND (org_sprt.permissions & '0000000000000000000000000000000000000000000000000000000001000000') = '0000000000000000000000000000000000000000000000000000000001000000'))
      AND is_system IS FALSE
  );

CREATE POLICY auth_del_com
  ON myapp_profiles_public.org_profiles
  AS PERMISSIVE
  FOR DELETE
  TO authenticated
  USING (
    entity_id IN (SELECT org_sprt.entity_id
    FROM myapp_memberships_private.org_memberships_sprt AS org_sprt
    WHERE
      (org_sprt.actor_id = jwt_public.current_principal_id()
      AND (org_sprt.permissions & '0000000000000000000000000000000000000000000000000000000001000000') = '0000000000000000000000000000000000000000000000000000000001000000'))
      AND is_system IS FALSE
  );

ALTER TABLE myapp_profiles_public.org_profile_permissions 
  ENABLE ROW LEVEL SECURITY;

GRANT SELECT ON myapp_profiles_public.org_profile_permissions TO authenticated;

GRANT INSERT ON myapp_profiles_public.org_profile_permissions TO authenticated;

GRANT UPDATE ON myapp_profiles_public.org_profile_permissions TO authenticated;

GRANT DELETE ON myapp_profiles_public.org_profile_permissions TO authenticated;

CREATE POLICY auth_sel_rel_ent_mem
  ON myapp_profiles_public.org_profile_permissions
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    profile_id IN (SELECT obj.id
    FROM myapp_memberships_private.org_memberships_sprt AS org_sprt
    JOIN myapp_profiles_public.org_profiles AS obj ON org_sprt.entity_id = obj.entity_id
    WHERE
      org_sprt.actor_id = jwt_public.current_principal_id())
  );

CREATE POLICY auth_ins_rel_ent_mem
  ON myapp_profiles_public.org_profile_permissions
  AS PERMISSIVE
  FOR INSERT
  TO authenticated
  WITH CHECK (
    profile_id IN (SELECT obj.id
    FROM myapp_memberships_private.org_memberships_sprt AS org_sprt
    JOIN myapp_profiles_public.org_profiles AS obj ON org_sprt.entity_id = obj.entity_id
    WHERE
      org_sprt.actor_id = jwt_public.current_principal_id()
      AND (org_sprt.permissions & '0000000000000000000000000000000000000000000000000000000001000000') = '0000000000000000000000000000000000000000000000000000000001000000')
  );

CREATE POLICY auth_upd_rel_ent_mem
  ON myapp_profiles_public.org_profile_permissions
  AS PERMISSIVE
  FOR UPDATE
  TO authenticated
  USING (
    profile_id IN (SELECT obj.id
    FROM myapp_memberships_private.org_memberships_sprt AS org_sprt
    JOIN myapp_profiles_public.org_profiles AS obj ON org_sprt.entity_id = obj.entity_id
    WHERE
      org_sprt.actor_id = jwt_public.current_principal_id()
      AND (org_sprt.permissions & '0000000000000000000000000000000000000000000000000000000001000000') = '0000000000000000000000000000000000000000000000000000000001000000')
  );

CREATE POLICY auth_del_rel_ent_mem
  ON myapp_profiles_public.org_profile_permissions
  AS PERMISSIVE
  FOR DELETE
  TO authenticated
  USING (
    profile_id IN (SELECT obj.id
    FROM myapp_memberships_private.org_memberships_sprt AS org_sprt
    JOIN myapp_profiles_public.org_profiles AS obj ON org_sprt.entity_id = obj.entity_id
    WHERE
      org_sprt.actor_id = jwt_public.current_principal_id()
      AND (org_sprt.permissions & '0000000000000000000000000000000000000000000000000000000001000000') = '0000000000000000000000000000000000000000000000000000000001000000')
  );

ALTER TABLE myapp_profiles_public.org_profile_grants 
  ENABLE ROW LEVEL SECURITY;

GRANT SELECT ON myapp_profiles_public.org_profile_grants TO authenticated;

GRANT INSERT ON myapp_profiles_public.org_profile_grants TO authenticated;

CREATE POLICY auth_sel_ent_mem
  ON myapp_profiles_public.org_profile_grants
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    entity_id IN (SELECT org_sprt.entity_id
    FROM myapp_memberships_private.org_memberships_sprt AS org_sprt
    WHERE
      org_sprt.actor_id = jwt_public.current_principal_id()
      AND (org_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000000001') = '0000000000000000000000000000000000000000000000000000000000000001')
  );

CREATE POLICY auth_ins_ent_mem
  ON myapp_profiles_public.org_profile_grants
  AS PERMISSIVE
  FOR INSERT
  TO authenticated
  WITH CHECK (
    entity_id IN (SELECT org_sprt.entity_id
    FROM myapp_memberships_private.org_memberships_sprt AS org_sprt
    WHERE
      org_sprt.actor_id = jwt_public.current_principal_id()
      AND (org_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000000001') = '0000000000000000000000000000000000000000000000000000000000000001')
  );

ALTER TABLE myapp_profiles_public.org_profile_definition_grants 
  ENABLE ROW LEVEL SECURITY;

GRANT SELECT ON myapp_profiles_public.org_profile_definition_grants TO authenticated;

GRANT INSERT ON myapp_profiles_public.org_profile_definition_grants TO authenticated;

CREATE POLICY auth_sel_rel_ent_mem
  ON myapp_profiles_public.org_profile_definition_grants
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    profile_id IN (SELECT obj.id
    FROM myapp_memberships_private.org_memberships_sprt AS org_sprt
    JOIN myapp_profiles_public.org_profiles AS obj ON org_sprt.entity_id = obj.entity_id
    WHERE
      org_sprt.actor_id = jwt_public.current_principal_id()
      AND (org_sprt.permissions & '0000000000000000000000000000000000000000000000000000000001000000') = '0000000000000000000000000000000000000000000000000000000001000000')
  );

CREATE POLICY auth_ins_rel_ent_mem
  ON myapp_profiles_public.org_profile_definition_grants
  AS PERMISSIVE
  FOR INSERT
  TO authenticated
  WITH CHECK (
    profile_id IN (SELECT obj.id
    FROM myapp_memberships_private.org_memberships_sprt AS org_sprt
    JOIN myapp_profiles_public.org_profiles AS obj ON org_sprt.entity_id = obj.entity_id
    WHERE
      org_sprt.actor_id = jwt_public.current_principal_id()
      AND (org_sprt.permissions & '0000000000000000000000000000000000000000000000000000000001000000') = '0000000000000000000000000000000000000000000000000000000001000000')
  );

ALTER TABLE myapp_memberships_public.org_membership_settings 
  ADD COLUMN limit_allocation_mode text;

ALTER TABLE myapp_memberships_public.org_membership_settings 
  ALTER COLUMN limit_allocation_mode SET NOT NULL;

ALTER TABLE myapp_memberships_public.org_membership_settings 
  ALTER COLUMN limit_allocation_mode SET DEFAULT 'pooled';

COMMENT ON COLUMN myapp_memberships_public.org_membership_settings.limit_allocation_mode IS 'Allocation mode for sub-entity limits: pooled (shared parent cap, no per-entity budgets) or budgeted (explicit per-entity allocations, transfer enabled)';

CREATE SCHEMA myapp_store_private;

GRANT USAGE ON SCHEMA myapp_store_private TO administrator;

GRANT USAGE ON SCHEMA myapp_store_private TO authenticated;

GRANT USAGE ON SCHEMA myapp_store_private TO anonymous;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_store_private
  GRANT ALL ON TABLES TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_store_private
  GRANT USAGE ON SEQUENCES TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_store_private
  GRANT ALL ON FUNCTIONS TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_store_private
  GRANT ALL ON FUNCTIONS TO authenticated;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_store_private
  GRANT USAGE ON SEQUENCES TO authenticated;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_store_private
  GRANT ALL ON FUNCTIONS TO anonymous;

CREATE TABLE myapp_store_private.user_state ();

ALTER TABLE myapp_store_private.user_state 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_store_private.user_state IS 'Internal per-user state store for auth counters, tokens, and ephemeral data';

ALTER TABLE myapp_store_private.user_state 
  ADD COLUMN id uuid;

ALTER TABLE myapp_store_private.user_state 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_store_private.user_state 
  ALTER COLUMN id SET DEFAULT uuidv7();

COMMENT ON COLUMN myapp_store_private.user_state.id IS 'Unique identifier for this secret entry';

ALTER TABLE myapp_store_private.user_state 
  ADD COLUMN owner_id uuid;

ALTER TABLE myapp_store_private.user_state 
  ALTER COLUMN owner_id SET NOT NULL;

COMMENT ON COLUMN myapp_store_private.user_state.owner_id IS 'User who owns this secret';

ALTER TABLE myapp_store_private.user_state 
  ADD COLUMN name text;

ALTER TABLE myapp_store_private.user_state 
  ALTER COLUMN name SET NOT NULL;

COMMENT ON COLUMN myapp_store_private.user_state.name IS 'Key name identifying the state entry (e.g. signin_attempts, verification_token)';

ALTER TABLE myapp_store_private.user_state 
  ADD COLUMN value text;

COMMENT ON COLUMN myapp_store_private.user_state.value IS 'The plaintext state value';

ALTER TABLE myapp_store_private.user_state 
  ADD CONSTRAINT user_states_pkey PRIMARY KEY (id);

ALTER TABLE myapp_store_private.user_state 
  ADD CONSTRAINT user_states_owner_id_name_key 
    UNIQUE (owner_id, name);

ALTER TABLE myapp_store_private.user_state 
  ENABLE ROW LEVEL SECURITY;

GRANT INSERT ON myapp_store_private.user_state TO authenticated;

GRANT UPDATE ON myapp_store_private.user_state TO authenticated;

GRANT DELETE ON myapp_store_private.user_state TO authenticated;

CREATE POLICY auth_ins_dir_own
  ON myapp_store_private.user_state
  AS PERMISSIVE
  FOR INSERT
  TO authenticated
  WITH CHECK (
    owner_id = jwt_public.current_principal_id()
  );

CREATE POLICY auth_upd_dir_own
  ON myapp_store_private.user_state
  AS PERMISSIVE
  FOR UPDATE
  TO authenticated
  USING (
    owner_id = jwt_public.current_principal_id()
  );

CREATE POLICY auth_del_dir_own
  ON myapp_store_private.user_state
  AS PERMISSIVE
  FOR DELETE
  TO authenticated
  USING (
    owner_id = jwt_public.current_principal_id()
  );

CREATE FUNCTION myapp_store_private.user_state_get(
  IN owner_id uuid,
  IN secret_name text,
  IN default_value text DEFAULT NULL
) RETURNS text AS $EOFCODE$
DECLARE
  val text;
BEGIN
  SELECT value
  FROM myapp_store_private.user_state AS t
  WHERE
    t.owner_id = user_state_get.owner_id AND t.name = user_state_get.secret_name INTO val;
  IF NOT (FOUND) OR val IS NULL THEN
    RETURN default_value;
  END IF;
  RETURN val;
END;
$EOFCODE$ LANGUAGE plpgsql STABLE;

CREATE FUNCTION myapp_store_private.user_state_set(
  IN user_id uuid,
  IN secret_name text,
  IN value anyelement
) RETURNS void AS $EOFCODE$
BEGIN
  INSERT INTO myapp_store_private.user_state (
    owner_id,
    name,
    value
  )
  VALUES
    (user_state_set.user_id, user_state_set.secret_name, user_state_set.value::text)
  ON CONFLICT (owner_id, name) DO UPDATE SET
  value = EXCLUDED.value;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE;

CREATE FUNCTION myapp_store_private.user_state_del(
  IN owner_id uuid,
  IN secret_name text
) RETURNS void AS $EOFCODE$
BEGIN
  DELETE FROM myapp_store_private.user_state AS s
  WHERE
    s.owner_id = user_state_del.owner_id AND s.name = secret_name;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE;

CREATE FUNCTION myapp_store_private.user_state_del(
  IN owner_id uuid,
  IN secret_names text[]
) RETURNS void AS $EOFCODE$
BEGIN
  DELETE FROM myapp_store_private.user_state AS s
  WHERE
    s.owner_id = user_state_del.owner_id AND s.name = ANY( user_state_del.secret_names );
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE;

CREATE SCHEMA myapp_auth_private;

GRANT USAGE ON SCHEMA myapp_auth_private TO administrator;

GRANT USAGE ON SCHEMA myapp_auth_private TO authenticated;

GRANT USAGE ON SCHEMA myapp_auth_private TO anonymous;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_auth_private
  GRANT ALL ON TABLES TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_auth_private
  GRANT USAGE ON SEQUENCES TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_auth_private
  GRANT ALL ON FUNCTIONS TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_auth_private
  GRANT ALL ON FUNCTIONS TO authenticated;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_auth_private
  GRANT USAGE ON SEQUENCES TO authenticated;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_auth_private
  GRANT ALL ON FUNCTIONS TO anonymous;

CREATE TABLE myapp_auth_private.sessions ();

ALTER TABLE myapp_auth_private.sessions 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_auth_private.sessions IS 'Tracks user authentication sessions with expiration, fingerprinting, and step-up verification state';

ALTER TABLE myapp_auth_private.sessions 
  ADD COLUMN id uuid;

ALTER TABLE myapp_auth_private.sessions 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_auth_private.sessions 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_auth_private.sessions 
  ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);

ALTER TABLE myapp_auth_private.sessions 
  ADD COLUMN user_id uuid;

COMMENT ON COLUMN myapp_auth_private.sessions.user_id IS 'References the authenticated user; NULL for anonymous sessions';

ALTER TABLE myapp_auth_private.sessions 
  ADD COLUMN is_anonymous boolean;

ALTER TABLE myapp_auth_private.sessions 
  ALTER COLUMN is_anonymous SET NOT NULL;

ALTER TABLE myapp_auth_private.sessions 
  ALTER COLUMN is_anonymous SET DEFAULT false;

COMMENT ON COLUMN myapp_auth_private.sessions.is_anonymous IS 'Whether this is an anonymous session (no authenticated user)';

ALTER TABLE myapp_auth_private.sessions 
  ADD COLUMN expires_at timestamptz;

ALTER TABLE myapp_auth_private.sessions 
  ALTER COLUMN expires_at SET NOT NULL;

ALTER TABLE myapp_auth_private.sessions 
  ALTER COLUMN expires_at SET DEFAULT now() + '30 days'::interval;

COMMENT ON COLUMN myapp_auth_private.sessions.expires_at IS 'When this session expires and can no longer be used for authentication';

ALTER TABLE myapp_auth_private.sessions 
  ADD COLUMN revoked_at timestamptz;

COMMENT ON COLUMN myapp_auth_private.sessions.revoked_at IS 'When this session was explicitly revoked (soft delete); NULL means active';

ALTER TABLE myapp_auth_private.sessions 
  ADD COLUMN origin origin;

ALTER TABLE myapp_auth_private.sessions 
  ALTER COLUMN origin SET DEFAULT jwt_public.current_origin();

COMMENT ON COLUMN myapp_auth_private.sessions.origin IS 'The origin (protocol + host) from which the session was created, used for fingerprint validation';

ALTER TABLE myapp_auth_private.sessions 
  ADD COLUMN ip inet;

ALTER TABLE myapp_auth_private.sessions 
  ALTER COLUMN ip SET DEFAULT jwt_public.current_ip_address();

COMMENT ON COLUMN myapp_auth_private.sessions.ip IS 'IP address from which the session was created, used for strict fingerprint validation';

ALTER TABLE myapp_auth_private.sessions 
  ADD COLUMN uagent text;

ALTER TABLE myapp_auth_private.sessions 
  ALTER COLUMN uagent SET DEFAULT jwt_public.current_user_agent();

COMMENT ON COLUMN myapp_auth_private.sessions.uagent IS 'User-Agent string from the client, used for strict fingerprint validation';

ALTER TABLE myapp_auth_private.sessions 
  ADD COLUMN fingerprint_mode text;

ALTER TABLE myapp_auth_private.sessions 
  ALTER COLUMN fingerprint_mode SET NOT NULL;

ALTER TABLE myapp_auth_private.sessions 
  ALTER COLUMN fingerprint_mode SET DEFAULT 'lax';

COMMENT ON COLUMN myapp_auth_private.sessions.fingerprint_mode IS 'Session validation mode: strict (origin+ip+uagent), lax (origin only), or none (no validation)';

ALTER TABLE myapp_auth_private.sessions 
  ADD COLUMN last_password_verified timestamptz;

COMMENT ON COLUMN myapp_auth_private.sessions.last_password_verified IS 'Timestamp of last password re-verification for step-up authentication';

ALTER TABLE myapp_auth_private.sessions 
  ADD COLUMN last_mfa_verified timestamptz;

COMMENT ON COLUMN myapp_auth_private.sessions.last_mfa_verified IS 'Timestamp of last MFA verification for step-up authentication';

ALTER TABLE myapp_auth_private.sessions 
  ADD COLUMN last_idp_verified timestamptz;

COMMENT ON COLUMN myapp_auth_private.sessions.last_idp_verified IS 'Timestamp of last identity-provider assertion for step-up authentication';

ALTER TABLE myapp_auth_private.sessions 
  ADD COLUMN csrf_secret text;

COMMENT ON COLUMN myapp_auth_private.sessions.csrf_secret IS 'Secret used to generate and validate CSRF tokens for cookie-based sessions';

ALTER TABLE myapp_auth_private.sessions 
  ADD COLUMN auth_method text;

ALTER TABLE myapp_auth_private.sessions 
  ALTER COLUMN auth_method SET NOT NULL;

ALTER TABLE myapp_auth_private.sessions 
  ALTER COLUMN auth_method SET DEFAULT 'password';

COMMENT ON COLUMN myapp_auth_private.sessions.auth_method IS 'Authentication method used to create this session: password, identity, magic_link, email_otp, sms_otp, anonymous';

ALTER TABLE myapp_auth_private.sessions 
  ADD COLUMN created_at timestamptz;

ALTER TABLE myapp_auth_private.sessions 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE myapp_auth_private.sessions 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE myapp_auth_private.sessions 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE TRIGGER timestamps_tg
  BEFORE INSERT OR UPDATE
  ON myapp_auth_private.sessions
  FOR EACH ROW
  EXECUTE PROCEDURE stamps.timestamps();

CREATE INDEX sessions_created_at_idx ON myapp_auth_private.sessions (created_at);

CREATE INDEX sessions_updated_at_idx ON myapp_auth_private.sessions (updated_at);

CREATE INDEX sessions_user_id_idx ON myapp_auth_private.sessions (user_id);

CREATE TABLE myapp_auth_private.session_credentials ();

ALTER TABLE myapp_auth_private.session_credentials 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_auth_private.session_credentials IS 'Authentication credentials (bearer tokens, cookies, API keys, magic links) tied to sessions';

ALTER TABLE myapp_auth_private.session_credentials 
  ADD COLUMN id uuid;

ALTER TABLE myapp_auth_private.session_credentials 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_auth_private.session_credentials 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_auth_private.session_credentials 
  ADD CONSTRAINT session_credentials_pkey PRIMARY KEY (id);

ALTER TABLE myapp_auth_private.session_credentials 
  ADD COLUMN session_id uuid;

ALTER TABLE myapp_auth_private.session_credentials 
  ALTER COLUMN session_id SET NOT NULL;

COMMENT ON COLUMN myapp_auth_private.session_credentials.session_id IS 'References the session this credential authenticates';

ALTER TABLE myapp_auth_private.session_credentials 
  ADD COLUMN kind text;

ALTER TABLE myapp_auth_private.session_credentials 
  ALTER COLUMN kind SET NOT NULL;

ALTER TABLE myapp_auth_private.session_credentials 
  ALTER COLUMN kind SET DEFAULT 'bearer';

COMMENT ON COLUMN myapp_auth_private.session_credentials.kind IS 'Credential type: bearer (JWT), cookie, api_key, or magic_link';

ALTER TABLE myapp_auth_private.session_credentials 
  ADD COLUMN key_id text;

COMMENT ON COLUMN myapp_auth_private.session_credentials.key_id IS 'Public prefix for API keys (e.g. sk_live_abc123), used for identification without exposing the secret';

ALTER TABLE myapp_auth_private.session_credentials 
  ADD COLUMN secret_hash bytea;

ALTER TABLE myapp_auth_private.session_credentials 
  ALTER COLUMN secret_hash SET NOT NULL;

COMMENT ON COLUMN myapp_auth_private.session_credentials.secret_hash IS 'SHA-256 hash of the credential secret; the plaintext secret is never stored';

ALTER TABLE myapp_auth_private.session_credentials 
  ADD COLUMN expires_at timestamptz;

COMMENT ON COLUMN myapp_auth_private.session_credentials.expires_at IS 'When this credential expires (can differ from the parent session expiration)';

ALTER TABLE myapp_auth_private.session_credentials 
  ADD COLUMN revoked_at timestamptz;

COMMENT ON COLUMN myapp_auth_private.session_credentials.revoked_at IS 'When this credential was explicitly revoked; NULL means active';

ALTER TABLE myapp_auth_private.session_credentials 
  ADD COLUMN last_used_at timestamptz;

COMMENT ON COLUMN myapp_auth_private.session_credentials.last_used_at IS 'Timestamp of the last time this credential was used for authentication';

ALTER TABLE myapp_auth_private.session_credentials 
  ADD COLUMN org_id uuid;

COMMENT ON COLUMN myapp_auth_private.session_credentials.org_id IS 'Scopes this API key to a specific organization; NULL means app-level';

ALTER TABLE myapp_auth_private.session_credentials 
  ADD COLUMN name text;

COMMENT ON COLUMN myapp_auth_private.session_credentials.name IS 'User-provided display name for this credential (e.g. My CI Key)';

ALTER TABLE myapp_auth_private.session_credentials 
  ADD COLUMN ot_token text;

COMMENT ON COLUMN myapp_auth_private.session_credentials.ot_token IS 'One-time token for magic link or passwordless authentication flows';

ALTER TABLE myapp_auth_private.session_credentials 
  ADD COLUMN mfa_level text;

ALTER TABLE myapp_auth_private.session_credentials 
  ALTER COLUMN mfa_level SET NOT NULL;

ALTER TABLE myapp_auth_private.session_credentials 
  ALTER COLUMN mfa_level SET DEFAULT 'none';

COMMENT ON COLUMN myapp_auth_private.session_credentials.mfa_level IS 'MFA level of this credential: none (no MFA), verified (created with MFA), enforced (per-action MFA)';

ALTER TABLE myapp_auth_private.session_credentials 
  ADD COLUMN access_level text;

ALTER TABLE myapp_auth_private.session_credentials 
  ALTER COLUMN access_level SET NOT NULL;

ALTER TABLE myapp_auth_private.session_credentials 
  ALTER COLUMN access_level SET DEFAULT 'full_access';

COMMENT ON COLUMN myapp_auth_private.session_credentials.access_level IS 'Access level for this credential: full_access (read+write) or read_only (SET TRANSACTION READ ONLY)';

ALTER TABLE myapp_auth_private.session_credentials 
  ADD COLUMN principal_id uuid;

COMMENT ON COLUMN myapp_auth_private.session_credentials.principal_id IS 'References the principal (service account) this credential acts on behalf of; NULL for human sessions';

ALTER TABLE myapp_auth_private.session_credentials 
  ADD COLUMN created_at timestamptz;

ALTER TABLE myapp_auth_private.session_credentials 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE myapp_auth_private.session_credentials 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE myapp_auth_private.session_credentials 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE TRIGGER timestamps_tg
  BEFORE INSERT OR UPDATE
  ON myapp_auth_private.session_credentials
  FOR EACH ROW
  EXECUTE PROCEDURE stamps.timestamps();

CREATE INDEX session_credentials_created_at_idx ON myapp_auth_private.session_credentials (created_at);

CREATE INDEX session_credentials_updated_at_idx ON myapp_auth_private.session_credentials (updated_at);

ALTER TABLE myapp_auth_private.session_credentials 
  ADD CONSTRAINT session_credentials_secret_hash_key 
    UNIQUE (secret_hash);

ALTER TABLE myapp_auth_private.session_credentials 
  ADD CONSTRAINT session_credentials_key_id_key 
    UNIQUE (key_id);

ALTER TABLE myapp_auth_private.session_credentials 
  ADD CONSTRAINT session_credentials_ot_token_key 
    UNIQUE (ot_token);

CREATE INDEX session_credentials_session_id_idx ON myapp_auth_private.session_credentials (session_id);

CREATE INDEX session_credentials_kind_idx ON myapp_auth_private.session_credentials (kind);

GRANT SELECT ON myapp_auth_private.session_credentials TO authenticated;

CREATE TABLE myapp_auth_private.app_settings_auth ();

ALTER TABLE myapp_auth_private.app_settings_auth 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_auth_private.app_settings_auth IS 'Singleton configuration table for authentication settings including session durations, lockout policy, and password requirements';

ALTER TABLE myapp_auth_private.app_settings_auth 
  ADD COLUMN id uuid;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_auth_private.app_settings_auth 
  ADD CONSTRAINT app_settings_auths_pkey PRIMARY KEY (id);

ALTER TABLE myapp_auth_private.app_settings_auth 
  ADD COLUMN require_csrf_for_auth boolean;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN require_csrf_for_auth SET NOT NULL;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN require_csrf_for_auth SET DEFAULT true;

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.require_csrf_for_auth IS 'Whether to enforce CSRF token validation on sign_in and sign_up endpoints';

ALTER TABLE myapp_auth_private.app_settings_auth 
  ADD COLUMN default_session_duration interval;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN default_session_duration SET NOT NULL;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN default_session_duration SET DEFAULT '2 weeks'::interval;

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.default_session_duration IS 'How long sessions last for standard (non-remember-me) logins';

ALTER TABLE myapp_auth_private.app_settings_auth 
  ADD COLUMN remember_me_duration interval;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN remember_me_duration SET NOT NULL;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN remember_me_duration SET DEFAULT '30 days'::interval;

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.remember_me_duration IS 'Extended session duration when the user selects remember me during login';

ALTER TABLE myapp_auth_private.app_settings_auth 
  ADD COLUMN default_credential_duration interval;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN default_credential_duration SET NOT NULL;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN default_credential_duration SET DEFAULT '1 hour'::interval;

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.default_credential_duration IS 'Default expiration for bearer token credentials';

ALTER TABLE myapp_auth_private.app_settings_auth 
  ADD COLUMN default_fingerprint_mode text;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN default_fingerprint_mode SET NOT NULL;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN default_fingerprint_mode SET DEFAULT 'lax';

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.default_fingerprint_mode IS 'Default fingerprint validation mode for new sessions: strict, lax, or none';

ALTER TABLE myapp_auth_private.app_settings_auth 
  ADD COLUMN allow_anonymous_sessions boolean;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN allow_anonymous_sessions SET NOT NULL;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN allow_anonymous_sessions SET DEFAULT true;

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.allow_anonymous_sessions IS 'Whether to allow anonymous sessions (useful for CSRF protection and shopping carts)';

ALTER TABLE myapp_auth_private.app_settings_auth 
  ADD COLUMN allow_multiple_sessions boolean;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN allow_multiple_sessions SET NOT NULL;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN allow_multiple_sessions SET DEFAULT true;

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.allow_multiple_sessions IS 'Whether users can have multiple active sessions simultaneously';

ALTER TABLE myapp_auth_private.app_settings_auth 
  ADD COLUMN min_password_length int;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN min_password_length SET NOT NULL;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN min_password_length SET DEFAULT 8;

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.min_password_length IS 'Minimum number of characters required for user passwords';

ALTER TABLE myapp_auth_private.app_settings_auth 
  ADD COLUMN enable_cookie_auth boolean;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN enable_cookie_auth SET NOT NULL;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN enable_cookie_auth SET DEFAULT false;

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.enable_cookie_auth IS 'Whether to enable HTTP cookie-based authentication (requires CSRF protection)';

ALTER TABLE myapp_auth_private.app_settings_auth 
  ADD COLUMN step_up_window interval;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN step_up_window SET NOT NULL;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN step_up_window SET DEFAULT '30 minutes'::interval;

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.step_up_window IS 'How long a password or MFA re-verification remains valid for step-up authentication';

ALTER TABLE myapp_auth_private.app_settings_auth 
  ADD COLUMN mfa_challenge_expiry interval;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN mfa_challenge_expiry SET NOT NULL;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN mfa_challenge_expiry SET DEFAULT '5 minutes'::interval;

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.mfa_challenge_expiry IS 'How long an MFA challenge token remains valid after password verification';

ALTER TABLE myapp_auth_private.app_settings_auth 
  ADD COLUMN allow_sign_up boolean;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN allow_sign_up SET NOT NULL;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN allow_sign_up SET DEFAULT true;

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.allow_sign_up IS 'Master switch: whether new user registration is allowed';

ALTER TABLE myapp_auth_private.app_settings_auth 
  ADD COLUMN allow_password_sign_up boolean;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN allow_password_sign_up SET NOT NULL;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN allow_password_sign_up SET DEFAULT true;

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.allow_password_sign_up IS 'Whether email plus password registration is allowed';

ALTER TABLE myapp_auth_private.app_settings_auth 
  ADD COLUMN allow_identity_sign_up boolean;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN allow_identity_sign_up SET NOT NULL;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN allow_identity_sign_up SET DEFAULT false;

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.allow_identity_sign_up IS 'Whether Identity-based account creation is allowed';

ALTER TABLE myapp_auth_private.app_settings_auth 
  ADD COLUMN allow_magic_link_sign_up boolean;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN allow_magic_link_sign_up SET NOT NULL;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN allow_magic_link_sign_up SET DEFAULT false;

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.allow_magic_link_sign_up IS 'Whether magic link account creation is allowed';

ALTER TABLE myapp_auth_private.app_settings_auth 
  ADD COLUMN allow_sms_sign_up boolean;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN allow_sms_sign_up SET NOT NULL;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN allow_sms_sign_up SET DEFAULT false;

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.allow_sms_sign_up IS 'Whether SMS-based account creation is allowed';

ALTER TABLE myapp_auth_private.app_settings_auth 
  ADD COLUMN allow_password_sign_in boolean;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN allow_password_sign_in SET NOT NULL;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN allow_password_sign_in SET DEFAULT true;

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.allow_password_sign_in IS 'Whether email plus password sign-in is allowed';

ALTER TABLE myapp_auth_private.app_settings_auth 
  ADD COLUMN allow_identity_sign_in boolean;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN allow_identity_sign_in SET NOT NULL;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN allow_identity_sign_in SET DEFAULT false;

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.allow_identity_sign_in IS 'Whether identity sign-in is allowed';

ALTER TABLE myapp_auth_private.app_settings_auth 
  ADD COLUMN allow_magic_link_sign_in boolean;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN allow_magic_link_sign_in SET NOT NULL;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN allow_magic_link_sign_in SET DEFAULT false;

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.allow_magic_link_sign_in IS 'Whether passwordless magic link sign-in is allowed';

ALTER TABLE myapp_auth_private.app_settings_auth 
  ADD COLUMN allow_email_otp_sign_in boolean;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN allow_email_otp_sign_in SET NOT NULL;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN allow_email_otp_sign_in SET DEFAULT false;

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.allow_email_otp_sign_in IS 'Whether passwordless email OTP sign-in is allowed';

ALTER TABLE myapp_auth_private.app_settings_auth 
  ADD COLUMN allow_sms_sign_in boolean;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN allow_sms_sign_in SET NOT NULL;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN allow_sms_sign_in SET DEFAULT false;

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.allow_sms_sign_in IS 'Whether passwordless SMS OTP sign-in is allowed';

ALTER TABLE myapp_auth_private.app_settings_auth 
  ADD COLUMN allow_webauthn_sign_up boolean;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN allow_webauthn_sign_up SET NOT NULL;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN allow_webauthn_sign_up SET DEFAULT false;

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.allow_webauthn_sign_up IS 'Whether WebAuthn / passkey registration during sign-up is allowed';

ALTER TABLE myapp_auth_private.app_settings_auth 
  ADD COLUMN allow_webauthn_sign_in boolean;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN allow_webauthn_sign_in SET NOT NULL;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN allow_webauthn_sign_in SET DEFAULT false;

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.allow_webauthn_sign_in IS 'Whether WebAuthn / passkey sign-in is allowed';

ALTER TABLE myapp_auth_private.app_settings_auth 
  ADD COLUMN allow_webauthn_usernameless boolean;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN allow_webauthn_usernameless SET NOT NULL;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN allow_webauthn_usernameless SET DEFAULT false;

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.allow_webauthn_usernameless IS 'Whether usernameless / conditional-UI passkey sign-in is allowed (discoverable credentials)';

ALTER TABLE myapp_auth_private.app_settings_auth 
  ADD COLUMN allow_cross_origin_token boolean;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN allow_cross_origin_token SET NOT NULL;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN allow_cross_origin_token SET DEFAULT true;

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.allow_cross_origin_token IS 'Whether cross-origin session handoff tokens are allowed';

ALTER TABLE myapp_auth_private.app_settings_auth 
  ADD COLUMN require_mfa boolean;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN require_mfa SET NOT NULL;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN require_mfa SET DEFAULT false;

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.require_mfa IS 'Whether all users are required to set up MFA';

ALTER TABLE myapp_auth_private.app_settings_auth 
  ADD COLUMN allow_totp_mfa boolean;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN allow_totp_mfa SET NOT NULL;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN allow_totp_mfa SET DEFAULT true;

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.allow_totp_mfa IS 'Whether TOTP authenticator app MFA is allowed';

ALTER TABLE myapp_auth_private.app_settings_auth 
  ADD COLUMN allow_email_mfa boolean;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN allow_email_mfa SET NOT NULL;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN allow_email_mfa SET DEFAULT true;

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.allow_email_mfa IS 'Whether email code MFA is allowed';

ALTER TABLE myapp_auth_private.app_settings_auth 
  ADD COLUMN allow_sms_mfa boolean;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN allow_sms_mfa SET NOT NULL;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN allow_sms_mfa SET DEFAULT false;

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.allow_sms_mfa IS 'Whether SMS code MFA is allowed';

ALTER TABLE myapp_auth_private.app_settings_auth 
  ADD COLUMN allow_backup_codes boolean;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN allow_backup_codes SET NOT NULL;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN allow_backup_codes SET DEFAULT true;

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.allow_backup_codes IS 'Whether backup code generation is allowed';

ALTER TABLE myapp_auth_private.app_settings_auth 
  ADD COLUMN allow_api_keys boolean;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN allow_api_keys SET NOT NULL;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN allow_api_keys SET DEFAULT true;

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.allow_api_keys IS 'Whether API key creation is allowed';

ALTER TABLE myapp_auth_private.app_settings_auth 
  ADD COLUMN api_key_max_per_user int;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN api_key_max_per_user SET NOT NULL;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN api_key_max_per_user SET DEFAULT 10;

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.api_key_max_per_user IS 'Maximum number of active API keys a single user may hold';

ALTER TABLE myapp_auth_private.app_settings_auth 
  ADD COLUMN api_key_default_duration interval;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN api_key_default_duration SET NOT NULL;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN api_key_default_duration SET DEFAULT '90 days'::interval;

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.api_key_default_duration IS 'Default lifetime for an API key when the caller does not supply expires_in';

ALTER TABLE myapp_auth_private.app_settings_auth 
  ADD COLUMN api_key_max_duration interval;

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.api_key_max_duration IS 'Upper bound on API key lifetime; caller-supplied expires_in is clamped to this. NULL disables the cap (useful for development)';

ALTER TABLE myapp_auth_private.app_settings_auth 
  ADD COLUMN identity_providers_max int;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN identity_providers_max SET NOT NULL;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN identity_providers_max SET DEFAULT 10;

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.identity_providers_max IS 'Maximum number of custom (non-built-in) identity providers that can be configured per database. Built-in providers (google, github, apple, facebook, microsoft) are exempt from this quota. Enforced by create_identity_provider at write time.';

ALTER TABLE myapp_auth_private.app_settings_auth 
  ADD COLUMN oauth_state_max_age interval;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN oauth_state_max_age SET NOT NULL;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN oauth_state_max_age SET DEFAULT '10 minutes'::interval;

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.oauth_state_max_age IS 'How long the HMAC-signed OAuth state token is valid before expiring; controls CSRF protection window for OAuth flows';

ALTER TABLE myapp_auth_private.app_settings_auth 
  ADD COLUMN oauth_require_verified_email boolean;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN oauth_require_verified_email SET NOT NULL;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN oauth_require_verified_email SET DEFAULT true;

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.oauth_require_verified_email IS 'Whether to reject OAuth sign-up when the identity provider reports the email as unverified; defends against shadow account attacks';

ALTER TABLE myapp_auth_private.app_settings_auth 
  ADD COLUMN oauth_error_redirect_path text;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN oauth_error_redirect_path SET NOT NULL;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN oauth_error_redirect_path SET DEFAULT '/auth/error';

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.oauth_error_redirect_path IS 'URL path the server redirects the browser to when an OAuth flow fails';

ALTER TABLE myapp_auth_private.app_settings_auth 
  ADD COLUMN cookie_secure boolean;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN cookie_secure SET NOT NULL;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN cookie_secure SET DEFAULT true;

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.cookie_secure IS 'Whether the auth cookie should be sent only over HTTPS (Secure flag)';

ALTER TABLE myapp_auth_private.app_settings_auth 
  ADD COLUMN cookie_samesite text;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN cookie_samesite SET NOT NULL;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN cookie_samesite SET DEFAULT 'lax';

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.cookie_samesite IS 'SameSite attribute for the auth cookie: strict, lax, or none';

ALTER TABLE myapp_auth_private.app_settings_auth 
  ADD COLUMN cookie_domain text;

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.cookie_domain IS 'Domain scope for the auth cookie (e.g. .example.com); NULL uses the request origin';

ALTER TABLE myapp_auth_private.app_settings_auth 
  ADD COLUMN cookie_httponly boolean;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN cookie_httponly SET NOT NULL;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN cookie_httponly SET DEFAULT true;

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.cookie_httponly IS 'Whether the auth cookie is inaccessible to client-side JavaScript (HttpOnly flag)';

ALTER TABLE myapp_auth_private.app_settings_auth 
  ADD COLUMN cookie_max_age interval;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN cookie_max_age SET NOT NULL;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN cookie_max_age SET DEFAULT '2 weeks'::interval;

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.cookie_max_age IS 'Max-Age for the auth cookie; defaults to match default_session_duration';

ALTER TABLE myapp_auth_private.app_settings_auth 
  ADD COLUMN cookie_path text;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN cookie_path SET NOT NULL;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN cookie_path SET DEFAULT '/';

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.cookie_path IS 'Path scope for the auth cookie';

ALTER TABLE myapp_auth_private.app_settings_auth 
  ADD COLUMN session_idle_timeout interval;

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.session_idle_timeout IS 'Optional idle timeout: sessions unused for this duration are expired; NULL means no idle expiry';

ALTER TABLE myapp_auth_private.app_settings_auth 
  ADD COLUMN max_sessions_per_user int;

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.max_sessions_per_user IS 'Maximum concurrent sessions per user; NULL means unlimited';

ALTER TABLE myapp_auth_private.app_settings_auth 
  ADD COLUMN allowed_origins text[];

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.allowed_origins IS 'Array of allowed CORS origins for API requests; NULL means allow all';

ALTER TABLE myapp_auth_private.app_settings_auth 
  ADD COLUMN enforce_primary_auth_method boolean;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN enforce_primary_auth_method SET NOT NULL;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN enforce_primary_auth_method SET DEFAULT true;

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.enforce_primary_auth_method IS 'When true, users can only sign in with their primary auth method (set on first sign-up). When false, any linked method can create sessions.';

ALTER TABLE myapp_auth_private.app_settings_auth 
  ADD COLUMN allowed_auth_methods text[];

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.allowed_auth_methods IS 'Array of allowed auth methods (e.g. password, identity, magic_link, sms, email_otp). NULL means all methods are allowed.';

ALTER TABLE myapp_auth_private.app_settings_auth 
  ADD COLUMN enable_captcha boolean;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN enable_captcha SET NOT NULL;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN enable_captcha SET DEFAULT false;

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.enable_captcha IS 'Whether CAPTCHA verification is required on sign-up and password-reset endpoints';

ALTER TABLE myapp_auth_private.app_settings_auth 
  ADD COLUMN captcha_site_key text;

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.captcha_site_key IS 'Public reCAPTCHA site key; the secret key should be stored as a simple_secret';

ALTER TABLE myapp_auth_private.app_settings_auth 
  ADD COLUMN created_at timestamptz;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE myapp_auth_private.app_settings_auth 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE myapp_auth_private.app_settings_auth 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE TRIGGER timestamps_tg
  BEFORE INSERT OR UPDATE
  ON myapp_auth_private.app_settings_auth
  FOR EACH ROW
  EXECUTE PROCEDURE stamps.timestamps();

CREATE INDEX app_settings_auth_created_at_idx ON myapp_auth_private.app_settings_auth (created_at);

CREATE INDEX app_settings_auth_updated_at_idx ON myapp_auth_private.app_settings_auth (updated_at);

ALTER TABLE myapp_auth_private.app_settings_auth 
  ENABLE ROW LEVEL SECURITY;

GRANT SELECT ON myapp_auth_private.app_settings_auth TO authenticated;

GRANT UPDATE ON myapp_auth_private.app_settings_auth TO authenticated;

CREATE POLICY auth_sel_app_mem
  ON myapp_auth_private.app_settings_auth
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.is_admin IS TRUE
      OR app_sprt.is_owner IS TRUE))
  );

CREATE POLICY auth_upd_app_mem
  ON myapp_auth_private.app_settings_auth
  AS PERMISSIVE
  FOR UPDATE
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.is_admin IS TRUE
      OR app_sprt.is_owner IS TRUE))
  );

INSERT INTO myapp_auth_private.app_settings_auth (
  require_csrf_for_auth,
  default_session_duration,
  remember_me_duration,
  default_credential_duration,
  default_fingerprint_mode,
  allow_anonymous_sessions,
  allow_multiple_sessions,
  min_password_length,
  enable_cookie_auth,
  step_up_window,
  mfa_challenge_expiry,
  allow_sign_up,
  allow_password_sign_up,
  allow_identity_sign_up,
  allow_magic_link_sign_up,
  allow_sms_sign_up,
  allow_password_sign_in,
  allow_identity_sign_in,
  allow_magic_link_sign_in,
  allow_email_otp_sign_in,
  allow_sms_sign_in,
  allow_webauthn_sign_up,
  allow_webauthn_sign_in,
  allow_webauthn_usernameless,
  allow_cross_origin_token,
  require_mfa,
  allow_totp_mfa,
  allow_email_mfa,
  allow_sms_mfa,
  allow_backup_codes,
  allow_api_keys,
  api_key_max_per_user,
  api_key_default_duration,
  api_key_max_duration,
  identity_providers_max,
  oauth_state_max_age,
  oauth_require_verified_email,
  oauth_error_redirect_path,
  cookie_secure,
  cookie_samesite,
  cookie_httponly,
  cookie_max_age,
  cookie_path,
  enforce_primary_auth_method,
  enable_captcha
) VALUES
  (CAST('f' AS boolean), '2 weeks'::interval, '30 days'::interval, '1 hour'::interval, 'lax', CAST('t' AS boolean), CAST('t' AS boolean), 8, CAST('f' AS boolean), '30 minutes'::interval, '5 minutes'::interval, CAST('t' AS boolean), CAST('t' AS boolean), CAST('f' AS boolean), CAST('f' AS boolean), CAST('f' AS boolean), CAST('t' AS boolean), CAST('f' AS boolean), CAST('f' AS boolean), CAST('f' AS boolean), CAST('f' AS boolean), CAST('f' AS boolean), CAST('f' AS boolean), CAST('f' AS boolean), CAST('t' AS boolean), CAST('f' AS boolean), CAST('t' AS boolean), CAST('t' AS boolean), CAST('f' AS boolean), CAST('t' AS boolean), CAST('t' AS boolean), 10, '90 days'::interval, '365 days'::interval, 10, '10 minutes'::interval, CAST('t' AS boolean), '/auth/error', CAST('t' AS boolean), 'lax', CAST('t' AS boolean), '2 weeks'::interval, '/', CAST('t' AS boolean), CAST('f' AS boolean));

CREATE TRIGGER app_settings_auth_insert_trg
  BEFORE INSERT
  ON myapp_auth_private.app_settings_auth
  FOR EACH ROW
  EXECUTE PROCEDURE utils.ensure_singleton();

CREATE FUNCTION myapp_auth_private.auth_settings() RETURNS myapp_auth_private.app_settings_auth AS $EOFCODE$
DECLARE
  settings myapp_auth_private.app_settings_auth;
BEGIN
  SELECT *
  FROM myapp_auth_private.app_settings_auth
  LIMIT
  1 INTO settings;
  RETURN settings;
END;
$EOFCODE$ LANGUAGE plpgsql STABLE SECURITY DEFINER;

CREATE FUNCTION myapp_auth_private.app_memberships_session_banned_tg() RETURNS trigger AS $EOFCODE$
BEGIN
  UPDATE myapp_auth_private.sessions SET
  revoked_at = now()
  WHERE
    user_id = NEW.actor_id AND revoked_at IS NULL;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE TRIGGER _99999_app_memberships_session_banned_trg
  AFTER UPDATE
  ON myapp_memberships_public.app_memberships
  FOR EACH ROW
  WHEN ((old.is_disabled IS DISTINCT FROM new.is_disabled
    OR old.is_banned IS DISTINCT FROM new.is_banned)
    AND (new.is_disabled IS TRUE
    OR new.is_banned IS TRUE))
  EXECUTE PROCEDURE myapp_auth_private.app_memberships_session_banned_tg();

CREATE VIEW myapp_auth_private.user_sessions WITH (security_invoker = 'true') AS SELECT
  id,
  user_id,
  auth_method,
  expires_at,
  revoked_at,
  origin,
  ip,
  uagent,
  fingerprint_mode,
  last_password_verified,
  last_mfa_verified,
  last_idp_verified,
  created_at,
  updated_at
FROM myapp_auth_private.sessions
WHERE
  user_id = jwt_public.current_principal_id();

CREATE RULE _insert_rule AS ON INSERT TO myapp_auth_private.user_sessions DO INSTEAD NOTHING;

CREATE RULE _update_rule AS ON UPDATE TO myapp_auth_private.user_sessions DO INSTEAD NOTHING;

CREATE RULE _delete_rule AS ON DELETE TO myapp_auth_private.user_sessions DO INSTEAD NOTHING;

COMMENT ON VIEW myapp_auth_private.user_sessions IS '@behavior -insert -update -delete';

GRANT SELECT ON myapp_auth_private.user_sessions TO authenticated;

CREATE VIEW myapp_auth_private.user_api_keys WITH (security_invoker = 'true') AS SELECT
  sc.id,
  sc.key_id,
  sc.name,
  sc.expires_at,
  sc.revoked_at,
  sc.last_used_at,
  sc.org_id,
  sc.mfa_level,
  sc.access_level,
  sc.created_at,
  sc.updated_at
FROM myapp_auth_private.session_credentials AS sc
JOIN myapp_auth_private.sessions AS s ON s.id = sc.session_id
WHERE
  sc.kind = 'api_key'
  AND s.user_id = jwt_public.current_user_id();

CREATE RULE _insert_rule AS ON INSERT TO myapp_auth_private.user_api_keys DO INSTEAD NOTHING;

CREATE RULE _update_rule AS ON UPDATE TO myapp_auth_private.user_api_keys DO INSTEAD NOTHING;

CREATE RULE _delete_rule AS ON DELETE TO myapp_auth_private.user_api_keys DO INSTEAD NOTHING;

COMMENT ON VIEW myapp_auth_private.user_api_keys IS '@behavior -insert -update -delete';

GRANT SELECT ON myapp_auth_private.user_api_keys TO authenticated;

CREATE TABLE myapp_auth_private.session_secrets ();

ALTER TABLE myapp_auth_private.session_secrets 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_auth_private.session_secrets IS 'DB-private, session-scoped ephemeral key-value store for challenges/nonces (e.g. WebAuthn challenges, MFA tokens, magic-link nonces). Never exposed to clients; accessed only by SECURITY DEFINER procedures on the private schema.';

ALTER TABLE myapp_auth_private.session_secrets 
  ADD COLUMN id uuid;

ALTER TABLE myapp_auth_private.session_secrets 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_auth_private.session_secrets 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_auth_private.session_secrets 
  ADD CONSTRAINT session_secrets_pkey PRIMARY KEY (id);

ALTER TABLE myapp_auth_private.session_secrets 
  ADD COLUMN session_id uuid;

ALTER TABLE myapp_auth_private.session_secrets 
  ALTER COLUMN session_id SET NOT NULL;

ALTER TABLE myapp_auth_private.session_secrets 
  ALTER COLUMN session_id SET DEFAULT jwt_public.current_user_id();

ALTER TABLE myapp_auth_private.session_secrets 
  ADD CONSTRAINT session_secrets_session_id_fkey
    FOREIGN KEY(session_id)
    REFERENCES myapp_auth_private.sessions (id)
    ON DELETE CASCADE;

CREATE INDEX session_secrets_session_id_idx ON myapp_auth_private.session_secrets (session_id);

ALTER TABLE myapp_auth_private.session_secrets 
  ADD COLUMN name text;

ALTER TABLE myapp_auth_private.session_secrets 
  ALTER COLUMN name SET NOT NULL;

COMMENT ON COLUMN myapp_auth_private.session_secrets.name IS 'Key name within the session namespace (e.g. webauthn_sign_in_challenge, mfa_challenge_token)';

ALTER TABLE myapp_auth_private.session_secrets 
  ADD COLUMN value text;

ALTER TABLE myapp_auth_private.session_secrets 
  ALTER COLUMN value SET NOT NULL;

COMMENT ON COLUMN myapp_auth_private.session_secrets.value IS 'The secret payload; use base64url for binary data';

ALTER TABLE myapp_auth_private.session_secrets 
  ADD COLUMN expires_at timestamptz;

COMMENT ON COLUMN myapp_auth_private.session_secrets.expires_at IS 'Per-row TTL. NULL means the row lives until the parent session is hard-deleted or explicit cleanup runs.';

ALTER TABLE myapp_auth_private.session_secrets 
  ADD COLUMN created_at timestamptz;

ALTER TABLE myapp_auth_private.session_secrets 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE myapp_auth_private.session_secrets 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE myapp_auth_private.session_secrets 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE TRIGGER timestamps_tg
  BEFORE INSERT OR UPDATE
  ON myapp_auth_private.session_secrets
  FOR EACH ROW
  EXECUTE PROCEDURE stamps.timestamps();

CREATE INDEX session_secrets_created_at_idx ON myapp_auth_private.session_secrets (created_at);

CREATE INDEX session_secrets_updated_at_idx ON myapp_auth_private.session_secrets (updated_at);

ALTER TABLE myapp_auth_private.session_secrets 
  ADD CONSTRAINT session_secrets_session_id_name_key 
    UNIQUE (session_id, name);

ALTER TABLE myapp_auth_private.session_secrets 
  ENABLE ROW LEVEL SECURITY;

CREATE FUNCTION myapp_auth_private.set_session_secret(
  IN v_session_id uuid,
  IN v_name text,
  IN v_value text,
  IN v_expires_at timestamptz DEFAULT NULL
) RETURNS void AS $EOFCODE$
BEGIN
  INSERT INTO myapp_auth_private.session_secrets (
    session_id,
    name,
    value,
    expires_at
  )
  VALUES
    (set_session_secret.v_session_id, set_session_secret.v_name, set_session_secret.v_value, set_session_secret.v_expires_at)
  ON CONFLICT (session_id, name) DO UPDATE SET
  value = EXCLUDED.value, expires_at = EXCLUDED.expires_at;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION myapp_auth_private.get_session_secret(
  IN v_session_id uuid,
  IN v_name text
) RETURNS text AS $EOFCODE$
DECLARE
  val text;
BEGIN
  SELECT s.value
  FROM myapp_auth_private.session_secrets AS s
  WHERE
    (s.session_id = get_session_secret.v_session_id AND s.name = get_session_secret.v_name) AND (s.expires_at IS NULL OR s.expires_at > now()) INTO val;
  IF NOT (FOUND) OR val IS NULL THEN
    RETURN NULL;
  END IF;
  RETURN val;
END;
$EOFCODE$ LANGUAGE plpgsql STABLE SECURITY DEFINER;

CREATE FUNCTION myapp_auth_private.consume_session_secret(
  IN v_session_id uuid,
  IN v_name text
) RETURNS text AS $EOFCODE$
DECLARE
  val text;
BEGIN
  DELETE FROM myapp_auth_private.session_secrets AS s
  WHERE
    (s.session_id = consume_session_secret.v_session_id AND s.name = consume_session_secret.v_name) AND (s.expires_at IS NULL OR s.expires_at > now())
  RETURNING s.value INTO val;
  IF NOT (FOUND) OR val IS NULL THEN
    RETURN NULL;
  END IF;
  RETURN val;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION myapp_auth_private.del_session_secret(
  IN v_session_id uuid,
  IN v_name text
) RETURNS void AS $EOFCODE$
BEGIN
  DELETE FROM myapp_auth_private.session_secrets AS s
  WHERE
    s.session_id = del_session_secret.v_session_id AND s.name = del_session_secret.v_name;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION myapp_auth_private.cleanup_expired_session_secrets() RETURNS void AS $EOFCODE$
BEGIN
  DELETE FROM myapp_auth_private.session_secrets AS s
  WHERE
    s.expires_at IS NOT NULL AND s.expires_at < now();
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE TABLE myapp_auth_private.app_settings_rate_limit ();

ALTER TABLE myapp_auth_private.app_settings_rate_limit 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_auth_private.app_settings_rate_limit IS 'Singleton configuration table for rate limiting thresholds including IP-based and user-based windows, attempt limits, and lockout durations';

ALTER TABLE myapp_auth_private.app_settings_rate_limit 
  ADD COLUMN id uuid;

ALTER TABLE myapp_auth_private.app_settings_rate_limit 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_auth_private.app_settings_rate_limit 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_auth_private.app_settings_rate_limit 
  ADD CONSTRAINT app_settings_rate_limits_pkey PRIMARY KEY (id);

ALTER TABLE myapp_auth_private.app_settings_rate_limit 
  ADD COLUMN ip_rate_limit_window interval;

ALTER TABLE myapp_auth_private.app_settings_rate_limit 
  ALTER COLUMN ip_rate_limit_window SET NOT NULL;

ALTER TABLE myapp_auth_private.app_settings_rate_limit 
  ALTER COLUMN ip_rate_limit_window SET DEFAULT '15 minutes'::interval;

COMMENT ON COLUMN myapp_auth_private.app_settings_rate_limit.ip_rate_limit_window IS 'Sliding window duration for counting IP-based rate limit attempts';

ALTER TABLE myapp_auth_private.app_settings_rate_limit 
  ADD COLUMN ip_max_attempts int;

ALTER TABLE myapp_auth_private.app_settings_rate_limit 
  ALTER COLUMN ip_max_attempts SET NOT NULL;

ALTER TABLE myapp_auth_private.app_settings_rate_limit 
  ALTER COLUMN ip_max_attempts SET DEFAULT 250;

COMMENT ON COLUMN myapp_auth_private.app_settings_rate_limit.ip_max_attempts IS 'Maximum number of attempts per IP address within the rate limit window before lockout';

ALTER TABLE myapp_auth_private.app_settings_rate_limit 
  ADD COLUMN ip_lockout_duration interval;

ALTER TABLE myapp_auth_private.app_settings_rate_limit 
  ALTER COLUMN ip_lockout_duration SET NOT NULL;

ALTER TABLE myapp_auth_private.app_settings_rate_limit 
  ALTER COLUMN ip_lockout_duration SET DEFAULT '30 minutes'::interval;

COMMENT ON COLUMN myapp_auth_private.app_settings_rate_limit.ip_lockout_duration IS 'How long an IP address is locked out after exceeding the maximum attempts';

ALTER TABLE myapp_auth_private.app_settings_rate_limit 
  ADD COLUMN user_rate_limit_window interval;

ALTER TABLE myapp_auth_private.app_settings_rate_limit 
  ALTER COLUMN user_rate_limit_window SET NOT NULL;

ALTER TABLE myapp_auth_private.app_settings_rate_limit 
  ALTER COLUMN user_rate_limit_window SET DEFAULT '15 minutes'::interval;

COMMENT ON COLUMN myapp_auth_private.app_settings_rate_limit.user_rate_limit_window IS 'Sliding window duration for counting user/subject-based rate limit attempts';

ALTER TABLE myapp_auth_private.app_settings_rate_limit 
  ADD COLUMN user_max_attempts int;

ALTER TABLE myapp_auth_private.app_settings_rate_limit 
  ALTER COLUMN user_max_attempts SET NOT NULL;

ALTER TABLE myapp_auth_private.app_settings_rate_limit 
  ALTER COLUMN user_max_attempts SET DEFAULT 10;

COMMENT ON COLUMN myapp_auth_private.app_settings_rate_limit.user_max_attempts IS 'Maximum number of attempts per user/subject within the rate limit window before lockout';

ALTER TABLE myapp_auth_private.app_settings_rate_limit 
  ADD COLUMN user_lockout_duration interval;

ALTER TABLE myapp_auth_private.app_settings_rate_limit 
  ALTER COLUMN user_lockout_duration SET NOT NULL;

ALTER TABLE myapp_auth_private.app_settings_rate_limit 
  ALTER COLUMN user_lockout_duration SET DEFAULT '15 minutes'::interval;

COMMENT ON COLUMN myapp_auth_private.app_settings_rate_limit.user_lockout_duration IS 'How long a user/subject is locked out after exceeding the maximum attempts';

ALTER TABLE myapp_auth_private.app_settings_rate_limit 
  ADD COLUMN email_cooldown_period interval;

ALTER TABLE myapp_auth_private.app_settings_rate_limit 
  ALTER COLUMN email_cooldown_period SET NOT NULL;

ALTER TABLE myapp_auth_private.app_settings_rate_limit 
  ALTER COLUMN email_cooldown_period SET DEFAULT '1 minute'::interval;

COMMENT ON COLUMN myapp_auth_private.app_settings_rate_limit.email_cooldown_period IS 'Minimum time between sending emails to the same address (forgot_password, verification, etc.)';

ALTER TABLE myapp_auth_private.app_settings_rate_limit 
  ADD COLUMN ip_ua_max_attempts int;

ALTER TABLE myapp_auth_private.app_settings_rate_limit 
  ALTER COLUMN ip_ua_max_attempts SET NOT NULL;

ALTER TABLE myapp_auth_private.app_settings_rate_limit 
  ALTER COLUMN ip_ua_max_attempts SET DEFAULT 50;

COMMENT ON COLUMN myapp_auth_private.app_settings_rate_limit.ip_ua_max_attempts IS 'Maximum attempts per IP + User-Agent pair within the IP rate limit window before lockout (second tier, catches individual attackers on shared networks)';

ALTER TABLE myapp_auth_private.app_settings_rate_limit 
  ADD COLUMN login_max_attempts int;

ALTER TABLE myapp_auth_private.app_settings_rate_limit 
  ALTER COLUMN login_max_attempts SET NOT NULL;

ALTER TABLE myapp_auth_private.app_settings_rate_limit 
  ALTER COLUMN login_max_attempts SET DEFAULT 5;

COMMENT ON COLUMN myapp_auth_private.app_settings_rate_limit.login_max_attempts IS 'Number of consecutive failed login attempts before the account is locked';

ALTER TABLE myapp_auth_private.app_settings_rate_limit 
  ADD COLUMN login_lockout_duration interval;

ALTER TABLE myapp_auth_private.app_settings_rate_limit 
  ALTER COLUMN login_lockout_duration SET NOT NULL;

ALTER TABLE myapp_auth_private.app_settings_rate_limit 
  ALTER COLUMN login_lockout_duration SET DEFAULT '15 minutes'::interval;

COMMENT ON COLUMN myapp_auth_private.app_settings_rate_limit.login_lockout_duration IS 'How long the account stays locked after exceeding max failed login attempts';

ALTER TABLE myapp_auth_private.app_settings_rate_limit 
  ADD COLUMN created_at timestamptz;

ALTER TABLE myapp_auth_private.app_settings_rate_limit 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE myapp_auth_private.app_settings_rate_limit 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE myapp_auth_private.app_settings_rate_limit 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE TRIGGER timestamps_tg
  BEFORE INSERT OR UPDATE
  ON myapp_auth_private.app_settings_rate_limit
  FOR EACH ROW
  EXECUTE PROCEDURE stamps.timestamps();

CREATE INDEX app_settings_rate_limit_created_at_idx ON myapp_auth_private.app_settings_rate_limit (created_at);

CREATE INDEX app_settings_rate_limit_updated_at_idx ON myapp_auth_private.app_settings_rate_limit (updated_at);

ALTER TABLE myapp_auth_private.app_settings_rate_limit 
  ENABLE ROW LEVEL SECURITY;

GRANT SELECT ON myapp_auth_private.app_settings_rate_limit TO authenticated;

GRANT UPDATE ON myapp_auth_private.app_settings_rate_limit TO authenticated;

CREATE POLICY auth_sel_app_mem
  ON myapp_auth_private.app_settings_rate_limit
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.is_admin IS TRUE
      OR app_sprt.is_owner IS TRUE))
  );

CREATE POLICY auth_upd_app_mem
  ON myapp_auth_private.app_settings_rate_limit
  AS PERMISSIVE
  FOR UPDATE
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.is_admin IS TRUE
      OR app_sprt.is_owner IS TRUE))
  );

INSERT INTO myapp_auth_private.app_settings_rate_limit (
  ip_rate_limit_window,
  ip_max_attempts,
  ip_lockout_duration,
  user_rate_limit_window,
  user_max_attempts,
  user_lockout_duration,
  email_cooldown_period,
  ip_ua_max_attempts,
  login_max_attempts,
  login_lockout_duration
) VALUES
  ('15 minutes'::interval, 250, '30 minutes'::interval, '15 minutes'::interval, 10, '15 minutes'::interval, '1 minute'::interval, 50, 5, '15 minutes'::interval);

CREATE TRIGGER app_settings_rate_limit_insert_trg
  BEFORE INSERT
  ON myapp_auth_private.app_settings_rate_limit
  FOR EACH ROW
  EXECUTE PROCEDURE utils.ensure_singleton();

CREATE TABLE myapp_auth_private.auth_ip_rate_limits ();

ALTER TABLE myapp_auth_private.auth_ip_rate_limits 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_auth_private.auth_ip_rate_limits IS 'Tracks per-IP-address rate limiting state for anonymous auth functions with native inet type support and /64 IPv6 normalization';

ALTER TABLE myapp_auth_private.auth_ip_rate_limits 
  ADD COLUMN id uuid;

ALTER TABLE myapp_auth_private.auth_ip_rate_limits 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_auth_private.auth_ip_rate_limits 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_auth_private.auth_ip_rate_limits 
  ADD CONSTRAINT auth_ip_rate_limits_pkey PRIMARY KEY (id);

ALTER TABLE myapp_auth_private.auth_ip_rate_limits 
  ADD COLUMN ip_address inet;

ALTER TABLE myapp_auth_private.auth_ip_rate_limits 
  ALTER COLUMN ip_address SET NOT NULL;

COMMENT ON COLUMN myapp_auth_private.auth_ip_rate_limits.ip_address IS 'Client IP address (IPv4 or IPv6 normalized to /64 prefix) being rate limited';

ALTER TABLE myapp_auth_private.auth_ip_rate_limits 
  ADD COLUMN ua_hash text;

ALTER TABLE myapp_auth_private.auth_ip_rate_limits 
  ALTER COLUMN ua_hash SET NOT NULL;

ALTER TABLE myapp_auth_private.auth_ip_rate_limits 
  ALTER COLUMN ua_hash SET DEFAULT '';

COMMENT ON COLUMN myapp_auth_private.auth_ip_rate_limits.ua_hash IS 'SHA-256 hash of User-Agent for per-client tracking; empty string for IP-only aggregate rows';

ALTER TABLE myapp_auth_private.auth_ip_rate_limits 
  ADD COLUMN action text;

ALTER TABLE myapp_auth_private.auth_ip_rate_limits 
  ALTER COLUMN action SET NOT NULL;

COMMENT ON COLUMN myapp_auth_private.auth_ip_rate_limits.action IS 'The auth function name this rate limit tracks (e.g. sign_in, sign_up, forgot_password)';

ALTER TABLE myapp_auth_private.auth_ip_rate_limits 
  ADD COLUMN attempts int;

ALTER TABLE myapp_auth_private.auth_ip_rate_limits 
  ALTER COLUMN attempts SET NOT NULL;

ALTER TABLE myapp_auth_private.auth_ip_rate_limits 
  ALTER COLUMN attempts SET DEFAULT 0;

COMMENT ON COLUMN myapp_auth_private.auth_ip_rate_limits.attempts IS 'Number of attempts from this IP for this action within the current rate limit window';

ALTER TABLE myapp_auth_private.auth_ip_rate_limits 
  ADD COLUMN first_attempt_at timestamptz;

COMMENT ON COLUMN myapp_auth_private.auth_ip_rate_limits.first_attempt_at IS 'Timestamp of the first attempt in the current window; NULL means no active window';

ALTER TABLE myapp_auth_private.auth_ip_rate_limits 
  ADD COLUMN locked_until timestamptz;

COMMENT ON COLUMN myapp_auth_private.auth_ip_rate_limits.locked_until IS 'Timestamp until which this IP is locked out for this action; NULL means not locked';

ALTER TABLE myapp_auth_private.auth_ip_rate_limits 
  ADD COLUMN created_at timestamptz;

ALTER TABLE myapp_auth_private.auth_ip_rate_limits 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE myapp_auth_private.auth_ip_rate_limits 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE myapp_auth_private.auth_ip_rate_limits 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE TRIGGER timestamps_tg
  BEFORE INSERT OR UPDATE
  ON myapp_auth_private.auth_ip_rate_limits
  FOR EACH ROW
  EXECUTE PROCEDURE stamps.timestamps();

CREATE INDEX auth_ip_rate_limits_created_at_idx ON myapp_auth_private.auth_ip_rate_limits (created_at);

CREATE INDEX auth_ip_rate_limits_updated_at_idx ON myapp_auth_private.auth_ip_rate_limits (updated_at);

ALTER TABLE myapp_auth_private.auth_ip_rate_limits 
  ADD CONSTRAINT auth_ip_rate_limits_ip_address_ua_hash_action_key 
    UNIQUE (ip_address, ua_hash, action);

CREATE INDEX auth_ip_rate_limits_ip_address_idx ON myapp_auth_private.auth_ip_rate_limits (ip_address);

CREATE INDEX auth_ip_rate_limits_locked_until_idx ON myapp_auth_private.auth_ip_rate_limits (locked_until);

CREATE TABLE myapp_auth_private.auth_rate_limits ();

ALTER TABLE myapp_auth_private.auth_rate_limits 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_auth_private.auth_rate_limits IS 'Tracks per-user/subject rate limiting state for auth functions using UUID subject identifiers';

ALTER TABLE myapp_auth_private.auth_rate_limits 
  ADD COLUMN id uuid;

ALTER TABLE myapp_auth_private.auth_rate_limits 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_auth_private.auth_rate_limits 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_auth_private.auth_rate_limits 
  ADD CONSTRAINT auth_rate_limits_pkey PRIMARY KEY (id);

ALTER TABLE myapp_auth_private.auth_rate_limits 
  ADD COLUMN subject_id uuid;

ALTER TABLE myapp_auth_private.auth_rate_limits 
  ALTER COLUMN subject_id SET NOT NULL;

COMMENT ON COLUMN myapp_auth_private.auth_rate_limits.subject_id IS 'UUID of the user or entity being rate limited';

ALTER TABLE myapp_auth_private.auth_rate_limits 
  ADD COLUMN action text;

ALTER TABLE myapp_auth_private.auth_rate_limits 
  ALTER COLUMN action SET NOT NULL;

COMMENT ON COLUMN myapp_auth_private.auth_rate_limits.action IS 'The auth function name this rate limit tracks (e.g. sign_in, verify_password, reset_password)';

ALTER TABLE myapp_auth_private.auth_rate_limits 
  ADD COLUMN attempts int;

ALTER TABLE myapp_auth_private.auth_rate_limits 
  ALTER COLUMN attempts SET NOT NULL;

ALTER TABLE myapp_auth_private.auth_rate_limits 
  ALTER COLUMN attempts SET DEFAULT 0;

COMMENT ON COLUMN myapp_auth_private.auth_rate_limits.attempts IS 'Number of attempts from this subject for this action within the current rate limit window';

ALTER TABLE myapp_auth_private.auth_rate_limits 
  ADD COLUMN first_attempt_at timestamptz;

COMMENT ON COLUMN myapp_auth_private.auth_rate_limits.first_attempt_at IS 'Timestamp of the first attempt in the current window; NULL means no active window';

ALTER TABLE myapp_auth_private.auth_rate_limits 
  ADD COLUMN last_attempt_at timestamptz;

COMMENT ON COLUMN myapp_auth_private.auth_rate_limits.last_attempt_at IS 'Timestamp of the most recent attempt; used for cooldown period enforcement';

ALTER TABLE myapp_auth_private.auth_rate_limits 
  ADD COLUMN locked_until timestamptz;

COMMENT ON COLUMN myapp_auth_private.auth_rate_limits.locked_until IS 'Timestamp until which this subject is locked out for this action; NULL means not locked';

ALTER TABLE myapp_auth_private.auth_rate_limits 
  ADD COLUMN created_at timestamptz;

ALTER TABLE myapp_auth_private.auth_rate_limits 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE myapp_auth_private.auth_rate_limits 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE myapp_auth_private.auth_rate_limits 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE TRIGGER timestamps_tg
  BEFORE INSERT OR UPDATE
  ON myapp_auth_private.auth_rate_limits
  FOR EACH ROW
  EXECUTE PROCEDURE stamps.timestamps();

CREATE INDEX auth_rate_limits_created_at_idx ON myapp_auth_private.auth_rate_limits (created_at);

CREATE INDEX auth_rate_limits_updated_at_idx ON myapp_auth_private.auth_rate_limits (updated_at);

ALTER TABLE myapp_auth_private.auth_rate_limits 
  ADD CONSTRAINT auth_rate_limits_subject_id_action_key 
    UNIQUE (subject_id, action);

CREATE INDEX auth_rate_limits_subject_id_idx ON myapp_auth_private.auth_rate_limits (subject_id);

CREATE INDEX auth_rate_limits_locked_until_idx ON myapp_auth_private.auth_rate_limits (locked_until);

CREATE TABLE myapp_auth_private.app_settings_device ();

ALTER TABLE myapp_auth_private.app_settings_device 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_auth_private.app_settings_device IS 'Singleton configuration table for device tracking and trust settings';

ALTER TABLE myapp_auth_private.app_settings_device 
  ADD COLUMN id uuid;

ALTER TABLE myapp_auth_private.app_settings_device 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_auth_private.app_settings_device 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_auth_private.app_settings_device 
  ADD CONSTRAINT app_settings_devices_pkey PRIMARY KEY (id);

ALTER TABLE myapp_auth_private.app_settings_device 
  ADD COLUMN enable_device_tracking bool;

ALTER TABLE myapp_auth_private.app_settings_device 
  ALTER COLUMN enable_device_tracking SET NOT NULL;

ALTER TABLE myapp_auth_private.app_settings_device 
  ALTER COLUMN enable_device_tracking SET DEFAULT true;

COMMENT ON COLUMN myapp_auth_private.app_settings_device.enable_device_tracking IS 'Master switch to enable or disable device tracking for this application';

ALTER TABLE myapp_auth_private.app_settings_device 
  ADD COLUMN enable_trusted_devices bool;

ALTER TABLE myapp_auth_private.app_settings_device 
  ALTER COLUMN enable_trusted_devices SET NOT NULL;

ALTER TABLE myapp_auth_private.app_settings_device 
  ALTER COLUMN enable_trusted_devices SET DEFAULT false;

COMMENT ON COLUMN myapp_auth_private.app_settings_device.enable_trusted_devices IS 'Whether trusted devices can skip MFA challenges on subsequent sign-ins';

ALTER TABLE myapp_auth_private.app_settings_device 
  ADD COLUMN device_trust_duration interval;

ALTER TABLE myapp_auth_private.app_settings_device 
  ALTER COLUMN device_trust_duration SET NOT NULL;

ALTER TABLE myapp_auth_private.app_settings_device 
  ALTER COLUMN device_trust_duration SET DEFAULT '30 days'::interval;

COMMENT ON COLUMN myapp_auth_private.app_settings_device.device_trust_duration IS 'How long a device remains trusted after user explicitly marks it as trusted via MFA';

ALTER TABLE myapp_auth_private.app_settings_device 
  ADD COLUMN require_mfa_new_device bool;

ALTER TABLE myapp_auth_private.app_settings_device 
  ALTER COLUMN require_mfa_new_device SET NOT NULL;

ALTER TABLE myapp_auth_private.app_settings_device 
  ALTER COLUMN require_mfa_new_device SET DEFAULT false;

COMMENT ON COLUMN myapp_auth_private.app_settings_device.require_mfa_new_device IS 'Whether to require MFA verification when logging in from an unrecognized device';

ALTER TABLE myapp_auth_private.app_settings_device 
  ADD COLUMN require_device_approval bool;

ALTER TABLE myapp_auth_private.app_settings_device 
  ALTER COLUMN require_device_approval SET NOT NULL;

ALTER TABLE myapp_auth_private.app_settings_device 
  ALTER COLUMN require_device_approval SET DEFAULT false;

COMMENT ON COLUMN myapp_auth_private.app_settings_device.require_device_approval IS 'Whether to require email approval when logging in from an unrecognized device';

ALTER TABLE myapp_auth_private.app_settings_device 
  ADD COLUMN max_devices_per_user int;

ALTER TABLE myapp_auth_private.app_settings_device 
  ALTER COLUMN max_devices_per_user SET NOT NULL;

ALTER TABLE myapp_auth_private.app_settings_device 
  ALTER COLUMN max_devices_per_user SET DEFAULT 50;

COMMENT ON COLUMN myapp_auth_private.app_settings_device.max_devices_per_user IS 'Maximum number of active (non-revoked) device records per user; oldest devices are auto-revoked when exceeded';

ALTER TABLE myapp_auth_private.app_settings_device 
  ADD COLUMN created_at timestamptz;

ALTER TABLE myapp_auth_private.app_settings_device 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE myapp_auth_private.app_settings_device 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE myapp_auth_private.app_settings_device 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE TRIGGER timestamps_tg
  BEFORE INSERT OR UPDATE
  ON myapp_auth_private.app_settings_device
  FOR EACH ROW
  EXECUTE PROCEDURE stamps.timestamps();

CREATE INDEX app_settings_device_created_at_idx ON myapp_auth_private.app_settings_device (created_at);

CREATE INDEX app_settings_device_updated_at_idx ON myapp_auth_private.app_settings_device (updated_at);

ALTER TABLE myapp_auth_private.app_settings_device 
  ENABLE ROW LEVEL SECURITY;

GRANT SELECT ON myapp_auth_private.app_settings_device TO authenticated;

GRANT UPDATE ON myapp_auth_private.app_settings_device TO authenticated;

CREATE POLICY auth_sel_app_mem
  ON myapp_auth_private.app_settings_device
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.is_admin IS TRUE
      OR app_sprt.is_owner IS TRUE))
  );

CREATE POLICY auth_upd_app_mem
  ON myapp_auth_private.app_settings_device
  AS PERMISSIVE
  FOR UPDATE
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.is_admin IS TRUE
      OR app_sprt.is_owner IS TRUE))
  );

INSERT INTO myapp_auth_private.app_settings_device (
  enable_device_tracking,
  enable_trusted_devices,
  device_trust_duration,
  require_mfa_new_device,
  require_device_approval,
  max_devices_per_user
) VALUES
  (CAST('true' AS boolean), CAST('false' AS boolean), '30 days'::interval, CAST('false' AS boolean), CAST('false' AS boolean), 50);

CREATE TRIGGER app_settings_device_insert_trg
  BEFORE INSERT
  ON myapp_auth_private.app_settings_device
  FOR EACH ROW
  EXECUTE PROCEDURE utils.ensure_singleton();

CREATE TABLE myapp_auth_private.auth_user_devices ();

ALTER TABLE myapp_auth_private.auth_user_devices 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_auth_private.auth_user_devices IS 'Tracks recognized and trusted devices per user via persistent opaque device tokens';

ALTER TABLE myapp_auth_private.auth_user_devices 
  ADD COLUMN id uuid;

ALTER TABLE myapp_auth_private.auth_user_devices 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_auth_private.auth_user_devices 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_auth_private.auth_user_devices 
  ADD CONSTRAINT auth_user_devices_pkey PRIMARY KEY (id);

ALTER TABLE myapp_auth_private.auth_user_devices 
  ADD COLUMN user_id uuid;

ALTER TABLE myapp_auth_private.auth_user_devices 
  ALTER COLUMN user_id SET NOT NULL;

COMMENT ON COLUMN myapp_auth_private.auth_user_devices.user_id IS 'User who owns this device record';

ALTER TABLE myapp_auth_private.auth_user_devices 
  ADD COLUMN device_token_hash bytea;

ALTER TABLE myapp_auth_private.auth_user_devices 
  ALTER COLUMN device_token_hash SET NOT NULL;

COMMENT ON COLUMN myapp_auth_private.auth_user_devices.device_token_hash IS 'SHA-256 hash of the persistent device token (stored in secure cookie on client)';

ALTER TABLE myapp_auth_private.auth_user_devices 
  ADD COLUMN label text;

COMMENT ON COLUMN myapp_auth_private.auth_user_devices.label IS 'User-facing device label derived from user agent (e.g. Chrome on macOS)';

ALTER TABLE myapp_auth_private.auth_user_devices 
  ADD COLUMN first_seen_at timestamptz;

ALTER TABLE myapp_auth_private.auth_user_devices 
  ALTER COLUMN first_seen_at SET NOT NULL;

ALTER TABLE myapp_auth_private.auth_user_devices 
  ALTER COLUMN first_seen_at SET DEFAULT CURRENT_TIMESTAMP;

COMMENT ON COLUMN myapp_auth_private.auth_user_devices.first_seen_at IS 'Timestamp when this device was first seen (first successful auth with this token)';

ALTER TABLE myapp_auth_private.auth_user_devices 
  ADD COLUMN last_seen_at timestamptz;

ALTER TABLE myapp_auth_private.auth_user_devices 
  ALTER COLUMN last_seen_at SET NOT NULL;

ALTER TABLE myapp_auth_private.auth_user_devices 
  ALTER COLUMN last_seen_at SET DEFAULT CURRENT_TIMESTAMP;

COMMENT ON COLUMN myapp_auth_private.auth_user_devices.last_seen_at IS 'Timestamp of the most recent successful auth using this device token';

ALTER TABLE myapp_auth_private.auth_user_devices 
  ADD COLUMN first_seen_ip inet;

COMMENT ON COLUMN myapp_auth_private.auth_user_devices.first_seen_ip IS 'IP address when this device was first seen';

ALTER TABLE myapp_auth_private.auth_user_devices 
  ADD COLUMN last_seen_ip inet;

COMMENT ON COLUMN myapp_auth_private.auth_user_devices.last_seen_ip IS 'IP address of the most recent auth using this device';

ALTER TABLE myapp_auth_private.auth_user_devices 
  ADD COLUMN user_agent text;

COMMENT ON COLUMN myapp_auth_private.auth_user_devices.user_agent IS 'Browser or client user-agent string captured when device was first seen';

ALTER TABLE myapp_auth_private.auth_user_devices 
  ADD COLUMN origin origin;

COMMENT ON COLUMN myapp_auth_private.auth_user_devices.origin IS 'Request origin (domain) where the device was first seen';

ALTER TABLE myapp_auth_private.auth_user_devices 
  ADD COLUMN is_approved bool;

ALTER TABLE myapp_auth_private.auth_user_devices 
  ALTER COLUMN is_approved SET NOT NULL;

ALTER TABLE myapp_auth_private.auth_user_devices 
  ALTER COLUMN is_approved SET DEFAULT false;

COMMENT ON COLUMN myapp_auth_private.auth_user_devices.is_approved IS 'Whether this device has been approved for login (via email confirmation, admin, or auto on first sign-up)';

ALTER TABLE myapp_auth_private.auth_user_devices 
  ADD COLUMN approved_at timestamptz;

COMMENT ON COLUMN myapp_auth_private.auth_user_devices.approved_at IS 'Timestamp when this device was approved for login';

ALTER TABLE myapp_auth_private.auth_user_devices 
  ADD COLUMN approval_method text;

COMMENT ON COLUMN myapp_auth_private.auth_user_devices.approval_method IS 'Method used to approve the device (e.g. email_link, admin, auto)';

ALTER TABLE myapp_auth_private.auth_user_devices 
  ADD COLUMN is_trusted bool;

ALTER TABLE myapp_auth_private.auth_user_devices 
  ALTER COLUMN is_trusted SET NOT NULL;

ALTER TABLE myapp_auth_private.auth_user_devices 
  ALTER COLUMN is_trusted SET DEFAULT false;

COMMENT ON COLUMN myapp_auth_private.auth_user_devices.is_trusted IS 'Whether the user explicitly trusted this device after MFA verification';

ALTER TABLE myapp_auth_private.auth_user_devices 
  ADD COLUMN trusted_at timestamptz;

COMMENT ON COLUMN myapp_auth_private.auth_user_devices.trusted_at IS 'Timestamp when the user explicitly marked this device as trusted';

ALTER TABLE myapp_auth_private.auth_user_devices 
  ADD COLUMN trust_expires_at timestamptz;

COMMENT ON COLUMN myapp_auth_private.auth_user_devices.trust_expires_at IS 'Timestamp when the device trust expires and MFA will be required again';

ALTER TABLE myapp_auth_private.auth_user_devices 
  ADD COLUMN trust_method text;

COMMENT ON COLUMN myapp_auth_private.auth_user_devices.trust_method IS 'Method used to establish trust (e.g. mfa, email_link, admin)';

ALTER TABLE myapp_auth_private.auth_user_devices 
  ADD COLUMN revoked_at timestamptz;

COMMENT ON COLUMN myapp_auth_private.auth_user_devices.revoked_at IS 'Timestamp when this device was revoked; non-NULL means device is no longer valid';

ALTER TABLE myapp_auth_private.auth_user_devices 
  ADD COLUMN created_at timestamptz;

ALTER TABLE myapp_auth_private.auth_user_devices 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE myapp_auth_private.auth_user_devices 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE myapp_auth_private.auth_user_devices 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE TRIGGER timestamps_tg
  BEFORE INSERT OR UPDATE
  ON myapp_auth_private.auth_user_devices
  FOR EACH ROW
  EXECUTE PROCEDURE stamps.timestamps();

CREATE INDEX auth_user_devices_created_at_idx ON myapp_auth_private.auth_user_devices (created_at);

CREATE INDEX auth_user_devices_updated_at_idx ON myapp_auth_private.auth_user_devices (updated_at);

ALTER TABLE myapp_auth_private.auth_user_devices 
  ADD CONSTRAINT auth_user_devices_user_id_fkey
    FOREIGN KEY(user_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE CASCADE;

ALTER TABLE myapp_auth_private.auth_user_devices 
  ADD CONSTRAINT auth_user_devices_user_id_device_token_hash_key 
    UNIQUE (user_id, device_token_hash);

CREATE INDEX auth_user_devices_user_id_idx ON myapp_auth_private.auth_user_devices (user_id);

CREATE INDEX auth_user_devices_device_token_hash_idx ON myapp_auth_private.auth_user_devices (device_token_hash);

CREATE INDEX auth_user_devices_trust_expires_at_idx ON myapp_auth_private.auth_user_devices (trust_expires_at);

ALTER TABLE myapp_auth_private.auth_user_devices 
  ENABLE ROW LEVEL SECURITY;

GRANT SELECT ON myapp_auth_private.auth_user_devices TO authenticated;

GRANT UPDATE ON myapp_auth_private.auth_user_devices TO authenticated;

GRANT DELETE ON myapp_auth_private.auth_user_devices TO authenticated;

CREATE POLICY auth_sel_dir_own
  ON myapp_auth_private.auth_user_devices
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    user_id = jwt_public.current_principal_id()
  );

CREATE POLICY auth_upd_dir_own
  ON myapp_auth_private.auth_user_devices
  AS PERMISSIVE
  FOR UPDATE
  TO authenticated
  USING (
    user_id = jwt_public.current_principal_id()
  );

CREATE POLICY auth_del_dir_own
  ON myapp_auth_private.auth_user_devices
  AS PERMISSIVE
  FOR DELETE
  TO authenticated
  USING (
    user_id = jwt_public.current_principal_id()
  );

CREATE TABLE myapp_store_private.user_secrets ();

ALTER TABLE myapp_store_private.user_secrets 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_store_private.user_secrets IS 'Per-user bcrypt credential store (password hashes, API key hashes)';

ALTER TABLE myapp_store_private.user_secrets 
  ADD COLUMN id uuid;

ALTER TABLE myapp_store_private.user_secrets 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_store_private.user_secrets 
  ALTER COLUMN id SET DEFAULT uuidv7();

COMMENT ON COLUMN myapp_store_private.user_secrets.id IS 'Unique identifier for this credential entry';

ALTER TABLE myapp_store_private.user_secrets 
  ADD COLUMN owner_id uuid;

ALTER TABLE myapp_store_private.user_secrets 
  ALTER COLUMN owner_id SET NOT NULL;

COMMENT ON COLUMN myapp_store_private.user_secrets.owner_id IS 'User who owns this credential';

ALTER TABLE myapp_store_private.user_secrets 
  ADD COLUMN name text;

ALTER TABLE myapp_store_private.user_secrets 
  ALTER COLUMN name SET NOT NULL;

COMMENT ON COLUMN myapp_store_private.user_secrets.name IS 'Key name identifying the credential (e.g. password_hash)';

ALTER TABLE myapp_store_private.user_secrets 
  ADD COLUMN value bytea;

COMMENT ON COLUMN myapp_store_private.user_secrets.value IS 'The bcrypt-hashed credential value stored as binary';

ALTER TABLE myapp_store_private.user_secrets 
  ADD COLUMN algo text;

COMMENT ON COLUMN myapp_store_private.user_secrets.algo IS 'Hash algorithm used (crypt/bcrypt)';

ALTER TABLE myapp_store_private.user_secrets 
  ADD COLUMN created_at timestamptz;

ALTER TABLE myapp_store_private.user_secrets 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE myapp_store_private.user_secrets 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE myapp_store_private.user_secrets 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE TRIGGER timestamps_tg
  BEFORE INSERT OR UPDATE
  ON myapp_store_private.user_secrets
  FOR EACH ROW
  EXECUTE PROCEDURE stamps.timestamps();

CREATE INDEX user_secrets_created_at_idx ON myapp_store_private.user_secrets (created_at);

CREATE INDEX user_secrets_updated_at_idx ON myapp_store_private.user_secrets (updated_at);

ALTER TABLE myapp_store_private.user_secrets 
  ADD CONSTRAINT user_secrets_pkey PRIMARY KEY (id);

ALTER TABLE myapp_store_private.user_secrets 
  ADD CONSTRAINT user_secrets_owner_id_name_key 
    UNIQUE (owner_id, name);

ALTER TABLE myapp_store_private.user_secrets 
  ENABLE ROW LEVEL SECURITY;

GRANT INSERT ON myapp_store_private.user_secrets TO authenticated;

GRANT UPDATE ON myapp_store_private.user_secrets TO authenticated;

GRANT DELETE ON myapp_store_private.user_secrets TO authenticated;

CREATE POLICY auth_ins_dir_own
  ON myapp_store_private.user_secrets
  AS PERMISSIVE
  FOR INSERT
  TO authenticated
  WITH CHECK (
    owner_id = jwt_public.current_principal_id()
  );

CREATE POLICY auth_upd_dir_own
  ON myapp_store_private.user_secrets
  AS PERMISSIVE
  FOR UPDATE
  TO authenticated
  USING (
    owner_id = jwt_public.current_principal_id()
  );

CREATE POLICY auth_del_dir_own
  ON myapp_store_private.user_secrets
  AS PERMISSIVE
  FOR DELETE
  TO authenticated
  USING (
    owner_id = jwt_public.current_principal_id()
  );

CREATE FUNCTION myapp_store_private.user_secrets_hash() RETURNS trigger AS $EOFCODE$
BEGIN
  IF NEW.algo = 'crypt' THEN
    SELECT public.crypt(NEW.value::text, public.gen_salt('bf')) INTO NEW.value;
  ELSE
    IF NEW.algo = 'pgp' THEN
      SELECT public.pgp_sym_encrypt(pg_catalog.encode(NEW.value::bytea, 'hex'), NEW.owner_id::text, 'compress-algo=1, cipher-algo=aes256') INTO NEW.value;
    ELSE
      SELECT 'none' INTO NEW.algo;
    END IF;
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE;

CREATE TRIGGER user_secrets_update_tg
  BEFORE UPDATE
  ON myapp_store_private.user_secrets
  FOR EACH ROW
  WHEN (old.value IS DISTINCT FROM new.value)
  EXECUTE PROCEDURE myapp_store_private.user_secrets_hash();

CREATE TRIGGER user_secrets_insert_tg
  BEFORE INSERT
  ON myapp_store_private.user_secrets
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_store_private.user_secrets_hash();

CREATE FUNCTION myapp_store_private.user_secrets_get(
  IN owner_id uuid,
  IN secret_name text,
  IN default_value text DEFAULT NULL
) RETURNS text AS $EOFCODE$
DECLARE
  v_secret myapp_store_private.user_secrets;
BEGIN
  SELECT *
  FROM myapp_store_private.user_secrets AS s
  WHERE
    s.name = user_secrets_get.secret_name AND s.owner_id = user_secrets_get.owner_id INTO v_secret;
  IF NOT (FOUND) OR v_secret IS NULL THEN
    RETURN user_secrets_get.default_value;
  END IF;
  IF v_secret.algo = 'crypt' THEN
    RETURN pg_catalog.convert_from(v_secret.value, 'SQL_ASCII');
  ELSIF v_secret.algo = 'pgp' THEN
    RETURN pg_catalog.convert_from(pg_catalog.decode(public.pgp_sym_decrypt(v_secret.value, v_secret.owner_id::text), 'hex'), 'SQL_ASCII');
  END IF;
  RETURN pg_catalog.convert_from(v_secret.value, 'SQL_ASCII');
END;
$EOFCODE$ LANGUAGE plpgsql STABLE;

GRANT EXECUTE ON FUNCTION myapp_store_private.user_secrets_get TO authenticated;

CREATE FUNCTION myapp_store_private.user_secrets_verify(
  IN owner_id uuid,
  IN secret_name text,
  IN value text
) RETURNS boolean AS $EOFCODE$
DECLARE
  v_secret_text text;
  v_secret myapp_store_private.user_secrets;
BEGIN
  SELECT myapp_store_private.user_secrets_get(user_secrets_verify.owner_id, user_secrets_verify.secret_name) INTO v_secret_text;
  SELECT *
  FROM myapp_store_private.user_secrets AS s
  WHERE
    s.name = user_secrets_verify.secret_name AND s.owner_id = user_secrets_verify.owner_id INTO v_secret;
  IF v_secret.algo = 'crypt' THEN
    RETURN v_secret_text = public.crypt(user_secrets_verify.value::bytea::text, v_secret_text);
  ELSIF v_secret.algo = 'pgp' THEN
    RETURN user_secrets_verify.value = v_secret_text;
  END IF;
  RETURN user_secrets_verify.value = v_secret_text;
END;
$EOFCODE$ LANGUAGE plpgsql STABLE;

GRANT EXECUTE ON FUNCTION myapp_store_private.user_secrets_verify TO authenticated;

CREATE FUNCTION myapp_store_private.user_secrets_set(
  IN user_id uuid,
  IN secret_name text,
  IN secret_value text,
  IN algo text DEFAULT 'pgp'
) RETURNS boolean AS $EOFCODE$
BEGIN
  INSERT INTO myapp_store_private.user_secrets (
    owner_id,
    name,
    value,
    algo
  )
  VALUES
    (user_secrets_set.user_id, user_secrets_set.secret_name, user_secrets_set.secret_value::bytea, user_secrets_set.algo)
  ON CONFLICT (owner_id, name) DO UPDATE SET
  value = user_secrets_set.secret_value::bytea, algo = EXCLUDED.algo;
  RETURN true;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE;

GRANT EXECUTE ON FUNCTION myapp_store_private.user_secrets_set TO authenticated;

CREATE FUNCTION myapp_store_private.user_secrets_del(
  IN owner_id uuid,
  IN secret_name text
) RETURNS void AS $EOFCODE$
BEGIN
  DELETE FROM myapp_store_private.user_secrets AS s
  WHERE
    s.owner_id = user_secrets_del.owner_id AND s.name = user_secrets_del.secret_name;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE SCHEMA myapp_store_public;

GRANT USAGE ON SCHEMA myapp_store_public TO administrator;

GRANT USAGE ON SCHEMA myapp_store_public TO authenticated;

GRANT USAGE ON SCHEMA myapp_store_public TO anonymous;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_store_public
  GRANT ALL ON TABLES TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_store_public
  GRANT USAGE ON SEQUENCES TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_store_public
  GRANT ALL ON FUNCTIONS TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_store_public
  GRANT ALL ON FUNCTIONS TO authenticated;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_store_public
  GRANT USAGE ON SEQUENCES TO authenticated;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_store_public
  GRANT ALL ON FUNCTIONS TO anonymous;

CREATE TABLE myapp_store_private.app_internal_secrets ();

ALTER TABLE myapp_store_private.app_internal_secrets 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_store_private.app_internal_secrets IS 'app-level PGP-encrypted key-value secrets store';

ALTER TABLE myapp_store_private.app_internal_secrets 
  ADD COLUMN id uuid;

ALTER TABLE myapp_store_private.app_internal_secrets 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_store_private.app_internal_secrets 
  ALTER COLUMN id SET DEFAULT uuidv7();

COMMENT ON COLUMN myapp_store_private.app_internal_secrets.id IS 'Unique identifier for this secret entry';

ALTER TABLE myapp_store_private.app_internal_secrets 
  ADD COLUMN key_id uuid;

ALTER TABLE myapp_store_private.app_internal_secrets 
  ALTER COLUMN key_id SET NOT NULL;

ALTER TABLE myapp_store_private.app_internal_secrets 
  ALTER COLUMN key_id SET DEFAULT uuidv7();

COMMENT ON COLUMN myapp_store_private.app_internal_secrets.key_id IS 'Per-secret key used as PGP symmetric encryption passphrase';

ALTER TABLE myapp_store_private.app_internal_secrets 
  ADD COLUMN namespace_id uuid;

ALTER TABLE myapp_store_private.app_internal_secrets 
  ALTER COLUMN namespace_id SET NOT NULL;

ALTER TABLE myapp_store_private.app_internal_secrets 
  ALTER COLUMN namespace_id SET DEFAULT '00000000-0000-0000-0000-000000000000'::uuid;

COMMENT ON COLUMN myapp_store_private.app_internal_secrets.namespace_id IS 'Logical grouping key for internal secret entries; always uuid_nil() for app-scoped internal secrets. Not an FK because internal_secrets_module does not depend on namespace_module.';

ALTER TABLE myapp_store_private.app_internal_secrets 
  ADD COLUMN name text;

ALTER TABLE myapp_store_private.app_internal_secrets 
  ALTER COLUMN name SET NOT NULL;

COMMENT ON COLUMN myapp_store_private.app_internal_secrets.name IS 'Key name identifying the secret';

ALTER TABLE myapp_store_private.app_internal_secrets 
  ADD COLUMN value bytea;

COMMENT ON COLUMN myapp_store_private.app_internal_secrets.value IS 'The PGP-encrypted secret value stored as binary';

ALTER TABLE myapp_store_private.app_internal_secrets 
  ADD COLUMN algo text;

COMMENT ON COLUMN myapp_store_private.app_internal_secrets.algo IS 'Encryption algorithm used (pgp)';

ALTER TABLE myapp_store_private.app_internal_secrets 
  ADD COLUMN labels jsonb;

ALTER TABLE myapp_store_private.app_internal_secrets 
  ALTER COLUMN labels SET NOT NULL;

ALTER TABLE myapp_store_private.app_internal_secrets 
  ALTER COLUMN labels SET DEFAULT '{}'::jsonb;

COMMENT ON COLUMN myapp_store_private.app_internal_secrets.labels IS 'Key/value pairs for selecting/filtering secrets';

ALTER TABLE myapp_store_private.app_internal_secrets 
  ADD COLUMN annotations jsonb;

ALTER TABLE myapp_store_private.app_internal_secrets 
  ALTER COLUMN annotations SET NOT NULL;

ALTER TABLE myapp_store_private.app_internal_secrets 
  ALTER COLUMN annotations SET DEFAULT '{}'::jsonb;

COMMENT ON COLUMN myapp_store_private.app_internal_secrets.annotations IS 'Freeform metadata for tooling and operational notes';

ALTER TABLE myapp_store_private.app_internal_secrets 
  ADD COLUMN description text;

COMMENT ON COLUMN myapp_store_private.app_internal_secrets.description IS 'Human-readable note about this secret';

ALTER TABLE myapp_store_private.app_internal_secrets 
  ADD COLUMN created_at timestamptz;

ALTER TABLE myapp_store_private.app_internal_secrets 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE myapp_store_private.app_internal_secrets 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE myapp_store_private.app_internal_secrets 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE TRIGGER timestamps_tg
  BEFORE INSERT OR UPDATE
  ON myapp_store_private.app_internal_secrets
  FOR EACH ROW
  EXECUTE PROCEDURE stamps.timestamps();

CREATE INDEX app_internal_secrets_created_at_idx ON myapp_store_private.app_internal_secrets (created_at);

CREATE INDEX app_internal_secrets_updated_at_idx ON myapp_store_private.app_internal_secrets (updated_at);

ALTER TABLE myapp_store_private.app_internal_secrets 
  ADD COLUMN retired_at timestamptz;

COMMENT ON COLUMN myapp_store_private.app_internal_secrets.retired_at IS 'When this secret version was retired by rotation. NULL = active. Only one active secret per (namespace_id, name) is allowed via partial unique index.';

ALTER TABLE myapp_store_private.app_internal_secrets 
  ADD COLUMN rotated_at timestamptz;

COMMENT ON COLUMN myapp_store_private.app_internal_secrets.rotated_at IS 'When this secret version was created by a rotation operation. NULL for secrets created directly (not via rotation).';

ALTER TABLE myapp_store_private.app_internal_secrets 
  ADD CONSTRAINT app_internal_secrets_pkey PRIMARY KEY (id);

CREATE UNIQUE INDEX app_internal_secrets_namespace_id_name_idx ON myapp_store_private.app_internal_secrets (namespace_id, name) WHERE retired_at IS NULL;

ALTER TABLE myapp_store_private.app_internal_secrets 
  ENABLE ROW LEVEL SECURITY;

GRANT SELECT ON myapp_store_private.app_internal_secrets TO authenticated;

GRANT INSERT ON myapp_store_private.app_internal_secrets TO authenticated;

GRANT UPDATE ON myapp_store_private.app_internal_secrets TO authenticated;

GRANT DELETE ON myapp_store_private.app_internal_secrets TO authenticated;

CREATE POLICY auth_sel_app_mem
  ON myapp_store_private.app_internal_secrets
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND app_sprt.is_admin IS TRUE)
  );

CREATE POLICY auth_ins_app_mem
  ON myapp_store_private.app_internal_secrets
  AS PERMISSIVE
  FOR INSERT
  TO authenticated
  WITH CHECK (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND app_sprt.is_admin IS TRUE)
  );

CREATE POLICY auth_upd_app_mem
  ON myapp_store_private.app_internal_secrets
  AS PERMISSIVE
  FOR UPDATE
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND app_sprt.is_admin IS TRUE)
  );

CREATE POLICY auth_del_app_mem
  ON myapp_store_private.app_internal_secrets
  AS PERMISSIVE
  FOR DELETE
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND app_sprt.is_admin IS TRUE)
  );

CREATE VIEW myapp_store_public.app_internal_secrets WITH (security_invoker = 'true') AS SELECT
  id,
  name,
  namespace_id,
  description,
  labels,
  annotations,
  created_at,
  updated_at,
  rotated_at,
  retired_at
FROM myapp_store_private.app_internal_secrets;

CREATE RULE _insert_rule AS ON INSERT TO myapp_store_public.app_internal_secrets DO INSTEAD NOTHING;

CREATE RULE _update_rule AS ON UPDATE TO myapp_store_public.app_internal_secrets DO INSTEAD NOTHING;

CREATE RULE _delete_rule AS ON DELETE TO myapp_store_public.app_internal_secrets DO INSTEAD NOTHING;

COMMENT ON VIEW myapp_store_public.app_internal_secrets IS '@behavior -insert -update -delete';

GRANT SELECT ON myapp_store_public.app_internal_secrets TO authenticated;

CREATE FUNCTION myapp_store_private.app_internal_secrets_hash() RETURNS trigger AS $EOFCODE$
BEGIN
  IF NEW.algo = 'crypt' THEN
    SELECT public.crypt(NEW.value::text, public.gen_salt('bf')) INTO NEW.value;
  ELSE
    IF NEW.algo = 'pgp' THEN
      SELECT public.pgp_sym_encrypt(pg_catalog.encode(NEW.value::bytea, 'hex'), NEW.key_id::text, 'compress-algo=1, cipher-algo=aes256') INTO NEW.value;
    ELSE
      SELECT 'none' INTO NEW.algo;
    END IF;
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE;

CREATE TRIGGER app_internal_secrets_update_tg
  BEFORE UPDATE
  ON myapp_store_private.app_internal_secrets
  FOR EACH ROW
  WHEN (old.value IS DISTINCT FROM new.value)
  EXECUTE PROCEDURE myapp_store_private.app_internal_secrets_hash();

CREATE TRIGGER app_internal_secrets_insert_tg
  BEFORE INSERT
  ON myapp_store_private.app_internal_secrets
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_store_private.app_internal_secrets_hash();

CREATE FUNCTION myapp_store_private.app_internal_secrets_get(
  IN secret_name text,
  IN namespace_id uuid,
  IN default_value text DEFAULT NULL
) RETURNS text AS $EOFCODE$
DECLARE
  v_secret myapp_store_private.app_internal_secrets;
BEGIN
  SELECT *
  FROM myapp_store_private.app_internal_secrets AS s
  WHERE
    (s.namespace_id = app_internal_secrets_get.namespace_id AND s.name = app_internal_secrets_get.secret_name) AND s.retired_at IS NULL INTO v_secret;
  IF NOT (FOUND) OR v_secret IS NULL THEN
    RETURN app_internal_secrets_get.default_value;
  END IF;
  IF v_secret.algo = 'crypt' THEN
    RETURN pg_catalog.convert_from(v_secret.value, 'SQL_ASCII');
  ELSIF v_secret.algo = 'pgp' THEN
    RETURN pg_catalog.convert_from(pg_catalog.decode(public.pgp_sym_decrypt(v_secret.value, v_secret.key_id::text), 'hex'), 'SQL_ASCII');
  END IF;
  RETURN pg_catalog.convert_from(v_secret.value, 'SQL_ASCII');
END;
$EOFCODE$ LANGUAGE plpgsql STABLE;

CREATE FUNCTION myapp_store_private.app_internal_secrets_verify(
  IN secret_name text,
  IN value text,
  IN namespace_id uuid
) RETURNS boolean AS $EOFCODE$
DECLARE
  v_secret_text text;
  v_secret myapp_store_private.app_internal_secrets;
BEGIN
  SELECT myapp_store_private.app_internal_secrets_get(app_internal_secrets_verify.secret_name, NULL::text, app_internal_secrets_verify.namespace_id) INTO v_secret_text;
  SELECT *
  FROM myapp_store_private.app_internal_secrets AS s
  WHERE
    (s.namespace_id = app_internal_secrets_verify.namespace_id AND s.name = app_internal_secrets_verify.secret_name) AND s.retired_at IS NULL INTO v_secret;
  IF v_secret.algo = 'crypt' THEN
    RETURN v_secret_text = public.crypt(app_internal_secrets_verify.value::bytea::text, v_secret_text);
  ELSIF v_secret.algo = 'pgp' THEN
    RETURN app_internal_secrets_verify.value = v_secret_text;
  END IF;
  RETURN app_internal_secrets_verify.value = v_secret_text;
END;
$EOFCODE$ LANGUAGE plpgsql STABLE;

CREATE FUNCTION myapp_store_public.app_internal_secrets_set(
  IN secret_name text,
  IN secret_value text,
  IN secret_namespace_id uuid,
  IN algo text DEFAULT 'pgp'
) RETURNS boolean AS $EOFCODE$
BEGIN
  INSERT INTO myapp_store_private.app_internal_secrets (
    namespace_id,
    name,
    value,
    algo
  )
  VALUES
    (app_internal_secrets_set.secret_namespace_id, app_internal_secrets_set.secret_name, app_internal_secrets_set.secret_value::bytea, app_internal_secrets_set.algo)
  ON CONFLICT (namespace_id, name) WHERE retired_at IS NULL DO UPDATE SET
  value = app_internal_secrets_set.secret_value::bytea, algo = EXCLUDED.algo;
  RETURN true;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE;

GRANT EXECUTE ON FUNCTION myapp_store_public.app_internal_secrets_set TO authenticated;

CREATE FUNCTION myapp_store_public.app_internal_secrets_del(
  IN secret_name text,
  IN namespace_id uuid
) RETURNS void AS $EOFCODE$
BEGIN
  DELETE FROM myapp_store_private.app_internal_secrets AS s
  WHERE
    (s.namespace_id = app_internal_secrets_del.namespace_id AND s.name = app_internal_secrets_del.secret_name) AND s.retired_at IS NULL;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE;

GRANT EXECUTE ON FUNCTION myapp_store_public.app_internal_secrets_del TO authenticated;

CREATE FUNCTION myapp_store_public.app_internal_secrets_remove_array(
  IN secret_names text[],
  IN namespace_id uuid
) RETURNS void AS $EOFCODE$
BEGIN
  DELETE FROM myapp_store_private.app_internal_secrets AS s
  WHERE
    (s.namespace_id = app_internal_secrets_remove_array.namespace_id AND s.name = ANY( app_internal_secrets_remove_array.secret_names )) AND s.retired_at IS NULL;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE;

GRANT EXECUTE ON FUNCTION myapp_store_public.app_internal_secrets_remove_array TO authenticated;

CREATE FUNCTION myapp_store_public.app_internal_secrets_rotate(
  IN secret_name text,
  IN secret_value text,
  IN namespace_id uuid,
  IN algo text DEFAULT 'pgp'
) RETURNS boolean AS $EOFCODE$
BEGIN
  UPDATE myapp_store_private.app_internal_secrets AS s SET
  retired_at = pg_catalog.now()
  WHERE
    (s.namespace_id = app_internal_secrets_rotate.namespace_id AND s.name = app_internal_secrets_rotate.secret_name) AND s.retired_at IS NULL;
  INSERT INTO myapp_store_private.app_internal_secrets (
    namespace_id,
    name,
    value,
    algo,
    rotated_at
  )
  VALUES
    (app_internal_secrets_rotate.namespace_id, app_internal_secrets_rotate.secret_name, app_internal_secrets_rotate.secret_value::bytea, app_internal_secrets_rotate.algo, pg_catalog.now());
  RETURN true;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE;

GRANT EXECUTE ON FUNCTION myapp_store_public.app_internal_secrets_rotate TO authenticated;

CREATE SCHEMA myapp_auth_public;

GRANT USAGE ON SCHEMA myapp_auth_public TO administrator;

GRANT USAGE ON SCHEMA myapp_auth_public TO authenticated;

GRANT USAGE ON SCHEMA myapp_auth_public TO anonymous;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_auth_public
  GRANT ALL ON TABLES TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_auth_public
  GRANT USAGE ON SEQUENCES TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_auth_public
  GRANT ALL ON FUNCTIONS TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_auth_public
  GRANT ALL ON FUNCTIONS TO authenticated;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_auth_public
  GRANT USAGE ON SEQUENCES TO authenticated;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_auth_public
  GRANT ALL ON FUNCTIONS TO anonymous;

CREATE FUNCTION myapp_auth_private.authenticate(
  IN token_str text
) RETURNS TABLE (
  id uuid,
  user_id uuid,
  session_id uuid,
  access_level text,
  kind text,
  principal_id uuid
) AS $EOFCODE$
DECLARE
  v_cred_id uuid;
BEGIN
  SELECT cred.id
  FROM myapp_auth_private.session_credentials AS cred INNER JOIN myapp_auth_private.sessions AS sess ON sess.id = cred.session_id
  WHERE
    (((cred.secret_hash = digest(authenticate.token_str, 'sha256') AND EXTRACT(EPOCH FROM cred.expires_at - now()) > 0) AND cred.revoked_at IS NULL) AND sess.revoked_at IS NULL) AND EXTRACT(EPOCH FROM sess.expires_at - now()) > 0 INTO v_cred_id;
  IF v_cred_id IS NOT NULL THEN
    UPDATE myapp_auth_private.session_credentials AS cred SET
    last_used_at = now()
    WHERE
      cred.id = v_cred_id;
  END IF;
  RETURN QUERY SELECT
    cred.id,
    sess.user_id,
    cred.session_id,
    cred.access_level,
    cred.kind,
    cred.principal_id
  FROM myapp_auth_private.session_credentials AS cred INNER JOIN myapp_auth_private.sessions AS sess ON sess.id = cred.session_id
  WHERE
    (((cred.secret_hash = digest(authenticate.token_str, 'sha256') AND EXTRACT(EPOCH FROM cred.expires_at - now()) > 0) AND cred.revoked_at IS NULL) AND sess.revoked_at IS NULL) AND EXTRACT(EPOCH FROM sess.expires_at - now()) > 0;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

GRANT EXECUTE ON FUNCTION myapp_auth_private.authenticate TO anonymous;

GRANT EXECUTE ON FUNCTION myapp_auth_private.authenticate TO authenticated;

CREATE FUNCTION myapp_auth_private.authenticate_strict(
  IN token_str text
) RETURNS TABLE (
  id uuid,
  user_id uuid,
  session_id uuid,
  access_level text,
  kind text,
  principal_id uuid
) AS $EOFCODE$
DECLARE
  v_cred_id uuid;
BEGIN
  SELECT cred.id
  FROM myapp_auth_private.session_credentials AS cred INNER JOIN myapp_auth_private.sessions AS sess ON sess.id = cred.session_id
  WHERE
    (((((cred.secret_hash = digest(authenticate_strict.token_str, 'sha256') AND EXTRACT(EPOCH FROM cred.expires_at - now()) > 0) AND cred.revoked_at IS NULL) AND sess.revoked_at IS NULL) AND EXTRACT(EPOCH FROM sess.expires_at - now()) > 0) AND CASE 
        WHEN sess.uagent IS NULL THEN jwt_public.current_user_agent() IS NULL 
        ELSE sess.uagent = jwt_public.current_user_agent() 
      END) AND CASE 
        WHEN sess.origin IS NULL THEN jwt_public.current_origin() IS NULL 
        ELSE sess.origin = jwt_public.current_origin() 
      END INTO v_cred_id;
  IF v_cred_id IS NOT NULL THEN
    UPDATE myapp_auth_private.session_credentials AS cred SET
    last_used_at = now()
    WHERE
      cred.id = v_cred_id;
  END IF;
  RETURN QUERY SELECT
    cred.id,
    sess.user_id,
    cred.session_id,
    cred.access_level,
    cred.kind,
    cred.principal_id
  FROM myapp_auth_private.session_credentials AS cred INNER JOIN myapp_auth_private.sessions AS sess ON sess.id = cred.session_id
  WHERE
    (((((cred.secret_hash = digest(authenticate_strict.token_str, 'sha256') AND EXTRACT(EPOCH FROM cred.expires_at - now()) > 0) AND cred.revoked_at IS NULL) AND sess.revoked_at IS NULL) AND EXTRACT(EPOCH FROM sess.expires_at - now()) > 0) AND CASE 
        WHEN sess.uagent IS NULL THEN jwt_public.current_user_agent() IS NULL 
        ELSE sess.uagent = jwt_public.current_user_agent() 
      END) AND CASE 
        WHEN sess.origin IS NULL THEN jwt_public.current_origin() IS NULL 
        ELSE sess.origin = jwt_public.current_origin() 
      END;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

GRANT EXECUTE ON FUNCTION myapp_auth_private.authenticate_strict TO anonymous;

GRANT EXECUTE ON FUNCTION myapp_auth_private.authenticate_strict TO authenticated;

CREATE FUNCTION myapp_auth_public.current_user_agent() RETURNS text AS $EOFCODE$
BEGIN
  RETURN jwt_public.user_agent();
EXCEPTION
  WHEN OTHERS THEN
    RETURN NULL;
END;
$EOFCODE$ LANGUAGE plpgsql STABLE;

CREATE FUNCTION myapp_auth_public.current_ip_address() RETURNS inet AS $EOFCODE$
BEGIN
  RETURN jwt_public.current_ip_address();
EXCEPTION
  WHEN OTHERS THEN
    RETURN NULL;
END;
$EOFCODE$ LANGUAGE plpgsql STABLE;

CREATE FUNCTION myapp_auth_public.current_user_id() RETURNS uuid AS $EOFCODE$
BEGIN
  RETURN jwt_public.current_user_id();
EXCEPTION
  WHEN OTHERS THEN
    RETURN NULL;
END;
$EOFCODE$ LANGUAGE plpgsql STABLE;

GRANT EXECUTE ON FUNCTION myapp_auth_public.current_user_id TO authenticated;

CREATE FUNCTION myapp_auth_public.current_user() RETURNS myapp_users_public.users AS $EOFCODE$
DECLARE
  v_user myapp_users_public.users;
BEGIN
  IF myapp_auth_public.current_user_id() IS NOT NULL THEN
    SELECT *
    FROM ONLY myapp_users_public.users
    WHERE
      id = myapp_auth_public.current_user_id() INTO v_user;
    RETURN v_user;
  ELSE
    RETURN NULL;
  END IF;
END;
$EOFCODE$ LANGUAGE plpgsql STABLE;

CREATE SCHEMA myapp_user_identifiers_public;

GRANT USAGE ON SCHEMA myapp_user_identifiers_public TO administrator;

GRANT USAGE ON SCHEMA myapp_user_identifiers_public TO authenticated;

GRANT USAGE ON SCHEMA myapp_user_identifiers_public TO anonymous;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_user_identifiers_public
  GRANT ALL ON TABLES TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_user_identifiers_public
  GRANT USAGE ON SEQUENCES TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_user_identifiers_public
  GRANT ALL ON FUNCTIONS TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_user_identifiers_public
  GRANT ALL ON FUNCTIONS TO authenticated;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_user_identifiers_public
  GRANT USAGE ON SEQUENCES TO authenticated;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_user_identifiers_public
  GRANT ALL ON FUNCTIONS TO anonymous;

CREATE SCHEMA myapp_user_identifiers_private;

GRANT USAGE ON SCHEMA myapp_user_identifiers_private TO administrator;

GRANT USAGE ON SCHEMA myapp_user_identifiers_private TO authenticated;

GRANT USAGE ON SCHEMA myapp_user_identifiers_private TO anonymous;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_user_identifiers_private
  GRANT ALL ON TABLES TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_user_identifiers_private
  GRANT USAGE ON SEQUENCES TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_user_identifiers_private
  GRANT ALL ON FUNCTIONS TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_user_identifiers_private
  GRANT ALL ON FUNCTIONS TO authenticated;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_user_identifiers_private
  GRANT USAGE ON SEQUENCES TO authenticated;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_user_identifiers_private
  GRANT ALL ON FUNCTIONS TO anonymous;

CREATE TABLE myapp_user_identifiers_public.emails ();

ALTER TABLE myapp_user_identifiers_public.emails 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_user_identifiers_public.emails IS 'User email addresses with verification and primary-email management';

ALTER TABLE myapp_user_identifiers_public.emails 
  ADD COLUMN id uuid;

ALTER TABLE myapp_user_identifiers_public.emails 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_user_identifiers_public.emails 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_user_identifiers_public.emails 
  ADD CONSTRAINT emails_pkey PRIMARY KEY (id);

ALTER TABLE myapp_user_identifiers_public.emails 
  ADD COLUMN owner_id uuid;

ALTER TABLE myapp_user_identifiers_public.emails 
  ALTER COLUMN owner_id SET NOT NULL;

ALTER TABLE myapp_user_identifiers_public.emails 
  ALTER COLUMN owner_id SET DEFAULT jwt_public.current_user_id();

ALTER TABLE myapp_user_identifiers_public.emails 
  ADD CONSTRAINT emails_owner_id_fkey
    FOREIGN KEY(owner_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE CASCADE;

CREATE INDEX emails_owner_id_idx ON myapp_user_identifiers_public.emails (owner_id);

ALTER TABLE myapp_user_identifiers_public.emails 
  ADD COLUMN email email;

ALTER TABLE myapp_user_identifiers_public.emails 
  ALTER COLUMN email SET NOT NULL;

COMMENT ON COLUMN myapp_user_identifiers_public.emails.email IS 'The email address';

ALTER TABLE myapp_user_identifiers_public.emails 
  ADD COLUMN is_verified boolean;

ALTER TABLE myapp_user_identifiers_public.emails 
  ALTER COLUMN is_verified SET NOT NULL;

ALTER TABLE myapp_user_identifiers_public.emails 
  ALTER COLUMN is_verified SET DEFAULT false;

COMMENT ON COLUMN myapp_user_identifiers_public.emails.is_verified IS 'Whether the email address has been verified via confirmation link';

ALTER TABLE myapp_user_identifiers_public.emails 
  ADD COLUMN is_primary boolean;

ALTER TABLE myapp_user_identifiers_public.emails 
  ALTER COLUMN is_primary SET NOT NULL;

ALTER TABLE myapp_user_identifiers_public.emails 
  ALTER COLUMN is_primary SET DEFAULT false;

COMMENT ON COLUMN myapp_user_identifiers_public.emails.is_primary IS 'Whether this is the user''s primary email address';

ALTER TABLE myapp_user_identifiers_public.emails 
  ADD COLUMN name text;

COMMENT ON COLUMN myapp_user_identifiers_public.emails.name IS 'Optional user-provided label for this email (e.g. "Work", "Personal").';

ALTER TABLE myapp_user_identifiers_public.emails 
  ADD CONSTRAINT emails_email_key 
    UNIQUE (email);

ALTER TABLE myapp_user_identifiers_public.emails 
  ADD COLUMN created_at timestamptz;

ALTER TABLE myapp_user_identifiers_public.emails 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE myapp_user_identifiers_public.emails 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE myapp_user_identifiers_public.emails 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE TRIGGER timestamps_tg
  BEFORE INSERT OR UPDATE
  ON myapp_user_identifiers_public.emails
  FOR EACH ROW
  EXECUTE PROCEDURE stamps.timestamps();

CREATE INDEX emails_created_at_idx ON myapp_user_identifiers_public.emails (created_at);

CREATE INDEX emails_updated_at_idx ON myapp_user_identifiers_public.emails (updated_at);

ALTER TABLE myapp_user_identifiers_public.emails 
  ENABLE ROW LEVEL SECURITY;

GRANT INSERT ( email, owner_id, is_primary, name ) ON myapp_user_identifiers_public.emails TO authenticated;

GRANT UPDATE ( is_primary, name ) ON myapp_user_identifiers_public.emails TO authenticated;

GRANT SELECT ON myapp_user_identifiers_public.emails TO authenticated;

GRANT DELETE ON myapp_user_identifiers_public.emails TO authenticated;

CREATE POLICY auth_sel_dir_own
  ON myapp_user_identifiers_public.emails
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    owner_id = jwt_public.current_principal_id()
  );

CREATE POLICY auth_ins_dir_own
  ON myapp_user_identifiers_public.emails
  AS PERMISSIVE
  FOR INSERT
  TO authenticated
  WITH CHECK (
    owner_id = jwt_public.current_principal_id()
  );

CREATE POLICY auth_upd_dir_own
  ON myapp_user_identifiers_public.emails
  AS PERMISSIVE
  FOR UPDATE
  TO authenticated
  USING (
    owner_id = jwt_public.current_principal_id()
  );

CREATE POLICY auth_del_dir_own
  ON myapp_user_identifiers_public.emails
  AS PERMISSIVE
  FOR DELETE
  TO authenticated
  USING (
    owner_id = jwt_public.current_principal_id()
  );

CREATE FUNCTION myapp_user_identifiers_private.emails_insert_tg() RETURNS trigger AS $EOFCODE$
DECLARE
  v_primary_field myapp_user_identifiers_public.emails;
  v_other_exists boolean;
BEGIN
  SELECT *
  FROM myapp_user_identifiers_public.emails AS e
  WHERE
    e.owner_id = NEW.owner_id AND is_primary IS TRUE INTO v_primary_field;
  IF NOT (FOUND) THEN
    new.is_primary := true;
  END IF;
  SELECT
    EXISTS (SELECT 1
    FROM myapp_user_identifiers_public.emails
    WHERE
      owner_id = NEW.owner_id
    LIMIT
    1) INTO v_other_exists;
  IF (NEW.is_primary IS TRUE AND NEW.is_verified IS FALSE) AND v_other_exists IS TRUE THEN
    RAISE EXCEPTION 'PRIMARY_REQUIRES_VERIFIED';
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE;

CREATE TRIGGER trigger_name
  BEFORE INSERT
  ON myapp_user_identifiers_public.emails
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_user_identifiers_private.emails_insert_tg();

CREATE FUNCTION myapp_user_identifiers_private.emails_insert_tg_ensure_primary() RETURNS trigger AS $EOFCODE$
BEGIN
  IF OLD.is_primary IS TRUE THEN
    IF NOT (EXISTS (SELECT 1
    FROM myapp_user_identifiers_public.emails
    WHERE
      owner_id = OLD.owner_id AND is_primary IS TRUE
    LIMIT
    1)) THEN
      UPDATE myapp_user_identifiers_public.emails SET
      is_primary = true
      WHERE
        ctid = ((SELECT ctid
        FROM myapp_user_identifiers_public.emails
        WHERE
            owner_id = OLD.owner_id AND is_verified IS TRUE
        LIMIT
        1));
    END IF;
  END IF;
  RETURN NULL;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE;

CREATE TRIGGER trigger_name_after_update
  AFTER UPDATE
  ON myapp_user_identifiers_public.emails
  FOR EACH ROW
  WHEN (old.is_primary IS DISTINCT FROM new.is_primary)
  EXECUTE PROCEDURE myapp_user_identifiers_private.emails_insert_tg_ensure_primary();

CREATE TRIGGER trigger_name_after_delete
  AFTER DELETE
  ON myapp_user_identifiers_public.emails
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_user_identifiers_private.emails_insert_tg_ensure_primary();

CREATE FUNCTION myapp_user_identifiers_private.emails_insert_tg_verified_guard() RETURNS trigger AS $EOFCODE$
BEGIN
  IF (OLD.is_primary IS FALSE AND NEW.is_primary IS TRUE) AND NEW.is_verified IS FALSE THEN
    RAISE EXCEPTION 'PRIMARY_REQUIRES_VERIFIED';
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE;

CREATE TRIGGER trigger_name_verified_guard
  BEFORE UPDATE
  ON myapp_user_identifiers_public.emails
  FOR EACH ROW
  WHEN (old.is_primary IS DISTINCT FROM new.is_primary)
  EXECUTE PROCEDURE myapp_user_identifiers_private.emails_insert_tg_verified_guard();

CREATE UNIQUE INDEX emails_is_primary_idx ON myapp_user_identifiers_public.emails (is_primary, owner_id) WHERE is_primary IS TRUE;

CREATE TRIGGER emails_immutable_tg
  BEFORE UPDATE
  ON myapp_user_identifiers_public.emails
  FOR EACH ROW
  WHEN (old.email IS DISTINCT FROM new.email
    AND old.email IS NOT NULL)
  EXECUTE PROCEDURE utils.throw('IMMUTABLE_PROPERTY', 'email');

CREATE TRIGGER emails_is_verified_monotonic_tg
  BEFORE UPDATE
  ON myapp_user_identifiers_public.emails
  FOR EACH ROW
  WHEN (old.is_verified IS TRUE
    AND new.is_verified IS FALSE)
  EXECUTE PROCEDURE utils.throw('MONOTONIC_FIELD', 'is_verified');

CREATE TABLE myapp_user_identifiers_public.phone_numbers ();

ALTER TABLE myapp_user_identifiers_public.phone_numbers 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_user_identifiers_public.phone_numbers IS 'User phone numbers with country code, verification, and primary-number management';

ALTER TABLE myapp_user_identifiers_public.phone_numbers 
  ADD COLUMN id uuid;

ALTER TABLE myapp_user_identifiers_public.phone_numbers 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_user_identifiers_public.phone_numbers 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_user_identifiers_public.phone_numbers 
  ADD CONSTRAINT phone_numbers_pkey PRIMARY KEY (id);

ALTER TABLE myapp_user_identifiers_public.phone_numbers 
  ADD COLUMN owner_id uuid;

ALTER TABLE myapp_user_identifiers_public.phone_numbers 
  ALTER COLUMN owner_id SET NOT NULL;

ALTER TABLE myapp_user_identifiers_public.phone_numbers 
  ALTER COLUMN owner_id SET DEFAULT jwt_public.current_user_id();

ALTER TABLE myapp_user_identifiers_public.phone_numbers 
  ADD CONSTRAINT phone_numbers_owner_id_fkey
    FOREIGN KEY(owner_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE CASCADE;

CREATE INDEX phone_numbers_owner_id_idx ON myapp_user_identifiers_public.phone_numbers (owner_id);

ALTER TABLE myapp_user_identifiers_public.phone_numbers 
  ADD COLUMN cc text;

ALTER TABLE myapp_user_identifiers_public.phone_numbers 
  ALTER COLUMN cc SET NOT NULL;

COMMENT ON COLUMN myapp_user_identifiers_public.phone_numbers.cc IS 'Country calling code (e.g. +1, +44)';

ALTER TABLE myapp_user_identifiers_public.phone_numbers 
  ADD COLUMN number text;

ALTER TABLE myapp_user_identifiers_public.phone_numbers 
  ALTER COLUMN number SET NOT NULL;

COMMENT ON COLUMN myapp_user_identifiers_public.phone_numbers.number IS 'The phone number without country code';

ALTER TABLE myapp_user_identifiers_public.phone_numbers 
  ADD COLUMN is_verified boolean;

ALTER TABLE myapp_user_identifiers_public.phone_numbers 
  ALTER COLUMN is_verified SET NOT NULL;

ALTER TABLE myapp_user_identifiers_public.phone_numbers 
  ALTER COLUMN is_verified SET DEFAULT false;

COMMENT ON COLUMN myapp_user_identifiers_public.phone_numbers.is_verified IS 'Whether the phone number has been verified via SMS code';

ALTER TABLE myapp_user_identifiers_public.phone_numbers 
  ADD COLUMN is_primary boolean;

ALTER TABLE myapp_user_identifiers_public.phone_numbers 
  ALTER COLUMN is_primary SET NOT NULL;

ALTER TABLE myapp_user_identifiers_public.phone_numbers 
  ALTER COLUMN is_primary SET DEFAULT false;

COMMENT ON COLUMN myapp_user_identifiers_public.phone_numbers.is_primary IS 'Whether this is the user''s primary phone number';

ALTER TABLE myapp_user_identifiers_public.phone_numbers 
  ADD COLUMN name text;

COMMENT ON COLUMN myapp_user_identifiers_public.phone_numbers.name IS 'Optional user-provided label for this phone number (e.g. "Mobile", "Work").';

ALTER TABLE myapp_user_identifiers_public.phone_numbers 
  ADD CONSTRAINT phone_numbers_number_key 
    UNIQUE (number);

ALTER TABLE myapp_user_identifiers_public.phone_numbers 
  ADD COLUMN created_at timestamptz;

ALTER TABLE myapp_user_identifiers_public.phone_numbers 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE myapp_user_identifiers_public.phone_numbers 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE myapp_user_identifiers_public.phone_numbers 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE TRIGGER timestamps_tg
  BEFORE INSERT OR UPDATE
  ON myapp_user_identifiers_public.phone_numbers
  FOR EACH ROW
  EXECUTE PROCEDURE stamps.timestamps();

CREATE INDEX phone_numbers_created_at_idx ON myapp_user_identifiers_public.phone_numbers (created_at);

CREATE INDEX phone_numbers_updated_at_idx ON myapp_user_identifiers_public.phone_numbers (updated_at);

ALTER TABLE myapp_user_identifiers_public.phone_numbers 
  ENABLE ROW LEVEL SECURITY;

GRANT INSERT ( cc, number, owner_id, is_primary, name ) ON myapp_user_identifiers_public.phone_numbers TO authenticated;

GRANT UPDATE ( is_primary, name ) ON myapp_user_identifiers_public.phone_numbers TO authenticated;

GRANT SELECT ON myapp_user_identifiers_public.phone_numbers TO authenticated;

GRANT DELETE ON myapp_user_identifiers_public.phone_numbers TO authenticated;

CREATE POLICY auth_sel_dir_own
  ON myapp_user_identifiers_public.phone_numbers
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    owner_id = jwt_public.current_principal_id()
  );

CREATE POLICY auth_ins_dir_own
  ON myapp_user_identifiers_public.phone_numbers
  AS PERMISSIVE
  FOR INSERT
  TO authenticated
  WITH CHECK (
    owner_id = jwt_public.current_principal_id()
  );

CREATE POLICY auth_upd_dir_own
  ON myapp_user_identifiers_public.phone_numbers
  AS PERMISSIVE
  FOR UPDATE
  TO authenticated
  USING (
    owner_id = jwt_public.current_principal_id()
  );

CREATE POLICY auth_del_dir_own
  ON myapp_user_identifiers_public.phone_numbers
  AS PERMISSIVE
  FOR DELETE
  TO authenticated
  USING (
    owner_id = jwt_public.current_principal_id()
  );

CREATE FUNCTION myapp_user_identifiers_private.phone_numbers_insert_tg() RETURNS trigger AS $EOFCODE$
DECLARE
  v_primary_field myapp_user_identifiers_public.phone_numbers;
  v_other_exists boolean;
BEGIN
  SELECT *
  FROM myapp_user_identifiers_public.phone_numbers AS e
  WHERE
    e.owner_id = NEW.owner_id AND is_primary IS TRUE INTO v_primary_field;
  IF NOT (FOUND) THEN
    new.is_primary := true;
  END IF;
  SELECT
    EXISTS (SELECT 1
    FROM myapp_user_identifiers_public.phone_numbers
    WHERE
      owner_id = NEW.owner_id
    LIMIT
    1) INTO v_other_exists;
  IF (NEW.is_primary IS TRUE AND NEW.is_verified IS FALSE) AND v_other_exists IS TRUE THEN
    RAISE EXCEPTION 'PRIMARY_REQUIRES_VERIFIED';
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE;

CREATE TRIGGER trigger_name
  BEFORE INSERT
  ON myapp_user_identifiers_public.phone_numbers
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_user_identifiers_private.phone_numbers_insert_tg();

CREATE FUNCTION myapp_user_identifiers_private.phone_numbers_insert_tg_ensure_primary() RETURNS trigger AS $EOFCODE$
BEGIN
  IF OLD.is_primary IS TRUE THEN
    IF NOT (EXISTS (SELECT 1
    FROM myapp_user_identifiers_public.phone_numbers
    WHERE
      owner_id = OLD.owner_id AND is_primary IS TRUE
    LIMIT
    1)) THEN
      UPDATE myapp_user_identifiers_public.phone_numbers SET
      is_primary = true
      WHERE
        ctid = ((SELECT ctid
        FROM myapp_user_identifiers_public.phone_numbers
        WHERE
            owner_id = OLD.owner_id AND is_verified IS TRUE
        LIMIT
        1));
    END IF;
  END IF;
  RETURN NULL;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE;

CREATE TRIGGER trigger_name_after_update
  AFTER UPDATE
  ON myapp_user_identifiers_public.phone_numbers
  FOR EACH ROW
  WHEN (old.is_primary IS DISTINCT FROM new.is_primary)
  EXECUTE PROCEDURE myapp_user_identifiers_private.phone_numbers_insert_tg_ensure_primary();

CREATE TRIGGER trigger_name_after_delete
  AFTER DELETE
  ON myapp_user_identifiers_public.phone_numbers
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_user_identifiers_private.phone_numbers_insert_tg_ensure_primary();

CREATE FUNCTION myapp_user_identifiers_private.phone_numbers_insert_tg_verified_guard() RETURNS trigger AS $EOFCODE$
BEGIN
  IF (OLD.is_primary IS FALSE AND NEW.is_primary IS TRUE) AND NEW.is_verified IS FALSE THEN
    RAISE EXCEPTION 'PRIMARY_REQUIRES_VERIFIED';
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE;

CREATE TRIGGER trigger_name_verified_guard
  BEFORE UPDATE
  ON myapp_user_identifiers_public.phone_numbers
  FOR EACH ROW
  WHEN (old.is_primary IS DISTINCT FROM new.is_primary)
  EXECUTE PROCEDURE myapp_user_identifiers_private.phone_numbers_insert_tg_verified_guard();

CREATE UNIQUE INDEX phone_numbers_is_primary_idx ON myapp_user_identifiers_public.phone_numbers (is_primary, owner_id) WHERE is_primary IS TRUE;

CREATE TRIGGER phone_numbers_immutable_number_tg
  BEFORE UPDATE
  ON myapp_user_identifiers_public.phone_numbers
  FOR EACH ROW
  WHEN (old.number IS DISTINCT FROM new.number
    AND old.number IS NOT NULL)
  EXECUTE PROCEDURE utils.throw('IMMUTABLE_PROPERTY', 'number');

CREATE TRIGGER phone_numbers_immutable_cc_tg
  BEFORE UPDATE
  ON myapp_user_identifiers_public.phone_numbers
  FOR EACH ROW
  WHEN (old.cc IS DISTINCT FROM new.cc
    AND old.cc IS NOT NULL)
  EXECUTE PROCEDURE utils.throw('IMMUTABLE_PROPERTY', 'cc');

CREATE TRIGGER phone_numbers_is_verified_monotonic_tg
  BEFORE UPDATE
  ON myapp_user_identifiers_public.phone_numbers
  FOR EACH ROW
  WHEN (old.is_verified IS TRUE
    AND new.is_verified IS FALSE)
  EXECUTE PROCEDURE utils.throw('MONOTONIC_FIELD', 'is_verified');

CREATE TABLE myapp_user_identifiers_public.webauthn_credentials ();

ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_user_identifiers_public.webauthn_credentials IS 'WebAuthn/passkey credentials owned by users. One row per registered authenticator (security key, device biometric, synced passkey). Schema mirrors SimpleWebAuthn''s canonical Passkey object.';

ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  ADD COLUMN id uuid;

ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  ADD CONSTRAINT webauthn_credentials_pkey PRIMARY KEY (id);

ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  ADD COLUMN owner_id uuid;

ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  ALTER COLUMN owner_id SET NOT NULL;

ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  ALTER COLUMN owner_id SET DEFAULT jwt_public.current_user_id();

ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  ADD CONSTRAINT webauthn_credentials_owner_id_fkey
    FOREIGN KEY(owner_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE CASCADE;

CREATE INDEX webauthn_credentials_owner_id_idx ON myapp_user_identifiers_public.webauthn_credentials (owner_id);

ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  ADD COLUMN credential_id text;

ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  ALTER COLUMN credential_id SET NOT NULL;

COMMENT ON COLUMN myapp_user_identifiers_public.webauthn_credentials.credential_id IS 'Base64url-encoded credential ID returned by the authenticator. Globally unique per WebAuthn spec.';

ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  ADD COLUMN public_key bytea;

ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  ALTER COLUMN public_key SET NOT NULL;

COMMENT ON COLUMN myapp_user_identifiers_public.webauthn_credentials.public_key IS 'COSE-encoded public key bytes from the authenticator attestation.';

ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  ADD COLUMN sign_count bigint;

ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  ALTER COLUMN sign_count SET NOT NULL;

ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  ALTER COLUMN sign_count SET DEFAULT 0;

COMMENT ON COLUMN myapp_user_identifiers_public.webauthn_credentials.sign_count IS 'Monotonic signature counter. Strict-increase check during sign-in detects cloned credentials. 0 means the authenticator does not implement a counter.';

ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  ADD COLUMN webauthn_user_id text;

ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  ALTER COLUMN webauthn_user_id SET NOT NULL;

COMMENT ON COLUMN myapp_user_identifiers_public.webauthn_credentials.webauthn_user_id IS 'Random per-user handle sent to authenticators as user.id. Privacy-preserving; NOT the internal user UUID.';

ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  ADD COLUMN transports text[];

COMMENT ON COLUMN myapp_user_identifiers_public.webauthn_credentials.transports IS 'Authenticator transport hints (e.g. usb, nfc, ble, internal, hybrid). Used to hint browser UI during sign-in.';

ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  ADD COLUMN credential_device_type text;

ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  ALTER COLUMN credential_device_type SET NOT NULL;

COMMENT ON COLUMN myapp_user_identifiers_public.webauthn_credentials.credential_device_type IS 'Either ''singleDevice'' (hardware-bound) or ''multiDevice'' (synced passkey). Enforced by CHECK constraint below.';

ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  ADD COLUMN backup_eligible boolean;

ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  ALTER COLUMN backup_eligible SET NOT NULL;

ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  ALTER COLUMN backup_eligible SET DEFAULT false;

COMMENT ON COLUMN myapp_user_identifiers_public.webauthn_credentials.backup_eligible IS 'Whether this credential is eligible for backup (syncing) per the authenticator''s flags at registration.';

ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  ADD COLUMN backup_state boolean;

ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  ALTER COLUMN backup_state SET NOT NULL;

ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  ALTER COLUMN backup_state SET DEFAULT false;

COMMENT ON COLUMN myapp_user_identifiers_public.webauthn_credentials.backup_state IS 'Current backup state; updated on each successful sign-in assertion.';

ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  ADD COLUMN name text;

COMMENT ON COLUMN myapp_user_identifiers_public.webauthn_credentials.name IS 'User-provided label for this credential (e.g. "YubiKey 5C", "iPhone 15"). Renamed via rename_passkey.';

ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  ADD COLUMN last_used_at timestamptz;

COMMENT ON COLUMN myapp_user_identifiers_public.webauthn_credentials.last_used_at IS 'Timestamp of the most recent successful sign-in assertion using this credential.';

ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  ADD COLUMN created_at timestamptz;

ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE TRIGGER timestamps_tg
  BEFORE INSERT OR UPDATE
  ON myapp_user_identifiers_public.webauthn_credentials
  FOR EACH ROW
  EXECUTE PROCEDURE stamps.timestamps();

CREATE INDEX webauthn_credentials_created_at_idx ON myapp_user_identifiers_public.webauthn_credentials (created_at);

CREATE INDEX webauthn_credentials_updated_at_idx ON myapp_user_identifiers_public.webauthn_credentials (updated_at);

ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  ADD CONSTRAINT webauthn_credentials_credential_id_key 
    UNIQUE (credential_id);

ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  ADD CONSTRAINT webauthn_credentials_webauthn_user_id_owner_id_key 
    UNIQUE (webauthn_user_id, owner_id);

ALTER TABLE myapp_user_identifiers_public.webauthn_credentials 
  ENABLE ROW LEVEL SECURITY;

GRANT SELECT ON myapp_user_identifiers_public.webauthn_credentials TO authenticated;

GRANT DELETE ON myapp_user_identifiers_public.webauthn_credentials TO authenticated;

GRANT UPDATE ( name ) ON myapp_user_identifiers_public.webauthn_credentials TO authenticated;

CREATE POLICY auth_sel_dir_own
  ON myapp_user_identifiers_public.webauthn_credentials
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    owner_id = jwt_public.current_principal_id()
  );

CREATE POLICY auth_upd_dir_own
  ON myapp_user_identifiers_public.webauthn_credentials
  AS PERMISSIVE
  FOR UPDATE
  TO authenticated
  USING (
    owner_id = jwt_public.current_principal_id()
  );

CREATE POLICY auth_del_dir_own
  ON myapp_user_identifiers_public.webauthn_credentials
  AS PERMISSIVE
  FOR DELETE
  TO authenticated
  USING (
    owner_id = jwt_public.current_principal_id()
  );

CREATE TABLE myapp_user_identifiers_private.connected_accounts ();

ALTER TABLE myapp_user_identifiers_private.connected_accounts 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_user_identifiers_private.connected_accounts IS 'OAuth and social login connections linking external service accounts to users';

ALTER TABLE myapp_user_identifiers_private.connected_accounts 
  ADD COLUMN id uuid;

ALTER TABLE myapp_user_identifiers_private.connected_accounts 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_user_identifiers_private.connected_accounts 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_user_identifiers_private.connected_accounts 
  ADD CONSTRAINT connected_accounts_pkey PRIMARY KEY (id);

ALTER TABLE myapp_user_identifiers_private.connected_accounts 
  ADD COLUMN owner_id uuid;

ALTER TABLE myapp_user_identifiers_private.connected_accounts 
  ALTER COLUMN owner_id SET NOT NULL;

ALTER TABLE myapp_user_identifiers_private.connected_accounts 
  ALTER COLUMN owner_id SET DEFAULT jwt_public.current_user_id();

ALTER TABLE myapp_user_identifiers_private.connected_accounts 
  ADD CONSTRAINT connected_accounts_owner_id_fkey
    FOREIGN KEY(owner_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE CASCADE;

CREATE INDEX connected_accounts_owner_id_idx ON myapp_user_identifiers_private.connected_accounts (owner_id);

ALTER TABLE myapp_user_identifiers_private.connected_accounts 
  ADD COLUMN service text;

ALTER TABLE myapp_user_identifiers_private.connected_accounts 
  ALTER COLUMN service SET NOT NULL;

COMMENT ON COLUMN myapp_user_identifiers_private.connected_accounts.service IS 'The service used, e.g. `twitter` or `github`.';

ALTER TABLE myapp_user_identifiers_private.connected_accounts 
  ADD COLUMN identifier text;

ALTER TABLE myapp_user_identifiers_private.connected_accounts 
  ALTER COLUMN identifier SET NOT NULL;

COMMENT ON COLUMN myapp_user_identifiers_private.connected_accounts.identifier IS 'A unique identifier for the user within the service';

ALTER TABLE myapp_user_identifiers_private.connected_accounts 
  ADD COLUMN details jsonb;

ALTER TABLE myapp_user_identifiers_private.connected_accounts 
  ALTER COLUMN details SET NOT NULL;

COMMENT ON COLUMN myapp_user_identifiers_private.connected_accounts.details IS 'Additional profile details extracted from this login method';

ALTER TABLE myapp_user_identifiers_private.connected_accounts 
  ADD COLUMN is_verified boolean;

ALTER TABLE myapp_user_identifiers_private.connected_accounts 
  ALTER COLUMN is_verified SET NOT NULL;

ALTER TABLE myapp_user_identifiers_private.connected_accounts 
  ALTER COLUMN is_verified SET DEFAULT false;

COMMENT ON COLUMN myapp_user_identifiers_private.connected_accounts.is_verified IS 'Whether this connected account has been verified';

ALTER TABLE myapp_user_identifiers_private.connected_accounts 
  ADD CONSTRAINT connected_accounts_service_identifier_key 
    UNIQUE (service, identifier);

ALTER TABLE myapp_user_identifiers_private.connected_accounts 
  ADD COLUMN created_at timestamptz;

ALTER TABLE myapp_user_identifiers_private.connected_accounts 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE myapp_user_identifiers_private.connected_accounts 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE myapp_user_identifiers_private.connected_accounts 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE TRIGGER timestamps_tg
  BEFORE INSERT OR UPDATE
  ON myapp_user_identifiers_private.connected_accounts
  FOR EACH ROW
  EXECUTE PROCEDURE stamps.timestamps();

CREATE INDEX connected_accounts_created_at_idx ON myapp_user_identifiers_private.connected_accounts (created_at);

CREATE INDEX connected_accounts_updated_at_idx ON myapp_user_identifiers_private.connected_accounts (updated_at);

ALTER TABLE myapp_user_identifiers_private.connected_accounts 
  ENABLE ROW LEVEL SECURITY;

GRANT SELECT ON myapp_user_identifiers_private.connected_accounts TO authenticated;

CREATE POLICY auth_sel_dir_own
  ON myapp_user_identifiers_private.connected_accounts
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    owner_id = jwt_public.current_principal_id()
  );

CREATE POLICY auth_ins_dir_own
  ON myapp_user_identifiers_private.connected_accounts
  AS PERMISSIVE
  FOR INSERT
  TO authenticated
  WITH CHECK (
    owner_id = jwt_public.current_principal_id()
  );

CREATE POLICY auth_upd_dir_own
  ON myapp_user_identifiers_private.connected_accounts
  AS PERMISSIVE
  FOR UPDATE
  TO authenticated
  USING (
    owner_id = jwt_public.current_principal_id()
  );

CREATE POLICY auth_del_dir_own
  ON myapp_user_identifiers_private.connected_accounts
  AS PERMISSIVE
  FOR DELETE
  TO authenticated
  USING (
    owner_id = jwt_public.current_principal_id()
  );

CREATE VIEW myapp_user_identifiers_public.user_connected_accounts WITH (security_invoker = 'true') AS SELECT
  id,
  owner_id,
  service,
  identifier,
  details,
  is_verified,
  created_at,
  updated_at
FROM myapp_user_identifiers_private.connected_accounts
WHERE
  owner_id = jwt_public.current_principal_id();

CREATE RULE _insert_rule AS ON INSERT TO myapp_user_identifiers_public.user_connected_accounts DO INSTEAD NOTHING;

CREATE RULE _update_rule AS ON UPDATE TO myapp_user_identifiers_public.user_connected_accounts DO INSTEAD NOTHING;

CREATE RULE _delete_rule AS ON DELETE TO myapp_user_identifiers_public.user_connected_accounts DO INSTEAD NOTHING;

COMMENT ON VIEW myapp_user_identifiers_public.user_connected_accounts IS '@behavior -insert -update -delete';

GRANT SELECT ON myapp_user_identifiers_public.user_connected_accounts TO authenticated;

CREATE TABLE myapp_auth_private.identity_providers ();

ALTER TABLE myapp_auth_private.identity_providers 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_auth_private.identity_providers IS 'OAuth2 / OIDC (and future SAML) identity provider definitions per database. Holds endpoint URLs, encrypted client secret reference, scopes, audience validation list, PKCE setting, and email-handling flags. Cached OIDC discovery_doc + JWKS are refreshed by background jobs. All writes go through SECURITY DEFINER admin procedures.';

ALTER TABLE myapp_auth_private.identity_providers 
  ADD COLUMN id uuid;

ALTER TABLE myapp_auth_private.identity_providers 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_auth_private.identity_providers 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_auth_private.identity_providers 
  ADD CONSTRAINT identity_providers_pkey PRIMARY KEY (id);

ALTER TABLE myapp_auth_private.identity_providers 
  ADD COLUMN slug text;

ALTER TABLE myapp_auth_private.identity_providers 
  ALTER COLUMN slug SET NOT NULL;

COMMENT ON COLUMN myapp_auth_private.identity_providers.slug IS 'Stable identifier (e.g. ''google'', ''github'', ''custom:acme-okta''). Used as connected_accounts.service value. Custom providers must use the custom:<slug> namespace; format ^[a-z0-9][a-z0-9_-]{0,30}[a-z0-9]$ enforced by admin procedure.';

ALTER TABLE myapp_auth_private.identity_providers 
  ADD COLUMN kind text;

ALTER TABLE myapp_auth_private.identity_providers 
  ALTER COLUMN kind SET NOT NULL;

COMMENT ON COLUMN myapp_auth_private.identity_providers.kind IS 'Protocol family: ''oauth2'' (manual endpoint configuration) or ''oidc'' (discovery + JWKS-verified id_token). Future kinds (''saml'') will use a different field set.';

ALTER TABLE myapp_auth_private.identity_providers 
  ADD COLUMN display_name text;

ALTER TABLE myapp_auth_private.identity_providers 
  ALTER COLUMN display_name SET NOT NULL;

COMMENT ON COLUMN myapp_auth_private.identity_providers.display_name IS 'Human-readable label for client UIs (e.g. ''Sign in with Google'', ''Acme Okta''). Exposed via the public-safe view.';

ALTER TABLE myapp_auth_private.identity_providers 
  ADD COLUMN enabled boolean;

ALTER TABLE myapp_auth_private.identity_providers 
  ALTER COLUMN enabled SET NOT NULL;

ALTER TABLE myapp_auth_private.identity_providers 
  ALTER COLUMN enabled SET DEFAULT true;

COMMENT ON COLUMN myapp_auth_private.identity_providers.enabled IS 'Whether sign-in via this provider is currently allowed. Toggled by enable_identity_provider / disable_identity_provider admin procedures. Disabled providers remain in the public-safe view as enabled=false so client UIs can grey out the button.';

ALTER TABLE myapp_auth_private.identity_providers 
  ADD COLUMN authorization_url text;

COMMENT ON COLUMN myapp_auth_private.identity_providers.authorization_url IS 'OAuth2 authorization endpoint (where the user is redirected to grant consent). Required when kind = ''oauth2''; for kind = ''oidc'' resolved from cached discovery_doc.';

ALTER TABLE myapp_auth_private.identity_providers 
  ADD COLUMN token_url text;

COMMENT ON COLUMN myapp_auth_private.identity_providers.token_url IS 'OAuth2 token endpoint (exchanges authorization code for access/id tokens). Required when kind = ''oauth2''; for kind = ''oidc'' resolved from cached discovery_doc.';

ALTER TABLE myapp_auth_private.identity_providers 
  ADD COLUMN userinfo_url text;

COMMENT ON COLUMN myapp_auth_private.identity_providers.userinfo_url IS 'OAuth2 userinfo endpoint (returns the user profile given an access token). Required when kind = ''oauth2''; for kind = ''oidc'' resolved from cached discovery_doc or used as a fallback when the id_token does not contain the desired claims.';

ALTER TABLE myapp_auth_private.identity_providers 
  ADD COLUMN issuer_url text;

COMMENT ON COLUMN myapp_auth_private.identity_providers.issuer_url IS 'OIDC issuer URL. Discovery fetches {issuer}/.well-known/openid-configuration unless discovery_url_override is set. Required when kind = ''oidc''. Used for id_token ''iss'' claim verification.';

ALTER TABLE myapp_auth_private.identity_providers 
  ADD COLUMN discovery_url_override text;

COMMENT ON COLUMN myapp_auth_private.identity_providers.discovery_url_override IS 'Optional non-standard discovery document URL. When NULL, discovery uses {issuer_url}/.well-known/openid-configuration. Used for IdPs that publish discovery at a non-spec path.';

ALTER TABLE myapp_auth_private.identity_providers 
  ADD COLUMN discovery_doc jsonb;

COMMENT ON COLUMN myapp_auth_private.identity_providers.discovery_doc IS 'Cached OIDC discovery document (authorization_endpoint, token_endpoint, userinfo_endpoint, jwks_uri, issuer, etc.). Refreshed by a background job; auth-server reads endpoints from here at request time when kind = ''oidc''.';

ALTER TABLE myapp_auth_private.identity_providers 
  ADD COLUMN jwks jsonb;

COMMENT ON COLUMN myapp_auth_private.identity_providers.jwks IS 'Cached JWKS document used to verify id_token signatures. Refreshed by a background job. NULL until first successful discovery + JWKS fetch.';

ALTER TABLE myapp_auth_private.identity_providers 
  ADD COLUMN jwks_fetched_at timestamptz;

COMMENT ON COLUMN myapp_auth_private.identity_providers.jwks_fetched_at IS 'Timestamp of the most recent successful JWKS fetch. Used by the background refresher to age out cache entries and to drive cold-start fetches when NULL.';

ALTER TABLE myapp_auth_private.identity_providers 
  ADD COLUMN client_id text;

COMMENT ON COLUMN myapp_auth_private.identity_providers.client_id IS 'OAuth2 / OIDC client_id registered with the IdP. NULL for built-in rows until an admin sets it. Providers with NULL client_id or NULL client_secret_id are treated as not-configured by the sign-in path regardless of the enabled flag.';

ALTER TABLE myapp_auth_private.identity_providers 
  ADD COLUMN client_secret_id uuid;

COMMENT ON COLUMN myapp_auth_private.identity_providers.client_secret_id IS 'Pointer to the row in user_secrets that holds the OAuth2 client_secret (encrypted at rest). NULL only briefly between create_identity_provider and the first rotate_provider_secret. Rotation writes a new user_secrets row and atomically updates this column; the raw secret is never returned to clients.';

ALTER TABLE myapp_auth_private.identity_providers 
  ADD COLUMN scopes text[];

ALTER TABLE myapp_auth_private.identity_providers 
  ALTER COLUMN scopes SET NOT NULL;

ALTER TABLE myapp_auth_private.identity_providers 
  ALTER COLUMN scopes SET DEFAULT CAST(ARRAY[] AS text[]);

COMMENT ON COLUMN myapp_auth_private.identity_providers.scopes IS 'OAuth2 scopes requested in the authorization URL. For kind = ''oidc'' the admin procedure ensures ''openid'' is always present (silently prepended if missing).';

ALTER TABLE myapp_auth_private.identity_providers 
  ADD COLUMN extra_authorization_params jsonb;

ALTER TABLE myapp_auth_private.identity_providers 
  ALTER COLUMN extra_authorization_params SET NOT NULL;

ALTER TABLE myapp_auth_private.identity_providers 
  ALTER COLUMN extra_authorization_params SET DEFAULT '{}'::jsonb;

COMMENT ON COLUMN myapp_auth_private.identity_providers.extra_authorization_params IS 'Extra query parameters merged into the authorization URL (e.g. {"prompt":"select_account"}). Admin procedure rejects reserved OAuth/OIDC keys: client_id, redirect_uri, state, nonce, code_challenge, code_challenge_method, response_type, scope.';

ALTER TABLE myapp_auth_private.identity_providers 
  ADD COLUMN acceptable_client_ids text[];

ALTER TABLE myapp_auth_private.identity_providers 
  ALTER COLUMN acceptable_client_ids SET NOT NULL;

ALTER TABLE myapp_auth_private.identity_providers 
  ALTER COLUMN acceptable_client_ids SET DEFAULT CAST(ARRAY[] AS text[]);

COMMENT ON COLUMN myapp_auth_private.identity_providers.acceptable_client_ids IS 'Multi-platform audience allow-list. When non-empty, id_token ''aud'' is validated against client_id OR any value here. Used when one IdP project issues tokens with platform-specific audiences (web vs iOS vs Android).';

ALTER TABLE myapp_auth_private.identity_providers 
  ADD COLUMN email_optional boolean;

ALTER TABLE myapp_auth_private.identity_providers 
  ALTER COLUMN email_optional SET NOT NULL;

ALTER TABLE myapp_auth_private.identity_providers 
  ALTER COLUMN email_optional SET DEFAULT false;

COMMENT ON COLUMN myapp_auth_private.identity_providers.email_optional IS 'When true, sign-in succeeds even if the IdP does not return a verified email. The user is provisioned without an email and can add one later. When false, missing email is a hard error.';

ALTER TABLE myapp_auth_private.identity_providers 
  ADD COLUMN allow_link_by_email boolean;

ALTER TABLE myapp_auth_private.identity_providers 
  ALTER COLUMN allow_link_by_email SET NOT NULL;

ALTER TABLE myapp_auth_private.identity_providers 
  ALTER COLUMN allow_link_by_email SET DEFAULT false;

COMMENT ON COLUMN myapp_auth_private.identity_providers.allow_link_by_email IS 'When true, an OAuth/OIDC sign-in whose IdP-verified email matches an existing user account auto-links the new identity to that account. When false, an existing-email collision raises IDENTITY_EMAIL_ALREADY_REGISTERED. Only honored when the IdP marks the email as verified.';

ALTER TABLE myapp_auth_private.identity_providers 
  ADD COLUMN skip_nonce_check boolean;

ALTER TABLE myapp_auth_private.identity_providers 
  ALTER COLUMN skip_nonce_check SET NOT NULL;

ALTER TABLE myapp_auth_private.identity_providers 
  ALTER COLUMN skip_nonce_check SET DEFAULT false;

COMMENT ON COLUMN myapp_auth_private.identity_providers.skip_nonce_check IS 'OIDC only. When true, the auth server does not require / verify the ''nonce'' claim in id_token. ONLY enable for IdPs that demonstrably do not support nonce; weakens replay resistance.';

ALTER TABLE myapp_auth_private.identity_providers 
  ADD COLUMN pkce_enabled boolean;

ALTER TABLE myapp_auth_private.identity_providers 
  ALTER COLUMN pkce_enabled SET NOT NULL;

ALTER TABLE myapp_auth_private.identity_providers 
  ALTER COLUMN pkce_enabled SET DEFAULT true;

COMMENT ON COLUMN myapp_auth_private.identity_providers.pkce_enabled IS 'When true, the auth server generates a PKCE code_verifier per authorization request, sends code_challenge with method = S256, and includes code_verifier in the token exchange. PKCE is handled entirely server-side. Default is true; only disable for IdPs that reject PKCE parameters.';

ALTER TABLE myapp_auth_private.identity_providers 
  ADD CONSTRAINT identity_providers_slug_key 
    UNIQUE (slug);

ALTER TABLE myapp_auth_private.identity_providers 
  ADD COLUMN created_at timestamptz;

ALTER TABLE myapp_auth_private.identity_providers 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE myapp_auth_private.identity_providers 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE myapp_auth_private.identity_providers 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE TRIGGER timestamps_tg
  BEFORE INSERT OR UPDATE
  ON myapp_auth_private.identity_providers
  FOR EACH ROW
  EXECUTE PROCEDURE stamps.timestamps();

CREATE INDEX identity_providers_created_at_idx ON myapp_auth_private.identity_providers (created_at);

CREATE INDEX identity_providers_updated_at_idx ON myapp_auth_private.identity_providers (updated_at);

ALTER TABLE myapp_auth_private.identity_providers 
  ENABLE ROW LEVEL SECURITY;

GRANT SELECT ( slug, kind, display_name, enabled ) ON myapp_auth_private.identity_providers TO authenticated;

GRANT INSERT ON myapp_auth_private.identity_providers TO authenticated;

GRANT UPDATE ON myapp_auth_private.identity_providers TO authenticated;

GRANT DELETE ON myapp_auth_private.identity_providers TO authenticated;

CREATE POLICY auth_sel_app_mem
  ON myapp_auth_private.identity_providers
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id())
  );

CREATE POLICY auth_ins_app_mem
  ON myapp_auth_private.identity_providers
  AS PERMISSIVE
  FOR INSERT
  TO authenticated
  WITH CHECK (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000000100000000') = '0000000000000000000000000000000000000000000000000000000100000000')
  );

CREATE POLICY auth_upd_app_mem
  ON myapp_auth_private.identity_providers
  AS PERMISSIVE
  FOR UPDATE
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000000100000000') = '0000000000000000000000000000000000000000000000000000000100000000')
  );

CREATE POLICY auth_del_app_mem
  ON myapp_auth_private.identity_providers
  AS PERMISSIVE
  FOR DELETE
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000000100000000') = '0000000000000000000000000000000000000000000000000000000100000000')
  );

CREATE TRIGGER identity_providers_quota_trg
  BEFORE INSERT
  ON myapp_auth_private.identity_providers
  FOR EACH ROW
  EXECUTE PROCEDURE utils.enforce_identity_providers_quota('myapp_auth_private', 'app_settings_auth');

CREATE VIEW myapp_auth_public.identity_providers WITH (security_invoker = 'true') AS SELECT
  slug,
  kind,
  display_name,
  enabled
FROM myapp_auth_private.identity_providers;

CREATE RULE _insert_rule AS ON INSERT TO myapp_auth_public.identity_providers DO INSTEAD NOTHING;

CREATE RULE _update_rule AS ON UPDATE TO myapp_auth_public.identity_providers DO INSTEAD NOTHING;

CREATE RULE _delete_rule AS ON DELETE TO myapp_auth_public.identity_providers DO INSTEAD NOTHING;

COMMENT ON VIEW myapp_auth_public.identity_providers IS '@behavior -insert -update -delete';

GRANT SELECT ON myapp_auth_public.identity_providers TO authenticated;

CREATE FUNCTION myapp_auth_private.rotate_identity_provider_app_secret(
  IN provider_id uuid,
  IN new_secret text
) RETURNS boolean AS $EOFCODE$
DECLARE
  v_secret_id uuid;
  v_slug text;
  v_namespace_id uuid;
BEGIN
  SELECT
    client_secret_id,
    slug
  FROM myapp_auth_private.identity_providers
  WHERE
    id = rotate_identity_provider_app_secret.provider_id INTO v_secret_id, v_slug;
  IF NOT (FOUND) THEN
    PERFORM errors.raise_error('IDENTITY_PROVIDER_NOT_FOUND', '{}', 'public');
  END IF;
  v_namespace_id := uuid_nil();
  IF v_secret_id IS NULL THEN
    INSERT INTO myapp_store_private.app_internal_secrets (
      namespace_id,
      name,
      value,
      algo
    )
    VALUES
      (v_namespace_id, v_slug || '/client-secret', rotate_identity_provider_app_secret.new_secret::bytea, 'pgp')
    RETURNING * INTO v_secret_id;
    UPDATE myapp_auth_private.identity_providers SET
    client_secret_id = v_secret_id
    WHERE
      id = rotate_identity_provider_app_secret.provider_id;
  ELSE
    UPDATE myapp_store_private.app_internal_secrets SET
    value = rotate_identity_provider_app_secret.new_secret::bytea, algo = 'pgp'
    WHERE
      id = v_secret_id;
  END IF;
  RETURN true;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE STRICT SECURITY DEFINER;

CREATE SCHEMA myapp_invites_public;

GRANT USAGE ON SCHEMA myapp_invites_public TO administrator;

GRANT USAGE ON SCHEMA myapp_invites_public TO authenticated;

GRANT USAGE ON SCHEMA myapp_invites_public TO anonymous;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_invites_public
  GRANT ALL ON TABLES TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_invites_public
  GRANT USAGE ON SEQUENCES TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_invites_public
  GRANT ALL ON FUNCTIONS TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_invites_public
  GRANT ALL ON FUNCTIONS TO authenticated;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_invites_public
  GRANT USAGE ON SEQUENCES TO authenticated;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_invites_public
  GRANT ALL ON FUNCTIONS TO anonymous;

CREATE SCHEMA myapp_invites_private;

GRANT USAGE ON SCHEMA myapp_invites_private TO administrator;

GRANT USAGE ON SCHEMA myapp_invites_private TO authenticated;

GRANT USAGE ON SCHEMA myapp_invites_private TO anonymous;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_invites_private
  GRANT ALL ON TABLES TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_invites_private
  GRANT USAGE ON SEQUENCES TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_invites_private
  GRANT ALL ON FUNCTIONS TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_invites_private
  GRANT ALL ON FUNCTIONS TO authenticated;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_invites_private
  GRANT USAGE ON SEQUENCES TO authenticated;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_invites_private
  GRANT ALL ON FUNCTIONS TO anonymous;

CREATE TABLE myapp_invites_public.app_invites ();

ALTER TABLE myapp_invites_public.app_invites 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_invites_public.app_invites IS 'Invitation records sent to prospective members via email, with token-based redemption and expiration';

ALTER TABLE myapp_invites_public.app_invites 
  ADD COLUMN id uuid;

ALTER TABLE myapp_invites_public.app_invites 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_invites_public.app_invites 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_invites_public.app_invites 
  ADD CONSTRAINT app_invites_pkey PRIMARY KEY (id);

ALTER TABLE myapp_invites_public.app_invites 
  ADD COLUMN channel text;

ALTER TABLE myapp_invites_public.app_invites 
  ALTER COLUMN channel SET NOT NULL;

ALTER TABLE myapp_invites_public.app_invites 
  ALTER COLUMN channel SET DEFAULT 'email';

COMMENT ON COLUMN myapp_invites_public.app_invites.channel IS 'Delivery channel for this invitation: email, sms, or link';

ALTER TABLE myapp_invites_public.app_invites 
  ADD COLUMN email email;

COMMENT ON COLUMN myapp_invites_public.app_invites.email IS 'Email address of the invited recipient (required when channel=email)';

ALTER TABLE myapp_invites_public.app_invites 
  ADD COLUMN phone text;

COMMENT ON COLUMN myapp_invites_public.app_invites.phone IS 'Phone number of the invited recipient in E.164 format (required when channel=sms)';

ALTER TABLE myapp_invites_public.app_invites 
  ADD COLUMN sender_id uuid;

ALTER TABLE myapp_invites_public.app_invites 
  ALTER COLUMN sender_id SET NOT NULL;

ALTER TABLE myapp_invites_public.app_invites 
  ALTER COLUMN sender_id SET DEFAULT jwt_public.current_user_id();

COMMENT ON COLUMN myapp_invites_public.app_invites.sender_id IS 'User ID of the member who sent this invitation';

ALTER TABLE myapp_invites_public.app_invites 
  ADD COLUMN invite_token text;

ALTER TABLE myapp_invites_public.app_invites 
  ALTER COLUMN invite_token SET NOT NULL;

ALTER TABLE myapp_invites_public.app_invites 
  ALTER COLUMN invite_token SET DEFAULT encode(gen_random_bytes(16), 'hex');

COMMENT ON COLUMN myapp_invites_public.app_invites.invite_token IS 'Unique random hex token used to redeem this invitation';

ALTER TABLE myapp_invites_public.app_invites 
  ADD COLUMN invite_valid boolean;

ALTER TABLE myapp_invites_public.app_invites 
  ALTER COLUMN invite_valid SET NOT NULL;

ALTER TABLE myapp_invites_public.app_invites 
  ALTER COLUMN invite_valid SET DEFAULT true;

COMMENT ON COLUMN myapp_invites_public.app_invites.invite_valid IS 'Whether this invitation is still valid and can be redeemed';

ALTER TABLE myapp_invites_public.app_invites 
  ADD COLUMN invite_limit int;

ALTER TABLE myapp_invites_public.app_invites 
  ALTER COLUMN invite_limit SET NOT NULL;

ALTER TABLE myapp_invites_public.app_invites 
  ALTER COLUMN invite_limit SET DEFAULT -1;

COMMENT ON COLUMN myapp_invites_public.app_invites.invite_limit IS 'Maximum number of times this invite can be claimed; -1 means unlimited';

ALTER TABLE myapp_invites_public.app_invites 
  ADD COLUMN invite_count int;

ALTER TABLE myapp_invites_public.app_invites 
  ALTER COLUMN invite_count SET NOT NULL;

ALTER TABLE myapp_invites_public.app_invites 
  ALTER COLUMN invite_count SET DEFAULT 0;

COMMENT ON COLUMN myapp_invites_public.app_invites.invite_count IS 'Running count of how many times this invite has been claimed';

ALTER TABLE myapp_invites_public.app_invites 
  ADD COLUMN multiple boolean;

ALTER TABLE myapp_invites_public.app_invites 
  ALTER COLUMN multiple SET NOT NULL;

ALTER TABLE myapp_invites_public.app_invites 
  ALTER COLUMN multiple SET DEFAULT false;

COMMENT ON COLUMN myapp_invites_public.app_invites.multiple IS 'Whether this invite can be claimed by multiple recipients';

ALTER TABLE myapp_invites_public.app_invites 
  ADD COLUMN data pg_catalog.json;

COMMENT ON COLUMN myapp_invites_public.app_invites.data IS 'Optional JSON payload of additional invite metadata';

ALTER TABLE myapp_invites_public.app_invites 
  ADD COLUMN profile_id uuid;

COMMENT ON COLUMN myapp_invites_public.app_invites.profile_id IS 'Optional profile (role) to assign to the member when they claim this invite. Only allowed on email invites.';

ALTER TABLE myapp_invites_public.app_invites 
  ADD CONSTRAINT app_invites_profile_id_fkey
    FOREIGN KEY(profile_id)
    REFERENCES myapp_profiles_public.app_profiles (id)
    ON DELETE SET NULL;

CREATE INDEX app_invites_profile_id_idx ON myapp_invites_public.app_invites (profile_id);

ALTER TABLE myapp_invites_public.app_invites 
  ADD COLUMN expires_at timestamptz;

ALTER TABLE myapp_invites_public.app_invites 
  ALTER COLUMN expires_at SET NOT NULL;

ALTER TABLE myapp_invites_public.app_invites 
  ALTER COLUMN expires_at SET DEFAULT now() + '6 months'::interval;

COMMENT ON COLUMN myapp_invites_public.app_invites.expires_at IS 'Timestamp after which this invitation can no longer be redeemed';

ALTER TABLE myapp_invites_public.app_invites 
  ADD COLUMN created_at timestamptz;

ALTER TABLE myapp_invites_public.app_invites 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE myapp_invites_public.app_invites 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE myapp_invites_public.app_invites 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE TRIGGER timestamps_tg
  BEFORE INSERT OR UPDATE
  ON myapp_invites_public.app_invites
  FOR EACH ROW
  EXECUTE PROCEDURE stamps.timestamps();

CREATE INDEX app_invites_created_at_idx ON myapp_invites_public.app_invites (created_at);

CREATE INDEX app_invites_updated_at_idx ON myapp_invites_public.app_invites (updated_at);

ALTER TABLE myapp_invites_public.app_invites 
  ADD CONSTRAINT app_invites_invite_token_key 
    UNIQUE (invite_token);

ALTER TABLE myapp_invites_public.app_invites 
  ADD CONSTRAINT app_invites_email_sender_id_key 
    UNIQUE (email, sender_id);

CREATE INDEX app_invites_expires_at_idx ON myapp_invites_public.app_invites (expires_at);

CREATE INDEX app_invites_invite_valid_idx ON myapp_invites_public.app_invites (invite_valid);

CREATE INDEX app_invites_sender_id_idx ON myapp_invites_public.app_invites (sender_id);

ALTER TABLE myapp_invites_public.app_invites 
  ADD CONSTRAINT app_invites_sender_id_fkey
    FOREIGN KEY(sender_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE CASCADE;

ALTER TABLE myapp_invites_public.app_invites 
  ADD CONSTRAINT app_invites_channel_email_phone_chk 
    CHECK (
    channel <> 'sms'
      OR phone IS NOT NULL
  );

CREATE TABLE myapp_invites_public.app_claimed_invites ();

ALTER TABLE myapp_invites_public.app_claimed_invites 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_invites_public.app_claimed_invites IS 'Records of successfully claimed invitations, linking senders to receivers';

ALTER TABLE myapp_invites_public.app_claimed_invites 
  ADD COLUMN id uuid;

ALTER TABLE myapp_invites_public.app_claimed_invites 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_invites_public.app_claimed_invites 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_invites_public.app_claimed_invites 
  ADD CONSTRAINT app_claimed_invites_pkey PRIMARY KEY (id);

ALTER TABLE myapp_invites_public.app_claimed_invites 
  ADD COLUMN data pg_catalog.json;

COMMENT ON COLUMN myapp_invites_public.app_claimed_invites.data IS 'Optional JSON payload captured at the time the invite was claimed';

ALTER TABLE myapp_invites_public.app_claimed_invites 
  ADD COLUMN sender_id uuid;

COMMENT ON COLUMN myapp_invites_public.app_claimed_invites.sender_id IS 'User ID of the original invitation sender';

ALTER TABLE myapp_invites_public.app_claimed_invites 
  ADD COLUMN receiver_id uuid;

COMMENT ON COLUMN myapp_invites_public.app_claimed_invites.receiver_id IS 'User ID of the person who claimed and redeemed the invitation';

ALTER TABLE myapp_invites_public.app_claimed_invites 
  ADD COLUMN created_at timestamptz;

ALTER TABLE myapp_invites_public.app_claimed_invites 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE myapp_invites_public.app_claimed_invites 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE myapp_invites_public.app_claimed_invites 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE TRIGGER timestamps_tg
  BEFORE INSERT OR UPDATE
  ON myapp_invites_public.app_claimed_invites
  FOR EACH ROW
  EXECUTE PROCEDURE stamps.timestamps();

CREATE INDEX app_claimed_invites_created_at_idx ON myapp_invites_public.app_claimed_invites (created_at);

CREATE INDEX app_claimed_invites_updated_at_idx ON myapp_invites_public.app_claimed_invites (updated_at);

ALTER TABLE myapp_invites_public.app_claimed_invites 
  ADD CONSTRAINT app_claimed_invites_sender_id_fkey
    FOREIGN KEY(sender_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE SET NULL;

ALTER TABLE myapp_invites_public.app_claimed_invites 
  ADD CONSTRAINT app_claimed_invites_receiver_id_fkey
    FOREIGN KEY(receiver_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE SET NULL;

CREATE INDEX app_claimed_invites_sender_id_idx ON myapp_invites_public.app_claimed_invites (sender_id);

CREATE INDEX app_claimed_invites_receiver_id_idx ON myapp_invites_public.app_claimed_invites (receiver_id);

ALTER TABLE myapp_invites_public.app_claimed_invites 
  ADD CONSTRAINT app_claimed_invites_sender_id_receiver_id_chk 
    CHECK (sender_id <> receiver_id);

CREATE FUNCTION myapp_invites_public.submit_app_invite_code(
  IN token text
) RETURNS boolean AS $EOFCODE$
DECLARE
  v_user myapp_users_public.users;
  v_email myapp_user_identifiers_public.emails;
  v_invite myapp_invites_public.app_invites;
BEGIN
  SELECT *
  FROM myapp_users_public.users
  WHERE
    id = jwt_public.current_user_id() INTO v_user;
  IF NOT (FOUND) THEN
    RAISE EXCEPTION 'OBJECT_NOT_FOUND';
  END IF;
  SELECT *
  FROM myapp_invites_public.app_invites AS i
  WHERE
    (i.invite_token = submit_app_invite_code.token AND EXTRACT(EPOCH FROM i.expires_at - now()) > 0) AND i.invite_valid = true INTO v_invite;
  IF NOT (FOUND) THEN
    RAISE EXCEPTION 'INVITE_NOT_FOUND';
  END IF;
  IF v_invite.invite_limit > 0 AND v_invite.invite_count >= v_invite.invite_limit THEN
    RAISE EXCEPTION 'INVITE_LIMIT';
  END IF;
  IF v_invite.email IS NOT NULL THEN
    SELECT *
    FROM myapp_user_identifiers_public.emails AS e
    WHERE
      e.email = v_invite.email AND e.owner_id = v_user.id INTO v_email;
    IF NOT (FOUND) THEN
      RAISE EXCEPTION 'INVITE_EMAIL_NOT_FOUND';
    END IF;
    UPDATE myapp_user_identifiers_public.emails SET
    is_verified = true
    WHERE
      id = v_email.id AND is_verified = false;
  ELSIF v_invite.phone IS NOT NULL THEN
  ELSE
    SELECT *
    FROM myapp_user_identifiers_public.emails AS e
    WHERE
      e.owner_id = v_user.id AND e.is_verified = true INTO v_email;
    IF NOT (FOUND) THEN
      RAISE EXCEPTION 'EMAIL_NOT_VERIFIED';
    END IF;
  END IF;
  IF v_invite.email IS NOT NULL OR v_invite.multiple = false THEN
    UPDATE myapp_invites_public.app_invites SET
    invite_valid = false
    WHERE
      id = v_invite.id;
  END IF;
  UPDATE myapp_invites_public.app_invites SET
  invite_count = invite_count + 1
  WHERE
    id = v_invite.id;
  INSERT INTO myapp_invites_public.app_claimed_invites (
    sender_id,
    receiver_id,
    data
  )
  VALUES
    (v_invite.sender_id, v_user.id, v_invite.data);
  IF myapp_memberships_private.app_memberships_perm_check('send_approved_invites', v_invite.sender_id) IS TRUE THEN
    INSERT INTO myapp_memberships_public.app_memberships (
      is_approved,
      actor_id,
      profile_id
    )
    VALUES
      (true, v_user.id, v_invite.profile_id)
    ON CONFLICT (actor_id) DO UPDATE SET
    is_approved = true, profile_id = CASE 
      WHEN v_invite.profile_id IS NOT NULL THEN v_invite.profile_id 
      ELSE app_memberships.profile_id 
    END;
  ELSE
    INSERT INTO myapp_memberships_public.app_memberships (
      is_approved,
      actor_id,
      profile_id
    )
    VALUES
      (false, v_user.id, v_invite.profile_id)
    ON CONFLICT (actor_id) DO UPDATE SET
    profile_id = CASE 
      WHEN v_invite.profile_id IS NOT NULL THEN v_invite.profile_id 
      ELSE app_memberships.profile_id 
    END;
  END IF;
  RETURN true;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

GRANT EXECUTE ON FUNCTION myapp_invites_public.submit_app_invite_code TO authenticated;

CREATE FUNCTION myapp_invites_private.app_invites_insert_before_tg() RETURNS trigger AS $EOFCODE$
DECLARE
  email_exists boolean;
BEGIN
  IF NEW.channel = 'email' AND NEW.email IS NOT NULL THEN
    SELECT
      EXISTS (SELECT 1
      FROM myapp_user_identifiers_public.emails AS e
      WHERE
        e.email = NEW.email) INTO email_exists;
    IF email_exists IS TRUE THEN
      RAISE EXCEPTION 'ACCOUNT_EXISTS';
    END IF;
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION myapp_invites_private.app_invites_insert_after_tg() RETURNS trigger AS $EOFCODE$
BEGIN
  IF NEW.channel = 'email' AND NEW.email IS NOT NULL THEN
    PERFORM app_jobs.add_job('email:send_verification_link', json_build_object('invite_table', 'app_invites', 'invite_type', '1', 'email_type', 'invite_email', 'email', NEW.email, 'sender_id', NEW.sender_id, 'invite_token', NEW.invite_token));
  END IF;
  IF NEW.channel = 'sms' AND NEW.phone IS NOT NULL THEN
    PERFORM app_jobs.add_job('sms:send_invite', json_build_object('invite_table', 'app_invites', 'invite_type', '1', 'phone', NEW.phone, 'sender_id', NEW.sender_id, 'invite_token', NEW.invite_token));
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE TRIGGER app_invites_email_tg
  BEFORE INSERT
  ON myapp_invites_public.app_invites
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_invites_private.app_invites_insert_before_tg();

CREATE TRIGGER app_invites_email_tg_after
  AFTER INSERT
  ON myapp_invites_public.app_invites
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_invites_private.app_invites_insert_after_tg();

CREATE FUNCTION myapp_invites_private.app_invites_profile_check_tg() RETURNS trigger AS $EOFCODE$
DECLARE
  v_profile_perms bit varying;
  v_inviter_perms bit varying;
BEGIN
  IF NEW.profile_id IS NOT NULL THEN
    IF NEW.email IS NULL OR NEW.multiple IS TRUE THEN
      RAISE EXCEPTION 'PROFILE_ASSIGNMENT_REQUIRES_EMAIL_INVITE';
    END IF;
    SELECT p.permissions
    FROM myapp_profiles_public.app_profiles AS p
    WHERE
      p.id = NEW.profile_id INTO v_profile_perms;
    IF NOT (FOUND) THEN
      RAISE EXCEPTION 'PROFILE_NOT_FOUND';
    END IF;
    IF NOT (myapp_memberships_private.app_memberships_perm_check('assign_profiles', NEW.sender_id) IS TRUE) THEN
      RAISE EXCEPTION 'ASSIGN_PROFILES_PERMISSION_REQUIRED';
    END IF;
    SELECT m.permissions
    FROM myapp_memberships_public.app_memberships AS m
    WHERE
      m.actor_id = NEW.sender_id INTO v_inviter_perms;
    IF NOT (FOUND) THEN
      RAISE EXCEPTION 'MEMBERSHIP_NOT_FOUND';
    END IF;
    IF (v_profile_perms & (~v_inviter_perms)) <> (v_inviter_perms & (~v_inviter_perms)) THEN
      RAISE EXCEPTION 'PROFILE_EXCEEDS_PERMISSIONS';
    END IF;
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE TRIGGER app_invites_profile_check_tg
  BEFORE INSERT
  ON myapp_invites_public.app_invites
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_invites_private.app_invites_profile_check_tg();

ALTER TABLE myapp_invites_public.app_invites 
  ENABLE ROW LEVEL SECURITY;

GRANT INSERT ( channel, email, phone, expires_at, multiple, invite_limit, profile_id ) ON myapp_invites_public.app_invites TO authenticated;

GRANT SELECT ON myapp_invites_public.app_invites TO authenticated;

GRANT UPDATE ON myapp_invites_public.app_invites TO authenticated;

GRANT DELETE ON myapp_invites_public.app_invites TO authenticated;

CREATE POLICY auth_ins_dir_own
  ON myapp_invites_public.app_invites
  AS PERMISSIVE
  FOR INSERT
  TO authenticated
  WITH CHECK (
    sender_id = jwt_public.current_principal_id()
  );

CREATE POLICY auth_ins_create_invite_check
  ON myapp_invites_public.app_invites
  AS RESTRICTIVE
  FOR INSERT
  TO authenticated
  WITH CHECK (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000000010') = '0000000000000000000000000000000000000000000000000000000000000010')
  );

CREATE POLICY auth_sel_dir_own
  ON myapp_invites_public.app_invites
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    sender_id = jwt_public.current_principal_id()
  );

CREATE POLICY auth_upd_dir_own
  ON myapp_invites_public.app_invites
  AS PERMISSIVE
  FOR UPDATE
  TO authenticated
  USING (
    sender_id = jwt_public.current_principal_id()
  );

CREATE POLICY auth_del_dir_own
  ON myapp_invites_public.app_invites
  AS PERMISSIVE
  FOR DELETE
  TO authenticated
  USING (
    sender_id = jwt_public.current_principal_id()
  );

ALTER TABLE myapp_invites_public.app_claimed_invites 
  ENABLE ROW LEVEL SECURITY;

GRANT SELECT ON myapp_invites_public.app_claimed_invites TO authenticated;

CREATE POLICY auth_sel_sender
  ON myapp_invites_public.app_claimed_invites
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    sender_id = jwt_public.current_principal_id()
  );

CREATE POLICY auth_sel_receiver
  ON myapp_invites_public.app_claimed_invites
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    receiver_id = jwt_public.current_principal_id()
  );

CREATE TABLE myapp_invites_public.org_invites ();

ALTER TABLE myapp_invites_public.org_invites 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_invites_public.org_invites IS 'Invitation records sent to prospective members via email, with token-based redemption and expiration';

ALTER TABLE myapp_invites_public.org_invites 
  ADD COLUMN id uuid;

ALTER TABLE myapp_invites_public.org_invites 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_invites_public.org_invites 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_invites_public.org_invites 
  ADD CONSTRAINT org_invites_pkey PRIMARY KEY (id);

ALTER TABLE myapp_invites_public.org_invites 
  ADD COLUMN channel text;

ALTER TABLE myapp_invites_public.org_invites 
  ALTER COLUMN channel SET NOT NULL;

ALTER TABLE myapp_invites_public.org_invites 
  ALTER COLUMN channel SET DEFAULT 'email';

COMMENT ON COLUMN myapp_invites_public.org_invites.channel IS 'Delivery channel for this invitation: email, sms, or link';

ALTER TABLE myapp_invites_public.org_invites 
  ADD COLUMN email email;

COMMENT ON COLUMN myapp_invites_public.org_invites.email IS 'Email address of the invited recipient (required when channel=email)';

ALTER TABLE myapp_invites_public.org_invites 
  ADD COLUMN phone text;

COMMENT ON COLUMN myapp_invites_public.org_invites.phone IS 'Phone number of the invited recipient in E.164 format (required when channel=sms)';

ALTER TABLE myapp_invites_public.org_invites 
  ADD COLUMN sender_id uuid;

ALTER TABLE myapp_invites_public.org_invites 
  ALTER COLUMN sender_id SET NOT NULL;

ALTER TABLE myapp_invites_public.org_invites 
  ALTER COLUMN sender_id SET DEFAULT jwt_public.current_user_id();

COMMENT ON COLUMN myapp_invites_public.org_invites.sender_id IS 'User ID of the member who sent this invitation';

ALTER TABLE myapp_invites_public.org_invites 
  ADD COLUMN receiver_id uuid;

COMMENT ON COLUMN myapp_invites_public.org_invites.receiver_id IS 'User ID of the intended recipient, if targeting a specific user';

ALTER TABLE myapp_invites_public.org_invites 
  ADD COLUMN invite_token text;

ALTER TABLE myapp_invites_public.org_invites 
  ALTER COLUMN invite_token SET NOT NULL;

ALTER TABLE myapp_invites_public.org_invites 
  ALTER COLUMN invite_token SET DEFAULT encode(gen_random_bytes(16), 'hex');

COMMENT ON COLUMN myapp_invites_public.org_invites.invite_token IS 'Unique random hex token used to redeem this invitation';

ALTER TABLE myapp_invites_public.org_invites 
  ADD COLUMN invite_valid boolean;

ALTER TABLE myapp_invites_public.org_invites 
  ALTER COLUMN invite_valid SET NOT NULL;

ALTER TABLE myapp_invites_public.org_invites 
  ALTER COLUMN invite_valid SET DEFAULT true;

COMMENT ON COLUMN myapp_invites_public.org_invites.invite_valid IS 'Whether this invitation is still valid and can be redeemed';

ALTER TABLE myapp_invites_public.org_invites 
  ADD COLUMN invite_limit int;

ALTER TABLE myapp_invites_public.org_invites 
  ALTER COLUMN invite_limit SET NOT NULL;

ALTER TABLE myapp_invites_public.org_invites 
  ALTER COLUMN invite_limit SET DEFAULT -1;

COMMENT ON COLUMN myapp_invites_public.org_invites.invite_limit IS 'Maximum number of times this invite can be claimed; -1 means unlimited';

ALTER TABLE myapp_invites_public.org_invites 
  ADD COLUMN invite_count int;

ALTER TABLE myapp_invites_public.org_invites 
  ALTER COLUMN invite_count SET NOT NULL;

ALTER TABLE myapp_invites_public.org_invites 
  ALTER COLUMN invite_count SET DEFAULT 0;

COMMENT ON COLUMN myapp_invites_public.org_invites.invite_count IS 'Running count of how many times this invite has been claimed';

ALTER TABLE myapp_invites_public.org_invites 
  ADD COLUMN multiple boolean;

ALTER TABLE myapp_invites_public.org_invites 
  ALTER COLUMN multiple SET NOT NULL;

ALTER TABLE myapp_invites_public.org_invites 
  ALTER COLUMN multiple SET DEFAULT false;

COMMENT ON COLUMN myapp_invites_public.org_invites.multiple IS 'Whether this invite can be claimed by multiple recipients';

ALTER TABLE myapp_invites_public.org_invites 
  ADD COLUMN data pg_catalog.json;

COMMENT ON COLUMN myapp_invites_public.org_invites.data IS 'Optional JSON payload of additional invite metadata';

ALTER TABLE myapp_invites_public.org_invites 
  ADD COLUMN profile_id uuid;

COMMENT ON COLUMN myapp_invites_public.org_invites.profile_id IS 'Optional profile (role) to assign to the member when they claim this invite. Only allowed on email invites.';

ALTER TABLE myapp_invites_public.org_invites 
  ADD CONSTRAINT org_invites_profile_id_fkey
    FOREIGN KEY(profile_id)
    REFERENCES myapp_profiles_public.org_profiles (id)
    ON DELETE SET NULL;

CREATE INDEX org_invites_profile_id_idx ON myapp_invites_public.org_invites (profile_id);

ALTER TABLE myapp_invites_public.org_invites 
  ADD COLUMN is_read_only boolean;

ALTER TABLE myapp_invites_public.org_invites 
  ALTER COLUMN is_read_only SET NOT NULL;

ALTER TABLE myapp_invites_public.org_invites 
  ALTER COLUMN is_read_only SET DEFAULT false;

COMMENT ON COLUMN myapp_invites_public.org_invites.is_read_only IS 'Whether the resulting membership should be read-only when this invite is claimed';

ALTER TABLE myapp_invites_public.org_invites 
  ADD COLUMN expires_at timestamptz;

ALTER TABLE myapp_invites_public.org_invites 
  ALTER COLUMN expires_at SET NOT NULL;

ALTER TABLE myapp_invites_public.org_invites 
  ALTER COLUMN expires_at SET DEFAULT now() + '6 months'::interval;

COMMENT ON COLUMN myapp_invites_public.org_invites.expires_at IS 'Timestamp after which this invitation can no longer be redeemed';

ALTER TABLE myapp_invites_public.org_invites 
  ADD COLUMN created_at timestamptz;

ALTER TABLE myapp_invites_public.org_invites 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE myapp_invites_public.org_invites 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE myapp_invites_public.org_invites 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE TRIGGER timestamps_tg
  BEFORE INSERT OR UPDATE
  ON myapp_invites_public.org_invites
  FOR EACH ROW
  EXECUTE PROCEDURE stamps.timestamps();

CREATE INDEX org_invites_created_at_idx ON myapp_invites_public.org_invites (created_at);

CREATE INDEX org_invites_updated_at_idx ON myapp_invites_public.org_invites (updated_at);

ALTER TABLE myapp_invites_public.org_invites 
  ADD CONSTRAINT org_invites_invite_token_key 
    UNIQUE (invite_token);

ALTER TABLE myapp_invites_public.org_invites 
  ADD COLUMN entity_id uuid;

ALTER TABLE myapp_invites_public.org_invites 
  ALTER COLUMN entity_id SET NOT NULL;

ALTER TABLE myapp_invites_public.org_invites 
  ADD CONSTRAINT org_invites_entity_id_fkey
    FOREIGN KEY(entity_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE CASCADE;

CREATE INDEX org_invites_entity_id_idx ON myapp_invites_public.org_invites (entity_id);

ALTER TABLE myapp_invites_public.org_invites 
  ADD CONSTRAINT org_invites_email_sender_id_entity_id_key 
    UNIQUE (email, sender_id, entity_id);

CREATE INDEX org_invites_expires_at_idx ON myapp_invites_public.org_invites (expires_at);

CREATE INDEX org_invites_invite_valid_idx ON myapp_invites_public.org_invites (invite_valid);

CREATE INDEX org_invites_sender_id_idx ON myapp_invites_public.org_invites (sender_id);

ALTER TABLE myapp_invites_public.org_invites 
  ADD CONSTRAINT org_invites_sender_id_fkey
    FOREIGN KEY(sender_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE CASCADE;

ALTER TABLE myapp_invites_public.org_invites 
  ADD CONSTRAINT org_invites_receiver_id_fkey
    FOREIGN KEY(receiver_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE CASCADE;

CREATE INDEX org_invites_receiver_id_idx ON myapp_invites_public.org_invites (receiver_id);

ALTER TABLE myapp_invites_public.org_invites 
  ADD CONSTRAINT org_invites_channel_email_phone_chk 
    CHECK (
    channel <> 'sms'
      OR phone IS NOT NULL
  );

CREATE TABLE myapp_invites_public.org_claimed_invites ();

ALTER TABLE myapp_invites_public.org_claimed_invites 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_invites_public.org_claimed_invites IS 'Records of successfully claimed invitations, linking senders to receivers';

ALTER TABLE myapp_invites_public.org_claimed_invites 
  ADD COLUMN id uuid;

ALTER TABLE myapp_invites_public.org_claimed_invites 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_invites_public.org_claimed_invites 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_invites_public.org_claimed_invites 
  ADD CONSTRAINT org_claimed_invites_pkey PRIMARY KEY (id);

ALTER TABLE myapp_invites_public.org_claimed_invites 
  ADD COLUMN data pg_catalog.json;

COMMENT ON COLUMN myapp_invites_public.org_claimed_invites.data IS 'Optional JSON payload captured at the time the invite was claimed';

ALTER TABLE myapp_invites_public.org_claimed_invites 
  ADD COLUMN sender_id uuid;

COMMENT ON COLUMN myapp_invites_public.org_claimed_invites.sender_id IS 'User ID of the original invitation sender';

ALTER TABLE myapp_invites_public.org_claimed_invites 
  ADD COLUMN receiver_id uuid;

COMMENT ON COLUMN myapp_invites_public.org_claimed_invites.receiver_id IS 'User ID of the person who claimed and redeemed the invitation';

ALTER TABLE myapp_invites_public.org_claimed_invites 
  ADD COLUMN created_at timestamptz;

ALTER TABLE myapp_invites_public.org_claimed_invites 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE myapp_invites_public.org_claimed_invites 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE myapp_invites_public.org_claimed_invites 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE TRIGGER timestamps_tg
  BEFORE INSERT OR UPDATE
  ON myapp_invites_public.org_claimed_invites
  FOR EACH ROW
  EXECUTE PROCEDURE stamps.timestamps();

CREATE INDEX org_claimed_invites_created_at_idx ON myapp_invites_public.org_claimed_invites (created_at);

CREATE INDEX org_claimed_invites_updated_at_idx ON myapp_invites_public.org_claimed_invites (updated_at);

ALTER TABLE myapp_invites_public.org_claimed_invites 
  ADD CONSTRAINT org_claimed_invites_sender_id_fkey
    FOREIGN KEY(sender_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE SET NULL;

ALTER TABLE myapp_invites_public.org_claimed_invites 
  ADD CONSTRAINT org_claimed_invites_receiver_id_fkey
    FOREIGN KEY(receiver_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE SET NULL;

CREATE INDEX org_claimed_invites_sender_id_idx ON myapp_invites_public.org_claimed_invites (sender_id);

CREATE INDEX org_claimed_invites_receiver_id_idx ON myapp_invites_public.org_claimed_invites (receiver_id);

ALTER TABLE myapp_invites_public.org_claimed_invites 
  ADD CONSTRAINT org_claimed_invites_sender_id_receiver_id_chk 
    CHECK (sender_id <> receiver_id);

ALTER TABLE myapp_invites_public.org_claimed_invites 
  ADD COLUMN entity_id uuid;

ALTER TABLE myapp_invites_public.org_claimed_invites 
  ALTER COLUMN entity_id SET NOT NULL;

ALTER TABLE myapp_invites_public.org_claimed_invites 
  ADD CONSTRAINT org_claimed_invites_entity_id_fkey
    FOREIGN KEY(entity_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE CASCADE;

CREATE INDEX org_claimed_invites_entity_id_idx ON myapp_invites_public.org_claimed_invites (entity_id);

CREATE FUNCTION myapp_invites_public.submit_org_invite_code(
  IN token text
) RETURNS boolean AS $EOFCODE$
DECLARE
  v_user myapp_users_public.users;
  v_email myapp_user_identifiers_public.emails;
  v_invite myapp_invites_public.org_invites;
BEGIN
  SELECT *
  FROM myapp_users_public.users
  WHERE
    id = jwt_public.current_user_id() INTO v_user;
  IF NOT (FOUND) THEN
    RAISE EXCEPTION 'OBJECT_NOT_FOUND';
  END IF;
  SELECT *
  FROM myapp_invites_public.org_invites AS i
  WHERE
    (i.invite_token = submit_org_invite_code.token AND EXTRACT(EPOCH FROM i.expires_at - now()) > 0) AND i.invite_valid = true INTO v_invite;
  IF NOT (FOUND) THEN
    RAISE EXCEPTION 'INVITE_NOT_FOUND';
  END IF;
  IF v_invite.invite_limit > 0 AND v_invite.invite_count >= v_invite.invite_limit THEN
    RAISE EXCEPTION 'INVITE_LIMIT';
  END IF;
  IF v_invite.email IS NOT NULL THEN
    SELECT *
    FROM myapp_user_identifiers_public.emails AS e
    WHERE
      e.email = v_invite.email AND e.owner_id = v_user.id INTO v_email;
    IF NOT (FOUND) THEN
      RAISE EXCEPTION 'INVITE_EMAIL_NOT_FOUND';
    END IF;
    UPDATE myapp_user_identifiers_public.emails SET
    is_verified = true
    WHERE
      id = v_email.id AND is_verified = false;
  ELSIF v_invite.phone IS NOT NULL THEN
  ELSE
    SELECT *
    FROM myapp_user_identifiers_public.emails AS e
    WHERE
      e.owner_id = v_user.id AND e.is_verified = true INTO v_email;
    IF NOT (FOUND) THEN
      RAISE EXCEPTION 'EMAIL_NOT_VERIFIED';
    END IF;
  END IF;
  IF v_invite.receiver_id IS NOT NULL THEN
    IF v_invite.receiver_id <> v_user.id THEN
      RAISE EXCEPTION 'INVITE_EMAIL_NOT_FOUND';
    END IF;
  END IF;
  IF v_invite.email IS NOT NULL OR v_invite.multiple = false THEN
    UPDATE myapp_invites_public.org_invites SET
    invite_valid = false
    WHERE
      id = v_invite.id;
  END IF;
  UPDATE myapp_invites_public.org_invites SET
  invite_count = invite_count + 1
  WHERE
    id = v_invite.id;
  INSERT INTO myapp_invites_public.org_claimed_invites (
    sender_id,
    receiver_id,
    data,
    entity_id
  )
  VALUES
    (v_invite.sender_id, v_user.id, v_invite.data, v_invite.entity_id);
  IF myapp_memberships_private.org_memberships_perm_check('send_approved_invites', v_invite.entity_id, v_invite.sender_id) IS TRUE THEN
    INSERT INTO myapp_memberships_public.org_memberships (
      is_approved,
      entity_id,
      actor_id,
      profile_id,
      is_read_only
    )
    VALUES
      (true, v_invite.entity_id, v_user.id, v_invite.profile_id, v_invite.is_read_only)
    ON CONFLICT (entity_id, actor_id) DO UPDATE SET
    is_approved = true, profile_id = CASE 
      WHEN v_invite.profile_id IS NOT NULL THEN v_invite.profile_id 
      ELSE org_memberships.profile_id 
    END, is_read_only = v_invite.is_read_only;
  ELSE
    INSERT INTO myapp_memberships_public.org_memberships (
      is_approved,
      entity_id,
      actor_id,
      profile_id,
      is_read_only
    )
    VALUES
      (false, v_invite.entity_id, v_user.id, v_invite.profile_id, v_invite.is_read_only)
    ON CONFLICT (entity_id, actor_id) DO UPDATE SET
    profile_id = CASE 
      WHEN v_invite.profile_id IS NOT NULL THEN v_invite.profile_id 
      ELSE org_memberships.profile_id 
    END, is_read_only = v_invite.is_read_only;
  END IF;
  RETURN true;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

GRANT EXECUTE ON FUNCTION myapp_invites_public.submit_org_invite_code TO authenticated;

CREATE FUNCTION myapp_invites_private.org_invites_insert_before_tg() RETURNS trigger AS $EOFCODE$
DECLARE
  owner_id uuid;
  membership_exists boolean;
BEGIN
  IF NEW.email IS NOT NULL THEN
    SELECT e.owner_id
    FROM myapp_user_identifiers_public.emails AS e
    WHERE
      e.email = NEW.email INTO owner_id;
    IF FOUND THEN
      SELECT owner_id INTO NEW.receiver_id;
      SELECT
        EXISTS (SELECT 1
        FROM myapp_memberships_public.org_memberships AS m
        WHERE
          m.actor_id = NEW.receiver_id AND m.entity_id = NEW.entity_id) INTO membership_exists;
      IF membership_exists IS TRUE THEN
        RAISE EXCEPTION 'ACCOUNT_EXISTS';
      END IF;
    END IF;
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION myapp_invites_private.org_invites_insert_after_tg() RETURNS trigger AS $EOFCODE$
BEGIN
  IF NEW.channel = 'email' AND NEW.email IS NOT NULL THEN
    PERFORM app_jobs.add_job('email:send_verification_link', json_build_object('invite_table', 'org_invites', 'invite_type', '2', 'email_type', 'invite_email', 'email', NEW.email, 'sender_id', NEW.sender_id, 'invite_token', NEW.invite_token));
  END IF;
  IF NEW.channel = 'sms' AND NEW.phone IS NOT NULL THEN
    PERFORM app_jobs.add_job('sms:send_invite', json_build_object('invite_table', 'org_invites', 'invite_type', '2', 'phone', NEW.phone, 'sender_id', NEW.sender_id, 'invite_token', NEW.invite_token));
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE TRIGGER org_invites_email_tg
  BEFORE INSERT
  ON myapp_invites_public.org_invites
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_invites_private.org_invites_insert_before_tg();

CREATE TRIGGER org_invites_email_tg_after
  AFTER INSERT
  ON myapp_invites_public.org_invites
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_invites_private.org_invites_insert_after_tg();

CREATE FUNCTION myapp_invites_private.org_invites_profile_check_tg() RETURNS trigger AS $EOFCODE$
DECLARE
  v_mode text := 'strict';
  v_profile_perms bit varying;
  v_inviter_perms bit varying;
BEGIN
  IF NEW.profile_id IS NOT NULL THEN
    IF NEW.email IS NULL OR NEW.multiple IS TRUE THEN
      RAISE EXCEPTION 'PROFILE_ASSIGNMENT_REQUIRES_EMAIL_INVITE';
    END IF;
    SELECT s.invite_profile_assignment_mode
    FROM myapp_memberships_public.org_membership_settings AS s
    WHERE
      s.entity_id = NEW.entity_id INTO v_mode;
    SELECT p.permissions
    FROM myapp_profiles_public.org_profiles AS p
    WHERE
      p.id = NEW.profile_id INTO v_profile_perms;
    IF NOT (FOUND) THEN
      RAISE EXCEPTION 'PROFILE_NOT_FOUND';
    END IF;
    IF v_mode = 'strict' OR v_mode = 'permission_only' THEN
      IF NOT (myapp_memberships_private.org_memberships_perm_check('assign_profiles', NEW.entity_id, NEW.sender_id) IS TRUE) THEN
        RAISE EXCEPTION 'ASSIGN_PROFILES_PERMISSION_REQUIRED';
      END IF;
    END IF;
    IF v_mode = 'strict' OR v_mode = 'subset_only' THEN
      SELECT m.permissions
      FROM myapp_memberships_public.org_memberships AS m
      WHERE
        m.actor_id = NEW.sender_id AND m.entity_id = NEW.entity_id INTO v_inviter_perms;
      IF NOT (FOUND) THEN
        RAISE EXCEPTION 'MEMBERSHIP_NOT_FOUND';
      END IF;
      IF (v_profile_perms & (~v_inviter_perms)) <> (v_inviter_perms & (~v_inviter_perms)) THEN
        RAISE EXCEPTION 'PROFILE_EXCEEDS_PERMISSIONS';
      END IF;
    END IF;
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE TRIGGER org_invites_profile_check_tg
  BEFORE INSERT
  ON myapp_invites_public.org_invites
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_invites_private.org_invites_profile_check_tg();

ALTER TABLE myapp_invites_public.org_invites 
  ENABLE ROW LEVEL SECURITY;

GRANT INSERT ( channel, email, phone, expires_at, multiple, invite_limit, entity_id, receiver_id, profile_id, is_read_only ) ON myapp_invites_public.org_invites TO authenticated;

GRANT SELECT ON myapp_invites_public.org_invites TO authenticated;

GRANT UPDATE ON myapp_invites_public.org_invites TO authenticated;

GRANT DELETE ON myapp_invites_public.org_invites TO authenticated;

CREATE POLICY auth_ins_dir_own
  ON myapp_invites_public.org_invites
  AS PERMISSIVE
  FOR INSERT
  TO authenticated
  WITH CHECK (
    sender_id = jwt_public.current_principal_id()
  );

CREATE POLICY auth_ins_create_invite_check
  ON myapp_invites_public.org_invites
  AS RESTRICTIVE
  FOR INSERT
  TO authenticated
  WITH CHECK (
    entity_id IN (SELECT org_sprt.entity_id
    FROM myapp_memberships_private.org_memberships_sprt AS org_sprt
    WHERE
      org_sprt.actor_id = jwt_public.current_principal_id()
      AND (org_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000000010') = '0000000000000000000000000000000000000000000000000000000000000010')
  );

CREATE POLICY auth_sel_dir_own
  ON myapp_invites_public.org_invites
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    sender_id = jwt_public.current_principal_id()
  );

CREATE POLICY auth_upd_dir_own
  ON myapp_invites_public.org_invites
  AS PERMISSIVE
  FOR UPDATE
  TO authenticated
  USING (
    sender_id = jwt_public.current_principal_id()
  );

CREATE POLICY auth_del_dir_own
  ON myapp_invites_public.org_invites
  AS PERMISSIVE
  FOR DELETE
  TO authenticated
  USING (
    sender_id = jwt_public.current_principal_id()
  );

ALTER TABLE myapp_invites_public.org_claimed_invites 
  ENABLE ROW LEVEL SECURITY;

GRANT SELECT ON myapp_invites_public.org_claimed_invites TO authenticated;

CREATE POLICY auth_sel_sender
  ON myapp_invites_public.org_claimed_invites
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    sender_id = jwt_public.current_principal_id()
  );

CREATE POLICY auth_sel_receiver
  ON myapp_invites_public.org_claimed_invites
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    receiver_id = jwt_public.current_principal_id()
  );

CREATE POLICY auth_sel_org_members_select
  ON myapp_invites_public.org_invites
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    entity_id IN (SELECT org_sprt.entity_id
    FROM myapp_memberships_private.org_memberships_sprt AS org_sprt
    WHERE
      org_sprt.actor_id = jwt_public.current_principal_id()
      AND (org_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000000100') = '0000000000000000000000000000000000000000000000000000000000000100')
  );

CREATE POLICY auth_del_org_members_delete
  ON myapp_invites_public.org_invites
  AS PERMISSIVE
  FOR DELETE
  TO authenticated
  USING (
    entity_id IN (SELECT org_sprt.entity_id
    FROM myapp_memberships_private.org_memberships_sprt AS org_sprt
    WHERE
      org_sprt.actor_id = jwt_public.current_principal_id()
      AND org_sprt.is_admin IS TRUE)
  );

CREATE POLICY auth_sel_org_members_claimed
  ON myapp_invites_public.org_claimed_invites
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    entity_id IN (SELECT org_sprt.entity_id
    FROM myapp_memberships_private.org_memberships_sprt AS org_sprt
    WHERE
      org_sprt.actor_id = jwt_public.current_principal_id()
      AND (org_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000000100') = '0000000000000000000000000000000000000000000000000000000000000100')
  );

CREATE SCHEMA myapp_logging_public;

GRANT USAGE ON SCHEMA myapp_logging_public TO administrator;

GRANT USAGE ON SCHEMA myapp_logging_public TO authenticated;

GRANT USAGE ON SCHEMA myapp_logging_public TO anonymous;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_logging_public
  GRANT ALL ON TABLES TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_logging_public
  GRANT USAGE ON SEQUENCES TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_logging_public
  GRANT ALL ON FUNCTIONS TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_logging_public
  GRANT ALL ON FUNCTIONS TO authenticated;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_logging_public
  GRANT USAGE ON SEQUENCES TO authenticated;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_logging_public
  GRANT ALL ON FUNCTIONS TO anonymous;

CREATE TABLE myapp_logging_public.audit_log_auth (
  created_at timestamptz NOT NULL DEFAULT now()
) PARTITION BY RANGE (created_at);

ALTER TABLE myapp_logging_public.audit_log_auth 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_logging_public.audit_log_auth IS 'Partitioned append-only audit log of authentication events (sign-in, sign-up, password changes, etc.)';

ALTER TABLE myapp_logging_public.audit_log_auth 
  ADD COLUMN id uuid;

ALTER TABLE myapp_logging_public.audit_log_auth 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_logging_public.audit_log_auth 
  ALTER COLUMN id SET DEFAULT uuidv7();

COMMENT ON COLUMN myapp_logging_public.audit_log_auth.id IS 'Unique identifier for each audit event (uuidv7 provides temporal ordering)';

ALTER TABLE myapp_logging_public.audit_log_auth 
  ADD COLUMN event citext;

ALTER TABLE myapp_logging_public.audit_log_auth 
  ALTER COLUMN event SET NOT NULL;

COMMENT ON COLUMN myapp_logging_public.audit_log_auth.event IS 'Type of authentication event (e.g. sign_in, sign_up, password_change, verify_email)';

ALTER TABLE myapp_logging_public.audit_log_auth 
  ADD COLUMN actor_id uuid;

ALTER TABLE myapp_logging_public.audit_log_auth 
  ALTER COLUMN actor_id SET DEFAULT jwt_public.current_user_id();

COMMENT ON COLUMN myapp_logging_public.audit_log_auth.actor_id IS 'User who performed the authentication action; NULL if user was deleted';

ALTER TABLE myapp_logging_public.audit_log_auth 
  ADD COLUMN origin origin;

ALTER TABLE myapp_logging_public.audit_log_auth 
  ALTER COLUMN origin SET DEFAULT jwt_public.current_origin();

COMMENT ON COLUMN myapp_logging_public.audit_log_auth.origin IS 'Request origin (domain) where the auth event occurred';

ALTER TABLE myapp_logging_public.audit_log_auth 
  ADD COLUMN user_agent text;

ALTER TABLE myapp_logging_public.audit_log_auth 
  ALTER COLUMN user_agent SET DEFAULT jwt_public.current_user_agent();

COMMENT ON COLUMN myapp_logging_public.audit_log_auth.user_agent IS 'Browser or client user-agent string from the request';

ALTER TABLE myapp_logging_public.audit_log_auth 
  ADD COLUMN ip_address inet;

ALTER TABLE myapp_logging_public.audit_log_auth 
  ALTER COLUMN ip_address SET DEFAULT jwt_public.current_ip_address();

COMMENT ON COLUMN myapp_logging_public.audit_log_auth.ip_address IS 'IP address of the client that initiated the auth event';

CREATE INDEX audit_log_auths_event_idx ON myapp_logging_public.audit_log_auth (event);

ALTER TABLE myapp_logging_public.audit_log_auth 
  ADD CONSTRAINT audit_log_auths_actor_id_fkey
    FOREIGN KEY(actor_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE SET NULL;

CREATE INDEX audit_log_auths_actor_id_idx ON myapp_logging_public.audit_log_auth (actor_id);

ALTER TABLE myapp_logging_public.audit_log_auth 
  ADD COLUMN success bool;

ALTER TABLE myapp_logging_public.audit_log_auth 
  ALTER COLUMN success SET NOT NULL;

COMMENT ON COLUMN myapp_logging_public.audit_log_auth.success IS 'Whether the authentication attempt succeeded';

INSERT INTO metaschema_public.partition (
  id,
  database_id,
  table_id,
  strategy,
  partition_key_id,
  "interval",
  retention,
  retention_keep_table,
  premake,
  naming_pattern
) VALUES
  ('01a5f788-857a-4a9d-9cb4-7e76e453014a', '019fb68d-023e-72ec-b6fc-33d15bd99e09', '019fb68d-5c77-7a20-9752-c370bfb93ee7', 'range', '019fb68d-5d6d-72a1-80a2-18b0f90edc89', '1 month', '12 months', true, 2, '{parent}_{bounds}') ON CONFLICT (table_id) DO NOTHING;

ALTER TABLE myapp_logging_public.audit_log_auth 
  ADD CONSTRAINT audit_log_auths_pkey PRIMARY KEY (created_at, id);

ALTER TABLE myapp_logging_public.audit_log_auth 
  ENABLE ROW LEVEL SECURITY;

GRANT SELECT ON myapp_logging_public.audit_log_auth TO authenticated;

CREATE POLICY auth_sel_dir_own
  ON myapp_logging_public.audit_log_auth
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    actor_id = jwt_public.current_principal_id()
  );

CREATE FUNCTION myapp_auth_public.check_password(
  IN password text
) RETURNS void AS $EOFCODE$
BEGIN
  IF check_password.password IS NULL THEN
    PERFORM errors.raise_error('PASSWORD_LEN', '{}', 'public');
  END IF;
  SELECT trim(check_password.password) INTO check_password.password;
  IF character_length(check_password.password) <= 7 OR character_length(check_password.password) >= 64 THEN
    PERFORM errors.raise_error('PASSWORD_LEN', '{}', 'public');
  END IF;
  IF check_password.password::citext = ANY( ARRAY['password', '12345678', '123456789', 'baseball', 'football', 'qwertyuiop', '1234567890', 'superman', '1qaz2wsx', 'trustno1', 'jennifer', 'sunshine', 'iloveyou', 'starwars', 'computer', 'michelle', '11111111', 'princess', '987654321', 'corvette', '1234qwer', '88888888', 'q1w2e3r4t5', 'internet', 'samantha', 'whatever', 'maverick', 'steelers', 'mercedes', '123123123', 'qwer1234', 'hardcore', 'q1w2e3r4', 'midnight', 'bigdaddy', 'victoria', '1q2w3e4r', 'cocacola', 'marlboro', 'asdfasdf', '87654321', '12344321', 'jordan23', 'Password', 'jonathan', 'liverpoo', 'danielle', 'abcd1234', 'scorpion', 'qazwsxedc', 'password1', 'slipknot', 'qwerty123', 'startrek', '12341234', 'redskins', 'butthead', 'asdfghjkl', 'qwertyui', 'liverpool', 'dolphins', 'nicholas', 'elephant', 'mountain', 'xxxxxxxx', '1q2w3e4r5t', 'metallic', 'shithead', 'benjamin', 'creative', 'rush2112', 'asdfghjk', '4815162342', 'passw0rd', 'bullshit', '1qazxsw2', 'garfield', '01012011', '69696969', 'december', '11223344', 'godzilla', 'airborne', 'lifehack', 'brooklyn', 'platinum', 'darkness', 'blink182', '789456123', '12qwaszx', 'snowball', 'pakistan', 'redwings', 'williams', 'nintendo', 'guinness', 'november', 'minecraft', 'asdf1234', 'lasvegas', 'babygirl', 'dickhead', '12121212', '147258369', 'explorer', 'snickers', 'metallica', 'alexande', 'paradise', 'michigan', 'carolina', 'lacrosse', 'christin', 'kimberly', 'kristina', '0987654321', 'poohbear', 'bollocks', 'qweasdzxc', 'drowssap', 'caroline', 'einstein', 'spitfire', 'maryjane', '1232323q', 'champion', 'svetlana', 'westside', 'courtney', '12345qwert', 'patricia', 'aaaaaaaa', 'anderson', 'security', 'stargate', 'simpsons', 'scarface', '123456789a', '1234554321', 'cherokee', 'Usuckballz1', 'veronica', 'semperfi', 'scotland', 'marshall', 'qwerty12', '98765432', 'softball', 'passport', 'franklin', 'alexander', '55555555', 'zaq12wsx', 'infinity', 'kawasaki', '77777777', 'vladimir', 'freeuser', 'wildcats', 'budlight', 'brittany', '00000000', 'bulldogs', 'swordfis', 'PASSWORD']::citext[] ) THEN
    PERFORM errors.raise_error('PASSWORD_INSECURE', '{}', 'public');
  END IF;
END;
$EOFCODE$ LANGUAGE plpgsql;

GRANT EXECUTE ON FUNCTION myapp_auth_public.check_password TO PUBLIC;

CREATE FUNCTION myapp_auth_public.sign_in(
  IN email text,
  IN password text,
  IN remember_me boolean DEFAULT false,
  IN credential_kind text DEFAULT 'bearer',
  IN csrf_token text DEFAULT NULL,
  IN device_token text DEFAULT NULL,
  OUT id uuid,
  OUT user_id uuid,
  OUT access_token text,
  OUT access_token_expires_at timestamptz,
  OUT is_verified boolean,
  OUT totp_enabled boolean,
  OUT mfa_required boolean,
  OUT mfa_challenge_token text,
  OUT out_device_token text,
  OUT device_approval_required boolean
) AS $EOFCODE$
DECLARE
  v_email myapp_user_identifiers_public.emails;
  v_settings myapp_auth_private.app_settings_auth;
  v_default_session_duration interval := '2 weeks'::interval;
  v_remember_me_duration interval := '30 days'::interval;
  v_require_csrf boolean := false;
  v_user_is_verified boolean := false;
  v_user_is_disabled boolean := false;
  v_user_is_banned boolean := false;
  v_user_rate_limit myapp_auth_private.auth_rate_limits;
  v_session_id uuid;
  v_credential_id uuid;
  v_plaintext_credential text;
  v_csrf_secret text;
  v_anon_session myapp_auth_private.sessions;
  v_session_expires_at timestamptz;
  v_mfa_enabled boolean := false;
  v_mfa_challenge_token text;
  v_device_token_hash bytea;
  v_device myapp_auth_private.auth_user_devices;
  v_device_settings myapp_auth_private.app_settings_device;
  v_device_trusted boolean := false;
  v_device_approved boolean := false;
  v_new_device_token text;
  v_rate_settings myapp_auth_private.app_settings_rate_limit;
  v_ip_rate_limit myapp_auth_private.auth_ip_rate_limits;
  v_ip_address inet;
  v_ua_hash text;
BEGIN
  SELECT *
  FROM myapp_auth_private.app_settings_rate_limit
  LIMIT
  1 INTO v_rate_settings;
  SELECT myapp_auth_public.current_ip_address() INTO v_ip_address;
  IF v_ip_address IS NOT NULL THEN
    IF family(v_ip_address) = 6 THEN
      SELECT set_masklen(v_ip_address, 64) INTO v_ip_address;
    END IF;
    SELECT
      COALESCE(md5(myapp_auth_public.current_user_agent()), '__no_ua__') INTO v_ua_hash;
    PERFORM pg_advisory_xact_lock(hashtext('ip_rate_limit_sign_in'), hashtext(v_ip_address::text));
    IF EXISTS (SELECT 1
    FROM myapp_auth_private.auth_ip_rate_limits
    WHERE
      ((ip_address = v_ip_address AND ua_hash = ANY( ARRAY[v_ua_hash, ''] )) AND action = 'sign_in') AND locked_until > now()
    LIMIT
    1) THEN
      PERFORM errors.raise_error('TOO_MANY_REQUESTS', '{}', 'public');
    END IF;
  END IF;
  SELECT *
  FROM myapp_auth_private.app_settings_auth
  LIMIT
  1 INTO v_settings;
  IF NOT (COALESCE(v_settings.allow_password_sign_in, true)) THEN
    PERFORM errors.raise_error('PASSWORD_SIGN_IN_DISABLED', '{}', 'public');
  END IF;
  IF v_settings.allowed_auth_methods IS NOT NULL AND NOT ('password' = ANY( v_settings.allowed_auth_methods )) THEN
    PERFORM errors.raise_error('AUTH_METHOD_NOT_ALLOWED', '{}', 'public');
  END IF;
  v_default_session_duration := COALESCE(v_settings.default_session_duration, '2 weeks'::interval);
  v_remember_me_duration := COALESCE(v_settings.remember_me_duration, '30 days'::interval);
  v_require_csrf := COALESCE(v_settings.require_csrf_for_auth, false);
  IF v_require_csrf AND sign_in.csrf_token IS NULL THEN
    PERFORM errors.raise_error('CSRF_TOKEN_REQUIRED', '{}', 'public');
  END IF;
  IF sign_in.csrf_token IS NOT NULL THEN
    SELECT s.*
    FROM myapp_auth_private.sessions AS s
    WHERE
      ((s.csrf_secret = sign_in.csrf_token AND s.is_anonymous = true) AND s.revoked_at IS NULL) AND s.expires_at > now() INTO v_anon_session;
    IF NOT (FOUND) THEN
      PERFORM errors.raise_error('INVALID_CSRF_TOKEN', '{}', 'public');
    END IF;
  END IF;
  SELECT *
  FROM myapp_user_identifiers_public.emails AS user_emails_alias
  WHERE
    user_emails_alias.email = sign_in.email::email INTO v_email;
  IF NOT (FOUND) THEN
    RETURN;
  END IF;
  PERFORM pg_advisory_xact_lock(hashtext('sign_in'), hashtext(v_email.owner_id::text));
  SELECT *
  FROM myapp_auth_private.auth_rate_limits
  WHERE
    subject_id = v_email.owner_id AND action = 'sign_in' INTO v_user_rate_limit;
  IF v_user_rate_limit.locked_until IS NOT NULL AND v_user_rate_limit.locked_until > now() THEN
    PERFORM errors.raise_error('ACCOUNT_LOCKED_EXCEED_ATTEMPTS', '{}', 'public');
  END IF;
  SELECT
    membership_status.is_verified,
    membership_status.is_disabled,
    membership_status.is_banned
  FROM myapp_memberships_public.app_memberships AS membership_status
  WHERE
    membership_status.actor_id = v_email.owner_id INTO v_user_is_verified, v_user_is_disabled, v_user_is_banned;
  IF v_user_is_disabled IS TRUE OR v_user_is_banned IS TRUE THEN
    PERFORM errors.raise_error('ACCOUNT_DISABLED', '{}', 'public');
  END IF;
  IF COALESCE(v_settings.enforce_primary_auth_method, true) AND myapp_store_private.user_state_get(v_email.owner_id, 'primary_auth_method') <> 'password' THEN
    PERFORM errors.raise_error('PRIMARY_AUTH_METHOD_MISMATCH', '{}', 'public');
  END IF;
  IF myapp_store_private.user_secrets_verify(v_email.owner_id, 'password_hash', sign_in.password) THEN
    DELETE FROM myapp_auth_private.auth_rate_limits
    WHERE
      subject_id = v_email.owner_id AND action = 'sign_in';
    INSERT INTO myapp_logging_public.audit_log_auth (
      actor_id,
      event,
      success
    )
    VALUES
      (v_email.owner_id, 'sign_in', true);
    IF v_anon_session.id IS NOT NULL THEN
      UPDATE myapp_auth_private.sessions SET
      revoked_at = now()
      WHERE
        id = v_anon_session.id;
    END IF;
    SELECT *
    FROM myapp_auth_private.app_settings_device
    LIMIT
    1 INTO v_device_settings;
    IF v_device_settings.enable_device_tracking IS TRUE THEN
      IF sign_in.device_token IS NOT NULL THEN
        SELECT digest(sign_in.device_token, 'sha256') INTO v_device_token_hash;
        SELECT *
        FROM myapp_auth_private.auth_user_devices AS ud
        WHERE
          ud.user_id = v_email.owner_id AND ud.device_token_hash = v_device_token_hash INTO v_device;
        IF v_device.is_trusted IS TRUE AND v_device.trust_expires_at > now() THEN
          SELECT true INTO v_device_trusted;
        END IF;
        IF v_device.is_approved IS TRUE THEN
          SELECT true INTO v_device_approved;
        END IF;
      ELSE
        SELECT encode(gen_random_bytes(32), 'hex') INTO v_new_device_token;
        SELECT digest(v_new_device_token, 'sha256') INTO v_device_token_hash;
      END IF;
    END IF;
    IF v_device_settings.require_device_approval IS TRUE AND v_device_approved IS NOT TRUE THEN
      IF v_device.id IS NULL THEN
        INSERT INTO myapp_auth_private.auth_user_devices (
          user_id,
          device_token_hash,
          first_seen_ip,
          last_seen_ip,
          user_agent,
          origin
        )
        VALUES
          (v_email.owner_id, v_device_token_hash, v_ip_address, v_ip_address, jwt_public.current_user_agent(), jwt_public.current_origin());
      END IF;
      SELECT true INTO device_approval_required;
      SELECT v_email.owner_id INTO user_id;
      SELECT
        COALESCE(v_new_device_token, sign_in.device_token) INTO out_device_token;
      RETURN;
    END IF;
    v_csrf_secret := encode(gen_random_bytes(32), 'hex');
    v_session_id := uuidv7();
    IF sign_in.remember_me IS TRUE THEN
      v_session_expires_at := now() + v_remember_me_duration;
    ELSE
      v_session_expires_at := now() + v_default_session_duration;
    END IF;
    INSERT INTO myapp_auth_private.sessions (
      id,
      user_id,
      is_anonymous,
      expires_at,
      last_password_verified,
      auth_method,
      csrf_secret,
      origin,
      uagent
    )
    VALUES
      (v_session_id, v_email.owner_id, false, v_session_expires_at, CURRENT_TIMESTAMP, 'password', v_csrf_secret, jwt_public.current_origin(), jwt_public.current_user_agent());
    v_plaintext_credential := (CASE 
      WHEN sign_in.credential_kind = 'api_key' THEN 'cnc_live_sk_' 
      WHEN sign_in.credential_kind = 'bearer' THEN 'cnc_live_bt_' 
      WHEN sign_in.credential_kind = 'access_token' THEN 'cnc_live_at_' 
      WHEN sign_in.credential_kind = 'mfa_challenge' THEN 'cnc_live_mfa_' 
      WHEN sign_in.credential_kind = 'one_time' THEN 'cnc_live_ot_' 
      WHEN sign_in.credential_kind = 'webauthn' THEN 'cnc_live_wa_' 
      ELSE 'cnc_live_tk_' 
    END) || translate(encode(gen_random_bytes(24), 'base64'), '+/=', '-_');
    v_credential_id := uuid_generate_v5(uuid_ns_url(), v_plaintext_credential);
    INSERT INTO myapp_auth_private.session_credentials (
      id,
      session_id,
      kind,
      secret_hash,
      expires_at
    )
    VALUES
      (v_credential_id, v_session_id, sign_in.credential_kind, digest(v_plaintext_credential, 'sha256'), v_session_expires_at);
    SELECT v_credential_id INTO id;
    SELECT v_email.owner_id INTO user_id;
    SELECT v_plaintext_credential INTO access_token;
    SELECT v_session_expires_at INTO access_token_expires_at;
    SELECT v_user_is_verified INTO is_verified;
    SELECT false INTO mfa_required;
    SELECT false INTO totp_enabled;
    IF v_device_settings.enable_device_tracking IS TRUE THEN
      IF v_device.id IS NOT NULL THEN
        UPDATE myapp_auth_private.auth_user_devices AS ud SET
        last_seen_at = now(), last_seen_ip = v_ip_address, user_agent = jwt_public.current_user_agent()
        WHERE
          ud.id = v_device.id;
      ELSE
        INSERT INTO myapp_auth_private.auth_user_devices (
          user_id,
          device_token_hash,
          first_seen_ip,
          last_seen_ip,
          user_agent,
          origin
        )
        VALUES
          (v_email.owner_id, v_device_token_hash, v_ip_address, v_ip_address, jwt_public.current_user_agent(), jwt_public.current_origin());
      END IF;
    END IF;
    SELECT
      COALESCE(v_new_device_token, sign_in.device_token) INTO out_device_token;
    IF v_ip_address IS NOT NULL THEN
      DELETE FROM myapp_auth_private.auth_ip_rate_limits
      WHERE
        (ip_address = v_ip_address AND ua_hash = v_ua_hash) AND action = 'sign_in';
      DELETE FROM myapp_auth_private.auth_ip_rate_limits
      WHERE
        (ip_address = v_ip_address AND ua_hash = '') AND action = 'sign_in';
    END IF;
    RETURN;
  ELSE
    INSERT INTO myapp_logging_public.audit_log_auth (
      actor_id,
      event,
      success
    )
    VALUES
      (v_email.owner_id, 'sign_in', false);
    INSERT INTO myapp_auth_private.auth_rate_limits (
      subject_id,
      action,
      attempts,
      first_attempt_at,
      last_attempt_at,
      locked_until
    )
    VALUES
      (v_email.owner_id, 'sign_in', 1, now(), now(), NULL)
    ON CONFLICT (subject_id, action) DO UPDATE SET
    attempts = CASE 
      WHEN auth_rate_limits.first_attempt_at < (now() - v_rate_settings.login_lockout_duration) THEN 1 
      ELSE auth_rate_limits.attempts + 1 
    END, first_attempt_at = CASE 
      WHEN auth_rate_limits.first_attempt_at < (now() - v_rate_settings.login_lockout_duration) THEN now() 
      ELSE auth_rate_limits.first_attempt_at 
    END, last_attempt_at = now(), locked_until = CASE 
      WHEN (auth_rate_limits.attempts + 1) >= v_rate_settings.login_max_attempts AND auth_rate_limits.first_attempt_at >= (now() - v_rate_settings.login_lockout_duration) THEN now() + v_rate_settings.login_lockout_duration 
      ELSE NULL 
    END;
    IF v_ip_address IS NOT NULL THEN
      INSERT INTO myapp_auth_private.auth_ip_rate_limits (
        ip_address,
        ua_hash,
        action,
        attempts,
        first_attempt_at,
        locked_until
      )
      VALUES
        (v_ip_address, v_ua_hash, 'sign_in', 1, now(), NULL)
      ON CONFLICT (ip_address, ua_hash, action) DO UPDATE SET
      attempts = CASE 
        WHEN auth_ip_rate_limits.first_attempt_at < (now() - v_rate_settings.ip_rate_limit_window) THEN 1 
        ELSE auth_ip_rate_limits.attempts + 1 
      END, first_attempt_at = CASE 
        WHEN auth_ip_rate_limits.first_attempt_at < (now() - v_rate_settings.ip_rate_limit_window) THEN now() 
        ELSE auth_ip_rate_limits.first_attempt_at 
      END, locked_until = CASE 
        WHEN (auth_ip_rate_limits.attempts + 1) >= v_rate_settings.ip_ua_max_attempts AND auth_ip_rate_limits.first_attempt_at >= (now() - v_rate_settings.ip_rate_limit_window) THEN now() + v_rate_settings.ip_lockout_duration 
        ELSE NULL 
      END;
      INSERT INTO myapp_auth_private.auth_ip_rate_limits (
        ip_address,
        ua_hash,
        action,
        attempts,
        first_attempt_at,
        locked_until
      )
      VALUES
        (v_ip_address, '', 'sign_in', 1, now(), NULL)
      ON CONFLICT (ip_address, ua_hash, action) DO UPDATE SET
      attempts = CASE 
        WHEN auth_ip_rate_limits.first_attempt_at < (now() - v_rate_settings.ip_rate_limit_window) THEN 1 
        ELSE auth_ip_rate_limits.attempts + 1 
      END, first_attempt_at = CASE 
        WHEN auth_ip_rate_limits.first_attempt_at < (now() - v_rate_settings.ip_rate_limit_window) THEN now() 
        ELSE auth_ip_rate_limits.first_attempt_at 
      END, locked_until = CASE 
        WHEN (auth_ip_rate_limits.attempts + 1) >= v_rate_settings.ip_max_attempts AND auth_ip_rate_limits.first_attempt_at >= (now() - v_rate_settings.ip_rate_limit_window) THEN now() + v_rate_settings.ip_lockout_duration 
        ELSE NULL 
      END;
    END IF;
    RETURN;
  END IF;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION myapp_auth_private.sign_in_identity(
  IN service text,
  IN identifier text,
  IN details jsonb DEFAULT NULL,
  IN email text DEFAULT NULL,
  IN credential_kind text DEFAULT 'bearer',
  IN remember_me boolean DEFAULT false,
  IN device_token text DEFAULT NULL,
  OUT id uuid,
  OUT user_id uuid,
  OUT access_token text,
  OUT access_token_expires_at timestamptz,
  OUT is_verified boolean,
  OUT totp_enabled boolean,
  OUT mfa_required boolean,
  OUT mfa_challenge_token text,
  OUT out_device_token text,
  OUT device_approval_required boolean
) AS $EOFCODE$
DECLARE
  v_user_id uuid;
  v_connected myapp_user_identifiers_private.connected_accounts;
  v_settings myapp_auth_private.app_settings_auth;
  v_default_session_duration interval := '2 weeks'::interval;
  v_user_is_verified boolean := false;
  v_user_is_disabled boolean := false;
  v_user_is_banned boolean := false;
  v_session_id uuid;
  v_credential_id uuid;
  v_plaintext_credential text;
  v_csrf_secret text;
  v_session_expires_at timestamptz;
  v_mfa_enabled boolean := false;
  v_mfa_challenge_token text;
  v_user_rate_limit myapp_auth_private.auth_rate_limits;
  v_remember_me_duration interval := '30 days'::interval;
  v_device_token_hash bytea;
  v_device myapp_auth_private.auth_user_devices;
  v_device_settings myapp_auth_private.app_settings_device;
  v_device_trusted boolean := false;
  v_device_approved boolean := false;
  v_new_device_token text;
  v_rate_settings myapp_auth_private.app_settings_rate_limit;
  v_ip_rate_limit myapp_auth_private.auth_ip_rate_limits;
  v_ip_address inet;
  v_ua_hash text;
  v_existing_user_id uuid;
  v_allow_link boolean;
BEGIN
  SELECT *
  FROM myapp_auth_private.app_settings_rate_limit
  LIMIT
  1 INTO v_rate_settings;
  SELECT jwt_public.current_ip_address() INTO v_ip_address;
  IF v_ip_address IS NOT NULL THEN
    IF family(v_ip_address) = 6 THEN
      SELECT set_masklen(v_ip_address, 64) INTO v_ip_address;
    END IF;
    SELECT
      COALESCE(md5(jwt_public.current_user_agent()), '__no_ua__') INTO v_ua_hash;
    PERFORM pg_advisory_xact_lock(hashtext('ip_rate_limit_sign_in_identity'), hashtext(v_ip_address::text));
    IF EXISTS (SELECT 1
    FROM myapp_auth_private.auth_ip_rate_limits
    WHERE
      ((ip_address = v_ip_address AND ua_hash = ANY( ARRAY[v_ua_hash, ''] )) AND action = 'sign_in_identity') AND locked_until > now()
    LIMIT
    1) THEN
      PERFORM errors.raise_error('TOO_MANY_REQUESTS', '{}', 'public');
    END IF;
  END IF;
  SELECT *
  FROM myapp_auth_private.app_settings_auth
  LIMIT
  1 INTO v_settings;
  IF NOT (COALESCE(v_settings.allow_identity_sign_in, false)) THEN
    PERFORM errors.raise_error('IDENTITY_SIGN_IN_DISABLED', '{}', 'public');
  END IF;
  IF v_settings.allowed_auth_methods IS NOT NULL AND NOT ('identity' = ANY( v_settings.allowed_auth_methods )) THEN
    PERFORM errors.raise_error('AUTH_METHOD_NOT_ALLOWED', '{}', 'public');
  END IF;
  IF NOT (EXISTS (SELECT 1
  FROM myapp_auth_private.identity_providers
  WHERE
    slug = sign_in_identity.service AND enabled IS TRUE
  LIMIT
  1)) THEN
    INSERT INTO myapp_logging_public.audit_log_auth (
      actor_id,
      event,
      success
    )
    VALUES
      (NULL, 'sign_in_identity_provider_not_configured', false);
    PERFORM errors.raise_error('IDENTITY_PROVIDER_NOT_CONFIGURED', '{}', 'public');
  END IF;
  v_default_session_duration := COALESCE(v_settings.default_session_duration, '2 weeks'::interval);
  v_remember_me_duration := COALESCE(v_settings.remember_me_duration, '30 days'::interval);
  SELECT *
  FROM myapp_user_identifiers_private.connected_accounts AS ca
  WHERE
    ca.service = sign_in_identity.service AND ca.identifier = sign_in_identity.identifier INTO v_connected;
  IF v_connected.owner_id IS NOT NULL THEN
    v_user_id := v_connected.owner_id;
    UPDATE myapp_user_identifiers_private.connected_accounts AS ca SET
    is_verified = true
    WHERE
      (ca.id = v_connected.id AND ca.is_verified = false) AND (COALESCE((sign_in_identity.details->>'email_verified')::boolean, false)) = true;
    SELECT
      membership_status.is_verified,
      membership_status.is_disabled,
      membership_status.is_banned
    FROM myapp_memberships_public.app_memberships AS membership_status
    WHERE
      membership_status.actor_id = v_user_id INTO v_user_is_verified, v_user_is_disabled, v_user_is_banned;
    IF v_user_is_disabled IS TRUE OR v_user_is_banned IS TRUE THEN
      PERFORM errors.raise_error('ACCOUNT_DISABLED', '{}', 'public');
    END IF;
    IF COALESCE(v_settings.enforce_primary_auth_method, true) AND myapp_store_private.user_state_get(v_user_id, 'primary_auth_method') <> 'identity' THEN
      PERFORM errors.raise_error('PRIMARY_AUTH_METHOD_MISMATCH', '{}', 'public');
    END IF;
    INSERT INTO myapp_logging_public.audit_log_auth (
      actor_id,
      event,
      success
    )
    VALUES
      (v_user_id, 'sign_in_identity', true);
    SELECT *
    FROM myapp_auth_private.app_settings_device
    LIMIT
    1 INTO v_device_settings;
    IF v_device_settings.enable_device_tracking IS TRUE THEN
      IF sign_in_identity.device_token IS NOT NULL THEN
        SELECT digest(sign_in_identity.device_token, 'sha256') INTO v_device_token_hash;
        SELECT *
        FROM myapp_auth_private.auth_user_devices AS ud
        WHERE
          ud.user_id = v_user_id AND ud.device_token_hash = v_device_token_hash INTO v_device;
        IF v_device.is_trusted IS TRUE AND v_device.trust_expires_at > now() THEN
          SELECT true INTO v_device_trusted;
        END IF;
        IF v_device.is_approved IS TRUE THEN
          SELECT true INTO v_device_approved;
        END IF;
      ELSE
        SELECT encode(gen_random_bytes(32), 'hex') INTO v_new_device_token;
        SELECT digest(v_new_device_token, 'sha256') INTO v_device_token_hash;
      END IF;
    END IF;
    IF v_device_settings.require_device_approval IS TRUE AND v_device_approved IS NOT TRUE THEN
      IF v_device.id IS NULL THEN
        INSERT INTO myapp_auth_private.auth_user_devices (
          user_id,
          device_token_hash,
          first_seen_ip,
          last_seen_ip,
          user_agent,
          origin
        )
        VALUES
          (v_user_id, v_device_token_hash, v_ip_address, v_ip_address, jwt_public.current_user_agent(), jwt_public.current_origin());
      END IF;
      SELECT true INTO device_approval_required;
      SELECT v_user_id INTO user_id;
      SELECT
        COALESCE(v_new_device_token, sign_in_identity.device_token) INTO out_device_token;
      RETURN;
    END IF;
    v_csrf_secret := encode(gen_random_bytes(32), 'hex');
    v_session_id := uuidv7();
    IF sign_in_identity.remember_me IS TRUE THEN
      v_session_expires_at := now() + v_remember_me_duration;
    ELSE
      v_session_expires_at := now() + v_default_session_duration;
    END IF;
    INSERT INTO myapp_auth_private.sessions (
      id,
      user_id,
      is_anonymous,
      expires_at,
      last_idp_verified,
      last_mfa_verified,
      auth_method,
      csrf_secret,
      origin,
      uagent
    )
    VALUES
      (v_session_id, v_user_id, false, v_session_expires_at, CURRENT_TIMESTAMP, CASE 
          WHEN COALESCE((sign_in_identity.details->>'mfa_verified')::boolean, false) THEN CURRENT_TIMESTAMP 
        END, 'identity', v_csrf_secret, jwt_public.current_origin(), jwt_public.current_user_agent());
    v_plaintext_credential := (CASE 
      WHEN sign_in_identity.credential_kind = 'api_key' THEN 'cnc_live_sk_' 
      WHEN sign_in_identity.credential_kind = 'bearer' THEN 'cnc_live_bt_' 
      WHEN sign_in_identity.credential_kind = 'access_token' THEN 'cnc_live_at_' 
      WHEN sign_in_identity.credential_kind = 'mfa_challenge' THEN 'cnc_live_mfa_' 
      WHEN sign_in_identity.credential_kind = 'one_time' THEN 'cnc_live_ot_' 
      WHEN sign_in_identity.credential_kind = 'webauthn' THEN 'cnc_live_wa_' 
      ELSE 'cnc_live_tk_' 
    END) || translate(encode(gen_random_bytes(24), 'base64'), '+/=', '-_');
    v_credential_id := uuid_generate_v5(uuid_ns_url(), v_plaintext_credential);
    INSERT INTO myapp_auth_private.session_credentials (
      id,
      session_id,
      kind,
      secret_hash,
      expires_at
    )
    VALUES
      (v_credential_id, v_session_id, sign_in_identity.credential_kind, digest(v_plaintext_credential, 'sha256'), v_session_expires_at);
    SELECT v_credential_id INTO id;
    SELECT v_user_id INTO user_id;
    SELECT v_plaintext_credential INTO access_token;
    SELECT v_session_expires_at INTO access_token_expires_at;
    SELECT v_user_is_verified INTO is_verified;
    SELECT false INTO mfa_required;
    SELECT false INTO totp_enabled;
    IF v_device_settings.enable_device_tracking IS TRUE THEN
      IF v_device.id IS NOT NULL THEN
        UPDATE myapp_auth_private.auth_user_devices AS ud SET
        last_seen_at = now(), last_seen_ip = v_ip_address, user_agent = jwt_public.current_user_agent()
        WHERE
          ud.id = v_device.id;
      ELSE
        INSERT INTO myapp_auth_private.auth_user_devices (
          user_id,
          device_token_hash,
          first_seen_ip,
          last_seen_ip,
          user_agent,
          origin
        )
        VALUES
          (v_user_id, v_device_token_hash, v_ip_address, v_ip_address, jwt_public.current_user_agent(), jwt_public.current_origin());
      END IF;
    END IF;
    SELECT
      COALESCE(v_new_device_token, sign_in_identity.device_token) INTO out_device_token;
    RETURN;
  ELSE
    SELECT e.owner_id
    FROM myapp_user_identifiers_public.emails AS e
    WHERE
      e.email = trim(lower(sign_in_identity.details->>'email'))
    LIMIT
    1 INTO v_existing_user_id;
    SELECT ip.allow_link_by_email
    FROM myapp_auth_private.identity_providers AS ip
    WHERE
      ip.slug = sign_in_identity.service AND ip.enabled IS TRUE
    LIMIT
    1 INTO v_allow_link;
    IF v_existing_user_id IS NOT NULL AND v_allow_link IS TRUE THEN
      INSERT INTO myapp_logging_public.audit_log_auth (
        actor_id,
        event,
        success
      )
      VALUES
        (v_existing_user_id, 'sign_in_identity_link_available', true);
      PERFORM errors.raise_error('IDENTITY_LINK_AVAILABLE', '{}', 'public');
    ELSE
      INSERT INTO myapp_logging_public.audit_log_auth (
        actor_id,
        event,
        success
      )
      VALUES
        (NULL, 'sign_in_identity_not_found', false);
      PERFORM errors.raise_error('IDENTITY_ACCOUNT_NOT_FOUND', '{}', 'public');
    END IF;
  END IF;
  IF v_ip_address IS NOT NULL THEN
    DELETE FROM myapp_auth_private.auth_ip_rate_limits
    WHERE
      (ip_address = v_ip_address AND ua_hash = v_ua_hash) AND action = 'sign_in_identity';
    DELETE FROM myapp_auth_private.auth_ip_rate_limits
    WHERE
      (ip_address = v_ip_address AND ua_hash = '') AND action = 'sign_in_identity';
  END IF;
  RETURN;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION myapp_auth_private.verify_idp(
  IN service text,
  IN identifier text,
  IN details jsonb DEFAULT NULL
) RETURNS boolean AS $EOFCODE$
DECLARE
  v_user_id uuid;
  v_session_id uuid;
  v_account_linked boolean;
BEGIN
  v_user_id := jwt_public.current_user_id();
  v_session_id := jwt_private.current_session_id();
  IF v_user_id IS NULL THEN
    PERFORM errors.raise_error('NOT_AUTHENTICATED', '{}', 'public');
  END IF;
  SELECT
    EXISTS (SELECT 1
    FROM myapp_user_identifiers_private.connected_accounts AS ca
    WHERE
      (ca.service = verify_idp.service AND ca.identifier = verify_idp.identifier) AND ca.owner_id = v_user_id) INTO v_account_linked;
  IF NOT (v_account_linked IS TRUE) THEN
    PERFORM errors.raise_error('IDENTITY_ACCOUNT_NOT_FOUND', '{}', 'public');
  END IF;
  UPDATE myapp_auth_private.sessions AS sess SET
  last_idp_verified = CURRENT_TIMESTAMP, last_mfa_verified = CASE 
    WHEN COALESCE((verify_idp.details->>'mfa_verified')::boolean, false) THEN CURRENT_TIMESTAMP 
    ELSE last_mfa_verified 
  END, expires_at = expires_at + '30 minutes'::interval
  WHERE
    sess.id = v_session_id;
  INSERT INTO myapp_logging_public.audit_log_auth (
    actor_id,
    event,
    success
  )
  VALUES
    (v_user_id, 'verify_idp', true);
  RETURN true;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION myapp_auth_private.send_sms_otp(
  IN phone text
) RETURNS boolean AS $EOFCODE$
DECLARE
  v_settings myapp_auth_private.app_settings_auth;
  v_sms_otp_secret text;
  v_code text;
  v_rate_settings myapp_auth_private.app_settings_rate_limit;
  v_ip_rate_limit myapp_auth_private.auth_ip_rate_limits;
  v_ip_address inet;
  v_ua_hash text;
BEGIN
  SELECT *
  FROM myapp_auth_private.app_settings_rate_limit
  LIMIT
  1 INTO v_rate_settings;
  SELECT jwt_public.current_ip_address() INTO v_ip_address;
  IF v_ip_address IS NOT NULL THEN
    IF family(v_ip_address) = 6 THEN
      SELECT set_masklen(v_ip_address, 64) INTO v_ip_address;
    END IF;
    SELECT
      COALESCE(md5(jwt_public.current_user_agent()), '__no_ua__') INTO v_ua_hash;
    PERFORM pg_advisory_xact_lock(hashtext('ip_rate_limit_send_sms_otp'), hashtext(v_ip_address::text));
    IF EXISTS (SELECT 1
    FROM myapp_auth_private.auth_ip_rate_limits
    WHERE
      ((ip_address = v_ip_address AND ua_hash = ANY( ARRAY[v_ua_hash, ''] )) AND action = 'send_sms_otp') AND locked_until > now()
    LIMIT
    1) THEN
      PERFORM errors.raise_error('TOO_MANY_REQUESTS', '{}', 'public');
    END IF;
  END IF;
  SELECT *
  FROM myapp_auth_private.app_settings_auth
  LIMIT
  1 INTO v_settings;
  IF NOT (COALESCE(v_settings.allow_sms_sign_in, false)) THEN
    PERFORM errors.raise_error('SMS_SIGN_IN_DISABLED', '{}', 'public');
  END IF;
  v_sms_otp_secret := myapp_store_private.user_state_get(uuid_nil(), concat('sms_otp:', send_sms_otp.phone));
  IF v_sms_otp_secret IS NULL THEN
    v_sms_otp_secret := concat('\x', encode(gen_random_bytes(20), 'hex'));
    PERFORM myapp_store_private.user_state_set(uuid_nil(), concat('sms_otp:', send_sms_otp.phone), v_sms_otp_secret);
  END IF;
  v_code := totp.generate(v_sms_otp_secret, 600, 6, now(), 'sha1', 'raw');
  PERFORM app_jobs.add_job('sms:send_verification_code', json_build_object('sms_type', 'sms_otp_code', 'phone', send_sms_otp.phone, 'code', v_code));
  IF v_ip_address IS NOT NULL THEN
    DELETE FROM myapp_auth_private.auth_ip_rate_limits
    WHERE
      (ip_address = v_ip_address AND ua_hash = v_ua_hash) AND action = 'send_sms_otp';
    DELETE FROM myapp_auth_private.auth_ip_rate_limits
    WHERE
      (ip_address = v_ip_address AND ua_hash = '') AND action = 'send_sms_otp';
  END IF;
  RETURN true;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION myapp_auth_public.sign_in_sms_otp(
  IN phone text,
  IN code text,
  IN credential_kind text DEFAULT 'access_token',
  IN remember_me boolean DEFAULT false,
  IN device_token text DEFAULT NULL,
  OUT user_id uuid,
  OUT access_token text,
  OUT access_token_expires_at timestamptz,
  OUT out_device_token text,
  OUT device_approval_required boolean
) AS $EOFCODE$
DECLARE
  v_user_id uuid;
  v_settings myapp_auth_private.app_settings_auth;
  v_phone myapp_user_identifiers_public.phone_numbers;
  v_default_session_duration interval := '2 weeks'::interval;
  v_session_id uuid;
  v_credential_id uuid;
  v_plaintext_credential text;
  v_csrf_secret text;
  v_session_expires_at timestamptz;
  v_sms_otp_secret text;
  v_code_valid boolean := false;
  v_user_is_verified boolean := false;
  v_user_is_disabled boolean := false;
  v_user_is_banned boolean := false;
  v_remember_me_duration interval := '30 days'::interval;
  v_device_token_hash bytea;
  v_device myapp_auth_private.auth_user_devices;
  v_device_settings myapp_auth_private.app_settings_device;
  v_device_trusted boolean := false;
  v_device_approved boolean := false;
  v_new_device_token text;
  v_rate_settings myapp_auth_private.app_settings_rate_limit;
  v_ip_rate_limit myapp_auth_private.auth_ip_rate_limits;
  v_ip_address inet;
  v_ua_hash text;
BEGIN
  SELECT *
  FROM myapp_auth_private.app_settings_rate_limit
  LIMIT
  1 INTO v_rate_settings;
  SELECT myapp_auth_public.current_ip_address() INTO v_ip_address;
  IF v_ip_address IS NOT NULL THEN
    IF family(v_ip_address) = 6 THEN
      SELECT set_masklen(v_ip_address, 64) INTO v_ip_address;
    END IF;
    SELECT
      COALESCE(md5(myapp_auth_public.current_user_agent()), '__no_ua__') INTO v_ua_hash;
    PERFORM pg_advisory_xact_lock(hashtext('ip_rate_limit_sign_in_sms_otp'), hashtext(v_ip_address::text));
    IF EXISTS (SELECT 1
    FROM myapp_auth_private.auth_ip_rate_limits
    WHERE
      ((ip_address = v_ip_address AND ua_hash = ANY( ARRAY[v_ua_hash, ''] )) AND action = 'sign_in_sms_otp') AND locked_until > now()
    LIMIT
    1) THEN
      PERFORM errors.raise_error('TOO_MANY_REQUESTS', '{}', 'public');
    END IF;
  END IF;
  SELECT *
  FROM myapp_auth_private.app_settings_auth
  LIMIT
  1 INTO v_settings;
  IF NOT (COALESCE(v_settings.allow_sms_sign_in, false)) THEN
    PERFORM errors.raise_error('SMS_SIGN_IN_DISABLED', '{}', 'public');
  END IF;
  IF v_settings.allowed_auth_methods IS NOT NULL AND NOT ('sms' = ANY( v_settings.allowed_auth_methods )) THEN
    PERFORM errors.raise_error('AUTH_METHOD_NOT_ALLOWED', '{}', 'public');
  END IF;
  v_default_session_duration := COALESCE(v_settings.default_session_duration, '2 weeks'::interval);
  v_remember_me_duration := COALESCE(v_settings.remember_me_duration, '30 days'::interval);
  v_sms_otp_secret := myapp_store_private.user_state_get(uuid_nil(), concat('sms_otp:', sign_in_sms_otp.phone));
  IF v_sms_otp_secret IS NULL THEN
    IF v_ip_address IS NOT NULL THEN
      INSERT INTO myapp_auth_private.auth_ip_rate_limits (
        ip_address,
        ua_hash,
        action,
        attempts,
        first_attempt_at,
        locked_until
      )
      VALUES
        (v_ip_address, v_ua_hash, 'sign_in_sms_otp', 1, now(), NULL)
      ON CONFLICT (ip_address, ua_hash, action) DO UPDATE SET
      attempts = CASE 
        WHEN auth_ip_rate_limits.first_attempt_at < (now() - v_rate_settings.ip_rate_limit_window) THEN 1 
        ELSE auth_ip_rate_limits.attempts + 1 
      END, first_attempt_at = CASE 
        WHEN auth_ip_rate_limits.first_attempt_at < (now() - v_rate_settings.ip_rate_limit_window) THEN now() 
        ELSE auth_ip_rate_limits.first_attempt_at 
      END, locked_until = CASE 
        WHEN (auth_ip_rate_limits.attempts + 1) >= v_rate_settings.ip_ua_max_attempts AND auth_ip_rate_limits.first_attempt_at >= (now() - v_rate_settings.ip_rate_limit_window) THEN now() + v_rate_settings.ip_lockout_duration 
        ELSE NULL 
      END;
      INSERT INTO myapp_auth_private.auth_ip_rate_limits (
        ip_address,
        ua_hash,
        action,
        attempts,
        first_attempt_at,
        locked_until
      )
      VALUES
        (v_ip_address, '', 'sign_in_sms_otp', 1, now(), NULL)
      ON CONFLICT (ip_address, ua_hash, action) DO UPDATE SET
      attempts = CASE 
        WHEN auth_ip_rate_limits.first_attempt_at < (now() - v_rate_settings.ip_rate_limit_window) THEN 1 
        ELSE auth_ip_rate_limits.attempts + 1 
      END, first_attempt_at = CASE 
        WHEN auth_ip_rate_limits.first_attempt_at < (now() - v_rate_settings.ip_rate_limit_window) THEN now() 
        ELSE auth_ip_rate_limits.first_attempt_at 
      END, locked_until = CASE 
        WHEN (auth_ip_rate_limits.attempts + 1) >= v_rate_settings.ip_max_attempts AND auth_ip_rate_limits.first_attempt_at >= (now() - v_rate_settings.ip_rate_limit_window) THEN now() + v_rate_settings.ip_lockout_duration 
        ELSE NULL 
      END;
    END IF;
    RETURN;
  END IF;
  v_code_valid := totp.verify(v_sms_otp_secret, sign_in_sms_otp.code, 600, 6, now(), 'sha1', 'raw');
  IF NOT (COALESCE(v_code_valid, false)) THEN
    IF v_ip_address IS NOT NULL THEN
      INSERT INTO myapp_auth_private.auth_ip_rate_limits (
        ip_address,
        ua_hash,
        action,
        attempts,
        first_attempt_at,
        locked_until
      )
      VALUES
        (v_ip_address, v_ua_hash, 'sign_in_sms_otp', 1, now(), NULL)
      ON CONFLICT (ip_address, ua_hash, action) DO UPDATE SET
      attempts = CASE 
        WHEN auth_ip_rate_limits.first_attempt_at < (now() - v_rate_settings.ip_rate_limit_window) THEN 1 
        ELSE auth_ip_rate_limits.attempts + 1 
      END, first_attempt_at = CASE 
        WHEN auth_ip_rate_limits.first_attempt_at < (now() - v_rate_settings.ip_rate_limit_window) THEN now() 
        ELSE auth_ip_rate_limits.first_attempt_at 
      END, locked_until = CASE 
        WHEN (auth_ip_rate_limits.attempts + 1) >= v_rate_settings.ip_ua_max_attempts AND auth_ip_rate_limits.first_attempt_at >= (now() - v_rate_settings.ip_rate_limit_window) THEN now() + v_rate_settings.ip_lockout_duration 
        ELSE NULL 
      END;
      INSERT INTO myapp_auth_private.auth_ip_rate_limits (
        ip_address,
        ua_hash,
        action,
        attempts,
        first_attempt_at,
        locked_until
      )
      VALUES
        (v_ip_address, '', 'sign_in_sms_otp', 1, now(), NULL)
      ON CONFLICT (ip_address, ua_hash, action) DO UPDATE SET
      attempts = CASE 
        WHEN auth_ip_rate_limits.first_attempt_at < (now() - v_rate_settings.ip_rate_limit_window) THEN 1 
        ELSE auth_ip_rate_limits.attempts + 1 
      END, first_attempt_at = CASE 
        WHEN auth_ip_rate_limits.first_attempt_at < (now() - v_rate_settings.ip_rate_limit_window) THEN now() 
        ELSE auth_ip_rate_limits.first_attempt_at 
      END, locked_until = CASE 
        WHEN (auth_ip_rate_limits.attempts + 1) >= v_rate_settings.ip_max_attempts AND auth_ip_rate_limits.first_attempt_at >= (now() - v_rate_settings.ip_rate_limit_window) THEN now() + v_rate_settings.ip_lockout_duration 
        ELSE NULL 
      END;
    END IF;
    RETURN;
  END IF;
  SELECT *
  FROM myapp_user_identifiers_public.phone_numbers AS pn
  WHERE
    pn.number = sign_in_sms_otp.phone INTO v_phone;
  IF v_phone.owner_id IS NULL THEN
    PERFORM errors.raise_error('ACCOUNT_NOT_FOUND', '{}', 'public');
  END IF;
  v_user_id := v_phone.owner_id;
  SELECT
    membership_status.is_verified,
    membership_status.is_disabled,
    membership_status.is_banned
  FROM myapp_memberships_public.app_memberships AS membership_status
  WHERE
    membership_status.actor_id = v_user_id INTO v_user_is_verified, v_user_is_disabled, v_user_is_banned;
  IF v_user_is_disabled IS TRUE OR v_user_is_banned IS TRUE THEN
    PERFORM errors.raise_error('ACCOUNT_DISABLED', '{}', 'public');
  END IF;
  IF COALESCE(v_settings.enforce_primary_auth_method, true) AND myapp_store_private.user_state_get(v_user_id, 'primary_auth_method') <> 'sms' THEN
    PERFORM errors.raise_error('PRIMARY_AUTH_METHOD_MISMATCH', '{}', 'public');
  END IF;
  SELECT *
  FROM myapp_auth_private.app_settings_device
  LIMIT
  1 INTO v_device_settings;
  IF v_device_settings.enable_device_tracking IS TRUE THEN
    IF sign_in_sms_otp.device_token IS NOT NULL THEN
      SELECT digest(sign_in_sms_otp.device_token, 'sha256') INTO v_device_token_hash;
      SELECT *
      FROM myapp_auth_private.auth_user_devices AS ud
      WHERE
        ud.user_id = v_user_id AND ud.device_token_hash = v_device_token_hash INTO v_device;
      IF v_device.is_trusted IS TRUE AND v_device.trust_expires_at > now() THEN
        SELECT true INTO v_device_trusted;
      END IF;
      IF v_device.is_approved IS TRUE THEN
        SELECT true INTO v_device_approved;
      END IF;
    ELSE
      SELECT encode(gen_random_bytes(32), 'hex') INTO v_new_device_token;
      SELECT digest(v_new_device_token, 'sha256') INTO v_device_token_hash;
    END IF;
  END IF;
  IF v_device_settings.require_device_approval IS TRUE AND v_device_approved IS NOT TRUE THEN
    IF v_device.id IS NULL THEN
      INSERT INTO myapp_auth_private.auth_user_devices (
        user_id,
        device_token_hash,
        first_seen_ip,
        last_seen_ip,
        user_agent,
        origin
      )
      VALUES
        (v_user_id, v_device_token_hash, v_ip_address, v_ip_address, jwt_public.current_user_agent(), jwt_public.current_origin());
    END IF;
    SELECT true INTO device_approval_required;
    SELECT v_user_id INTO user_id;
    SELECT
      COALESCE(v_new_device_token, sign_in_sms_otp.device_token) INTO out_device_token;
    RETURN;
  END IF;
  INSERT INTO myapp_logging_public.audit_log_auth (
    actor_id,
    event,
    success
  )
  VALUES
    (v_user_id, 'sign_in_sms_otp', true);
  v_csrf_secret := encode(gen_random_bytes(32), 'hex');
  v_session_id := uuidv7();
  IF sign_in_sms_otp.remember_me IS TRUE THEN
    v_session_expires_at := now() + v_remember_me_duration;
  ELSE
    v_session_expires_at := now() + v_default_session_duration;
  END IF;
  INSERT INTO myapp_auth_private.sessions (
    id,
    user_id,
    is_anonymous,
    expires_at,
    auth_method,
    csrf_secret,
    origin,
    uagent
  )
  VALUES
    (v_session_id, v_user_id, false, v_session_expires_at, 'sms_otp', v_csrf_secret, jwt_public.current_origin(), jwt_public.current_user_agent());
  v_plaintext_credential := (CASE 
    WHEN sign_in_sms_otp.credential_kind = 'api_key' THEN 'cnc_live_sk_' 
    WHEN sign_in_sms_otp.credential_kind = 'bearer' THEN 'cnc_live_bt_' 
    WHEN sign_in_sms_otp.credential_kind = 'access_token' THEN 'cnc_live_at_' 
    WHEN sign_in_sms_otp.credential_kind = 'mfa_challenge' THEN 'cnc_live_mfa_' 
    WHEN sign_in_sms_otp.credential_kind = 'one_time' THEN 'cnc_live_ot_' 
    WHEN sign_in_sms_otp.credential_kind = 'webauthn' THEN 'cnc_live_wa_' 
    ELSE 'cnc_live_tk_' 
  END) || translate(encode(gen_random_bytes(24), 'base64'), '+/=', '-_');
  v_credential_id := uuid_generate_v5(uuid_ns_url(), v_plaintext_credential);
  INSERT INTO myapp_auth_private.session_credentials (
    id,
    session_id,
    kind,
    secret_hash,
    expires_at
  )
  VALUES
    (v_credential_id, v_session_id, sign_in_sms_otp.credential_kind, digest(v_plaintext_credential, 'sha256'), v_session_expires_at);
  SELECT v_user_id INTO user_id;
  SELECT v_plaintext_credential INTO access_token;
  SELECT v_session_expires_at INTO access_token_expires_at;
  IF v_device_settings.enable_device_tracking IS TRUE THEN
    IF v_device.id IS NOT NULL THEN
      UPDATE myapp_auth_private.auth_user_devices AS ud SET
      last_seen_at = now(), last_seen_ip = v_ip_address, user_agent = jwt_public.current_user_agent()
      WHERE
        ud.id = v_device.id;
    ELSE
      INSERT INTO myapp_auth_private.auth_user_devices (
        user_id,
        device_token_hash,
        first_seen_ip,
        last_seen_ip,
        user_agent,
        origin
      )
      VALUES
        (v_user_id, v_device_token_hash, v_ip_address, v_ip_address, jwt_public.current_user_agent(), jwt_public.current_origin());
    END IF;
  END IF;
  SELECT
    COALESCE(v_new_device_token, sign_in_sms_otp.device_token) INTO out_device_token;
  IF v_ip_address IS NOT NULL THEN
    DELETE FROM myapp_auth_private.auth_ip_rate_limits
    WHERE
      (ip_address = v_ip_address AND ua_hash = v_ua_hash) AND action = 'sign_in_sms_otp';
    DELETE FROM myapp_auth_private.auth_ip_rate_limits
    WHERE
      (ip_address = v_ip_address AND ua_hash = '') AND action = 'sign_in_sms_otp';
  END IF;
  RETURN;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION myapp_auth_public.request_cross_origin_token(
  IN email text,
  IN password text,
  IN origin origin,
  IN remember_me boolean DEFAULT false
) RETURNS text AS $EOFCODE$
DECLARE
  v_credential_id uuid;
  v_session_id uuid;
  v_ot_token text;
  v_rate_settings myapp_auth_private.app_settings_rate_limit;
  v_ip_rate_limit myapp_auth_private.auth_ip_rate_limits;
  v_ip_address inet;
  v_ua_hash text;
BEGIN
  SELECT *
  FROM myapp_auth_private.app_settings_rate_limit
  LIMIT
  1 INTO v_rate_settings;
  SELECT myapp_auth_public.current_ip_address() INTO v_ip_address;
  IF v_ip_address IS NOT NULL THEN
    IF family(v_ip_address) = 6 THEN
      SELECT set_masklen(v_ip_address, 64) INTO v_ip_address;
    END IF;
    SELECT
      COALESCE(md5(myapp_auth_public.current_user_agent()), '__no_ua__') INTO v_ua_hash;
    PERFORM pg_advisory_xact_lock(hashtext('ip_rate_limit_request_cross_origin_token'), hashtext(v_ip_address::text));
    IF EXISTS (SELECT 1
    FROM myapp_auth_private.auth_ip_rate_limits
    WHERE
      ((ip_address = v_ip_address AND ua_hash = ANY( ARRAY[v_ua_hash, ''] )) AND action = 'request_cross_origin_token') AND locked_until > now()
    LIMIT
    1) THEN
      PERFORM errors.raise_error('TOO_MANY_REQUESTS', '{}', 'public');
    END IF;
  END IF;
  SELECT si.id
  FROM myapp_auth_public.sign_in(request_cross_origin_token.email, request_cross_origin_token.password, request_cross_origin_token.remember_me) AS si INTO v_credential_id;
  IF v_credential_id IS NULL THEN
    RETURN NULL;
  END IF;
  SELECT c.session_id
  FROM myapp_auth_private.session_credentials AS c
  WHERE
    c.id = v_credential_id INTO v_session_id;
  v_ot_token := (CASE 
    WHEN 'one_time' = 'api_key' THEN 'cnc_live_sk_' 
    WHEN 'one_time' = 'bearer' THEN 'cnc_live_bt_' 
    WHEN 'one_time' = 'access_token' THEN 'cnc_live_at_' 
    WHEN 'one_time' = 'mfa_challenge' THEN 'cnc_live_mfa_' 
    WHEN 'one_time' = 'one_time' THEN 'cnc_live_ot_' 
    WHEN 'one_time' = 'webauthn' THEN 'cnc_live_wa_' 
    ELSE 'cnc_live_tk_' 
  END) || translate(encode(gen_random_bytes(24), 'base64'), '+/=', '-_');
  UPDATE myapp_auth_private.session_credentials AS c SET
  ot_token = v_ot_token
  WHERE
    c.id = v_credential_id;
  UPDATE myapp_auth_private.sessions AS s SET
  origin = request_cross_origin_token.origin
  WHERE
    s.id = v_session_id;
  RETURN lower(replace(base32.encode(v_ot_token), '=', ''));
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION myapp_auth_public.sign_in_cross_origin(
  IN token text,
  IN credential_kind text DEFAULT 'bearer',
  OUT id uuid,
  OUT user_id uuid,
  OUT access_token text,
  OUT access_token_expires_at timestamptz,
  OUT is_verified boolean,
  OUT totp_enabled boolean
) AS $EOFCODE$
DECLARE
  v_credential_id uuid;
  v_session_id uuid;
  v_user_id uuid;
  v_plaintext_credential text;
  v_expires_at timestamptz;
  v_user_is_verified boolean := false;
  v_totp_enabled boolean := false;
  v_rate_settings myapp_auth_private.app_settings_rate_limit;
  v_ip_rate_limit myapp_auth_private.auth_ip_rate_limits;
  v_ip_address inet;
  v_ua_hash text;
BEGIN
  SELECT *
  FROM myapp_auth_private.app_settings_rate_limit
  LIMIT
  1 INTO v_rate_settings;
  SELECT myapp_auth_public.current_ip_address() INTO v_ip_address;
  IF v_ip_address IS NOT NULL THEN
    IF family(v_ip_address) = 6 THEN
      SELECT set_masklen(v_ip_address, 64) INTO v_ip_address;
    END IF;
    SELECT
      COALESCE(md5(myapp_auth_public.current_user_agent()), '__no_ua__') INTO v_ua_hash;
    PERFORM pg_advisory_xact_lock(hashtext('ip_rate_limit_sign_in_cross_origin'), hashtext(v_ip_address::text));
    IF EXISTS (SELECT 1
    FROM myapp_auth_private.auth_ip_rate_limits
    WHERE
      ((ip_address = v_ip_address AND ua_hash = ANY( ARRAY[v_ua_hash, ''] )) AND action = 'sign_in_cross_origin') AND locked_until > now()
    LIMIT
    1) THEN
      PERFORM errors.raise_error('TOO_MANY_REQUESTS', '{}', 'public');
    END IF;
  END IF;
  SELECT
    c.id,
    c.session_id,
    s.user_id,
    c.expires_at
  FROM myapp_auth_private.session_credentials AS c INNER JOIN myapp_auth_private.sessions AS s ON s.id = c.session_id
  WHERE
    ((((c.ot_token = sign_in_cross_origin.token AND c.revoked_at IS NULL) AND s.revoked_at IS NULL) AND (c.expires_at IS NULL OR c.expires_at > now())) AND CASE s.uagent IS NULL 
        WHEN true THEN jwt_public.current_user_agent() IS NULL 
        ELSE s.uagent = jwt_public.current_user_agent() 
      END) AND CASE s.origin IS NULL 
        WHEN true THEN jwt_public.current_origin() IS NULL 
        ELSE s.origin = jwt_public.current_origin() 
      END INTO v_credential_id, v_session_id, v_user_id, v_expires_at;
  IF NOT (FOUND) THEN
    RETURN;
  END IF;
  v_plaintext_credential := (CASE 
    WHEN sign_in_cross_origin.credential_kind = 'api_key' THEN 'cnc_live_sk_' 
    WHEN sign_in_cross_origin.credential_kind = 'bearer' THEN 'cnc_live_bt_' 
    WHEN sign_in_cross_origin.credential_kind = 'access_token' THEN 'cnc_live_at_' 
    WHEN sign_in_cross_origin.credential_kind = 'mfa_challenge' THEN 'cnc_live_mfa_' 
    WHEN sign_in_cross_origin.credential_kind = 'one_time' THEN 'cnc_live_ot_' 
    WHEN sign_in_cross_origin.credential_kind = 'webauthn' THEN 'cnc_live_wa_' 
    ELSE 'cnc_live_tk_' 
  END) || translate(encode(gen_random_bytes(24), 'base64'), '+/=', '-_');
  UPDATE myapp_auth_private.session_credentials AS c SET
  id = uuid_generate_v5(uuid_ns_url(), v_plaintext_credential), ot_token = NULL, secret_hash = digest(v_plaintext_credential, 'sha256'), kind = sign_in_cross_origin.credential_kind
  WHERE
    c.id = v_credential_id
  RETURNING c.id INTO v_credential_id;
  SELECT mem.is_verified
  FROM myapp_memberships_public.app_memberships AS mem
  WHERE
    mem.actor_id = v_user_id INTO v_user_is_verified;
  SELECT v_credential_id INTO id;
  SELECT v_user_id INTO user_id;
  SELECT v_plaintext_credential INTO access_token;
  SELECT v_expires_at INTO access_token_expires_at;
  SELECT
    COALESCE(v_user_is_verified, false) INTO is_verified;
  SELECT false INTO totp_enabled;
  RETURN;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION myapp_auth_public.extend_token_expires(
  IN amount interval DEFAULT '30 minutes'::interval
) RETURNS TABLE (
  id uuid,
  session_id uuid,
  expires_at timestamptz
) AS $EOFCODE$
DECLARE
  v_token_id uuid;
  v_session_id uuid;
  v_credential myapp_auth_private.session_credentials;
  v_session myapp_auth_private.sessions;
BEGIN
  v_token_id := jwt_private.current_token_id();
  v_session_id := jwt_private.current_session_id();
  IF v_token_id IS NULL THEN
    RETURN;
  END IF;
  SELECT cred.*
  FROM myapp_auth_private.session_credentials AS cred
  WHERE
    (cred.id = v_token_id AND cred.revoked_at IS NULL) AND (cred.expires_at IS NULL OR EXTRACT(EPOCH FROM cred.expires_at - now()) > 0) INTO v_credential;
  IF NOT (FOUND) THEN
    RETURN;
  END IF;
  SELECT sess.*
  FROM myapp_auth_private.sessions AS sess
  WHERE
    (((sess.id = v_credential.session_id AND sess.revoked_at IS NULL) AND EXTRACT(EPOCH FROM sess.expires_at - now()) > 0) AND CASE sess.uagent IS NULL 
        WHEN true THEN jwt_public.current_user_agent() IS NULL 
        ELSE sess.uagent = jwt_public.current_user_agent() 
      END) AND CASE sess.origin IS NULL 
        WHEN true THEN jwt_public.current_origin() IS NULL 
        ELSE sess.origin = jwt_public.current_origin() 
      END INTO v_session;
  IF NOT (FOUND) THEN
    RETURN;
  END IF;
  UPDATE myapp_auth_private.session_credentials AS c SET
  expires_at = (COALESCE(c.expires_at, now())) + extend_token_expires.amount
  WHERE
    c.id = v_credential.id
  RETURNING c.id, c.session_id, c.expires_at INTO id, session_id, expires_at;
  RETURN NEXT;
END;
$EOFCODE$ LANGUAGE plpgsql STRICT SECURITY DEFINER;

CREATE FUNCTION myapp_auth_public.provision_new_user(
  IN email text,
  IN password text DEFAULT NULL,
  OUT user_id uuid
) AS $EOFCODE$
DECLARE
  v_user myapp_users_public.users;
  v_email myapp_user_identifiers_public.emails;
BEGIN
  INSERT INTO myapp_users_public.users
  VALUES
    (DEFAULT)
  RETURNING * INTO v_user;
  IF provision_new_user.email IS NOT NULL THEN
    INSERT INTO myapp_user_identifiers_public.emails (
      owner_id,
      email
    )
    VALUES
      (v_user.id, trim(provision_new_user.email))
    RETURNING * INTO v_email;
  END IF;
  IF provision_new_user.password IS NOT NULL THEN
    PERFORM myapp_store_private.user_secrets_set(v_user.id, 'password_hash', trim(provision_new_user.password), 'crypt');
  END IF;
  SELECT v_user.id INTO user_id;
  RETURN;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION myapp_auth_public.sign_up(
  IN email text,
  IN password text,
  IN remember_me boolean DEFAULT false,
  IN credential_kind text DEFAULT 'bearer',
  IN csrf_token text DEFAULT NULL,
  IN device_token text DEFAULT NULL,
  OUT id uuid,
  OUT user_id uuid,
  OUT access_token text,
  OUT access_token_expires_at timestamptz,
  OUT is_verified boolean,
  OUT totp_enabled boolean,
  OUT out_device_token text
) AS $EOFCODE$
DECLARE
  v_user myapp_users_public.users;
  v_email myapp_user_identifiers_public.emails;
  v_session_id uuid;
  v_credential_id uuid;
  v_plaintext_credential text;
  v_csrf_secret text;
  v_anon_session myapp_auth_private.sessions;
  v_session_expires_at timestamptz;
  v_settings myapp_auth_private.app_settings_auth;
  v_default_session_duration interval := '2 weeks'::interval;
  v_remember_me_duration interval := '30 days'::interval;
  v_require_csrf boolean := false;
  v_min_password_length int := 8;
  v_device_token_hash bytea;
  v_device_settings myapp_auth_private.app_settings_device;
  v_new_device_token text;
  v_rate_settings myapp_auth_private.app_settings_rate_limit;
  v_ip_rate_limit myapp_auth_private.auth_ip_rate_limits;
  v_ip_address inet;
  v_ua_hash text;
BEGIN
  SELECT *
  FROM myapp_auth_private.app_settings_rate_limit
  LIMIT
  1 INTO v_rate_settings;
  SELECT myapp_auth_public.current_ip_address() INTO v_ip_address;
  IF v_ip_address IS NOT NULL THEN
    IF family(v_ip_address) = 6 THEN
      SELECT set_masklen(v_ip_address, 64) INTO v_ip_address;
    END IF;
    SELECT
      COALESCE(md5(myapp_auth_public.current_user_agent()), '__no_ua__') INTO v_ua_hash;
    PERFORM pg_advisory_xact_lock(hashtext('ip_rate_limit_sign_up'), hashtext(v_ip_address::text));
    IF EXISTS (SELECT 1
    FROM myapp_auth_private.auth_ip_rate_limits
    WHERE
      ((ip_address = v_ip_address AND ua_hash = ANY( ARRAY[v_ua_hash, ''] )) AND action = 'sign_up') AND locked_until > now()
    LIMIT
    1) THEN
      PERFORM errors.raise_error('TOO_MANY_REQUESTS', '{}', 'public');
    END IF;
  END IF;
  SELECT *
  FROM myapp_auth_private.app_settings_auth
  LIMIT
  1 INTO v_settings;
  IF NOT (COALESCE(v_settings.allow_password_sign_up, true)) THEN
    PERFORM errors.raise_error('PASSWORD_SIGN_UP_DISABLED', '{}', 'public');
  END IF;
  IF v_settings.allowed_auth_methods IS NOT NULL AND NOT ('password' = ANY( v_settings.allowed_auth_methods )) THEN
    PERFORM errors.raise_error('AUTH_METHOD_NOT_ALLOWED', '{}', 'public');
  END IF;
  v_default_session_duration := COALESCE(v_settings.default_session_duration, '2 weeks'::interval);
  v_remember_me_duration := COALESCE(v_settings.remember_me_duration, '30 days'::interval);
  v_require_csrf := COALESCE(v_settings.require_csrf_for_auth, false);
  v_min_password_length := COALESCE(v_settings.min_password_length, 8);
  IF v_require_csrf AND sign_up.csrf_token IS NULL THEN
    PERFORM errors.raise_error('CSRF_TOKEN_REQUIRED', '{}', 'public');
  END IF;
  IF sign_up.csrf_token IS NOT NULL THEN
    SELECT s.*
    FROM myapp_auth_private.sessions AS s
    WHERE
      ((s.csrf_secret = sign_up.csrf_token AND s.is_anonymous = true) AND s.revoked_at IS NULL) AND s.expires_at > now() INTO v_anon_session;
    IF NOT (FOUND) THEN
      PERFORM errors.raise_error('INVALID_CSRF_TOKEN', '{}', 'public');
    END IF;
  END IF;
  PERFORM myapp_auth_public.check_password(sign_up.password);
  SELECT trim(sign_up.password) INTO password;
  SELECT *
  FROM myapp_user_identifiers_public.emails AS t
  WHERE
    (trim(sign_up.email))::email = t.email INTO v_email;
  IF NOT (FOUND) THEN
    INSERT INTO myapp_users_public.users
    VALUES
      (DEFAULT)
    RETURNING * INTO v_user;
    INSERT INTO myapp_user_identifiers_public.emails (
      owner_id,
      email
    )
    VALUES
      (v_user.id, trim(sign_up.email))
    RETURNING * INTO v_email;
    PERFORM myapp_store_private.user_secrets_set(v_user.id, 'password_hash', trim(sign_up.password), 'crypt');
    PERFORM myapp_store_private.user_state_set(v_user.id, 'primary_auth_method', 'password'::text);
    IF v_anon_session.id IS NOT NULL THEN
      UPDATE myapp_auth_private.sessions SET
      revoked_at = now()
      WHERE
        id = v_anon_session.id;
    END IF;
    v_csrf_secret := encode(gen_random_bytes(32), 'hex');
    v_session_id := uuidv7();
    IF sign_up.remember_me IS TRUE THEN
      v_session_expires_at := now() + v_remember_me_duration;
    ELSE
      v_session_expires_at := now() + v_default_session_duration;
    END IF;
    INSERT INTO myapp_auth_private.sessions (
      id,
      user_id,
      is_anonymous,
      expires_at,
      last_password_verified,
      csrf_secret
    )
    VALUES
      (v_session_id, v_user.id, false, v_session_expires_at, CURRENT_TIMESTAMP, v_csrf_secret);
    v_plaintext_credential := (CASE 
      WHEN sign_up.credential_kind = 'api_key' THEN 'cnc_live_sk_' 
      WHEN sign_up.credential_kind = 'bearer' THEN 'cnc_live_bt_' 
      WHEN sign_up.credential_kind = 'access_token' THEN 'cnc_live_at_' 
      WHEN sign_up.credential_kind = 'mfa_challenge' THEN 'cnc_live_mfa_' 
      WHEN sign_up.credential_kind = 'one_time' THEN 'cnc_live_ot_' 
      WHEN sign_up.credential_kind = 'webauthn' THEN 'cnc_live_wa_' 
      ELSE 'cnc_live_tk_' 
    END) || translate(encode(gen_random_bytes(24), 'base64'), '+/=', '-_');
    v_credential_id := uuid_generate_v5(uuid_ns_url(), v_plaintext_credential);
    INSERT INTO myapp_auth_private.session_credentials (
      id,
      session_id,
      kind,
      secret_hash,
      expires_at
    )
    VALUES
      (v_credential_id, v_session_id, sign_up.credential_kind, digest(v_plaintext_credential, 'sha256'), v_session_expires_at);
    SELECT v_credential_id INTO id;
    SELECT v_user.id INTO user_id;
    SELECT v_plaintext_credential INTO access_token;
    SELECT v_session_expires_at INTO access_token_expires_at;
    SELECT false INTO is_verified;
    SELECT false INTO totp_enabled;
    SELECT *
    FROM myapp_auth_private.app_settings_device
    LIMIT
    1 INTO v_device_settings;
    IF v_device_settings.enable_device_tracking IS TRUE THEN
      IF sign_up.device_token IS NOT NULL THEN
        SELECT digest(sign_up.device_token, 'sha256') INTO v_device_token_hash;
      ELSE
        SELECT encode(gen_random_bytes(32), 'hex') INTO v_new_device_token;
        SELECT digest(v_new_device_token, 'sha256') INTO v_device_token_hash;
      END IF;
      INSERT INTO myapp_auth_private.auth_user_devices (
        user_id,
        device_token_hash,
        first_seen_ip,
        last_seen_ip,
        user_agent,
        origin,
        is_approved,
        approved_at,
        approval_method
      )
      VALUES
        (v_user.id, v_device_token_hash, v_ip_address, v_ip_address, jwt_public.current_user_agent(), jwt_public.current_origin(), true, now(), 'auto');
    END IF;
    SELECT
      COALESCE(v_new_device_token, sign_up.device_token) INTO out_device_token;
    IF v_ip_address IS NOT NULL THEN
      DELETE FROM myapp_auth_private.auth_ip_rate_limits
      WHERE
        (ip_address = v_ip_address AND ua_hash = v_ua_hash) AND action = 'sign_up';
      DELETE FROM myapp_auth_private.auth_ip_rate_limits
      WHERE
        (ip_address = v_ip_address AND ua_hash = '') AND action = 'sign_up';
    END IF;
    RETURN;
  ELSE
    PERFORM errors.raise_error('ACCOUNT_EXISTS', '{}', 'public');
  END IF;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION myapp_auth_private.sign_up_identity(
  IN service text,
  IN identifier text,
  IN email text,
  IN details jsonb DEFAULT NULL,
  IN credential_kind text DEFAULT 'access_token',
  IN remember_me boolean DEFAULT false,
  IN device_token text DEFAULT NULL,
  OUT user_id uuid,
  OUT access_token text,
  OUT access_token_expires_at timestamptz,
  OUT out_device_token text
) AS $EOFCODE$
DECLARE
  v_user_id uuid;
  v_settings myapp_auth_private.app_settings_auth;
  v_email myapp_user_identifiers_public.emails;
  v_default_session_duration interval := '2 weeks'::interval;
  v_remember_me_duration interval := '30 days'::interval;
  v_session_id uuid;
  v_credential_id uuid;
  v_plaintext_credential text;
  v_csrf_secret text;
  v_session_expires_at timestamptz;
  v_device_token_hash bytea;
  v_device_settings myapp_auth_private.app_settings_device;
  v_new_device_token text;
  v_rate_settings myapp_auth_private.app_settings_rate_limit;
  v_ip_rate_limit myapp_auth_private.auth_ip_rate_limits;
  v_ip_address inet;
  v_ua_hash text;
BEGIN
  SELECT *
  FROM myapp_auth_private.app_settings_rate_limit
  LIMIT
  1 INTO v_rate_settings;
  SELECT jwt_public.current_ip_address() INTO v_ip_address;
  IF v_ip_address IS NOT NULL THEN
    IF family(v_ip_address) = 6 THEN
      SELECT set_masklen(v_ip_address, 64) INTO v_ip_address;
    END IF;
    SELECT
      COALESCE(md5(jwt_public.current_user_agent()), '__no_ua__') INTO v_ua_hash;
    PERFORM pg_advisory_xact_lock(hashtext('ip_rate_limit_sign_up_identity'), hashtext(v_ip_address::text));
    IF EXISTS (SELECT 1
    FROM myapp_auth_private.auth_ip_rate_limits
    WHERE
      ((ip_address = v_ip_address AND ua_hash = ANY( ARRAY[v_ua_hash, ''] )) AND action = 'sign_up_identity') AND locked_until > now()
    LIMIT
    1) THEN
      PERFORM errors.raise_error('TOO_MANY_REQUESTS', '{}', 'public');
    END IF;
  END IF;
  SELECT *
  FROM myapp_auth_private.app_settings_auth
  LIMIT
  1 INTO v_settings;
  IF NOT (COALESCE(v_settings.allow_sign_up, true)) THEN
    PERFORM errors.raise_error('SIGN_UP_DISABLED', '{}', 'public');
  END IF;
  IF NOT (COALESCE(v_settings.allow_identity_sign_up, false)) THEN
    PERFORM errors.raise_error('IDENTITY_SIGN_UP_DISABLED', '{}', 'public');
  END IF;
  IF v_settings.allowed_auth_methods IS NOT NULL AND NOT ('identity' = ANY( v_settings.allowed_auth_methods )) THEN
    PERFORM errors.raise_error('AUTH_METHOD_NOT_ALLOWED', '{}', 'public');
  END IF;
  v_default_session_duration := COALESCE(v_settings.default_session_duration, '2 weeks'::interval);
  v_remember_me_duration := COALESCE(v_settings.remember_me_duration, '30 days'::interval);
  SELECT *
  FROM myapp_user_identifiers_public.emails AS t
  WHERE
    trim(sign_up_identity.email) = t.email INTO v_email;
  IF v_email.owner_id IS NOT NULL THEN
    PERFORM errors.raise_error('ACCOUNT_EXISTS', '{}', 'public');
  END IF;
  v_user_id := myapp_auth_public.provision_new_user(trim(sign_up_identity.email));
  INSERT INTO myapp_user_identifiers_private.connected_accounts (
    owner_id,
    service,
    identifier,
    details,
    is_verified
  )
  VALUES
    (v_user_id, sign_up_identity.service, sign_up_identity.identifier, sign_up_identity.details, COALESCE((sign_up_identity.details->>'email_verified')::boolean, false));
  PERFORM myapp_store_private.user_state_set(v_user_id, 'primary_auth_method', 'identity'::text);
  v_csrf_secret := encode(gen_random_bytes(32), 'hex');
  v_session_id := uuidv7();
  IF sign_up_identity.remember_me IS TRUE THEN
    v_session_expires_at := now() + v_remember_me_duration;
  ELSE
    v_session_expires_at := now() + v_default_session_duration;
  END IF;
  INSERT INTO myapp_auth_private.sessions (
    id,
    user_id,
    is_anonymous,
    expires_at,
    csrf_secret,
    origin,
    uagent
  )
  VALUES
    (v_session_id, v_user_id, false, v_session_expires_at, v_csrf_secret, jwt_public.current_origin(), jwt_public.current_user_agent());
  v_plaintext_credential := (CASE 
    WHEN sign_up_identity.credential_kind = 'api_key' THEN 'cnc_live_sk_' 
    WHEN sign_up_identity.credential_kind = 'bearer' THEN 'cnc_live_bt_' 
    WHEN sign_up_identity.credential_kind = 'access_token' THEN 'cnc_live_at_' 
    WHEN sign_up_identity.credential_kind = 'mfa_challenge' THEN 'cnc_live_mfa_' 
    WHEN sign_up_identity.credential_kind = 'one_time' THEN 'cnc_live_ot_' 
    WHEN sign_up_identity.credential_kind = 'webauthn' THEN 'cnc_live_wa_' 
    ELSE 'cnc_live_tk_' 
  END) || translate(encode(gen_random_bytes(24), 'base64'), '+/=', '-_');
  v_credential_id := uuid_generate_v5(uuid_ns_url(), v_plaintext_credential);
  INSERT INTO myapp_auth_private.session_credentials (
    id,
    session_id,
    kind,
    secret_hash,
    expires_at
  )
  VALUES
    (v_credential_id, v_session_id, sign_up_identity.credential_kind, digest(v_plaintext_credential, 'sha256'), v_session_expires_at);
  SELECT v_user_id INTO user_id;
  SELECT v_plaintext_credential INTO access_token;
  SELECT v_session_expires_at INTO access_token_expires_at;
  SELECT *
  FROM myapp_auth_private.app_settings_device
  LIMIT
  1 INTO v_device_settings;
  IF v_device_settings.enable_device_tracking IS TRUE THEN
    IF sign_up_identity.device_token IS NOT NULL THEN
      SELECT digest(sign_up_identity.device_token, 'sha256') INTO v_device_token_hash;
    ELSE
      SELECT encode(gen_random_bytes(32), 'hex') INTO v_new_device_token;
      SELECT digest(v_new_device_token, 'sha256') INTO v_device_token_hash;
    END IF;
    INSERT INTO myapp_auth_private.auth_user_devices (
      user_id,
      device_token_hash,
      first_seen_ip,
      last_seen_ip,
      user_agent,
      origin,
      is_approved,
      approved_at,
      approval_method
    )
    VALUES
      (v_user_id, v_device_token_hash, v_ip_address, v_ip_address, jwt_public.current_user_agent(), jwt_public.current_origin(), true, now(), 'auto');
  END IF;
  SELECT
    COALESCE(v_new_device_token, sign_up_identity.device_token) INTO out_device_token;
  IF v_ip_address IS NOT NULL THEN
    DELETE FROM myapp_auth_private.auth_ip_rate_limits
    WHERE
      (ip_address = v_ip_address AND ua_hash = v_ua_hash) AND action = 'sign_up_identity';
    DELETE FROM myapp_auth_private.auth_ip_rate_limits
    WHERE
      (ip_address = v_ip_address AND ua_hash = '') AND action = 'sign_up_identity';
  END IF;
  RETURN;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION myapp_auth_public.sign_up_sms(
  IN phone text,
  IN code text,
  IN credential_kind text DEFAULT 'access_token',
  IN remember_me boolean DEFAULT false,
  IN device_token text DEFAULT NULL,
  OUT user_id uuid,
  OUT access_token text,
  OUT access_token_expires_at timestamptz,
  OUT out_device_token text
) AS $EOFCODE$
DECLARE
  v_user_id uuid;
  v_settings myapp_auth_private.app_settings_auth;
  v_phone myapp_user_identifiers_public.phone_numbers;
  v_default_session_duration interval := '2 weeks'::interval;
  v_remember_me_duration interval := '30 days'::interval;
  v_session_id uuid;
  v_credential_id uuid;
  v_plaintext_credential text;
  v_csrf_secret text;
  v_session_expires_at timestamptz;
  v_sms_secret text;
  v_code_valid boolean := false;
  v_device_token_hash bytea;
  v_device_settings myapp_auth_private.app_settings_device;
  v_new_device_token text;
  v_rate_settings myapp_auth_private.app_settings_rate_limit;
  v_ip_rate_limit myapp_auth_private.auth_ip_rate_limits;
  v_ip_address inet;
  v_ua_hash text;
BEGIN
  SELECT *
  FROM myapp_auth_private.app_settings_rate_limit
  LIMIT
  1 INTO v_rate_settings;
  SELECT myapp_auth_public.current_ip_address() INTO v_ip_address;
  IF v_ip_address IS NOT NULL THEN
    IF family(v_ip_address) = 6 THEN
      SELECT set_masklen(v_ip_address, 64) INTO v_ip_address;
    END IF;
    SELECT
      COALESCE(md5(myapp_auth_public.current_user_agent()), '__no_ua__') INTO v_ua_hash;
    PERFORM pg_advisory_xact_lock(hashtext('ip_rate_limit_sign_up_sms'), hashtext(v_ip_address::text));
    IF EXISTS (SELECT 1
    FROM myapp_auth_private.auth_ip_rate_limits
    WHERE
      ((ip_address = v_ip_address AND ua_hash = ANY( ARRAY[v_ua_hash, ''] )) AND action = 'sign_up_sms') AND locked_until > now()
    LIMIT
    1) THEN
      PERFORM errors.raise_error('TOO_MANY_REQUESTS', '{}', 'public');
    END IF;
  END IF;
  SELECT *
  FROM myapp_auth_private.app_settings_auth
  LIMIT
  1 INTO v_settings;
  IF NOT (COALESCE(v_settings.allow_sign_up, true)) THEN
    PERFORM errors.raise_error('SIGN_UP_DISABLED', '{}', 'public');
  END IF;
  IF NOT (COALESCE(v_settings.allow_sms_sign_up, false)) THEN
    PERFORM errors.raise_error('SMS_SIGN_UP_DISABLED', '{}', 'public');
  END IF;
  IF v_settings.allowed_auth_methods IS NOT NULL AND NOT ('sms' = ANY( v_settings.allowed_auth_methods )) THEN
    PERFORM errors.raise_error('AUTH_METHOD_NOT_ALLOWED', '{}', 'public');
  END IF;
  v_default_session_duration := COALESCE(v_settings.default_session_duration, '2 weeks'::interval);
  v_remember_me_duration := COALESCE(v_settings.remember_me_duration, '30 days'::interval);
  v_sms_secret := myapp_store_private.user_state_get(uuid_nil(), concat('sms_otp:', sign_up_sms.phone));
  IF v_sms_secret IS NULL THEN
    PERFORM errors.raise_error('INVALID_CODE', '{}', 'public');
  END IF;
  v_code_valid := totp.verify(v_sms_secret, sign_up_sms.code, 600, 6, now(), 'sha1', 'raw');
  IF NOT (COALESCE(v_code_valid, false)) THEN
    PERFORM errors.raise_error('INVALID_CODE', '{}', 'public');
  END IF;
  SELECT *
  FROM myapp_user_identifiers_public.phone_numbers AS pn
  WHERE
    pn.number = sign_up_sms.phone INTO v_phone;
  IF v_phone.owner_id IS NOT NULL THEN
    PERFORM errors.raise_error('ACCOUNT_EXISTS', '{}', 'public');
  END IF;
  v_user_id := myapp_auth_public.provision_new_user(NULL::text);
  INSERT INTO myapp_user_identifiers_public.phone_numbers (
    owner_id,
    cc,
    number
  )
  VALUES
    (v_user_id, '+', sign_up_sms.phone);
  PERFORM myapp_store_private.user_state_set(v_user_id, 'primary_auth_method', 'sms'::text);
  v_csrf_secret := encode(gen_random_bytes(32), 'hex');
  v_session_id := uuidv7();
  IF sign_up_sms.remember_me IS TRUE THEN
    v_session_expires_at := now() + v_remember_me_duration;
  ELSE
    v_session_expires_at := now() + v_default_session_duration;
  END IF;
  INSERT INTO myapp_auth_private.sessions (
    id,
    user_id,
    is_anonymous,
    expires_at,
    csrf_secret,
    origin,
    uagent
  )
  VALUES
    (v_session_id, v_user_id, false, v_session_expires_at, v_csrf_secret, jwt_public.current_origin(), jwt_public.current_user_agent());
  v_plaintext_credential := (CASE 
    WHEN sign_up_sms.credential_kind = 'api_key' THEN 'cnc_live_sk_' 
    WHEN sign_up_sms.credential_kind = 'bearer' THEN 'cnc_live_bt_' 
    WHEN sign_up_sms.credential_kind = 'access_token' THEN 'cnc_live_at_' 
    WHEN sign_up_sms.credential_kind = 'mfa_challenge' THEN 'cnc_live_mfa_' 
    WHEN sign_up_sms.credential_kind = 'one_time' THEN 'cnc_live_ot_' 
    WHEN sign_up_sms.credential_kind = 'webauthn' THEN 'cnc_live_wa_' 
    ELSE 'cnc_live_tk_' 
  END) || translate(encode(gen_random_bytes(24), 'base64'), '+/=', '-_');
  v_credential_id := uuid_generate_v5(uuid_ns_url(), v_plaintext_credential);
  INSERT INTO myapp_auth_private.session_credentials (
    id,
    session_id,
    kind,
    secret_hash,
    expires_at
  )
  VALUES
    (v_credential_id, v_session_id, sign_up_sms.credential_kind, digest(v_plaintext_credential, 'sha256'), v_session_expires_at);
  SELECT v_user_id INTO user_id;
  SELECT v_plaintext_credential INTO access_token;
  SELECT v_session_expires_at INTO access_token_expires_at;
  SELECT *
  FROM myapp_auth_private.app_settings_device
  LIMIT
  1 INTO v_device_settings;
  IF v_device_settings.enable_device_tracking IS TRUE THEN
    IF sign_up_sms.device_token IS NOT NULL THEN
      SELECT digest(sign_up_sms.device_token, 'sha256') INTO v_device_token_hash;
    ELSE
      SELECT encode(gen_random_bytes(32), 'hex') INTO v_new_device_token;
      SELECT digest(v_new_device_token, 'sha256') INTO v_device_token_hash;
    END IF;
    INSERT INTO myapp_auth_private.auth_user_devices (
      user_id,
      device_token_hash,
      first_seen_ip,
      last_seen_ip,
      user_agent,
      origin,
      is_approved,
      approved_at,
      approval_method
    )
    VALUES
      (v_user_id, v_device_token_hash, v_ip_address, v_ip_address, jwt_public.current_user_agent(), jwt_public.current_origin(), true, now(), 'auto');
  END IF;
  SELECT
    COALESCE(v_new_device_token, sign_up_sms.device_token) INTO out_device_token;
  IF v_ip_address IS NOT NULL THEN
    DELETE FROM myapp_auth_private.auth_ip_rate_limits
    WHERE
      (ip_address = v_ip_address AND ua_hash = v_ua_hash) AND action = 'sign_up_sms';
    DELETE FROM myapp_auth_private.auth_ip_rate_limits
    WHERE
      (ip_address = v_ip_address AND ua_hash = '') AND action = 'sign_up_sms';
  END IF;
  RETURN;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION myapp_auth_public.sign_out() RETURNS void AS $EOFCODE$
DECLARE
  v_session_id uuid;
BEGIN
  v_session_id := jwt_private.current_session_id();
  IF v_session_id IS NOT NULL THEN
    UPDATE myapp_auth_private.session_credentials AS cred SET
    revoked_at = now()
    WHERE
      cred.session_id = v_session_id AND cred.revoked_at IS NULL;
    UPDATE myapp_auth_private.sessions AS s SET
    revoked_at = now()
    WHERE
      s.id = v_session_id AND s.revoked_at IS NULL;
  END IF;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION myapp_auth_public.set_password(
  IN current_password text,
  IN new_password text
) RETURNS boolean AS $EOFCODE$
DECLARE
  v_user myapp_users_public.users;
  v_user_secret myapp_store_private.user_state;
  password_exists boolean;
BEGIN
  PERFORM myapp_auth_public.check_password(set_password.new_password);
  SELECT trim(set_password.new_password) INTO new_password;
  SELECT *
  FROM myapp_users_public.users AS u
  WHERE
    id = jwt_public.current_user_id() INTO v_user;
  IF NOT (FOUND) THEN
    RETURN false;
  END IF;
  SELECT
    EXISTS (SELECT 1
    FROM myapp_store_private.user_secrets
    WHERE
      owner_id = v_user.id AND name = 'password_hash') INTO password_exists;
  IF password_exists IS TRUE THEN
    IF myapp_store_private.user_secrets_verify(v_user.id, 'password_hash', set_password.current_password) = false THEN
      PERFORM errors.raise_error('INCORRECT_PASSWORD', '{}', 'public');
    END IF;
  END IF;
  INSERT INTO myapp_logging_public.audit_log_auth (
    actor_id,
    event,
    success
  )
  VALUES
    (v_user.id, 'set_password', true);
  PERFORM myapp_store_private.user_secrets_set(v_user.id, 'password_hash', set_password.new_password, 'crypt');
  RETURN true;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION myapp_auth_public.reset_password(
  IN role_id uuid,
  IN reset_token text,
  IN new_password text
) RETURNS boolean AS $EOFCODE$
DECLARE
  v_user myapp_users_public.users;
  v_user_is_verified boolean := false;
  v_user_is_disabled boolean := false;
  v_user_is_banned boolean := false;
  v_user_rate_limit myapp_auth_private.auth_rate_limits;
  v_rate_settings myapp_auth_private.app_settings_rate_limit;
  v_ip_rate_limit myapp_auth_private.auth_ip_rate_limits;
  v_ip_address inet;
  v_ua_hash text;
BEGIN
  SELECT *
  FROM myapp_auth_private.app_settings_rate_limit
  LIMIT
  1 INTO v_rate_settings;
  SELECT myapp_auth_public.current_ip_address() INTO v_ip_address;
  IF v_ip_address IS NOT NULL THEN
    IF family(v_ip_address) = 6 THEN
      SELECT set_masklen(v_ip_address, 64) INTO v_ip_address;
    END IF;
    SELECT
      COALESCE(md5(myapp_auth_public.current_user_agent()), '__no_ua__') INTO v_ua_hash;
    PERFORM pg_advisory_xact_lock(hashtext('ip_rate_limit_password_reset'), hashtext(v_ip_address::text));
    IF EXISTS (SELECT 1
    FROM myapp_auth_private.auth_ip_rate_limits
    WHERE
      ((ip_address = v_ip_address AND ua_hash = ANY( ARRAY[v_ua_hash, ''] )) AND action = 'password_reset') AND locked_until > now()
    LIMIT
    1) THEN
      PERFORM errors.raise_error('TOO_MANY_REQUESTS', '{}', 'public');
    END IF;
  END IF;
  IF (reset_password.role_id IS NULL OR reset_password.reset_token IS NULL) OR reset_password.new_password IS NULL THEN
    PERFORM errors.raise_error('NULL_VALUES_DISALLOWED', '{}', 'public');
  END IF;
  SELECT *
  FROM myapp_users_public.users AS u
  WHERE
    id = reset_password.role_id INTO v_user;
  IF NOT (FOUND) THEN
    RETURN NULL;
  END IF;
  SELECT
    membership_status.is_verified,
    membership_status.is_disabled,
    membership_status.is_banned
  FROM myapp_memberships_public.app_memberships AS membership_status
  WHERE
    membership_status.actor_id = reset_password.role_id INTO v_user_is_verified, v_user_is_disabled, v_user_is_banned;
  IF v_user_is_disabled IS TRUE OR v_user_is_banned IS TRUE THEN
    PERFORM errors.raise_error('ACCOUNT_DISABLED', '{}', 'public');
  END IF;
  PERFORM pg_advisory_xact_lock(hashtext('password_reset'), hashtext(v_user.id::text));
  SELECT *
  FROM myapp_auth_private.auth_rate_limits
  WHERE
    subject_id = v_user.id AND action = 'password_reset' INTO v_user_rate_limit;
  IF v_user_rate_limit.locked_until IS NOT NULL AND v_user_rate_limit.locked_until > now() THEN
    PERFORM errors.raise_error('PASSWORD_RESET_LOCKED_EXCEED_ATTEMPTS', '{}', 'public');
  END IF;
  IF myapp_store_private.user_secrets_verify(v_user.id, 'reset_password_token', reset_password.reset_token) THEN
    PERFORM myapp_store_private.user_secrets_set(v_user.id, 'password_hash', reset_password.new_password, 'crypt');
    DELETE FROM myapp_auth_private.auth_rate_limits
    WHERE
      subject_id = v_user.id AND action = 'sign_in';
    DELETE FROM myapp_auth_private.auth_rate_limits
    WHERE
      subject_id = v_user.id AND action = 'password_reset';
    PERFORM myapp_store_private.user_state_del(v_user.id, ARRAY['reset_password_token_generated']);
    PERFORM myapp_store_private.user_secrets_del(v_user.id, 'reset_password_token');
    INSERT INTO myapp_logging_public.audit_log_auth (
      actor_id,
      event,
      success
    )
    VALUES
      (v_user.id, 'reset_password', true);
    IF v_ip_address IS NOT NULL THEN
      DELETE FROM myapp_auth_private.auth_ip_rate_limits
      WHERE
        (ip_address = v_ip_address AND ua_hash = v_ua_hash) AND action = 'password_reset';
      DELETE FROM myapp_auth_private.auth_ip_rate_limits
      WHERE
        (ip_address = v_ip_address AND ua_hash = '') AND action = 'password_reset';
    END IF;
    RETURN true;
  ELSE
    INSERT INTO myapp_logging_public.audit_log_auth (
      actor_id,
      event,
      success
    )
    VALUES
      (v_user.id, 'reset_password', false);
    INSERT INTO myapp_auth_private.auth_rate_limits (
      subject_id,
      action,
      attempts,
      first_attempt_at,
      last_attempt_at,
      locked_until
    )
    VALUES
      (v_user.id, 'password_reset', 1, now(), now(), NULL)
    ON CONFLICT (subject_id, action) DO UPDATE SET
    attempts = CASE 
      WHEN auth_rate_limits.first_attempt_at < (now() - v_rate_settings.user_rate_limit_window) THEN 1 
      ELSE auth_rate_limits.attempts + 1 
    END, first_attempt_at = CASE 
      WHEN auth_rate_limits.first_attempt_at < (now() - v_rate_settings.user_rate_limit_window) THEN now() 
      ELSE auth_rate_limits.first_attempt_at 
    END, last_attempt_at = now(), locked_until = CASE 
      WHEN (auth_rate_limits.attempts + 1) >= v_rate_settings.user_max_attempts AND auth_rate_limits.first_attempt_at >= (now() - v_rate_settings.user_rate_limit_window) THEN now() + v_rate_settings.user_lockout_duration 
      ELSE NULL 
    END;
    IF v_ip_address IS NOT NULL THEN
      INSERT INTO myapp_auth_private.auth_ip_rate_limits (
        ip_address,
        ua_hash,
        action,
        attempts,
        first_attempt_at,
        locked_until
      )
      VALUES
        (v_ip_address, v_ua_hash, 'password_reset', 1, now(), NULL)
      ON CONFLICT (ip_address, ua_hash, action) DO UPDATE SET
      attempts = CASE 
        WHEN auth_ip_rate_limits.first_attempt_at < (now() - v_rate_settings.ip_rate_limit_window) THEN 1 
        ELSE auth_ip_rate_limits.attempts + 1 
      END, first_attempt_at = CASE 
        WHEN auth_ip_rate_limits.first_attempt_at < (now() - v_rate_settings.ip_rate_limit_window) THEN now() 
        ELSE auth_ip_rate_limits.first_attempt_at 
      END, locked_until = CASE 
        WHEN (auth_ip_rate_limits.attempts + 1) >= v_rate_settings.ip_ua_max_attempts AND auth_ip_rate_limits.first_attempt_at >= (now() - v_rate_settings.ip_rate_limit_window) THEN now() + v_rate_settings.ip_lockout_duration 
        ELSE NULL 
      END;
      INSERT INTO myapp_auth_private.auth_ip_rate_limits (
        ip_address,
        ua_hash,
        action,
        attempts,
        first_attempt_at,
        locked_until
      )
      VALUES
        (v_ip_address, '', 'password_reset', 1, now(), NULL)
      ON CONFLICT (ip_address, ua_hash, action) DO UPDATE SET
      attempts = CASE 
        WHEN auth_ip_rate_limits.first_attempt_at < (now() - v_rate_settings.ip_rate_limit_window) THEN 1 
        ELSE auth_ip_rate_limits.attempts + 1 
      END, first_attempt_at = CASE 
        WHEN auth_ip_rate_limits.first_attempt_at < (now() - v_rate_settings.ip_rate_limit_window) THEN now() 
        ELSE auth_ip_rate_limits.first_attempt_at 
      END, locked_until = CASE 
        WHEN (auth_ip_rate_limits.attempts + 1) >= v_rate_settings.ip_max_attempts AND auth_ip_rate_limits.first_attempt_at >= (now() - v_rate_settings.ip_rate_limit_window) THEN now() + v_rate_settings.ip_lockout_duration 
        ELSE NULL 
      END;
    END IF;
    RETURN false;
  END IF;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION myapp_auth_public.verify_password(
  IN password text
) RETURNS boolean AS $EOFCODE$
DECLARE
  v_session myapp_auth_private.sessions;
  v_user_id uuid;
  v_session_id uuid;
  v_user_rate_limit myapp_auth_private.auth_rate_limits;
  v_rate_settings myapp_auth_private.app_settings_rate_limit;
BEGIN
  v_user_id := jwt_public.current_user_id();
  v_session_id := jwt_private.current_session_id();
  PERFORM pg_advisory_xact_lock(hashtext('verify_password'), hashtext(v_user_id::text));
  SELECT *
  FROM myapp_auth_private.app_settings_rate_limit
  LIMIT
  1 INTO v_rate_settings;
  SELECT *
  FROM myapp_auth_private.auth_rate_limits
  WHERE
    subject_id = v_user_id AND action = 'verify_password' INTO v_user_rate_limit;
  IF v_user_rate_limit.locked_until IS NOT NULL AND v_user_rate_limit.locked_until > now() THEN
    PERFORM errors.raise_error('ACCOUNT_LOCKED_EXCEED_ATTEMPTS', '{}', 'public');
  END IF;
  IF myapp_store_private.user_secrets_verify(v_user_id, 'password_hash', verify_password.password) THEN
    DELETE FROM myapp_auth_private.auth_rate_limits
    WHERE
      subject_id = v_user_id AND action = 'verify_password';
    INSERT INTO myapp_logging_public.audit_log_auth (
      actor_id,
      event,
      success
    )
    VALUES
      (v_user_id, 'verify_password', true);
    UPDATE myapp_auth_private.sessions AS sess SET
    last_password_verified = CURRENT_TIMESTAMP, expires_at = expires_at + '30 minutes'::interval
    WHERE
      (sess.id = v_session_id AND CASE sess.uagent IS NULL 
          WHEN true THEN jwt_public.current_user_agent() IS NULL 
          ELSE sess.uagent = jwt_public.current_user_agent() 
        END) AND CASE sess.origin IS NULL 
          WHEN true THEN jwt_public.current_origin() IS NULL 
          ELSE sess.origin = jwt_public.current_origin() 
        END
    RETURNING * INTO v_session;
    RETURN true;
  ELSE
    INSERT INTO myapp_logging_public.audit_log_auth (
      actor_id,
      event,
      success
    )
    VALUES
      (v_user_id, 'verify_password', false);
    INSERT INTO myapp_auth_private.auth_rate_limits (
      subject_id,
      action,
      attempts,
      first_attempt_at,
      last_attempt_at,
      locked_until
    )
    VALUES
      (v_user_id, 'verify_password', 1, now(), now(), NULL)
    ON CONFLICT (subject_id, action) DO UPDATE SET
    attempts = CASE 
      WHEN auth_rate_limits.first_attempt_at < (now() - v_rate_settings.user_rate_limit_window) THEN 1 
      ELSE auth_rate_limits.attempts + 1 
    END, first_attempt_at = CASE 
      WHEN auth_rate_limits.first_attempt_at < (now() - v_rate_settings.user_rate_limit_window) THEN now() 
      ELSE auth_rate_limits.first_attempt_at 
    END, last_attempt_at = now(), locked_until = CASE 
      WHEN (auth_rate_limits.attempts + 1) >= v_rate_settings.user_max_attempts AND auth_rate_limits.first_attempt_at >= (now() - v_rate_settings.user_rate_limit_window) THEN now() + v_rate_settings.user_lockout_duration 
      ELSE NULL 
    END;
    RETURN NULL;
  END IF;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE STRICT SECURITY DEFINER;

CREATE FUNCTION myapp_auth_public.verify_totp(
  IN totp_value text
) RETURNS boolean AS $EOFCODE$
DECLARE
  v_session myapp_auth_private.sessions;
  totp_secret text;
  v_user_id uuid;
  v_session_id uuid;
  v_user_rate_limit myapp_auth_private.auth_rate_limits;
  v_rate_settings myapp_auth_private.app_settings_rate_limit;
BEGIN
  v_user_id := jwt_public.current_user_id();
  v_session_id := jwt_private.current_session_id();
  PERFORM pg_advisory_xact_lock(hashtext('verify_totp'), hashtext(v_user_id::text));
  SELECT *
  FROM myapp_auth_private.app_settings_rate_limit
  LIMIT
  1 INTO v_rate_settings;
  totp_secret := myapp_store_private.user_state_get(v_user_id, 'totp_secret');
  IF totp_secret IS NULL THEN
    PERFORM errors.raise_error('TOTP_NOT_ENABLED', '{}', 'public');
  END IF;
  SELECT *
  FROM myapp_auth_private.auth_rate_limits
  WHERE
    subject_id = v_user_id AND action = 'verify_totp' INTO v_user_rate_limit;
  IF v_user_rate_limit.locked_until IS NOT NULL AND v_user_rate_limit.locked_until > now() THEN
    PERFORM errors.raise_error('ACCOUNT_LOCKED_EXCEED_ATTEMPTS', '{}', 'public');
  END IF;
  IF totp.verify(totp_secret, verify_totp.totp_value, 30, 6) IS TRUE THEN
    DELETE FROM myapp_auth_private.auth_rate_limits
    WHERE
      subject_id = v_user_id AND action = 'verify_totp';
    INSERT INTO myapp_logging_public.audit_log_auth (
      actor_id,
      event,
      success
    )
    VALUES
      (v_user_id, 'verify_totp', true);
    UPDATE myapp_auth_private.sessions AS sess SET
    last_mfa_verified = CURRENT_TIMESTAMP, expires_at = expires_at + '30 minutes'::interval
    WHERE
      (sess.id = v_session_id AND CASE sess.uagent IS NULL 
          WHEN true THEN jwt_public.current_user_agent() IS NULL 
          ELSE sess.uagent = jwt_public.current_user_agent() 
        END) AND CASE sess.origin IS NULL 
          WHEN true THEN jwt_public.current_origin() IS NULL 
          ELSE sess.origin = jwt_public.current_origin() 
        END
    RETURNING * INTO v_session;
    RETURN true;
  ELSE
    INSERT INTO myapp_logging_public.audit_log_auth (
      actor_id,
      event,
      success
    )
    VALUES
      (v_user_id, 'verify_totp', false);
    INSERT INTO myapp_auth_private.auth_rate_limits (
      subject_id,
      action,
      attempts,
      first_attempt_at,
      last_attempt_at,
      locked_until
    )
    VALUES
      (v_user_id, 'verify_totp', 1, now(), now(), NULL)
    ON CONFLICT (subject_id, action) DO UPDATE SET
    attempts = CASE 
      WHEN auth_rate_limits.first_attempt_at < (now() - v_rate_settings.user_rate_limit_window) THEN 1 
      ELSE auth_rate_limits.attempts + 1 
    END, first_attempt_at = CASE 
      WHEN auth_rate_limits.first_attempt_at < (now() - v_rate_settings.user_rate_limit_window) THEN now() 
      ELSE auth_rate_limits.first_attempt_at 
    END, last_attempt_at = now(), locked_until = CASE 
      WHEN (auth_rate_limits.attempts + 1) >= v_rate_settings.user_max_attempts AND auth_rate_limits.first_attempt_at >= (now() - v_rate_settings.user_rate_limit_window) THEN now() + v_rate_settings.user_lockout_duration 
      ELSE NULL 
    END;
    RETURN NULL;
  END IF;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE STRICT SECURITY DEFINER;

CREATE FUNCTION myapp_auth_public.forgot_password(
  IN email email
) RETURNS void AS $EOFCODE$
DECLARE
  v_email myapp_user_identifiers_public.emails;
  v_user_id uuid;
  v_token text;
  v_max_duration interval := '3 days'::interval;
  v_user_is_verified boolean := false;
  v_user_is_disabled boolean := false;
  v_user_is_banned boolean := false;
  v_user_rate_limit myapp_auth_private.auth_rate_limits;
  v_rate_settings myapp_auth_private.app_settings_rate_limit;
  v_ip_rate_limit myapp_auth_private.auth_ip_rate_limits;
  v_ip_address inet;
  v_ua_hash text;
BEGIN
  SELECT *
  FROM myapp_auth_private.app_settings_rate_limit
  LIMIT
  1 INTO v_rate_settings;
  SELECT myapp_auth_public.current_ip_address() INTO v_ip_address;
  IF v_ip_address IS NOT NULL THEN
    IF family(v_ip_address) = 6 THEN
      SELECT set_masklen(v_ip_address, 64) INTO v_ip_address;
    END IF;
    SELECT
      COALESCE(md5(myapp_auth_public.current_user_agent()), '__no_ua__') INTO v_ua_hash;
    PERFORM pg_advisory_xact_lock(hashtext('ip_rate_limit_password_reset_request'), hashtext(v_ip_address::text));
    IF EXISTS (SELECT 1
    FROM myapp_auth_private.auth_ip_rate_limits
    WHERE
      ((ip_address = v_ip_address AND ua_hash = ANY( ARRAY[v_ua_hash, ''] )) AND action = 'password_reset_request') AND locked_until > now()
    LIMIT
    1) THEN
      PERFORM errors.raise_error('TOO_MANY_REQUESTS', '{}', 'public');
    END IF;
  END IF;
  SELECT *
  FROM myapp_user_identifiers_public.emails AS e
  WHERE
    e.email = forgot_password.email::email INTO v_email;
  IF NOT (FOUND) THEN
    RETURN;
  END IF;
  SELECT
    membership_status.is_verified,
    membership_status.is_disabled,
    membership_status.is_banned
  FROM myapp_memberships_public.app_memberships AS membership_status
  WHERE
    membership_status.actor_id = v_email.owner_id INTO v_user_is_verified, v_user_is_disabled, v_user_is_banned;
  IF v_user_is_banned IS TRUE OR v_user_is_disabled IS TRUE THEN
    RETURN;
  END IF;
  v_user_id := v_email.owner_id;
  SELECT *
  FROM myapp_auth_private.auth_rate_limits
  WHERE
    subject_id = v_user_id AND action = 'password_reset_request' INTO v_user_rate_limit;
  IF v_user_rate_limit.last_attempt_at IS NOT NULL AND now() < (v_user_rate_limit.last_attempt_at + v_rate_settings.email_cooldown_period) THEN
    RETURN;
  END IF;
  INSERT INTO myapp_logging_public.audit_log_auth (
    actor_id,
    event,
    success
  )
  VALUES
    (v_email.owner_id, 'forgot_password', true);
  v_token := encode(gen_random_bytes(16), 'hex');
  PERFORM myapp_store_private.user_secrets_set(v_user_id, 'reset_password_token', v_token, 'crypt');
  INSERT INTO myapp_auth_private.auth_rate_limits (
    subject_id,
    action,
    attempts,
    first_attempt_at,
    last_attempt_at
  )
  VALUES
    (v_user_id, 'password_reset_request', 0, now(), now())
  ON CONFLICT (subject_id, action) DO UPDATE SET
  last_attempt_at = now();
  PERFORM app_jobs.add_job('email:send_verification_link', json_build_object('email_type', 'forgot_password', 'user_id', v_user_id, 'email', v_email.email::text, 'reset_token', v_token));
  RETURN;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION myapp_auth_public.send_verification_email(
  IN email email
) RETURNS boolean AS $EOFCODE$
DECLARE
  v_email myapp_user_identifiers_public.emails;
  v_user_id uuid;
  v_verification_token text;
  v_verification_min_duration_between_new_tokens interval := '10 minutes'::interval;
  verification_token_name text;
  v_user_rate_limit myapp_auth_private.auth_rate_limits;
  v_rate_settings myapp_auth_private.app_settings_rate_limit;
  v_ip_rate_limit myapp_auth_private.auth_ip_rate_limits;
  v_ip_address inet;
  v_ua_hash text;
BEGIN
  SELECT *
  FROM myapp_auth_private.app_settings_rate_limit
  LIMIT
  1 INTO v_rate_settings;
  SELECT myapp_auth_public.current_ip_address() INTO v_ip_address;
  IF v_ip_address IS NOT NULL THEN
    IF family(v_ip_address) = 6 THEN
      SELECT set_masklen(v_ip_address, 64) INTO v_ip_address;
    END IF;
    SELECT
      COALESCE(md5(myapp_auth_public.current_user_agent()), '__no_ua__') INTO v_ua_hash;
    PERFORM pg_advisory_xact_lock(hashtext('ip_rate_limit_email_verification_request'), hashtext(v_ip_address::text));
    IF EXISTS (SELECT 1
    FROM myapp_auth_private.auth_ip_rate_limits
    WHERE
      ((ip_address = v_ip_address AND ua_hash = ANY( ARRAY[v_ua_hash, ''] )) AND action = 'email_verification_request') AND locked_until > now()
    LIMIT
    1) THEN
      PERFORM errors.raise_error('TOO_MANY_REQUESTS', '{}', 'public');
    END IF;
  END IF;
  SELECT *
  FROM myapp_user_identifiers_public.emails AS e
  WHERE
    e.email = send_verification_email.email INTO v_email;
  IF NOT (FOUND) THEN
    RETURN false;
  END IF;
  verification_token_name := v_email.email::text || '_verification_token';
  IF v_email.is_verified IS TRUE THEN
    DELETE FROM myapp_auth_private.auth_rate_limits
    WHERE
      subject_id = v_email.owner_id AND action = 'email_verification_request';
    PERFORM myapp_store_private.user_secrets_del(v_email.owner_id, ARRAY[verification_token_name]);
    RETURN false;
  END IF;
  v_user_id := v_email.owner_id;
  SELECT *
  FROM myapp_auth_private.auth_rate_limits
  WHERE
    subject_id = v_user_id AND action = 'email_verification_request' INTO v_user_rate_limit;
  IF v_user_rate_limit.last_attempt_at IS NOT NULL AND now() < (v_user_rate_limit.last_attempt_at + v_rate_settings.email_cooldown_period) THEN
    RETURN NULL;
  END IF;
  IF v_user_rate_limit.last_attempt_at IS NOT NULL AND now() < (v_user_rate_limit.last_attempt_at + v_verification_min_duration_between_new_tokens) THEN
    v_verification_token := myapp_store_private.user_secrets_get(v_user_id, verification_token_name, encode(gen_random_bytes(10), 'hex'));
  ELSE
    v_verification_token := encode(gen_random_bytes(10), 'hex');
  END IF;
  INSERT INTO myapp_auth_private.auth_rate_limits (
    subject_id,
    action,
    attempts,
    first_attempt_at,
    last_attempt_at
  )
  VALUES
    (v_user_id, 'email_verification_request', 0, now(), now())
  ON CONFLICT (subject_id, action) DO UPDATE SET
  last_attempt_at = now();
  INSERT INTO myapp_auth_private.auth_rate_limits (
    subject_id,
    action,
    attempts,
    first_attempt_at,
    last_attempt_at
  )
  VALUES
    (v_user_id, 'email_verification', 0, now(), now())
  ON CONFLICT (subject_id, action) DO UPDATE SET
  last_attempt_at = now();
  PERFORM myapp_store_private.user_secrets_set(v_user_id, verification_token_name, v_verification_token, 'pgp');
  PERFORM app_jobs.add_job('email:send_verification_link', json_build_object('email_type', 'email_verification', 'email_id', v_email.id, 'email', email, 'verification_token', v_verification_token));
  RETURN true;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION myapp_auth_public.verify_email(
  IN email_id uuid,
  IN token text
) RETURNS boolean AS $EOFCODE$
DECLARE
  v_email myapp_user_identifiers_public.emails;
  v_user_id uuid;
  v_verification_expires_interval interval := '3 days'::interval;
  verification_token_name text;
  v_user_rate_limit myapp_auth_private.auth_rate_limits;
  v_rate_settings myapp_auth_private.app_settings_rate_limit;
  v_ip_rate_limit myapp_auth_private.auth_ip_rate_limits;
  v_ip_address inet;
  v_ua_hash text;
BEGIN
  SELECT *
  FROM myapp_auth_private.app_settings_rate_limit
  LIMIT
  1 INTO v_rate_settings;
  SELECT myapp_auth_public.current_ip_address() INTO v_ip_address;
  IF v_ip_address IS NOT NULL THEN
    IF family(v_ip_address) = 6 THEN
      SELECT set_masklen(v_ip_address, 64) INTO v_ip_address;
    END IF;
    SELECT
      COALESCE(md5(myapp_auth_public.current_user_agent()), '__no_ua__') INTO v_ua_hash;
    PERFORM pg_advisory_xact_lock(hashtext('ip_rate_limit_email_verification'), hashtext(v_ip_address::text));
    IF EXISTS (SELECT 1
    FROM myapp_auth_private.auth_ip_rate_limits
    WHERE
      ((ip_address = v_ip_address AND ua_hash = ANY( ARRAY[v_ua_hash, ''] )) AND action = 'email_verification') AND locked_until > now()
    LIMIT
    1) THEN
      PERFORM errors.raise_error('TOO_MANY_REQUESTS', '{}', 'public');
    END IF;
  END IF;
  SELECT *
  FROM myapp_user_identifiers_public.emails AS e
  WHERE
    e.id = verify_email.email_id INTO v_email;
  IF v_email.is_verified IS TRUE THEN
    RETURN true;
  END IF;
  IF NOT (FOUND) THEN
    RETURN false;
  END IF;
  v_user_id := v_email.owner_id;
  SELECT *
  FROM myapp_auth_private.auth_rate_limits
  WHERE
    subject_id = v_user_id AND action = 'email_verification' INTO v_user_rate_limit;
  IF v_user_rate_limit.locked_until IS NOT NULL AND v_user_rate_limit.locked_until > now() THEN
    PERFORM errors.raise_error('ACCOUNT_LOCKED_EXCEED_ATTEMPTS', '{}', 'public');
  END IF;
  IF v_user_rate_limit.last_attempt_at IS NOT NULL AND (v_user_rate_limit.last_attempt_at + v_verification_expires_interval) < now() THEN
    DELETE FROM myapp_auth_private.auth_rate_limits
    WHERE
      subject_id = v_user_id AND action = 'email_verification';
    PERFORM myapp_store_private.user_secrets_del(v_user_id, verification_token_name);
    RETURN false;
  END IF;
  verification_token_name := v_email.email::text || '_verification_token';
  IF myapp_store_private.user_secrets_verify(v_user_id, verification_token_name, verify_email.token) THEN
    UPDATE myapp_user_identifiers_public.emails AS e SET
    is_verified = true
    WHERE
      e.id = verify_email.email_id;
    UPDATE myapp_memberships_public.app_memberships SET
    is_verified = true
    WHERE
      actor_id = v_user_id;
    DELETE FROM myapp_auth_private.auth_rate_limits
    WHERE
      subject_id = v_user_id AND action = 'email_verification';
    PERFORM myapp_store_private.user_secrets_del(v_user_id, verification_token_name);
    IF v_ip_address IS NOT NULL THEN
      DELETE FROM myapp_auth_private.auth_ip_rate_limits
      WHERE
        (ip_address = v_ip_address AND ua_hash = v_ua_hash) AND action = 'email_verification';
      DELETE FROM myapp_auth_private.auth_ip_rate_limits
      WHERE
        (ip_address = v_ip_address AND ua_hash = '') AND action = 'email_verification';
    END IF;
    RETURN true;
  ELSE
    INSERT INTO myapp_auth_private.auth_rate_limits (
      subject_id,
      action,
      attempts,
      first_attempt_at,
      last_attempt_at,
      locked_until
    )
    VALUES
      (v_user_id, 'email_verification', 1, now(), now(), NULL)
    ON CONFLICT (subject_id, action) DO UPDATE SET
    attempts = CASE 
      WHEN auth_rate_limits.first_attempt_at < (now() - v_rate_settings.user_rate_limit_window) THEN 1 
      ELSE auth_rate_limits.attempts + 1 
    END, first_attempt_at = CASE 
      WHEN auth_rate_limits.first_attempt_at < (now() - v_rate_settings.user_rate_limit_window) THEN now() 
      ELSE auth_rate_limits.first_attempt_at 
    END, last_attempt_at = now(), locked_until = CASE 
      WHEN (auth_rate_limits.attempts + 1) >= v_rate_settings.user_max_attempts AND auth_rate_limits.first_attempt_at >= (now() - v_rate_settings.user_rate_limit_window) THEN now() + v_rate_settings.user_lockout_duration 
      ELSE NULL 
    END;
    IF v_ip_address IS NOT NULL THEN
      INSERT INTO myapp_auth_private.auth_ip_rate_limits (
        ip_address,
        ua_hash,
        action,
        attempts,
        first_attempt_at,
        locked_until
      )
      VALUES
        (v_ip_address, v_ua_hash, 'email_verification', 1, now(), NULL)
      ON CONFLICT (ip_address, ua_hash, action) DO UPDATE SET
      attempts = CASE 
        WHEN auth_ip_rate_limits.first_attempt_at < (now() - v_rate_settings.ip_rate_limit_window) THEN 1 
        ELSE auth_ip_rate_limits.attempts + 1 
      END, first_attempt_at = CASE 
        WHEN auth_ip_rate_limits.first_attempt_at < (now() - v_rate_settings.ip_rate_limit_window) THEN now() 
        ELSE auth_ip_rate_limits.first_attempt_at 
      END, locked_until = CASE 
        WHEN (auth_ip_rate_limits.attempts + 1) >= v_rate_settings.ip_ua_max_attempts AND auth_ip_rate_limits.first_attempt_at >= (now() - v_rate_settings.ip_rate_limit_window) THEN now() + v_rate_settings.ip_lockout_duration 
        ELSE NULL 
      END;
      INSERT INTO myapp_auth_private.auth_ip_rate_limits (
        ip_address,
        ua_hash,
        action,
        attempts,
        first_attempt_at,
        locked_until
      )
      VALUES
        (v_ip_address, '', 'email_verification', 1, now(), NULL)
      ON CONFLICT (ip_address, ua_hash, action) DO UPDATE SET
      attempts = CASE 
        WHEN auth_ip_rate_limits.first_attempt_at < (now() - v_rate_settings.ip_rate_limit_window) THEN 1 
        ELSE auth_ip_rate_limits.attempts + 1 
      END, first_attempt_at = CASE 
        WHEN auth_ip_rate_limits.first_attempt_at < (now() - v_rate_settings.ip_rate_limit_window) THEN now() 
        ELSE auth_ip_rate_limits.first_attempt_at 
      END, locked_until = CASE 
        WHEN (auth_ip_rate_limits.attempts + 1) >= v_rate_settings.ip_max_attempts AND auth_ip_rate_limits.first_attempt_at >= (now() - v_rate_settings.ip_rate_limit_window) THEN now() + v_rate_settings.ip_lockout_duration 
        ELSE NULL 
      END;
    END IF;
    RETURN false;
  END IF;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION myapp_auth_public.send_account_deletion_email() RETURNS boolean AS $EOFCODE$
DECLARE
  v_email myapp_user_identifiers_public.emails;
  v_deletion_token text;
  v_user_id uuid := jwt_public.current_user_id();
  v_max_duration interval := '3 days'::interval;
  v_rate_settings myapp_auth_private.app_settings_rate_limit;
  v_user_rate_limit myapp_auth_private.auth_rate_limits;
BEGIN
  IF v_user_id IS NULL THEN
    RETURN false;
  END IF;
  SELECT *
  FROM myapp_auth_private.app_settings_rate_limit
  LIMIT
  1 INTO v_rate_settings;
  SELECT *
  FROM myapp_user_identifiers_public.emails AS e
  WHERE
    e.owner_id = v_user_id
  ORDER BY
    is_primary DESC,
    is_verified DESC
  LIMIT
  1 INTO v_email;
  IF NOT (FOUND) THEN
    RETURN false;
  END IF;
  v_user_id := v_email.owner_id;
  SELECT *
  FROM myapp_auth_private.auth_rate_limits
  WHERE
    subject_id = v_user_id AND action = 'account_deletion_request' INTO v_user_rate_limit;
  IF v_user_rate_limit.last_attempt_at IS NOT NULL AND now() < (v_user_rate_limit.last_attempt_at + v_rate_settings.email_cooldown_period) THEN
    RETURN false;
  END IF;
  v_deletion_token := encode(gen_random_bytes(16), 'hex');
  PERFORM myapp_store_private.user_secrets_set(v_user_id, 'account_deletion_token', v_deletion_token, 'crypt');
  INSERT INTO myapp_auth_private.auth_rate_limits (
    subject_id,
    action,
    attempts,
    first_attempt_at,
    last_attempt_at
  )
  VALUES
    (v_user_id, 'account_deletion_request', 0, now(), now())
  ON CONFLICT (subject_id, action) DO UPDATE SET
  last_attempt_at = now();
  INSERT INTO myapp_auth_private.auth_rate_limits (
    subject_id,
    action,
    attempts,
    first_attempt_at,
    last_attempt_at
  )
  VALUES
    (v_user_id, 'account_deletion', 0, now(), now())
  ON CONFLICT (subject_id, action) DO UPDATE SET
  last_attempt_at = now();
  PERFORM app_jobs.add_job('email:send_verification_link', json_build_object('email_type', 'account_deletion', 'user_id', v_user_id, 'email', v_email.email::text, 'account_deletion_token', v_deletion_token));
  RETURN true;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION myapp_auth_public.confirm_delete_account(
  IN user_id uuid,
  IN token text
) RETURNS boolean AS $EOFCODE$
DECLARE
  v_expires_interval interval := '3 days'::interval;
  v_user_rate_limit myapp_auth_private.auth_rate_limits;
  v_rate_settings myapp_auth_private.app_settings_rate_limit;
  v_ip_rate_limit myapp_auth_private.auth_ip_rate_limits;
  v_ip_address inet;
  v_ua_hash text;
BEGIN
  SELECT *
  FROM myapp_auth_private.app_settings_rate_limit
  LIMIT
  1 INTO v_rate_settings;
  SELECT myapp_auth_public.current_ip_address() INTO v_ip_address;
  IF v_ip_address IS NOT NULL THEN
    IF family(v_ip_address) = 6 THEN
      SELECT set_masklen(v_ip_address, 64) INTO v_ip_address;
    END IF;
    SELECT
      COALESCE(md5(myapp_auth_public.current_user_agent()), '__no_ua__') INTO v_ua_hash;
    PERFORM pg_advisory_xact_lock(hashtext('ip_rate_limit_account_deletion'), hashtext(v_ip_address::text));
    IF EXISTS (SELECT 1
    FROM myapp_auth_private.auth_ip_rate_limits
    WHERE
      ((ip_address = v_ip_address AND ua_hash = ANY( ARRAY[v_ua_hash, ''] )) AND action = 'account_deletion') AND locked_until > now()
    LIMIT
    1) THEN
      PERFORM errors.raise_error('TOO_MANY_REQUESTS', '{}', 'public');
    END IF;
  END IF;
  PERFORM pg_advisory_xact_lock(hashtext('account_deletion'), hashtext(confirm_delete_account.user_id::text));
  SELECT *
  FROM myapp_auth_private.auth_rate_limits
  WHERE
    subject_id = confirm_delete_account.user_id AND action = 'account_deletion' INTO v_user_rate_limit;
  IF v_user_rate_limit.locked_until IS NOT NULL AND v_user_rate_limit.locked_until > now() THEN
    PERFORM errors.raise_error('ACCOUNT_LOCKED_EXCEED_ATTEMPTS', '{}', 'public');
  END IF;
  IF v_user_rate_limit.last_attempt_at IS NOT NULL AND (v_user_rate_limit.last_attempt_at + v_expires_interval) < now() THEN
    DELETE FROM myapp_auth_private.auth_rate_limits
    WHERE
      subject_id = confirm_delete_account.user_id AND action = 'account_deletion';
    PERFORM myapp_store_private.user_secrets_del(confirm_delete_account.user_id, 'account_deletion_token');
    RETURN false;
  END IF;
  IF myapp_store_private.user_secrets_verify(confirm_delete_account.user_id, 'account_deletion_token', confirm_delete_account.token) THEN
    DELETE FROM myapp_auth_private.auth_rate_limits
    WHERE
      subject_id = confirm_delete_account.user_id AND action = 'account_deletion';
    PERFORM myapp_store_private.user_secrets_del(confirm_delete_account.user_id, 'account_deletion_token');
    DELETE FROM myapp_users_public.users
    WHERE
      id = confirm_delete_account.user_id;
    IF v_ip_address IS NOT NULL THEN
      DELETE FROM myapp_auth_private.auth_ip_rate_limits
      WHERE
        (ip_address = v_ip_address AND ua_hash = v_ua_hash) AND action = 'account_deletion';
      DELETE FROM myapp_auth_private.auth_ip_rate_limits
      WHERE
        (ip_address = v_ip_address AND ua_hash = '') AND action = 'account_deletion';
    END IF;
    RETURN true;
  ELSE
    INSERT INTO myapp_auth_private.auth_rate_limits (
      subject_id,
      action,
      attempts,
      first_attempt_at,
      last_attempt_at,
      locked_until
    )
    VALUES
      (confirm_delete_account.user_id, 'account_deletion', 1, now(), now(), NULL)
    ON CONFLICT (subject_id, action) DO UPDATE SET
    attempts = CASE 
      WHEN auth_rate_limits.first_attempt_at < (now() - v_rate_settings.user_rate_limit_window) THEN 1 
      ELSE auth_rate_limits.attempts + 1 
    END, first_attempt_at = CASE 
      WHEN auth_rate_limits.first_attempt_at < (now() - v_rate_settings.user_rate_limit_window) THEN now() 
      ELSE auth_rate_limits.first_attempt_at 
    END, last_attempt_at = now(), locked_until = CASE 
      WHEN (auth_rate_limits.attempts + 1) >= v_rate_settings.user_max_attempts AND auth_rate_limits.first_attempt_at >= (now() - v_rate_settings.user_rate_limit_window) THEN now() + v_rate_settings.user_lockout_duration 
      ELSE NULL 
    END;
    IF v_ip_address IS NOT NULL THEN
      INSERT INTO myapp_auth_private.auth_ip_rate_limits (
        ip_address,
        ua_hash,
        action,
        attempts,
        first_attempt_at,
        locked_until
      )
      VALUES
        (v_ip_address, v_ua_hash, 'account_deletion', 1, now(), NULL)
      ON CONFLICT (ip_address, ua_hash, action) DO UPDATE SET
      attempts = CASE 
        WHEN auth_ip_rate_limits.first_attempt_at < (now() - v_rate_settings.ip_rate_limit_window) THEN 1 
        ELSE auth_ip_rate_limits.attempts + 1 
      END, first_attempt_at = CASE 
        WHEN auth_ip_rate_limits.first_attempt_at < (now() - v_rate_settings.ip_rate_limit_window) THEN now() 
        ELSE auth_ip_rate_limits.first_attempt_at 
      END, locked_until = CASE 
        WHEN (auth_ip_rate_limits.attempts + 1) >= v_rate_settings.ip_ua_max_attempts AND auth_ip_rate_limits.first_attempt_at >= (now() - v_rate_settings.ip_rate_limit_window) THEN now() + v_rate_settings.ip_lockout_duration 
        ELSE NULL 
      END;
      INSERT INTO myapp_auth_private.auth_ip_rate_limits (
        ip_address,
        ua_hash,
        action,
        attempts,
        first_attempt_at,
        locked_until
      )
      VALUES
        (v_ip_address, '', 'account_deletion', 1, now(), NULL)
      ON CONFLICT (ip_address, ua_hash, action) DO UPDATE SET
      attempts = CASE 
        WHEN auth_ip_rate_limits.first_attempt_at < (now() - v_rate_settings.ip_rate_limit_window) THEN 1 
        ELSE auth_ip_rate_limits.attempts + 1 
      END, first_attempt_at = CASE 
        WHEN auth_ip_rate_limits.first_attempt_at < (now() - v_rate_settings.ip_rate_limit_window) THEN now() 
        ELSE auth_ip_rate_limits.first_attempt_at 
      END, locked_until = CASE 
        WHEN (auth_ip_rate_limits.attempts + 1) >= v_rate_settings.ip_max_attempts AND auth_ip_rate_limits.first_attempt_at >= (now() - v_rate_settings.ip_rate_limit_window) THEN now() + v_rate_settings.ip_lockout_duration 
        ELSE NULL 
      END;
    END IF;
    RETURN false;
  END IF;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION myapp_auth_public.create_api_key(
  IN key_name text,
  IN access_level text DEFAULT 'full_access',
  IN mfa_level text DEFAULT 'none',
  IN expires_in interval DEFAULT NULL,
  IN principal_id uuid DEFAULT NULL,
  OUT api_key text,
  OUT key_id uuid,
  OUT expires_at timestamptz
) RETURNS record AS $EOFCODE$
DECLARE
  v_user_id uuid;
  v_session_id uuid;
  v_credential_id uuid;
  v_plaintext_key text;
  v_settings myapp_auth_private.app_settings_auth;
  v_count int := 0;
  v_effective_duration interval;
  v_expires_at timestamptz;
BEGIN
  v_user_id := jwt_public.current_user_id();
  IF v_user_id IS NULL THEN
    PERFORM errors.raise_error('NOT_AUTHENTICATED', '{}', 'public');
  END IF;
  IF jwt_public.current_principal_id() <> v_user_id THEN
    PERFORM errors.raise_error('PRINCIPAL_CANNOT_CREATE_API_KEY', '{}', 'public');
  END IF;
  SELECT *
  FROM myapp_auth_private.app_settings_auth
  LIMIT
  1 INTO v_settings;
  IF NOT (COALESCE(v_settings.allow_api_keys, true)) THEN
    PERFORM errors.raise_error('API_KEYS_DISABLED', '{}', 'public');
  END IF;
  IF create_api_key.access_level <> 'full_access' AND create_api_key.access_level <> 'read_only' THEN
    PERFORM errors.raise_error('INVALID_ACCESS_LEVEL', '{}', 'public');
  END IF;
  IF create_api_key.mfa_level <> 'none' AND create_api_key.mfa_level <> 'verified' THEN
    PERFORM errors.raise_error('INVALID_MFA_LEVEL', '{}', 'public');
  END IF;
  SELECT count(*)
  FROM myapp_auth_private.session_credentials AS c INNER JOIN myapp_auth_private.sessions AS s ON c.session_id = s.id
  WHERE
    (s.user_id = v_user_id AND c.kind = 'api_key') AND c.revoked_at IS NULL INTO v_count;
  IF NOT (v_count < (COALESCE(v_settings.api_key_max_per_user, 10))) THEN
    PERFORM errors.raise_error('API_KEY_LIMIT_REACHED', '{}', 'public');
  END IF;
  IF NOT (EXISTS (SELECT 1
  FROM myapp_auth_private.sessions AS s INNER JOIN myapp_auth_private.session_credentials AS c ON c.session_id = s.id
  WHERE
    c.id = jwt_private.current_token_id() AND (((c.mfa_level = 'verified' OR s.last_password_verified > (now() - '30 minutes'::interval)) OR s.last_mfa_verified > (now() - '30 minutes'::interval)) OR s.last_idp_verified > (now() - '30 minutes'::interval)))) THEN
    PERFORM errors.raise_error('STEP_UP_REQUIRED', '{}', 'public');
  END IF;
  IF create_api_key.principal_id IS NOT NULL AND NOT (EXISTS (SELECT 1
  FROM myapp_auth_public.principals AS p
  WHERE
    (p.user_id = create_api_key.principal_id AND p.owner_id = v_user_id))) THEN
    PERFORM errors.raise_error('PRINCIPAL_NOT_OWNED', '{}', 'public');
  END IF;
  v_effective_duration := COALESCE(create_api_key.expires_in, v_settings.api_key_default_duration, '90 days'::interval);
  IF v_settings.api_key_max_duration IS NOT NULL AND v_effective_duration > v_settings.api_key_max_duration THEN
    v_effective_duration := v_settings.api_key_max_duration;
  END IF;
  v_expires_at := now() + v_effective_duration;
  v_session_id := uuidv7();
  INSERT INTO myapp_auth_private.sessions (
    id,
    user_id,
    is_anonymous,
    origin,
    expires_at
  )
  VALUES
    (v_session_id, v_user_id, false, NULL, v_expires_at);
  v_plaintext_key := (CASE 
    WHEN 'api_key' = 'api_key' THEN 'cnc_live_sk_' 
    WHEN 'api_key' = 'bearer' THEN 'cnc_live_bt_' 
    WHEN 'api_key' = 'access_token' THEN 'cnc_live_at_' 
    WHEN 'api_key' = 'mfa_challenge' THEN 'cnc_live_mfa_' 
    WHEN 'api_key' = 'one_time' THEN 'cnc_live_ot_' 
    WHEN 'api_key' = 'webauthn' THEN 'cnc_live_wa_' 
    ELSE 'cnc_live_tk_' 
  END) || translate(encode(gen_random_bytes(24), 'base64'), '+/=', '-_');
  v_credential_id := uuidv7();
  INSERT INTO myapp_auth_private.session_credentials (
    id,
    session_id,
    kind,
    secret_hash,
    mfa_level,
    access_level,
    expires_at,
    name,
    principal_id
  )
  VALUES
    (v_credential_id, v_session_id, 'api_key', digest(v_plaintext_key, 'sha256'), create_api_key.mfa_level, create_api_key.access_level, v_expires_at, create_api_key.key_name, create_api_key.principal_id);
  INSERT INTO myapp_logging_public.audit_log_auth (
    actor_id,
    event,
    success
  )
  VALUES
    (v_user_id, 'create_api_key', true);
  SELECT v_plaintext_key INTO api_key;
  SELECT v_credential_id INTO key_id;
  SELECT v_expires_at INTO expires_at;
  RETURN;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION myapp_auth_public.revoke_api_key(
  IN key_id uuid
) RETURNS boolean AS $EOFCODE$
DECLARE
  v_user_id uuid;
  v_session_id uuid;
BEGIN
  v_user_id := jwt_public.current_user_id();
  IF v_user_id IS NULL THEN
    PERFORM errors.raise_error('NOT_AUTHENTICATED', '{}', 'public');
  END IF;
  IF jwt_public.current_principal_id() <> v_user_id THEN
    PERFORM errors.raise_error('PRINCIPAL_CANNOT_REVOKE_API_KEY', '{}', 'public');
  END IF;
  SELECT sc.session_id
  FROM myapp_auth_private.session_credentials AS sc INNER JOIN myapp_auth_private.sessions AS s ON s.id = sc.session_id
  WHERE
    (sc.id = revoke_api_key.key_id AND sc.kind = 'api_key') AND s.user_id = v_user_id INTO v_session_id;
  IF v_session_id IS NULL THEN
    PERFORM errors.raise_error('API_KEY_NOT_FOUND', '{}', 'public');
  END IF;
  DELETE FROM myapp_auth_private.session_credentials
  WHERE
    id = revoke_api_key.key_id;
  DELETE FROM myapp_auth_private.sessions
  WHERE
    id = v_session_id;
  INSERT INTO myapp_logging_public.audit_log_auth (
    actor_id,
    event,
    success
  )
  VALUES
    (v_user_id, 'revoke_api_key', true);
  RETURN true;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE STRICT SECURITY DEFINER;

CREATE FUNCTION myapp_auth_public.revoke_session(
  IN session_id uuid
) RETURNS boolean AS $EOFCODE$
DECLARE
  v_user_id uuid;
  v_current_session uuid;
BEGIN
  v_user_id := jwt_public.current_user_id();
  v_current_session := jwt_private.current_session_id();
  IF v_user_id IS NULL THEN
    PERFORM errors.raise_error('NOT_AUTHENTICATED', '{}', 'public');
  END IF;
  IF revoke_session.session_id = v_current_session THEN
    PERFORM errors.raise_error('CANNOT_REVOKE_CURRENT_SESSION', '{}', 'public');
  END IF;
  DELETE FROM myapp_auth_private.session_credentials
  WHERE
    session_credentials.session_id = revoke_session.session_id;
  DELETE FROM myapp_auth_private.sessions
  WHERE
    id = revoke_session.session_id AND user_id = v_user_id;
  IF NOT (FOUND) THEN
    PERFORM errors.raise_error('SESSION_NOT_FOUND', '{}', 'public');
  END IF;
  INSERT INTO myapp_logging_public.audit_log_auth (
    actor_id,
    event,
    success
  )
  VALUES
    (v_user_id, 'revoke_session', true);
  RETURN true;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE STRICT SECURITY DEFINER;

CREATE FUNCTION myapp_auth_public.approve_device(
  IN approval_token text
) RETURNS boolean AS $EOFCODE$
DECLARE
  v_token_hash text;
  v_stored_user_id text;
  v_stored_device_hash text;
  v_created_at text;
BEGIN
  v_token_hash := encode(digest(approve_device.approval_token, 'sha256'), 'hex');
  v_stored_user_id := myapp_store_private.user_state_get(v_token_hash, 'device_approval_user_id');
  IF v_stored_user_id IS NULL THEN
    PERFORM errors.raise_error('INVALID_TOKEN', '{}', 'public');
  END IF;
  v_stored_device_hash := myapp_store_private.user_state_get(v_token_hash, 'device_approval_device_hash');
  v_created_at := myapp_store_private.user_state_get(v_token_hash, 'device_approval_created_at');
  IF v_created_at IS NOT NULL AND v_created_at::timestamptz < (now() - '15 minutes'::interval) THEN
    PERFORM myapp_store_private.user_state_del(v_token_hash, 'device_approval_user_id');
    PERFORM myapp_store_private.user_state_del(v_token_hash, 'device_approval_device_hash');
    PERFORM myapp_store_private.user_state_del(v_token_hash, 'device_approval_created_at');
    PERFORM errors.raise_error('EXPIRED_TOKEN', '{}', 'public');
  END IF;
  UPDATE myapp_auth_private.auth_user_devices AS ud SET
  is_approved = true, approved_at = now(), approval_method = 'email_link'
  WHERE
    ud.user_id = v_stored_user_id::uuid AND ud.device_token_hash = decode(v_stored_device_hash, 'hex');
  IF NOT (FOUND) THEN
    PERFORM errors.raise_error('DEVICE_NOT_FOUND', '{}', 'public');
  END IF;
  PERFORM myapp_store_private.user_state_del(v_token_hash, 'device_approval_user_id');
  PERFORM myapp_store_private.user_state_del(v_token_hash, 'device_approval_device_hash');
  PERFORM myapp_store_private.user_state_del(v_token_hash, 'device_approval_created_at');
  INSERT INTO myapp_logging_public.audit_log_auth (
    actor_id,
    event,
    success
  )
  VALUES
    (v_stored_user_id::uuid, 'approve_device', true);
  RETURN true;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE STRICT SECURITY DEFINER;

CREATE FUNCTION myapp_auth_public.disconnect_account(
  IN account_id uuid
) RETURNS boolean AS $EOFCODE$
DECLARE
  v_user_id uuid;
  v_has_password boolean;
  v_other_accounts_count int;
BEGIN
  v_user_id := jwt_public.current_user_id();
  IF v_user_id IS NULL THEN
    PERFORM errors.raise_error('NOT_AUTHENTICATED', '{}', 'public');
  END IF;
  IF NOT (EXISTS (SELECT 1
  FROM myapp_auth_private.sessions AS s INNER JOIN myapp_auth_private.session_credentials AS c ON c.session_id = s.id
  WHERE
    c.id = jwt_private.current_token_id() AND (((c.mfa_level = 'verified' OR s.last_password_verified > (now() - '30 minutes'::interval)) OR s.last_mfa_verified > (now() - '30 minutes'::interval)) OR s.last_idp_verified > (now() - '30 minutes'::interval)))) THEN
    PERFORM errors.raise_error('STEP_UP_REQUIRED', '{}', 'public');
  END IF;
  SELECT
    EXISTS (SELECT 1
    FROM myapp_store_private.user_secrets
    WHERE
      owner_id = v_user_id AND name = 'password_hash') INTO v_has_password;
  SELECT count(*)
  FROM myapp_user_identifiers_private.connected_accounts
  WHERE
    owner_id = v_user_id AND id <> disconnect_account.account_id INTO v_other_accounts_count;
  IF NOT (v_has_password) AND v_other_accounts_count = 0 THEN
    PERFORM errors.raise_error('CANNOT_DISCONNECT_LAST_AUTH_METHOD', '{}', 'public');
  END IF;
  DELETE FROM myapp_user_identifiers_private.connected_accounts
  WHERE
    id = disconnect_account.account_id AND owner_id = v_user_id;
  IF NOT (FOUND) THEN
    PERFORM errors.raise_error('CONNECTED_ACCOUNT_NOT_FOUND', '{}', 'public');
  END IF;
  INSERT INTO myapp_logging_public.audit_log_auth (
    actor_id,
    event,
    success
  )
  VALUES
    (v_user_id, 'disconnect_account', true);
  RETURN true;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE STRICT SECURITY DEFINER;

CREATE FUNCTION myapp_auth_public.link_identity(
  IN service text,
  IN identifier text,
  IN details jsonb DEFAULT NULL
) RETURNS boolean AS $EOFCODE$
DECLARE
  v_user_id uuid;
  v_already_linked boolean;
BEGIN
  v_user_id := jwt_public.current_user_id();
  IF v_user_id IS NULL THEN
    PERFORM errors.raise_error('NOT_AUTHENTICATED', '{}', 'public');
  END IF;
  IF NOT (EXISTS (SELECT 1
  FROM myapp_auth_private.sessions AS s INNER JOIN myapp_auth_private.session_credentials AS c ON c.session_id = s.id
  WHERE
    c.id = jwt_private.current_token_id() AND (((c.mfa_level = 'verified' OR s.last_password_verified > (now() - '30 minutes'::interval)) OR s.last_mfa_verified > (now() - '30 minutes'::interval)) OR s.last_idp_verified > (now() - '30 minutes'::interval)))) THEN
    PERFORM errors.raise_error('STEP_UP_REQUIRED', '{}', 'public');
  END IF;
  IF NOT (EXISTS (SELECT 1
  FROM myapp_auth_private.identity_providers
  WHERE
    slug = link_identity.service AND enabled IS TRUE
  LIMIT
  1)) THEN
    PERFORM errors.raise_error('IDENTITY_PROVIDER_NOT_CONFIGURED', '{}', 'public');
  END IF;
  SELECT
    EXISTS (SELECT 1
    FROM myapp_user_identifiers_private.connected_accounts AS ca
    WHERE
      ca.service = link_identity.service AND ca.identifier = link_identity.identifier) INTO v_already_linked;
  IF v_already_linked IS TRUE THEN
    PERFORM errors.raise_error('IDENTITY_ALREADY_LINKED', '{}', 'public');
  END IF;
  INSERT INTO myapp_user_identifiers_private.connected_accounts (
    owner_id,
    service,
    identifier,
    details,
    is_verified
  )
  VALUES
    (v_user_id, link_identity.service, link_identity.identifier, link_identity.details, COALESCE((link_identity.details->>'email_verified')::boolean, false));
  INSERT INTO myapp_logging_public.audit_log_auth (
    actor_id,
    event,
    success
  )
  VALUES
    (v_user_id, 'link_identity', true);
  RETURN true;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE STRICT SECURITY DEFINER;

CREATE FUNCTION myapp_auth_public.require_step_up(
  IN step_up_type text DEFAULT 'fresh_auth'
) RETURNS boolean AS $EOFCODE$
DECLARE
  v_user_id uuid;
  v_session_id uuid;
  v_session myapp_auth_private.sessions;
  v_credential myapp_auth_private.session_credentials;
  v_settings myapp_auth_private.app_settings_auth;
  v_step_up_window interval := '30 minutes'::interval;
BEGIN
  v_user_id := jwt_public.current_user_id();
  v_session_id := jwt_private.current_session_id();
  IF v_user_id IS NULL THEN
    PERFORM errors.raise_error('NOT_AUTHENTICATED', '{}', 'public');
  END IF;
  SELECT *
  FROM myapp_auth_private.sessions AS s
  WHERE
    s.id = v_session_id INTO v_session;
  SELECT *
  FROM myapp_auth_private.session_credentials AS sc
  WHERE
    sc.session_id = v_session_id INTO v_credential;
  IF v_credential.kind = 'api_key' AND v_credential.mfa_level = 'verified' THEN
    RETURN true;
  END IF;
  SELECT *
  FROM myapp_auth_private.app_settings_auth
  LIMIT
  1 INTO v_settings;
  v_step_up_window := COALESCE(v_settings.step_up_window, '30 minutes'::interval);
  IF require_step_up.step_up_type = 'password' THEN
    IF v_session.last_password_verified IS NULL OR v_session.last_password_verified < (now() - v_step_up_window) THEN
      PERFORM errors.raise_error('STEP_UP_REQUIRED_PASSWORD', '{}', 'public');
    END IF;
  ELSE
    IF require_step_up.step_up_type = 'mfa' THEN
      IF v_session.last_mfa_verified IS NULL OR v_session.last_mfa_verified < (now() - v_step_up_window) THEN
        PERFORM errors.raise_error('STEP_UP_REQUIRED_MFA', '{}', 'public');
      END IF;
    ELSE
      IF require_step_up.step_up_type = 'fresh_auth' OR require_step_up.step_up_type = 'password_or_mfa' THEN
        IF ((v_session.last_password_verified IS NULL OR v_session.last_password_verified < (now() - v_step_up_window)) AND (v_session.last_mfa_verified IS NULL OR v_session.last_mfa_verified < (now() - v_step_up_window))) AND (v_session.last_idp_verified IS NULL OR v_session.last_idp_verified < (now() - v_step_up_window)) THEN
          PERFORM errors.raise_error('STEP_UP_REQUIRED_FRESH_AUTH', '{}', 'public');
        END IF;
      ELSE
        PERFORM errors.raise_error('STEP_UP_INVALID_TYPE', '{}', 'public');
      END IF;
    END IF;
  END IF;
  RETURN true;
END;
$EOFCODE$ LANGUAGE plpgsql STABLE SECURITY DEFINER;

CREATE FUNCTION myapp_app_private.app_settings_auth_guard_step_up_upd_fn() RETURNS trigger AS $EOFCODE$
BEGIN
  PERFORM myapp_auth_public.require_step_up('mfa');
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql STABLE SECURITY DEFINER;

CREATE TRIGGER app_settings_auth_guard_step_up_upd_tg
  BEFORE UPDATE
  ON myapp_auth_private.app_settings_auth
  FOR EACH ROW
  WHEN ((new.step_up_window IS DISTINCT FROM old.step_up_window
    OR new.require_mfa IS DISTINCT FROM old.require_mfa
    OR new.require_csrf_for_auth IS DISTINCT FROM old.require_csrf_for_auth
    OR new.enforce_primary_auth_method IS DISTINCT FROM old.enforce_primary_auth_method
    OR new.allowed_auth_methods IS DISTINCT FROM old.allowed_auth_methods
    OR new.min_password_length IS DISTINCT FROM old.min_password_length
    OR new.allow_sign_up IS DISTINCT FROM old.allow_sign_up
    OR new.allow_password_sign_in IS DISTINCT FROM old.allow_password_sign_in
    OR new.allow_identity_sign_in IS DISTINCT FROM old.allow_identity_sign_in
    OR new.allow_magic_link_sign_in IS DISTINCT FROM old.allow_magic_link_sign_in
    OR new.allow_email_otp_sign_in IS DISTINCT FROM old.allow_email_otp_sign_in
    OR new.allow_sms_sign_in IS DISTINCT FROM old.allow_sms_sign_in
    OR new.allow_webauthn_sign_in IS DISTINCT FROM old.allow_webauthn_sign_in
    OR new.allow_webauthn_usernameless IS DISTINCT FROM old.allow_webauthn_usernameless
    OR new.allow_anonymous_sessions IS DISTINCT FROM old.allow_anonymous_sessions
    OR new.allow_cross_origin_token IS DISTINCT FROM old.allow_cross_origin_token
    OR new.allow_api_keys IS DISTINCT FROM old.allow_api_keys
    OR new.allow_totp_mfa IS DISTINCT FROM old.allow_totp_mfa
    OR new.allow_email_mfa IS DISTINCT FROM old.allow_email_mfa
    OR new.allow_sms_mfa IS DISTINCT FROM old.allow_sms_mfa
    OR new.allow_backup_codes IS DISTINCT FROM old.allow_backup_codes
    OR new.allowed_origins IS DISTINCT FROM old.allowed_origins
    OR new.cookie_secure IS DISTINCT FROM old.cookie_secure
    OR new.cookie_samesite IS DISTINCT FROM old.cookie_samesite
    OR new.enable_captcha IS DISTINCT FROM old.enable_captcha
    OR new.oauth_require_verified_email IS DISTINCT FROM old.oauth_require_verified_email)
    AND old.created_at < (now() - '6 hours'::interval))
  EXECUTE PROCEDURE myapp_app_private.app_settings_auth_guard_step_up_upd_fn();

COMMENT ON TABLE myapp_auth_private.app_settings_auth IS '@has_guard
Singleton configuration table for authentication settings including session durations, lockout policy, and password requirements';

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.step_up_window IS '@has_guard
How long a password or MFA re-verification remains valid for step-up authentication';

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.require_mfa IS '@has_guard
Whether all users are required to set up MFA';

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.require_csrf_for_auth IS '@has_guard
Whether to enforce CSRF token validation on sign_in and sign_up endpoints';

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.enforce_primary_auth_method IS '@has_guard
When true, users can only sign in with their primary auth method (set on first sign-up). When false, any linked method can create sessions.';

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.allowed_auth_methods IS '@has_guard
Array of allowed auth methods (e.g. password, identity, magic_link, sms, email_otp). NULL means all methods are allowed.';

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.min_password_length IS '@has_guard
Minimum number of characters required for user passwords';

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.allow_sign_up IS '@has_guard
Master switch: whether new user registration is allowed';

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.allow_password_sign_in IS '@has_guard
Whether email plus password sign-in is allowed';

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.allow_identity_sign_in IS '@has_guard
Whether identity sign-in is allowed';

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.allow_magic_link_sign_in IS '@has_guard
Whether passwordless magic link sign-in is allowed';

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.allow_email_otp_sign_in IS '@has_guard
Whether passwordless email OTP sign-in is allowed';

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.allow_sms_sign_in IS '@has_guard
Whether passwordless SMS OTP sign-in is allowed';

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.allow_webauthn_sign_in IS '@has_guard
Whether WebAuthn / passkey sign-in is allowed';

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.allow_webauthn_usernameless IS '@has_guard
Whether usernameless / conditional-UI passkey sign-in is allowed (discoverable credentials)';

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.allow_anonymous_sessions IS '@has_guard
Whether to allow anonymous sessions (useful for CSRF protection and shopping carts)';

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.allow_cross_origin_token IS '@has_guard
Whether cross-origin session handoff tokens are allowed';

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.allow_api_keys IS '@has_guard
Whether API key creation is allowed';

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.allow_totp_mfa IS '@has_guard
Whether TOTP authenticator app MFA is allowed';

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.allow_email_mfa IS '@has_guard
Whether email code MFA is allowed';

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.allow_sms_mfa IS '@has_guard
Whether SMS code MFA is allowed';

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.allow_backup_codes IS '@has_guard
Whether backup code generation is allowed';

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.allowed_origins IS '@has_guard
Array of allowed CORS origins for API requests; NULL means allow all';

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.cookie_secure IS '@has_guard
Whether the auth cookie should be sent only over HTTPS (Secure flag)';

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.cookie_samesite IS '@has_guard
SameSite attribute for the auth cookie: strict, lax, or none';

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.enable_captcha IS '@has_guard
Whether CAPTCHA verification is required on sign-up and password-reset endpoints';

COMMENT ON COLUMN myapp_auth_private.app_settings_auth.oauth_require_verified_email IS '@has_guard
Whether to reject OAuth sign-up when the identity provider reports the email as unverified; defends against shadow account attacks';

CREATE FUNCTION myapp_app_private.app_settings_auth_guard_step_up_del_fn() RETURNS trigger AS $EOFCODE$
BEGIN
  PERFORM myapp_auth_public.require_step_up('mfa');
  RETURN OLD;
END;
$EOFCODE$ LANGUAGE plpgsql STABLE SECURITY DEFINER;

CREATE TRIGGER app_settings_auth_guard_step_up_del_tg
  BEFORE DELETE
  ON myapp_auth_private.app_settings_auth
  FOR EACH ROW
  WHEN (old.created_at < (now() - '6 hours'::interval))
  EXECUTE PROCEDURE myapp_app_private.app_settings_auth_guard_step_up_del_fn();

CREATE FUNCTION myapp_app_private.identity_providers_guard_step_up_upd_fn() RETURNS trigger AS $EOFCODE$
BEGIN
  PERFORM myapp_auth_public.require_step_up('mfa');
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql STABLE SECURITY DEFINER;

CREATE TRIGGER identity_providers_guard_step_up_upd_tg
  BEFORE UPDATE
  ON myapp_auth_private.identity_providers
  FOR EACH ROW
  WHEN ((new.slug IS DISTINCT FROM old.slug
    OR new.kind IS DISTINCT FROM old.kind
    OR new.enabled IS DISTINCT FROM old.enabled
    OR new.issuer_url IS DISTINCT FROM old.issuer_url
    OR new.discovery_url_override IS DISTINCT FROM old.discovery_url_override
    OR new.authorization_url IS DISTINCT FROM old.authorization_url
    OR new.token_url IS DISTINCT FROM old.token_url
    OR new.userinfo_url IS DISTINCT FROM old.userinfo_url
    OR new.client_id IS DISTINCT FROM old.client_id
    OR new.client_secret_id IS DISTINCT FROM old.client_secret_id
    OR new.acceptable_client_ids IS DISTINCT FROM old.acceptable_client_ids
    OR new.scopes IS DISTINCT FROM old.scopes
    OR new.extra_authorization_params IS DISTINCT FROM old.extra_authorization_params
    OR new.email_optional IS DISTINCT FROM old.email_optional
    OR new.allow_link_by_email IS DISTINCT FROM old.allow_link_by_email
    OR new.skip_nonce_check IS DISTINCT FROM old.skip_nonce_check
    OR new.pkce_enabled IS DISTINCT FROM old.pkce_enabled)
    AND old.created_at < (now() - '6 hours'::interval))
  EXECUTE PROCEDURE myapp_app_private.identity_providers_guard_step_up_upd_fn();

COMMENT ON TABLE myapp_auth_private.identity_providers IS '@has_guard
OAuth2 / OIDC (and future SAML) identity provider definitions per database. Holds endpoint URLs, encrypted client secret reference, scopes, audience validation list, PKCE setting, and email-handling flags. Cached OIDC discovery_doc + JWKS are refreshed by background jobs. All writes go through SECURITY DEFINER admin procedures.';

COMMENT ON COLUMN myapp_auth_private.identity_providers.slug IS '@has_guard
Stable identifier (e.g. ''google'', ''github'', ''custom:acme-okta''). Used as connected_accounts.service value. Custom providers must use the custom:<slug> namespace; format ^[a-z0-9][a-z0-9_-]{0,30}[a-z0-9]$ enforced by admin procedure.';

COMMENT ON COLUMN myapp_auth_private.identity_providers.kind IS '@has_guard
Protocol family: ''oauth2'' (manual endpoint configuration) or ''oidc'' (discovery + JWKS-verified id_token). Future kinds (''saml'') will use a different field set.';

COMMENT ON COLUMN myapp_auth_private.identity_providers.enabled IS '@has_guard
Whether sign-in via this provider is currently allowed. Toggled by enable_identity_provider / disable_identity_provider admin procedures. Disabled providers remain in the public-safe view as enabled=false so client UIs can grey out the button.';

COMMENT ON COLUMN myapp_auth_private.identity_providers.issuer_url IS '@has_guard
OIDC issuer URL. Discovery fetches {issuer}/.well-known/openid-configuration unless discovery_url_override is set. Required when kind = ''oidc''. Used for id_token ''iss'' claim verification.';

COMMENT ON COLUMN myapp_auth_private.identity_providers.discovery_url_override IS '@has_guard
Optional non-standard discovery document URL. When NULL, discovery uses {issuer_url}/.well-known/openid-configuration. Used for IdPs that publish discovery at a non-spec path.';

COMMENT ON COLUMN myapp_auth_private.identity_providers.authorization_url IS '@has_guard
OAuth2 authorization endpoint (where the user is redirected to grant consent). Required when kind = ''oauth2''; for kind = ''oidc'' resolved from cached discovery_doc.';

COMMENT ON COLUMN myapp_auth_private.identity_providers.token_url IS '@has_guard
OAuth2 token endpoint (exchanges authorization code for access/id tokens). Required when kind = ''oauth2''; for kind = ''oidc'' resolved from cached discovery_doc.';

COMMENT ON COLUMN myapp_auth_private.identity_providers.userinfo_url IS '@has_guard
OAuth2 userinfo endpoint (returns the user profile given an access token). Required when kind = ''oauth2''; for kind = ''oidc'' resolved from cached discovery_doc or used as a fallback when the id_token does not contain the desired claims.';

COMMENT ON COLUMN myapp_auth_private.identity_providers.client_id IS '@has_guard
OAuth2 / OIDC client_id registered with the IdP. NULL for built-in rows until an admin sets it. Providers with NULL client_id or NULL client_secret_id are treated as not-configured by the sign-in path regardless of the enabled flag.';

COMMENT ON COLUMN myapp_auth_private.identity_providers.client_secret_id IS '@has_guard
Pointer to the row in user_secrets that holds the OAuth2 client_secret (encrypted at rest). NULL only briefly between create_identity_provider and the first rotate_provider_secret. Rotation writes a new user_secrets row and atomically updates this column; the raw secret is never returned to clients.';

COMMENT ON COLUMN myapp_auth_private.identity_providers.acceptable_client_ids IS '@has_guard
Multi-platform audience allow-list. When non-empty, id_token ''aud'' is validated against client_id OR any value here. Used when one IdP project issues tokens with platform-specific audiences (web vs iOS vs Android).';

COMMENT ON COLUMN myapp_auth_private.identity_providers.scopes IS '@has_guard
OAuth2 scopes requested in the authorization URL. For kind = ''oidc'' the admin procedure ensures ''openid'' is always present (silently prepended if missing).';

COMMENT ON COLUMN myapp_auth_private.identity_providers.extra_authorization_params IS '@has_guard
Extra query parameters merged into the authorization URL (e.g. {"prompt":"select_account"}). Admin procedure rejects reserved OAuth/OIDC keys: client_id, redirect_uri, state, nonce, code_challenge, code_challenge_method, response_type, scope.';

COMMENT ON COLUMN myapp_auth_private.identity_providers.email_optional IS '@has_guard
When true, sign-in succeeds even if the IdP does not return a verified email. The user is provisioned without an email and can add one later. When false, missing email is a hard error.';

COMMENT ON COLUMN myapp_auth_private.identity_providers.allow_link_by_email IS '@has_guard
When true, an OAuth/OIDC sign-in whose IdP-verified email matches an existing user account auto-links the new identity to that account. When false, an existing-email collision raises IDENTITY_EMAIL_ALREADY_REGISTERED. Only honored when the IdP marks the email as verified.';

COMMENT ON COLUMN myapp_auth_private.identity_providers.skip_nonce_check IS '@has_guard
OIDC only. When true, the auth server does not require / verify the ''nonce'' claim in id_token. ONLY enable for IdPs that demonstrably do not support nonce; weakens replay resistance.';

COMMENT ON COLUMN myapp_auth_private.identity_providers.pkce_enabled IS '@has_guard
When true, the auth server generates a PKCE code_verifier per authorization request, sends code_challenge with method = S256, and includes code_verifier in the token exchange. PKCE is handled entirely server-side. Default is true; only disable for IdPs that reject PKCE parameters.';

CREATE FUNCTION myapp_app_private.identity_providers_guard_step_up_del_fn() RETURNS trigger AS $EOFCODE$
BEGIN
  PERFORM myapp_auth_public.require_step_up('mfa');
  RETURN OLD;
END;
$EOFCODE$ LANGUAGE plpgsql STABLE SECURITY DEFINER;

CREATE TRIGGER identity_providers_guard_step_up_del_tg
  BEFORE DELETE
  ON myapp_auth_private.identity_providers
  FOR EACH ROW
  WHEN (old.created_at < (now() - '6 hours'::interval))
  EXECUTE PROCEDURE myapp_app_private.identity_providers_guard_step_up_del_fn();

CREATE TABLE myapp_auth_public.principals ();

ALTER TABLE myapp_auth_public.principals 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_auth_public.principals IS '@behavior -insert -update -delete
Scoped sub-identities (API keys and agents) with precomputed SPRT';

ALTER TABLE myapp_auth_public.principals 
  ADD COLUMN id uuid;

ALTER TABLE myapp_auth_public.principals 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_auth_public.principals 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_auth_public.principals 
  ADD CONSTRAINT principals_pkey PRIMARY KEY (id);

ALTER TABLE myapp_auth_public.principals 
  ADD COLUMN created_at timestamptz;

ALTER TABLE myapp_auth_public.principals 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE myapp_auth_public.principals 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE myapp_auth_public.principals 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE TRIGGER timestamps_tg
  BEFORE INSERT OR UPDATE
  ON myapp_auth_public.principals
  FOR EACH ROW
  EXECUTE PROCEDURE stamps.timestamps();

CREATE INDEX principals_created_at_idx ON myapp_auth_public.principals (created_at);

CREATE INDEX principals_updated_at_idx ON myapp_auth_public.principals (updated_at);

ALTER TABLE myapp_auth_public.principals 
  ADD COLUMN owner_id uuid;

ALTER TABLE myapp_auth_public.principals 
  ALTER COLUMN owner_id SET NOT NULL;

COMMENT ON COLUMN myapp_auth_public.principals.owner_id IS 'The human user who owns and manages this principal';

ALTER TABLE myapp_auth_public.principals 
  ADD CONSTRAINT principals_owner_id_fkey
    FOREIGN KEY(owner_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE CASCADE;

ALTER TABLE myapp_auth_public.principals 
  ADD COLUMN user_id uuid;

ALTER TABLE myapp_auth_public.principals 
  ALTER COLUMN user_id SET NOT NULL;

COMMENT ON COLUMN myapp_auth_public.principals.user_id IS 'The user row (type=3 Principal) that represents this principal identity';

ALTER TABLE myapp_auth_public.principals 
  ADD CONSTRAINT principals_user_id_fkey
    FOREIGN KEY(user_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE CASCADE;

ALTER TABLE myapp_auth_public.principals 
  ADD COLUMN name text;

ALTER TABLE myapp_auth_public.principals 
  ALTER COLUMN name SET NOT NULL;

COMMENT ON COLUMN myapp_auth_public.principals.name IS 'Human-readable label for this principal (e.g., billing-bot, ci-deploy-key)';

ALTER TABLE myapp_auth_public.principals 
  ADD COLUMN use_admin_owner boolean;

ALTER TABLE myapp_auth_public.principals 
  ALTER COLUMN use_admin_owner SET NOT NULL;

ALTER TABLE myapp_auth_public.principals 
  ALTER COLUMN use_admin_owner SET DEFAULT true;

COMMENT ON COLUMN myapp_auth_public.principals.use_admin_owner IS 'Whether this principal inherits admin/owner privileges from the owner';

ALTER TABLE myapp_auth_public.principals 
  ADD COLUMN is_read_only boolean;

ALTER TABLE myapp_auth_public.principals 
  ALTER COLUMN is_read_only SET NOT NULL;

ALTER TABLE myapp_auth_public.principals 
  ALTER COLUMN is_read_only SET DEFAULT false;

COMMENT ON COLUMN myapp_auth_public.principals.is_read_only IS 'Whether this principal is restricted to read-only operations';

ALTER TABLE myapp_auth_public.principals 
  ADD COLUMN bypass_step_up boolean;

ALTER TABLE myapp_auth_public.principals 
  ALTER COLUMN bypass_step_up SET NOT NULL;

ALTER TABLE myapp_auth_public.principals 
  ALTER COLUMN bypass_step_up SET DEFAULT false;

COMMENT ON COLUMN myapp_auth_public.principals.bypass_step_up IS 'Whether this principal bypasses MFA step-up requirements';

CREATE INDEX principals_owner_id_idx ON myapp_auth_public.principals (owner_id);

CREATE INDEX principals_user_id_idx ON myapp_auth_public.principals (user_id);

CREATE TABLE myapp_auth_public.principal_entities ();

ALTER TABLE myapp_auth_public.principal_entities 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_auth_public.principal_entities IS 'Association table scoping principals to specific organizations';

ALTER TABLE myapp_auth_public.principal_entities 
  ADD COLUMN id uuid;

ALTER TABLE myapp_auth_public.principal_entities 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_auth_public.principal_entities 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_auth_public.principal_entities 
  ADD CONSTRAINT principal_entities_pkey PRIMARY KEY (id);

ALTER TABLE myapp_auth_public.principal_entities 
  ADD COLUMN created_at timestamptz;

ALTER TABLE myapp_auth_public.principal_entities 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE myapp_auth_public.principal_entities 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE myapp_auth_public.principal_entities 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE TRIGGER timestamps_tg
  BEFORE INSERT OR UPDATE
  ON myapp_auth_public.principal_entities
  FOR EACH ROW
  EXECUTE PROCEDURE stamps.timestamps();

CREATE INDEX principal_entities_created_at_idx ON myapp_auth_public.principal_entities (created_at);

CREATE INDEX principal_entities_updated_at_idx ON myapp_auth_public.principal_entities (updated_at);

ALTER TABLE myapp_auth_public.principal_entities 
  ADD COLUMN principal_id uuid;

ALTER TABLE myapp_auth_public.principal_entities 
  ALTER COLUMN principal_id SET NOT NULL;

COMMENT ON COLUMN myapp_auth_public.principal_entities.principal_id IS 'The principal this scoping row belongs to';

ALTER TABLE myapp_auth_public.principal_entities 
  ADD CONSTRAINT principal_entities_principal_id_fkey
    FOREIGN KEY(principal_id)
    REFERENCES myapp_auth_public.principals (id)
    ON DELETE CASCADE;

ALTER TABLE myapp_auth_public.principal_entities 
  ADD COLUMN entity_id uuid;

ALTER TABLE myapp_auth_public.principal_entities 
  ALTER COLUMN entity_id SET NOT NULL;

COMMENT ON COLUMN myapp_auth_public.principal_entities.entity_id IS 'The organization this principal is scoped to';

ALTER TABLE myapp_auth_public.principal_entities 
  ADD CONSTRAINT principal_entities_entity_id_fkey
    FOREIGN KEY(entity_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE CASCADE;

ALTER TABLE myapp_auth_public.principal_entities 
  ADD COLUMN owner_id uuid;

ALTER TABLE myapp_auth_public.principal_entities 
  ALTER COLUMN owner_id SET NOT NULL;

COMMENT ON COLUMN myapp_auth_public.principal_entities.owner_id IS 'Denormalized owner_id from principals table for RLS';

ALTER TABLE myapp_auth_public.principal_entities 
  ADD CONSTRAINT principal_entities_owner_id_fkey
    FOREIGN KEY(owner_id)
    REFERENCES myapp_users_public.users (id)
    ON DELETE CASCADE;

ALTER TABLE myapp_auth_public.principal_entities 
  ADD CONSTRAINT principal_entities_principal_id_entity_id_key 
    UNIQUE (principal_id, entity_id);

CREATE INDEX principal_entities_principal_id_idx ON myapp_auth_public.principal_entities (principal_id);

CREATE INDEX principal_entities_entity_id_idx ON myapp_auth_public.principal_entities (entity_id);

CREATE INDEX principal_entities_owner_id_idx ON myapp_auth_public.principal_entities (owner_id);

ALTER TABLE myapp_auth_public.principals 
  ENABLE ROW LEVEL SECURITY;

GRANT SELECT ON myapp_auth_public.principals TO authenticated;

CREATE POLICY auth_sel_dir_own
  ON myapp_auth_public.principals
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    owner_id = jwt_public.current_principal_id()
  );

ALTER TABLE myapp_auth_public.principal_entities 
  ENABLE ROW LEVEL SECURITY;

GRANT SELECT ON myapp_auth_public.principal_entities TO authenticated;

CREATE POLICY auth_sel_dir_own
  ON myapp_auth_public.principal_entities
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    owner_id = jwt_public.current_principal_id()
  );

CREATE TABLE myapp_auth_public.principal_scope_overrides ();

ALTER TABLE myapp_auth_public.principal_scope_overrides 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_auth_public.principal_scope_overrides IS '@behavior -insert -update -delete
Per-scope permission overrides for principals. No row = full access; row exists = apply restrictions.';

ALTER TABLE myapp_auth_public.principal_scope_overrides 
  ADD COLUMN id uuid;

ALTER TABLE myapp_auth_public.principal_scope_overrides 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_auth_public.principal_scope_overrides 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_auth_public.principal_scope_overrides 
  ADD CONSTRAINT principal_scope_overrides_pkey PRIMARY KEY (id);

ALTER TABLE myapp_auth_public.principal_scope_overrides 
  ADD COLUMN created_at timestamptz;

ALTER TABLE myapp_auth_public.principal_scope_overrides 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE myapp_auth_public.principal_scope_overrides 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE myapp_auth_public.principal_scope_overrides 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE TRIGGER timestamps_tg
  BEFORE INSERT OR UPDATE
  ON myapp_auth_public.principal_scope_overrides
  FOR EACH ROW
  EXECUTE PROCEDURE stamps.timestamps();

CREATE INDEX principal_scope_overrides_created_at_idx ON myapp_auth_public.principal_scope_overrides (created_at);

CREATE INDEX principal_scope_overrides_updated_at_idx ON myapp_auth_public.principal_scope_overrides (updated_at);

ALTER TABLE myapp_auth_public.principal_scope_overrides 
  ADD COLUMN principal_id uuid;

ALTER TABLE myapp_auth_public.principal_scope_overrides 
  ALTER COLUMN principal_id SET NOT NULL;

COMMENT ON COLUMN myapp_auth_public.principal_scope_overrides.principal_id IS 'The principal this override applies to';

ALTER TABLE myapp_auth_public.principal_scope_overrides 
  ADD CONSTRAINT principal_scope_overrides_principal_id_fkey
    FOREIGN KEY(principal_id)
    REFERENCES myapp_auth_public.principals (id)
    ON DELETE CASCADE;

ALTER TABLE myapp_auth_public.principal_scope_overrides 
  ADD COLUMN membership_type int4;

ALTER TABLE myapp_auth_public.principal_scope_overrides 
  ALTER COLUMN membership_type SET NOT NULL;

COMMENT ON COLUMN myapp_auth_public.principal_scope_overrides.membership_type IS 'The scope level (membership_type) this override restricts';

ALTER TABLE myapp_auth_public.principal_scope_overrides 
  ADD COLUMN allowed_mask varbit;

COMMENT ON COLUMN myapp_auth_public.principal_scope_overrides.allowed_mask IS 'Optional permission mask; AND-masked with parent permissions during cascade. NULL means no extra mask.';

ALTER TABLE myapp_auth_public.principal_scope_overrides 
  ADD COLUMN use_admin_owner boolean;

ALTER TABLE myapp_auth_public.principal_scope_overrides 
  ALTER COLUMN use_admin_owner SET NOT NULL;

ALTER TABLE myapp_auth_public.principal_scope_overrides 
  ALTER COLUMN use_admin_owner SET DEFAULT true;

COMMENT ON COLUMN myapp_auth_public.principal_scope_overrides.use_admin_owner IS 'Whether this principal inherits admin/owner at this scope (default true = inherit from parent)';

ALTER TABLE myapp_auth_public.principal_scope_overrides 
  ADD COLUMN is_active boolean;

ALTER TABLE myapp_auth_public.principal_scope_overrides 
  ALTER COLUMN is_active SET NOT NULL;

ALTER TABLE myapp_auth_public.principal_scope_overrides 
  ALTER COLUMN is_active SET DEFAULT true;

COMMENT ON COLUMN myapp_auth_public.principal_scope_overrides.is_active IS 'Whether this scope is active for this principal; false disables all access at this scope';

ALTER TABLE myapp_auth_public.principal_scope_overrides 
  ADD COLUMN is_read_only boolean;

ALTER TABLE myapp_auth_public.principal_scope_overrides 
  ALTER COLUMN is_read_only SET NOT NULL;

ALTER TABLE myapp_auth_public.principal_scope_overrides 
  ALTER COLUMN is_read_only SET DEFAULT false;

COMMENT ON COLUMN myapp_auth_public.principal_scope_overrides.is_read_only IS 'Whether this principal is restricted to read-only at this scope';

ALTER TABLE myapp_auth_public.principal_scope_overrides 
  ADD CONSTRAINT principal_scope_overrides_principal_id_membership_type_key 
    UNIQUE (principal_id, membership_type);

CREATE INDEX principal_scope_overrides_principal_id_idx ON myapp_auth_public.principal_scope_overrides (principal_id);

ALTER TABLE myapp_auth_public.principal_scope_overrides 
  ENABLE ROW LEVEL SECURITY;

GRANT SELECT ON myapp_auth_public.principal_scope_overrides TO authenticated;

CREATE POLICY auth_sel_ent_mem
  ON myapp_auth_public.principals
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    owner_id IN (SELECT org_sprt.entity_id
    FROM myapp_memberships_private.org_memberships_sprt AS org_sprt
    WHERE
      org_sprt.actor_id = jwt_public.current_principal_id()
      AND org_sprt.is_admin IS TRUE)
  );

CREATE FUNCTION myapp_auth_public.create_principal(
  IN name text,
  IN use_admin_owner boolean DEFAULT true,
  IN entity_ids uuid[] DEFAULT NULL,
  IN is_read_only boolean DEFAULT false,
  IN bypass_step_up boolean DEFAULT false,
  OUT principal_id uuid
) RETURNS uuid AS $EOFCODE$
DECLARE
  v_user_id uuid;
  v_principal_user_id uuid;
  v_principal_id uuid;
BEGIN
  v_user_id := jwt_public.current_user_id();
  IF v_user_id IS NULL THEN
    PERFORM errors.raise_error('NOT_AUTHENTICATED', '{}', 'public');
  END IF;
  IF jwt_public.current_principal_id() <> v_user_id THEN
    PERFORM errors.raise_error('PRINCIPAL_CANNOT_CREATE_PRINCIPAL', '{}', 'public');
  END IF;
  v_principal_user_id := uuidv7();
  INSERT INTO myapp_users_public.users (
    id,
    type,
    username,
    display_name
  )
  VALUES
    (v_principal_user_id, 3, create_principal.name, create_principal.name);
  v_principal_id := uuidv7();
  INSERT INTO myapp_auth_public.principals (
    id,
    owner_id,
    user_id,
    name,
    use_admin_owner,
    is_read_only,
    bypass_step_up
  )
  VALUES
    (v_principal_id, v_user_id, v_principal_user_id, create_principal.name, create_principal.use_admin_owner, create_principal.is_read_only, create_principal.bypass_step_up);
  IF create_principal.entity_ids IS NOT NULL THEN
    INSERT INTO myapp_auth_public.principal_entities (
      id,
      principal_id,
      entity_id,
      owner_id
    )
    SELECT
      uuidv7(),
      v_principal_id,
      unnest(create_principal.entity_ids),
      v_user_id;
  END IF;
  INSERT INTO myapp_logging_public.audit_log_auth (
    actor_id,
    event,
    success
  )
  VALUES
    (v_user_id, 'create_principal', true);
  SELECT v_principal_user_id INTO principal_id;
  RETURN;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION myapp_auth_public.delete_principal(
  IN principal_id uuid,
  OUT success boolean
) RETURNS boolean AS $EOFCODE$
DECLARE
  v_user_id uuid;
  v_owner_id uuid;
BEGIN
  v_user_id := jwt_public.current_user_id();
  IF v_user_id IS NULL THEN
    PERFORM errors.raise_error('NOT_AUTHENTICATED', '{}', 'public');
  END IF;
  IF jwt_public.current_principal_id() <> v_user_id THEN
    PERFORM errors.raise_error('PRINCIPAL_CANNOT_DELETE_PRINCIPAL', '{}', 'public');
  END IF;
  SELECT owner_id
  FROM myapp_auth_public.principals
  WHERE
    user_id = delete_principal.principal_id INTO v_owner_id;
  IF v_owner_id IS NULL THEN
    PERFORM errors.raise_error('PRINCIPAL_NOT_FOUND', '{}', 'public');
  END IF;
  IF v_owner_id <> v_user_id THEN
    PERFORM errors.raise_error('NOT_OWNER', '{}', 'public');
  END IF;
  DELETE FROM myapp_users_public.users
  WHERE
    id = delete_principal.principal_id;
  INSERT INTO myapp_logging_public.audit_log_auth (
    actor_id,
    event,
    success
  )
  VALUES
    (v_user_id, 'delete_principal', true);
  SELECT true INTO success;
  RETURN;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION myapp_auth_public.create_org_principal(
  IN name text,
  IN org_id uuid,
  IN use_admin_owner boolean DEFAULT true,
  IN is_read_only boolean DEFAULT false,
  IN bypass_step_up boolean DEFAULT false,
  OUT principal_id uuid
) RETURNS uuid AS $EOFCODE$
DECLARE
  v_user_id uuid;
  v_principal_user_id uuid;
  v_principal_id uuid;
  v_org_type int;
  v_is_admin boolean;
BEGIN
  v_user_id := jwt_public.current_user_id();
  IF v_user_id IS NULL THEN
    PERFORM errors.raise_error('NOT_AUTHENTICATED', '{}', 'public');
  END IF;
  IF jwt_public.current_principal_id() <> v_user_id THEN
    PERFORM errors.raise_error('PRINCIPAL_CANNOT_CREATE_PRINCIPAL', '{}', 'public');
  END IF;
  SELECT type
  FROM myapp_users_public.users
  WHERE
    id = create_org_principal.org_id INTO v_org_type;
  IF v_org_type IS NULL OR v_org_type <> 2 THEN
    PERFORM errors.raise_error('INVALID_ORGANIZATION', '{}', 'public');
  END IF;
  SELECT is_admin
  FROM myapp_memberships_private.org_memberships_sprt
  WHERE
    actor_id = v_user_id AND entity_id = create_org_principal.org_id INTO v_is_admin;
  IF v_is_admin IS NOT TRUE THEN
    PERFORM errors.raise_error('NOT_ORG_ADMIN', '{}', 'public');
  END IF;
  v_principal_user_id := uuidv7();
  INSERT INTO myapp_users_public.users (
    id,
    type,
    username,
    display_name
  )
  VALUES
    (v_principal_user_id, 3, create_org_principal.name, create_org_principal.name);
  v_principal_id := uuidv7();
  INSERT INTO myapp_auth_public.principals (
    id,
    owner_id,
    user_id,
    name,
    use_admin_owner,
    is_read_only,
    bypass_step_up
  )
  VALUES
    (v_principal_id, v_user_id, v_principal_user_id, create_org_principal.name, create_org_principal.use_admin_owner, create_org_principal.is_read_only, create_org_principal.bypass_step_up);
  UPDATE myapp_memberships_private.org_memberships_sprt SET
  is_admin = v_is_admin
  WHERE
    actor_id = v_user_id AND entity_id = create_org_principal.org_id;
  INSERT INTO myapp_logging_public.audit_log_auth (
    actor_id,
    event,
    success
  )
  VALUES
    (v_user_id, 'create_org_principal', true);
  SELECT v_principal_user_id INTO principal_id;
  RETURN;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION myapp_auth_public.delete_org_principal(
  IN principal_id uuid,
  OUT success boolean
) RETURNS boolean AS $EOFCODE$
DECLARE
  v_user_id uuid;
  v_owner_id uuid;
  v_org_id uuid;
  v_is_admin boolean;
BEGIN
  v_user_id := jwt_public.current_user_id();
  IF v_user_id IS NULL THEN
    PERFORM errors.raise_error('NOT_AUTHENTICATED', '{}', 'public');
  END IF;
  IF jwt_public.current_principal_id() <> v_user_id THEN
    PERFORM errors.raise_error('PRINCIPAL_CANNOT_DELETE_PRINCIPAL', '{}', 'public');
  END IF;
  SELECT owner_id
  FROM myapp_auth_public.principals
  WHERE
    user_id = delete_org_principal.principal_id INTO v_owner_id;
  IF v_owner_id IS NULL THEN
    PERFORM errors.raise_error('PRINCIPAL_NOT_FOUND', '{}', 'public');
  END IF;
  SELECT entity_id
  FROM myapp_memberships_private.org_memberships_sprt
  WHERE
    actor_id = delete_org_principal.principal_id
  LIMIT
  1 INTO v_org_id;
  IF v_org_id IS NULL THEN
    PERFORM errors.raise_error('NOT_ORG_PRINCIPAL', '{}', 'public');
  END IF;
  SELECT is_admin
  FROM myapp_memberships_private.org_memberships_sprt
  WHERE
    actor_id = v_user_id AND entity_id = v_org_id INTO v_is_admin;
  IF v_is_admin IS NOT TRUE THEN
    PERFORM errors.raise_error('NOT_ORG_ADMIN', '{}', 'public');
  END IF;
  DELETE FROM myapp_users_public.users
  WHERE
    id = delete_org_principal.principal_id;
  INSERT INTO myapp_logging_public.audit_log_auth (
    actor_id,
    event,
    success
  )
  VALUES
    (v_user_id, 'delete_org_principal', true);
  SELECT true INTO success;
  RETURN;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION myapp_auth_private.mint_org_credential(
  IN session_id uuid,
  IN credential_id uuid,
  IN org_id uuid,
  IN principal_id uuid,
  IN secret_hash bytea,
  IN mfa_level text,
  IN access_level text,
  IN expires_at timestamptz,
  IN key_name text,
  IN actor_id uuid
) RETURNS void AS $EOFCODE$
BEGIN
  INSERT INTO myapp_auth_private.sessions (
    id,
    user_id,
    is_anonymous,
    origin,
    expires_at
  )
  VALUES
    (mint_org_credential.session_id, mint_org_credential.org_id, false, NULL, mint_org_credential.expires_at);
  INSERT INTO myapp_auth_private.session_credentials (
    id,
    session_id,
    kind,
    secret_hash,
    mfa_level,
    access_level,
    expires_at,
    name,
    principal_id,
    org_id
  )
  VALUES
    (mint_org_credential.credential_id, mint_org_credential.session_id, 'api_key', mint_org_credential.secret_hash, mint_org_credential.mfa_level, mint_org_credential.access_level, mint_org_credential.expires_at, mint_org_credential.key_name, mint_org_credential.principal_id, mint_org_credential.org_id);
  INSERT INTO myapp_logging_public.audit_log_auth (
    actor_id,
    event,
    success
  )
  VALUES
    (mint_org_credential.actor_id, 'create_org_api_key', true);
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION myapp_auth_private.revoke_org_credential(
  IN key_id uuid,
  IN session_id uuid,
  IN actor_id uuid
) RETURNS void AS $EOFCODE$
BEGIN
  DELETE FROM myapp_auth_private.session_credentials
  WHERE
    id = revoke_org_credential.key_id;
  DELETE FROM myapp_auth_private.sessions
  WHERE
    id = revoke_org_credential.session_id;
  INSERT INTO myapp_logging_public.audit_log_auth (
    actor_id,
    event,
    success
  )
  VALUES
    (revoke_org_credential.actor_id, 'revoke_org_api_key', true);
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION myapp_auth_public.create_org_api_key(
  IN org_id uuid,
  IN principal_id uuid,
  IN key_name text DEFAULT NULL,
  IN access_level text DEFAULT 'full_access',
  IN mfa_level text DEFAULT 'none',
  IN expires_in interval DEFAULT NULL,
  OUT api_key text,
  OUT key_id uuid,
  OUT expires_at timestamptz
) RETURNS record AS $EOFCODE$
DECLARE
  v_user_id uuid;
  v_session_id uuid;
  v_credential_id uuid;
  v_plaintext_key text;
  v_settings myapp_auth_private.app_settings_auth;
  v_count int := 0;
  v_effective_duration interval;
  v_expires_at timestamptz;
  v_owner_id uuid;
BEGIN
  v_user_id := jwt_public.current_user_id();
  IF v_user_id IS NULL THEN
    PERFORM errors.raise_error('NOT_AUTHENTICATED', '{}', 'public');
  END IF;
  IF jwt_public.current_principal_id() <> v_user_id THEN
    PERFORM errors.raise_error('PRINCIPAL_CANNOT_CREATE_API_KEY', '{}', 'public');
  END IF;
  v_settings := myapp_auth_private.auth_settings();
  IF NOT (COALESCE(v_settings.allow_api_keys, true)) THEN
    PERFORM errors.raise_error('API_KEYS_DISABLED', '{}', 'public');
  END IF;
  IF create_org_api_key.access_level <> 'full_access' AND create_org_api_key.access_level <> 'read_only' THEN
    PERFORM errors.raise_error('INVALID_ACCESS_LEVEL', '{}', 'public');
  END IF;
  IF create_org_api_key.mfa_level <> 'none' AND create_org_api_key.mfa_level <> 'verified' THEN
    PERFORM errors.raise_error('INVALID_MFA_LEVEL', '{}', 'public');
  END IF;
  SELECT p.owner_id
  FROM myapp_auth_public.principals AS p
  WHERE
    p.user_id = create_org_api_key.principal_id INTO v_owner_id;
  IF v_owner_id IS NULL THEN
    PERFORM errors.raise_error('PRINCIPAL_NOT_FOUND', '{}', 'public');
  END IF;
  IF v_owner_id <> create_org_api_key.org_id THEN
    PERFORM errors.raise_error('PRINCIPAL_NOT_IN_ORG', '{}', 'public');
  END IF;
  SELECT count(*)
  FROM myapp_auth_private.session_credentials AS c
  WHERE
    (c.principal_id = create_org_api_key.principal_id AND c.kind = 'api_key') AND c.revoked_at IS NULL INTO v_count;
  IF NOT (v_count < (COALESCE(v_settings.api_key_max_per_user, 10))) THEN
    PERFORM errors.raise_error('API_KEY_LIMIT_REACHED', '{}', 'public');
  END IF;
  v_effective_duration := COALESCE(create_org_api_key.expires_in, v_settings.api_key_default_duration, '90 days'::interval);
  IF v_settings.api_key_max_duration IS NOT NULL AND v_effective_duration > v_settings.api_key_max_duration THEN
    v_effective_duration := v_settings.api_key_max_duration;
  END IF;
  v_expires_at := now() + v_effective_duration;
  v_session_id := uuidv7();
  v_plaintext_key := (CASE 
    WHEN 'api_key' = 'api_key' THEN 'cnc_live_sk_' 
    WHEN 'api_key' = 'bearer' THEN 'cnc_live_bt_' 
    WHEN 'api_key' = 'access_token' THEN 'cnc_live_at_' 
    WHEN 'api_key' = 'mfa_challenge' THEN 'cnc_live_mfa_' 
    WHEN 'api_key' = 'one_time' THEN 'cnc_live_ot_' 
    WHEN 'api_key' = 'webauthn' THEN 'cnc_live_wa_' 
    ELSE 'cnc_live_tk_' 
  END) || translate(encode(gen_random_bytes(24), 'base64'), '+/=', '-_');
  v_credential_id := uuidv7();
  PERFORM myapp_auth_private.mint_org_credential(v_session_id, v_credential_id, create_org_api_key.org_id, create_org_api_key.principal_id, digest(v_plaintext_key, 'sha256'), create_org_api_key.mfa_level, create_org_api_key.access_level, v_expires_at, create_org_api_key.key_name, v_user_id);
  SELECT v_plaintext_key INTO api_key;
  SELECT v_credential_id INTO key_id;
  SELECT v_expires_at INTO expires_at;
  RETURN;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY INVOKER;

CREATE FUNCTION myapp_auth_public.revoke_org_api_key(
  IN key_id uuid,
  IN org_id uuid
) RETURNS boolean AS $EOFCODE$
DECLARE
  v_user_id uuid;
  v_session_id uuid;
  v_principal_id uuid;
  v_owner_id uuid;
BEGIN
  v_user_id := jwt_public.current_user_id();
  IF v_user_id IS NULL THEN
    PERFORM errors.raise_error('NOT_AUTHENTICATED', '{}', 'public');
  END IF;
  IF jwt_public.current_principal_id() <> v_user_id THEN
    PERFORM errors.raise_error('PRINCIPAL_CANNOT_REVOKE_API_KEY', '{}', 'public');
  END IF;
  SELECT
    sc.session_id,
    sc.principal_id
  FROM myapp_auth_private.session_credentials AS sc
  WHERE
    ((sc.id = revoke_org_api_key.key_id AND sc.kind = 'api_key') AND sc.org_id = revoke_org_api_key.org_id) AND sc.principal_id IS NOT NULL INTO v_session_id, v_principal_id;
  IF v_session_id IS NULL THEN
    PERFORM errors.raise_error('ORG_API_KEY_NOT_FOUND', '{}', 'public');
  END IF;
  SELECT p.owner_id
  FROM myapp_auth_public.principals AS p
  WHERE
    p.user_id = v_principal_id INTO v_owner_id;
  IF v_owner_id IS NULL THEN
    PERFORM errors.raise_error('ORG_API_KEY_NOT_FOUND', '{}', 'public');
  END IF;
  PERFORM myapp_auth_private.revoke_org_credential(revoke_org_api_key.key_id, v_session_id, v_user_id);
  RETURN true;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE STRICT SECURITY INVOKER;

CREATE VIEW myapp_auth_public.org_api_key_list WITH (security_invoker = 'true') AS SELECT
  sc.id,
  sc.key_id,
  sc.name,
  sc.principal_id,
  sc.org_id,
  sc.expires_at,
  sc.revoked_at,
  sc.last_used_at,
  sc.mfa_level,
  sc.access_level,
  sc.created_at,
  sc.updated_at
FROM myapp_auth_private.session_credentials AS sc
WHERE
  sc.kind = 'api_key'
  AND sc.org_id IS NOT NULL;

CREATE RULE _insert_rule AS ON INSERT TO myapp_auth_public.org_api_key_list DO INSTEAD NOTHING;

CREATE RULE _update_rule AS ON UPDATE TO myapp_auth_public.org_api_key_list DO INSTEAD NOTHING;

CREATE RULE _delete_rule AS ON DELETE TO myapp_auth_public.org_api_key_list DO INSTEAD NOTHING;

COMMENT ON VIEW myapp_auth_public.org_api_key_list IS '@behavior -insert -update -delete';

GRANT SELECT ON myapp_auth_public.org_api_key_list TO authenticated;

CREATE FUNCTION myapp_auth_private.org_memberships_sprt_principal_sync_tg() RETURNS trigger AS $EOFCODE$
BEGIN
  IF TG_OP = 'DELETE' THEN
    BEGIN
      DELETE FROM myapp_memberships_private.org_memberships_sprt
      WHERE
        actor_id IN (SELECT p.user_id
        FROM myapp_auth_public.principals AS p
        WHERE
            p.owner_id = OLD.actor_id) AND entity_id = OLD.entity_id;
    EXCEPTION
      WHEN undefined_table THEN
        SELECT NULL;
    END;
    RETURN OLD;
  END IF;
  IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
    BEGIN
      DELETE FROM myapp_memberships_private.org_memberships_sprt
      WHERE
        actor_id IN (SELECT p.user_id
        FROM myapp_auth_public.principals AS p INNER JOIN myapp_auth_public.principal_scope_overrides AS o ON (o.principal_id = p.id AND o.membership_type = 2)
        WHERE
            (p.owner_id = NEW.actor_id AND o.is_active = false)) AND entity_id = NEW.entity_id;
      INSERT INTO myapp_memberships_private.org_memberships_sprt (
        is_owner,
        is_admin,
        permissions,
        actor_id,
        entity_id,
        is_read_only
      )
      SELECT
        false,
        NEW.is_admin AND COALESCE(o.use_admin_owner, p.use_admin_owner),
        NEW.permissions & (COALESCE(o.allowed_mask, (repeat('1', bit_length(NEW.permissions)))::varbit)),
        p.user_id,
        NEW.entity_id,
        (NEW.is_read_only OR p.is_read_only) OR COALESCE(o.is_read_only, false)
      FROM myapp_auth_public.principals AS p LEFT OUTER JOIN myapp_auth_public.principal_scope_overrides AS o ON o.principal_id = p.id AND o.membership_type = 2
      WHERE
        p.owner_id = NEW.actor_id AND o.is_active IS NOT FALSE
      ON CONFLICT (actor_id, entity_id) DO UPDATE SET
      is_owner = EXCLUDED.is_owner, is_admin = EXCLUDED.is_admin, permissions = EXCLUDED.permissions, is_read_only = EXCLUDED.is_read_only;
    EXCEPTION
      WHEN undefined_table THEN
        SELECT NULL;
    END;
    RETURN NEW;
  END IF;
  RETURN NULL;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE TRIGGER _00040_org_memberships_sprt_principal_sync
  AFTER INSERT OR DELETE OR UPDATE
  ON myapp_memberships_private.org_memberships_sprt
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_auth_private.org_memberships_sprt_principal_sync_tg();

CREATE FUNCTION myapp_app_private.principals_guard_step_up_upd_fn() RETURNS trigger AS $EOFCODE$
BEGIN
  PERFORM myapp_auth_public.require_step_up('mfa');
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql STABLE SECURITY DEFINER;

CREATE TRIGGER principals_guard_step_up_upd_tg
  BEFORE UPDATE
  ON myapp_auth_public.principals
  FOR EACH ROW
  WHEN ((new.owner_id IS DISTINCT FROM old.owner_id
    OR new.use_admin_owner IS DISTINCT FROM old.use_admin_owner
    OR new.is_read_only IS DISTINCT FROM old.is_read_only
    OR new.bypass_step_up IS DISTINCT FROM old.bypass_step_up)
    AND old.created_at < (now() - '6 hours'::interval))
  EXECUTE PROCEDURE myapp_app_private.principals_guard_step_up_upd_fn();

COMMENT ON TABLE myapp_auth_public.principals IS '@behavior -insert -update -delete
@has_guard
Scoped sub-identities (API keys and agents) with precomputed SPRT';

COMMENT ON COLUMN myapp_auth_public.principals.owner_id IS '@has_guard
The human user who owns and manages this principal';

COMMENT ON COLUMN myapp_auth_public.principals.use_admin_owner IS '@has_guard
Whether this principal inherits admin/owner privileges from the owner';

COMMENT ON COLUMN myapp_auth_public.principals.is_read_only IS '@has_guard
Whether this principal is restricted to read-only operations';

COMMENT ON COLUMN myapp_auth_public.principals.bypass_step_up IS '@has_guard
Whether this principal bypasses MFA step-up requirements';

CREATE FUNCTION myapp_app_private.principal_scope_overrides_guard_step_up_upd_fn() RETURNS trigger AS $EOFCODE$
BEGIN
  PERFORM myapp_auth_public.require_step_up('mfa');
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql STABLE SECURITY DEFINER;

CREATE TRIGGER principal_scope_overrides_guard_step_up_upd_tg
  BEFORE UPDATE
  ON myapp_auth_public.principal_scope_overrides
  FOR EACH ROW
  WHEN ((new.allowed_mask IS DISTINCT FROM old.allowed_mask
    OR new.use_admin_owner IS DISTINCT FROM old.use_admin_owner
    OR new.is_read_only IS DISTINCT FROM old.is_read_only)
    AND old.created_at < (now() - '6 hours'::interval))
  EXECUTE PROCEDURE myapp_app_private.principal_scope_overrides_guard_step_up_upd_fn();

COMMENT ON TABLE myapp_auth_public.principal_scope_overrides IS '@behavior -insert -update -delete
@has_guard
Per-scope permission overrides for principals. No row = full access; row exists = apply restrictions.';

COMMENT ON COLUMN myapp_auth_public.principal_scope_overrides.allowed_mask IS '@has_guard
Optional permission mask; AND-masked with parent permissions during cascade. NULL means no extra mask.';

COMMENT ON COLUMN myapp_auth_public.principal_scope_overrides.use_admin_owner IS '@has_guard
Whether this principal inherits admin/owner at this scope (default true = inherit from parent)';

COMMENT ON COLUMN myapp_auth_public.principal_scope_overrides.is_read_only IS '@has_guard
Whether this principal is restricted to read-only at this scope';

CREATE FUNCTION myapp_app_private.principal_scope_overrides_guard_step_up_del_fn() RETURNS trigger AS $EOFCODE$
BEGIN
  PERFORM myapp_auth_public.require_step_up('mfa');
  RETURN OLD;
END;
$EOFCODE$ LANGUAGE plpgsql STABLE SECURITY DEFINER;

CREATE TRIGGER principal_scope_overrides_guard_step_up_del_tg
  BEFORE DELETE
  ON myapp_auth_public.principal_scope_overrides
  FOR EACH ROW
  WHEN (old.created_at < (now() - '6 hours'::interval))
  EXECUTE PROCEDURE myapp_app_private.principal_scope_overrides_guard_step_up_del_fn();

CREATE VIEW myapp_auth_private.webauthn_credentials WITH (security_invoker = 'true') AS SELECT
  id,
  owner_id,
  webauthn_user_id,
  credential_id,
  transports,
  public_key,
  sign_count,
  backup_state
FROM myapp_user_identifiers_public.webauthn_credentials;

CREATE FUNCTION myapp_auth_private.webauthn_begin_registration(
  IN user_id uuid
) RETURNS jsonb AS $EOFCODE$
DECLARE
  v_session_id uuid;
  v_webauthn_user_id text;
  v_challenge text;
  v_expires_at timestamptz;
  v_settings myapp_auth_private.app_settings_auth;
  v_exclude_credentials jsonb;
  v_user_rate_limit myapp_auth_private.auth_rate_limits;
  v_rate_settings myapp_auth_private.app_settings_rate_limit;
  v_ip_rate_limit myapp_auth_private.auth_ip_rate_limits;
  v_ip_address inet;
  v_ua_hash text;
BEGIN
  SELECT *
  FROM myapp_auth_private.app_settings_rate_limit
  LIMIT
  1 INTO v_rate_settings;
  SELECT myapp_auth_public.current_ip_address() INTO v_ip_address;
  IF v_ip_address IS NOT NULL THEN
    IF family(v_ip_address) = 6 THEN
      SELECT set_masklen(v_ip_address, 64) INTO v_ip_address;
    END IF;
    SELECT
      COALESCE(md5(myapp_auth_public.current_user_agent()), '__no_ua__') INTO v_ua_hash;
    PERFORM pg_advisory_xact_lock(hashtext('ip_rate_limit_webauthn_begin_registration'), hashtext(v_ip_address::text));
    IF EXISTS (SELECT 1
    FROM myapp_auth_private.auth_ip_rate_limits
    WHERE
      ((ip_address = v_ip_address AND ua_hash = ANY( ARRAY[v_ua_hash, ''] )) AND action = 'webauthn_begin_registration') AND locked_until > now()
    LIMIT
    1) THEN
      PERFORM errors.raise_error('TOO_MANY_REQUESTS', '{}', 'public');
    END IF;
  END IF;
  SELECT *
  FROM myapp_auth_private.app_settings_auth
  LIMIT
  1 INTO v_settings;
  IF NOT (COALESCE(v_settings.allow_webauthn_sign_up, false)) THEN
    PERFORM errors.raise_error('WEBAUTHN_SIGN_UP_DISABLED', '{}', 'public');
  END IF;
  PERFORM pg_advisory_xact_lock(hashtext('webauthn_begin_registration'), hashtext(webauthn_begin_registration.user_id::text));
  SELECT *
  FROM myapp_auth_private.auth_rate_limits
  WHERE
    subject_id = webauthn_begin_registration.user_id AND action = 'webauthn_begin_registration' INTO v_user_rate_limit;
  IF v_user_rate_limit.locked_until IS NOT NULL AND v_user_rate_limit.locked_until > now() THEN
    PERFORM errors.raise_error('ACCOUNT_LOCKED_EXCEED_ATTEMPTS', '{}', 'public');
  END IF;
  v_session_id := jwt_private.current_session_id();
  SELECT c.webauthn_user_id
  FROM myapp_user_identifiers_public.webauthn_credentials AS c
  WHERE
    c.owner_id = webauthn_begin_registration.user_id
  LIMIT
  1 INTO v_webauthn_user_id;
  IF v_webauthn_user_id IS NULL THEN
    v_webauthn_user_id := translate(encode(gen_random_bytes(32), 'base64'), '+/=', '-_');
  END IF;
  v_challenge := translate(encode(gen_random_bytes(32), 'base64'), '+/=', '-_');
  v_expires_at := now() + '5 minutes'::interval;
  INSERT INTO myapp_auth_private.session_secrets (
    session_id,
    name,
    value,
    expires_at
  )
  VALUES
    (v_session_id, 'webauthn_register_challenge', v_challenge, v_expires_at)
  ON CONFLICT (session_id, name) DO UPDATE SET
  value = EXCLUDED.value, expires_at = EXCLUDED.expires_at;
  SELECT
    COALESCE(jsonb_agg(jsonb_build_object('id', c.credential_id, 'type', 'public-key', 'transports', c.transports)), '[]'::jsonb)
  FROM myapp_user_identifiers_public.webauthn_credentials AS c
  WHERE
    c.owner_id = webauthn_begin_registration.user_id INTO v_exclude_credentials;
  DELETE FROM myapp_auth_private.auth_rate_limits
  WHERE
    subject_id = webauthn_begin_registration.user_id AND action = 'webauthn_begin_registration';
  INSERT INTO myapp_logging_public.audit_log_auth (
    actor_id,
    event,
    success
  )
  VALUES
    (webauthn_begin_registration.user_id, 'webauthn_begin_registration', true);
  IF v_ip_address IS NOT NULL THEN
    DELETE FROM myapp_auth_private.auth_ip_rate_limits
    WHERE
      (ip_address = v_ip_address AND ua_hash = v_ua_hash) AND action = 'webauthn_begin_registration';
    DELETE FROM myapp_auth_private.auth_ip_rate_limits
    WHERE
      (ip_address = v_ip_address AND ua_hash = '') AND action = 'webauthn_begin_registration';
  END IF;
  RETURN jsonb_build_object('challenge', v_challenge, 'webauthn_user_id', v_webauthn_user_id, 'excludeCredentials', v_exclude_credentials);
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION myapp_auth_private.webauthn_begin_sign_in(
  IN user_id uuid DEFAULT NULL
) RETURNS jsonb AS $EOFCODE$
DECLARE
  v_session_id uuid;
  v_challenge text;
  v_expires_at timestamptz;
  v_settings myapp_auth_private.app_settings_auth;
  v_allow_credentials jsonb;
  v_rate_settings myapp_auth_private.app_settings_rate_limit;
  v_ip_rate_limit myapp_auth_private.auth_ip_rate_limits;
  v_ip_address inet;
  v_ua_hash text;
BEGIN
  SELECT *
  FROM myapp_auth_private.app_settings_rate_limit
  LIMIT
  1 INTO v_rate_settings;
  SELECT myapp_auth_public.current_ip_address() INTO v_ip_address;
  IF v_ip_address IS NOT NULL THEN
    IF family(v_ip_address) = 6 THEN
      SELECT set_masklen(v_ip_address, 64) INTO v_ip_address;
    END IF;
    SELECT
      COALESCE(md5(myapp_auth_public.current_user_agent()), '__no_ua__') INTO v_ua_hash;
    PERFORM pg_advisory_xact_lock(hashtext('ip_rate_limit_webauthn_begin_sign_in'), hashtext(v_ip_address::text));
    IF EXISTS (SELECT 1
    FROM myapp_auth_private.auth_ip_rate_limits
    WHERE
      ((ip_address = v_ip_address AND ua_hash = ANY( ARRAY[v_ua_hash, ''] )) AND action = 'webauthn_begin_sign_in') AND locked_until > now()
    LIMIT
    1) THEN
      PERFORM errors.raise_error('TOO_MANY_REQUESTS', '{}', 'public');
    END IF;
  END IF;
  SELECT *
  FROM myapp_auth_private.app_settings_auth
  LIMIT
  1 INTO v_settings;
  IF NOT (COALESCE(v_settings.allow_webauthn_sign_in, false)) THEN
    PERFORM errors.raise_error('WEBAUTHN_SIGN_IN_DISABLED', '{}', 'public');
  END IF;
  v_session_id := jwt_private.current_session_id();
  v_challenge := translate(encode(gen_random_bytes(32), 'base64'), '+/=', '-_');
  v_expires_at := now() + '5 minutes'::interval;
  INSERT INTO myapp_auth_private.session_secrets (
    session_id,
    name,
    value,
    expires_at
  )
  VALUES
    (v_session_id, 'webauthn_sign_in_challenge', v_challenge, v_expires_at)
  ON CONFLICT (session_id, name) DO UPDATE SET
  value = EXCLUDED.value, expires_at = EXCLUDED.expires_at;
  IF webauthn_begin_sign_in.user_id IS NOT NULL THEN
    SELECT
      COALESCE(jsonb_agg(jsonb_build_object('id', c.credential_id, 'type', 'public-key', 'transports', c.transports)), '[]'::jsonb)
    FROM myapp_user_identifiers_public.webauthn_credentials AS c
    WHERE
      c.owner_id = webauthn_begin_sign_in.user_id INTO v_allow_credentials;
  ELSE
    v_allow_credentials := '[]'::jsonb;
  END IF;
  INSERT INTO myapp_logging_public.audit_log_auth (
    actor_id,
    event,
    success
  )
  VALUES
    (webauthn_begin_sign_in.user_id, 'webauthn_begin_sign_in', true);
  IF v_ip_address IS NOT NULL THEN
    DELETE FROM myapp_auth_private.auth_ip_rate_limits
    WHERE
      (ip_address = v_ip_address AND ua_hash = v_ua_hash) AND action = 'webauthn_begin_sign_in';
    DELETE FROM myapp_auth_private.auth_ip_rate_limits
    WHERE
      (ip_address = v_ip_address AND ua_hash = '') AND action = 'webauthn_begin_sign_in';
  END IF;
  RETURN jsonb_build_object('challenge', v_challenge, 'allowCredentials', v_allow_credentials);
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION myapp_auth_private.webauthn_finish_registration(
  IN credential_id text,
  IN public_key bytea,
  IN sign_count bigint,
  IN transports text[],
  IN credential_device_type text,
  IN backup_eligible boolean,
  IN backup_state boolean,
  IN webauthn_user_id text,
  IN user_id uuid,
  IN name text DEFAULT NULL
) RETURNS uuid AS $EOFCODE$
DECLARE
  v_session_id uuid;
  v_challenge text;
  v_new_id uuid;
  v_settings myapp_auth_private.app_settings_auth;
  v_user_rate_limit myapp_auth_private.auth_rate_limits;
  v_rate_settings myapp_auth_private.app_settings_rate_limit;
  v_ip_rate_limit myapp_auth_private.auth_ip_rate_limits;
  v_ip_address inet;
  v_ua_hash text;
BEGIN
  SELECT *
  FROM myapp_auth_private.app_settings_rate_limit
  LIMIT
  1 INTO v_rate_settings;
  SELECT myapp_auth_public.current_ip_address() INTO v_ip_address;
  IF v_ip_address IS NOT NULL THEN
    IF family(v_ip_address) = 6 THEN
      SELECT set_masklen(v_ip_address, 64) INTO v_ip_address;
    END IF;
    SELECT
      COALESCE(md5(myapp_auth_public.current_user_agent()), '__no_ua__') INTO v_ua_hash;
    PERFORM pg_advisory_xact_lock(hashtext('ip_rate_limit_webauthn_finish_registration'), hashtext(v_ip_address::text));
    IF EXISTS (SELECT 1
    FROM myapp_auth_private.auth_ip_rate_limits
    WHERE
      ((ip_address = v_ip_address AND ua_hash = ANY( ARRAY[v_ua_hash, ''] )) AND action = 'webauthn_finish_registration') AND locked_until > now()
    LIMIT
    1) THEN
      PERFORM errors.raise_error('TOO_MANY_REQUESTS', '{}', 'public');
    END IF;
  END IF;
  SELECT *
  FROM myapp_auth_private.app_settings_auth
  LIMIT
  1 INTO v_settings;
  IF NOT (COALESCE(v_settings.allow_webauthn_sign_up, false)) THEN
    PERFORM errors.raise_error('WEBAUTHN_SIGN_UP_DISABLED', '{}', 'public');
  END IF;
  PERFORM pg_advisory_xact_lock(hashtext('webauthn_finish_registration'), hashtext(webauthn_finish_registration.user_id::text));
  SELECT *
  FROM myapp_auth_private.auth_rate_limits
  WHERE
    subject_id = webauthn_finish_registration.user_id AND action = 'webauthn_finish_registration' INTO v_user_rate_limit;
  IF v_user_rate_limit.locked_until IS NOT NULL AND v_user_rate_limit.locked_until > now() THEN
    PERFORM errors.raise_error('ACCOUNT_LOCKED_EXCEED_ATTEMPTS', '{}', 'public');
  END IF;
  v_session_id := jwt_private.current_session_id();
  DELETE FROM myapp_auth_private.session_secrets AS s
  WHERE
    (s.session_id = v_session_id AND s.name = 'webauthn_register_challenge') AND (s.expires_at IS NULL OR s.expires_at > now())
  RETURNING s.value INTO v_challenge;
  IF v_challenge IS NULL THEN
    INSERT INTO myapp_auth_private.auth_rate_limits (
      subject_id,
      action,
      attempts,
      first_attempt_at,
      last_attempt_at,
      locked_until
    )
    VALUES
      (webauthn_finish_registration.user_id, 'webauthn_finish_registration', 1, now(), now(), NULL)
    ON CONFLICT (subject_id, action) DO UPDATE SET
    attempts = CASE 
      WHEN auth_rate_limits.first_attempt_at < (now() - v_rate_settings.login_lockout_duration) THEN 1 
      ELSE auth_rate_limits.attempts + 1 
    END, first_attempt_at = CASE 
      WHEN auth_rate_limits.first_attempt_at < (now() - v_rate_settings.login_lockout_duration) THEN now() 
      ELSE auth_rate_limits.first_attempt_at 
    END, last_attempt_at = now(), locked_until = CASE 
      WHEN (auth_rate_limits.attempts + 1) >= v_rate_settings.login_max_attempts AND auth_rate_limits.first_attempt_at >= (now() - v_rate_settings.login_lockout_duration) THEN now() + v_rate_settings.login_lockout_duration 
      ELSE NULL 
    END;
    INSERT INTO myapp_logging_public.audit_log_auth (
      actor_id,
      event,
      success
    )
    VALUES
      (webauthn_finish_registration.user_id, 'webauthn_finish_registration_challenge_not_found', false);
    IF v_ip_address IS NOT NULL THEN
      INSERT INTO myapp_auth_private.auth_ip_rate_limits (
        ip_address,
        ua_hash,
        action,
        attempts,
        first_attempt_at,
        locked_until
      )
      VALUES
        (v_ip_address, v_ua_hash, 'webauthn_finish_registration', 1, now(), NULL)
      ON CONFLICT (ip_address, ua_hash, action) DO UPDATE SET
      attempts = CASE 
        WHEN auth_ip_rate_limits.first_attempt_at < (now() - v_rate_settings.ip_rate_limit_window) THEN 1 
        ELSE auth_ip_rate_limits.attempts + 1 
      END, first_attempt_at = CASE 
        WHEN auth_ip_rate_limits.first_attempt_at < (now() - v_rate_settings.ip_rate_limit_window) THEN now() 
        ELSE auth_ip_rate_limits.first_attempt_at 
      END, locked_until = CASE 
        WHEN (auth_ip_rate_limits.attempts + 1) >= v_rate_settings.ip_ua_max_attempts AND auth_ip_rate_limits.first_attempt_at >= (now() - v_rate_settings.ip_rate_limit_window) THEN now() + v_rate_settings.ip_lockout_duration 
        ELSE NULL 
      END;
      INSERT INTO myapp_auth_private.auth_ip_rate_limits (
        ip_address,
        ua_hash,
        action,
        attempts,
        first_attempt_at,
        locked_until
      )
      VALUES
        (v_ip_address, '', 'webauthn_finish_registration', 1, now(), NULL)
      ON CONFLICT (ip_address, ua_hash, action) DO UPDATE SET
      attempts = CASE 
        WHEN auth_ip_rate_limits.first_attempt_at < (now() - v_rate_settings.ip_rate_limit_window) THEN 1 
        ELSE auth_ip_rate_limits.attempts + 1 
      END, first_attempt_at = CASE 
        WHEN auth_ip_rate_limits.first_attempt_at < (now() - v_rate_settings.ip_rate_limit_window) THEN now() 
        ELSE auth_ip_rate_limits.first_attempt_at 
      END, locked_until = CASE 
        WHEN (auth_ip_rate_limits.attempts + 1) >= v_rate_settings.ip_max_attempts AND auth_ip_rate_limits.first_attempt_at >= (now() - v_rate_settings.ip_rate_limit_window) THEN now() + v_rate_settings.ip_lockout_duration 
        ELSE NULL 
      END;
    END IF;
    PERFORM errors.raise_error('WEBAUTHN_REGISTER_CHALLENGE_NOT_FOUND_OR_EXPIRED', '{}', 'public');
  END IF;
  INSERT INTO myapp_user_identifiers_public.webauthn_credentials (
    owner_id,
    credential_id,
    public_key,
    sign_count,
    transports,
    credential_device_type,
    backup_eligible,
    backup_state,
    webauthn_user_id,
    name
  )
  VALUES
    (webauthn_finish_registration.user_id, webauthn_finish_registration.credential_id, webauthn_finish_registration.public_key, webauthn_finish_registration.sign_count, webauthn_finish_registration.transports, webauthn_finish_registration.credential_device_type, webauthn_finish_registration.backup_eligible, webauthn_finish_registration.backup_state, webauthn_finish_registration.webauthn_user_id, webauthn_finish_registration.name)
  RETURNING id INTO v_new_id;
  DELETE FROM myapp_auth_private.auth_rate_limits
  WHERE
    subject_id = webauthn_finish_registration.user_id AND action = 'webauthn_finish_registration';
  INSERT INTO myapp_logging_public.audit_log_auth (
    actor_id,
    event,
    success
  )
  VALUES
    (webauthn_finish_registration.user_id, 'webauthn_finish_registration', true);
  IF v_ip_address IS NOT NULL THEN
    DELETE FROM myapp_auth_private.auth_ip_rate_limits
    WHERE
      (ip_address = v_ip_address AND ua_hash = v_ua_hash) AND action = 'webauthn_finish_registration';
    DELETE FROM myapp_auth_private.auth_ip_rate_limits
    WHERE
      (ip_address = v_ip_address AND ua_hash = '') AND action = 'webauthn_finish_registration';
  END IF;
  RETURN v_new_id;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE FUNCTION myapp_auth_private.webauthn_finish_sign_in(
  IN credential_id text,
  IN new_sign_count bigint,
  IN new_backup_state boolean,
  IN credential_kind text DEFAULT 'access_token',
  OUT user_id uuid,
  OUT access_token text,
  OUT access_token_expires_at timestamptz
) AS $EOFCODE$
DECLARE
  v_session_id uuid;
  v_challenge text;
  v_owner_id uuid;
  v_settings myapp_auth_private.app_settings_auth;
  v_default_session_duration interval := '2 weeks'::interval;
  v_session_expires_at timestamptz;
  v_session_id_new uuid;
  v_credential_id_new uuid;
  v_plaintext_credential text;
  v_csrf_secret text;
  v_rate_settings myapp_auth_private.app_settings_rate_limit;
  v_ip_rate_limit myapp_auth_private.auth_ip_rate_limits;
  v_ip_address inet;
  v_ua_hash text;
BEGIN
  SELECT *
  FROM myapp_auth_private.app_settings_rate_limit
  LIMIT
  1 INTO v_rate_settings;
  SELECT myapp_auth_public.current_ip_address() INTO v_ip_address;
  IF v_ip_address IS NOT NULL THEN
    IF family(v_ip_address) = 6 THEN
      SELECT set_masklen(v_ip_address, 64) INTO v_ip_address;
    END IF;
    SELECT
      COALESCE(md5(myapp_auth_public.current_user_agent()), '__no_ua__') INTO v_ua_hash;
    PERFORM pg_advisory_xact_lock(hashtext('ip_rate_limit_webauthn_finish_sign_in'), hashtext(v_ip_address::text));
    IF EXISTS (SELECT 1
    FROM myapp_auth_private.auth_ip_rate_limits
    WHERE
      ((ip_address = v_ip_address AND ua_hash = ANY( ARRAY[v_ua_hash, ''] )) AND action = 'webauthn_finish_sign_in') AND locked_until > now()
    LIMIT
    1) THEN
      PERFORM errors.raise_error('TOO_MANY_REQUESTS', '{}', 'public');
    END IF;
  END IF;
  SELECT *
  FROM myapp_auth_private.app_settings_auth
  LIMIT
  1 INTO v_settings;
  IF NOT (COALESCE(v_settings.allow_webauthn_sign_in, false)) THEN
    PERFORM errors.raise_error('WEBAUTHN_SIGN_IN_DISABLED', '{}', 'public');
  END IF;
  v_session_id := jwt_private.current_session_id();
  DELETE FROM myapp_auth_private.session_secrets AS s
  WHERE
    (s.session_id = v_session_id AND s.name = 'webauthn_sign_in_challenge') AND (s.expires_at IS NULL OR s.expires_at > now())
  RETURNING s.value INTO v_challenge;
  IF v_challenge IS NULL THEN
    INSERT INTO myapp_logging_public.audit_log_auth (
      actor_id,
      event,
      success
    )
    VALUES
      (NULL, 'webauthn_finish_sign_in_challenge_not_found', false);
    IF v_ip_address IS NOT NULL THEN
      INSERT INTO myapp_auth_private.auth_ip_rate_limits (
        ip_address,
        ua_hash,
        action,
        attempts,
        first_attempt_at,
        locked_until
      )
      VALUES
        (v_ip_address, v_ua_hash, 'webauthn_finish_sign_in', 1, now(), NULL)
      ON CONFLICT (ip_address, ua_hash, action) DO UPDATE SET
      attempts = CASE 
        WHEN auth_ip_rate_limits.first_attempt_at < (now() - v_rate_settings.ip_rate_limit_window) THEN 1 
        ELSE auth_ip_rate_limits.attempts + 1 
      END, first_attempt_at = CASE 
        WHEN auth_ip_rate_limits.first_attempt_at < (now() - v_rate_settings.ip_rate_limit_window) THEN now() 
        ELSE auth_ip_rate_limits.first_attempt_at 
      END, locked_until = CASE 
        WHEN (auth_ip_rate_limits.attempts + 1) >= v_rate_settings.ip_ua_max_attempts AND auth_ip_rate_limits.first_attempt_at >= (now() - v_rate_settings.ip_rate_limit_window) THEN now() + v_rate_settings.ip_lockout_duration 
        ELSE NULL 
      END;
      INSERT INTO myapp_auth_private.auth_ip_rate_limits (
        ip_address,
        ua_hash,
        action,
        attempts,
        first_attempt_at,
        locked_until
      )
      VALUES
        (v_ip_address, '', 'webauthn_finish_sign_in', 1, now(), NULL)
      ON CONFLICT (ip_address, ua_hash, action) DO UPDATE SET
      attempts = CASE 
        WHEN auth_ip_rate_limits.first_attempt_at < (now() - v_rate_settings.ip_rate_limit_window) THEN 1 
        ELSE auth_ip_rate_limits.attempts + 1 
      END, first_attempt_at = CASE 
        WHEN auth_ip_rate_limits.first_attempt_at < (now() - v_rate_settings.ip_rate_limit_window) THEN now() 
        ELSE auth_ip_rate_limits.first_attempt_at 
      END, locked_until = CASE 
        WHEN (auth_ip_rate_limits.attempts + 1) >= v_rate_settings.ip_max_attempts AND auth_ip_rate_limits.first_attempt_at >= (now() - v_rate_settings.ip_rate_limit_window) THEN now() + v_rate_settings.ip_lockout_duration 
        ELSE NULL 
      END;
    END IF;
    PERFORM errors.raise_error('WEBAUTHN_SIGN_IN_CHALLENGE_NOT_FOUND_OR_EXPIRED', '{}', 'public');
  END IF;
  UPDATE myapp_user_identifiers_public.webauthn_credentials AS c SET
  sign_count = webauthn_finish_sign_in.new_sign_count, backup_state = webauthn_finish_sign_in.new_backup_state, last_used_at = now()
  WHERE
    c.credential_id = webauthn_finish_sign_in.credential_id
  RETURNING c.owner_id INTO v_owner_id;
  IF v_owner_id IS NULL THEN
    INSERT INTO myapp_logging_public.audit_log_auth (
      actor_id,
      event,
      success
    )
    VALUES
      (NULL, 'webauthn_finish_sign_in_credential_not_found', false);
    IF v_ip_address IS NOT NULL THEN
      INSERT INTO myapp_auth_private.auth_ip_rate_limits (
        ip_address,
        ua_hash,
        action,
        attempts,
        first_attempt_at,
        locked_until
      )
      VALUES
        (v_ip_address, v_ua_hash, 'webauthn_finish_sign_in', 1, now(), NULL)
      ON CONFLICT (ip_address, ua_hash, action) DO UPDATE SET
      attempts = CASE 
        WHEN auth_ip_rate_limits.first_attempt_at < (now() - v_rate_settings.ip_rate_limit_window) THEN 1 
        ELSE auth_ip_rate_limits.attempts + 1 
      END, first_attempt_at = CASE 
        WHEN auth_ip_rate_limits.first_attempt_at < (now() - v_rate_settings.ip_rate_limit_window) THEN now() 
        ELSE auth_ip_rate_limits.first_attempt_at 
      END, locked_until = CASE 
        WHEN (auth_ip_rate_limits.attempts + 1) >= v_rate_settings.ip_ua_max_attempts AND auth_ip_rate_limits.first_attempt_at >= (now() - v_rate_settings.ip_rate_limit_window) THEN now() + v_rate_settings.ip_lockout_duration 
        ELSE NULL 
      END;
      INSERT INTO myapp_auth_private.auth_ip_rate_limits (
        ip_address,
        ua_hash,
        action,
        attempts,
        first_attempt_at,
        locked_until
      )
      VALUES
        (v_ip_address, '', 'webauthn_finish_sign_in', 1, now(), NULL)
      ON CONFLICT (ip_address, ua_hash, action) DO UPDATE SET
      attempts = CASE 
        WHEN auth_ip_rate_limits.first_attempt_at < (now() - v_rate_settings.ip_rate_limit_window) THEN 1 
        ELSE auth_ip_rate_limits.attempts + 1 
      END, first_attempt_at = CASE 
        WHEN auth_ip_rate_limits.first_attempt_at < (now() - v_rate_settings.ip_rate_limit_window) THEN now() 
        ELSE auth_ip_rate_limits.first_attempt_at 
      END, locked_until = CASE 
        WHEN (auth_ip_rate_limits.attempts + 1) >= v_rate_settings.ip_max_attempts AND auth_ip_rate_limits.first_attempt_at >= (now() - v_rate_settings.ip_rate_limit_window) THEN now() + v_rate_settings.ip_lockout_duration 
        ELSE NULL 
      END;
    END IF;
    PERFORM errors.raise_error('WEBAUTHN_CREDENTIAL_NOT_FOUND', '{}', 'public');
  END IF;
  v_default_session_duration := COALESCE(v_settings.default_session_duration, '2 weeks'::interval);
  v_session_expires_at := now() + v_default_session_duration;
  v_session_id_new := uuidv7();
  v_plaintext_credential := (CASE 
    WHEN webauthn_finish_sign_in.credential_kind = 'api_key' THEN 'cnc_live_sk_' 
    WHEN webauthn_finish_sign_in.credential_kind = 'bearer' THEN 'cnc_live_bt_' 
    WHEN webauthn_finish_sign_in.credential_kind = 'access_token' THEN 'cnc_live_at_' 
    WHEN webauthn_finish_sign_in.credential_kind = 'mfa_challenge' THEN 'cnc_live_mfa_' 
    WHEN webauthn_finish_sign_in.credential_kind = 'one_time' THEN 'cnc_live_ot_' 
    WHEN webauthn_finish_sign_in.credential_kind = 'webauthn' THEN 'cnc_live_wa_' 
    ELSE 'cnc_live_tk_' 
  END) || translate(encode(gen_random_bytes(24), 'base64'), '+/=', '-_');
  v_credential_id_new := uuid_generate_v5(uuid_ns_url(), v_plaintext_credential);
  v_csrf_secret := encode(gen_random_bytes(32), 'hex');
  INSERT INTO myapp_auth_private.sessions (
    id,
    user_id,
    is_anonymous,
    expires_at,
    auth_method,
    csrf_secret,
    origin,
    uagent
  )
  VALUES
    (v_session_id_new, v_owner_id, false, v_session_expires_at, 'webauthn', v_csrf_secret, jwt_public.current_origin(), jwt_public.current_user_agent());
  INSERT INTO myapp_auth_private.session_credentials (
    id,
    session_id,
    kind,
    secret_hash,
    expires_at
  )
  VALUES
    (v_credential_id_new, v_session_id_new, webauthn_finish_sign_in.credential_kind, digest(v_plaintext_credential, 'sha256'), v_session_expires_at);
  INSERT INTO myapp_logging_public.audit_log_auth (
    actor_id,
    event,
    success
  )
  VALUES
    (v_owner_id, 'webauthn_finish_sign_in', true);
  IF v_ip_address IS NOT NULL THEN
    DELETE FROM myapp_auth_private.auth_ip_rate_limits
    WHERE
      (ip_address = v_ip_address AND ua_hash = v_ua_hash) AND action = 'webauthn_finish_sign_in';
    DELETE FROM myapp_auth_private.auth_ip_rate_limits
    WHERE
      (ip_address = v_ip_address AND ua_hash = '') AND action = 'webauthn_finish_sign_in';
  END IF;
  SELECT v_owner_id INTO user_id;
  SELECT v_plaintext_credential INTO access_token;
  SELECT v_session_expires_at INTO access_token_expires_at;
  RETURN;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

CREATE SCHEMA myapp_storage_public;

GRANT USAGE ON SCHEMA myapp_storage_public TO administrator;

GRANT USAGE ON SCHEMA myapp_storage_public TO authenticated;

GRANT USAGE ON SCHEMA myapp_storage_public TO anonymous;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_storage_public
  GRANT ALL ON TABLES TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_storage_public
  GRANT USAGE ON SEQUENCES TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_storage_public
  GRANT ALL ON FUNCTIONS TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_storage_public
  GRANT ALL ON FUNCTIONS TO authenticated;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_storage_public
  GRANT USAGE ON SEQUENCES TO authenticated;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_storage_public
  GRANT ALL ON FUNCTIONS TO anonymous;

CREATE SCHEMA myapp_storage_private;

GRANT USAGE ON SCHEMA myapp_storage_private TO administrator;

GRANT USAGE ON SCHEMA myapp_storage_private TO authenticated;

GRANT USAGE ON SCHEMA myapp_storage_private TO anonymous;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_storage_private
  GRANT ALL ON TABLES TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_storage_private
  GRANT USAGE ON SEQUENCES TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_storage_private
  GRANT ALL ON FUNCTIONS TO administrator;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_storage_private
  GRANT ALL ON FUNCTIONS TO authenticated;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_storage_private
  GRANT USAGE ON SEQUENCES TO authenticated;

ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_storage_private
  GRANT ALL ON FUNCTIONS TO anonymous;

CREATE TABLE myapp_storage_public.app_buckets ();

ALTER TABLE myapp_storage_public.app_buckets 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_storage_public.app_buckets IS 'Logical storage containers that group files with shared access policies and CDN behavior';

ALTER TABLE myapp_storage_public.app_buckets 
  ADD COLUMN id uuid;

ALTER TABLE myapp_storage_public.app_buckets 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_storage_public.app_buckets 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_storage_public.app_buckets 
  ADD CONSTRAINT app_buckets_pkey PRIMARY KEY (id);

ALTER TABLE myapp_storage_public.app_buckets 
  ADD COLUMN created_at timestamptz;

ALTER TABLE myapp_storage_public.app_buckets 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE myapp_storage_public.app_buckets 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE myapp_storage_public.app_buckets 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE TRIGGER timestamps_tg
  BEFORE INSERT OR UPDATE
  ON myapp_storage_public.app_buckets
  FOR EACH ROW
  EXECUTE PROCEDURE stamps.timestamps();

CREATE INDEX app_buckets_created_at_idx ON myapp_storage_public.app_buckets (created_at);

CREATE INDEX app_buckets_updated_at_idx ON myapp_storage_public.app_buckets (updated_at);

ALTER TABLE myapp_storage_public.app_buckets 
  ADD COLUMN key text;

ALTER TABLE myapp_storage_public.app_buckets 
  ALTER COLUMN key SET NOT NULL;

COMMENT ON COLUMN myapp_storage_public.app_buckets.key IS 'Unique bucket identifier used in S3 key paths (e.g. avatars, documents, temp)';

ALTER TABLE myapp_storage_public.app_buckets 
  ADD COLUMN type text;

ALTER TABLE myapp_storage_public.app_buckets 
  ALTER COLUMN type SET NOT NULL;

ALTER TABLE myapp_storage_public.app_buckets 
  ALTER COLUMN type SET DEFAULT 'private';

COMMENT ON COLUMN myapp_storage_public.app_buckets.type IS 'Bucket CDN access type: public (CDN-served), private (presigned GET), temp (staging uploads)';

ALTER TABLE myapp_storage_public.app_buckets 
  ADD COLUMN is_public boolean;

ALTER TABLE myapp_storage_public.app_buckets 
  ALTER COLUMN is_public SET NOT NULL;

ALTER TABLE myapp_storage_public.app_buckets 
  ALTER COLUMN is_public SET DEFAULT false;

COMMENT ON COLUMN myapp_storage_public.app_buckets.is_public IS 'Whether bucket contents are publicly readable. Set to true when type is public.';

ALTER TABLE myapp_storage_public.app_buckets 
  ADD COLUMN description text;

COMMENT ON COLUMN myapp_storage_public.app_buckets.description IS 'Human-readable description of the bucket purpose';

ALTER TABLE myapp_storage_public.app_buckets 
  ADD COLUMN actor_id uuid;

ALTER TABLE myapp_storage_public.app_buckets 
  ALTER COLUMN actor_id SET NOT NULL;

COMMENT ON COLUMN myapp_storage_public.app_buckets.actor_id IS 'User who created this bucket. Forced to current_user_id() on INSERT.';

ALTER TABLE myapp_storage_public.app_buckets 
  ADD COLUMN max_file_size bigint;

COMMENT ON COLUMN myapp_storage_public.app_buckets.max_file_size IS 'Maximum file size in bytes allowed in this bucket (NULL = no limit, enforcement deferred)';

ALTER TABLE myapp_storage_public.app_buckets 
  ADD COLUMN allowed_mime_types text[];

COMMENT ON COLUMN myapp_storage_public.app_buckets.allowed_mime_types IS 'Whitelist of allowed MIME types for files in this bucket (NULL = all allowed, enforcement deferred)';

ALTER TABLE myapp_storage_public.app_buckets 
  ADD COLUMN allowed_origins text[];

COMMENT ON COLUMN myapp_storage_public.app_buckets.allowed_origins IS 'Per-bucket CORS allowed origins override (NULL = inherit from storage_module/plugin defaults). Use ARRAY[''*''] for open/CDN mode.';

ALTER TABLE myapp_storage_public.app_buckets 
  ADD COLUMN allow_custom_keys boolean;

ALTER TABLE myapp_storage_public.app_buckets 
  ALTER COLUMN allow_custom_keys SET NOT NULL;

ALTER TABLE myapp_storage_public.app_buckets 
  ALTER COLUMN allow_custom_keys SET DEFAULT false;

COMMENT ON COLUMN myapp_storage_public.app_buckets.allow_custom_keys IS 'When true, clients can provide custom S3 keys (e.g. reports/2024/Q1.pdf). When false (default), S3 key = content hash (automatic dedup). contentHash always required for integrity.';

ALTER TABLE myapp_storage_public.app_buckets 
  ADD CONSTRAINT app_buckets_key_key 
    UNIQUE (key);

CREATE INDEX app_buckets_is_public_idx ON myapp_storage_public.app_buckets (is_public);

CREATE FUNCTION myapp_app_private.app_buckets_force_current_user_actor_id() RETURNS trigger AS $EOFCODE$
BEGIN
  IF jwt_public.current_user_id() IS NOT NULL THEN
    SELECT jwt_public.current_user_id() INTO NEW.actor_id;
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE;

CREATE TRIGGER app_buckets_force_current_user_actor_id_tg
  BEFORE INSERT
  ON myapp_storage_public.app_buckets
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_app_private.app_buckets_force_current_user_actor_id();

CREATE FUNCTION myapp_app_private.app_buckets_immutable_fields() RETURNS trigger AS $EOFCODE$
BEGIN
  IF (((NEW.key IS DISTINCT FROM OLD.key OR NEW.type IS DISTINCT FROM OLD.type) OR NEW.is_public IS DISTINCT FROM OLD.is_public) OR NEW.actor_id IS DISTINCT FROM OLD.actor_id) OR NEW.allow_custom_keys IS DISTINCT FROM OLD.allow_custom_keys THEN
    RAISE EXCEPTION 'Cannot modify immutable fields on app_buckets';
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE;

CREATE TRIGGER app_buckets_immutable_fields_tg
  BEFORE UPDATE
  ON myapp_storage_public.app_buckets
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_app_private.app_buckets_immutable_fields();

COMMENT ON TABLE myapp_storage_public.app_buckets IS '@storageBuckets
Logical storage containers that group files with shared access policies and CDN behavior';

CREATE TYPE myapp_storage_public.file_status AS ENUM ('requested', 'uploaded', 'processed');

CREATE TABLE myapp_storage_public.app_files ();

ALTER TABLE myapp_storage_public.app_files 
  DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE myapp_storage_public.app_files IS 'Individual file records within buckets, with immutable identity fields and mutable metadata';

ALTER TABLE myapp_storage_public.app_files 
  ADD COLUMN id uuid;

ALTER TABLE myapp_storage_public.app_files 
  ALTER COLUMN id SET NOT NULL;

ALTER TABLE myapp_storage_public.app_files 
  ALTER COLUMN id SET DEFAULT uuidv7();

ALTER TABLE myapp_storage_public.app_files 
  ADD CONSTRAINT app_files_pkey PRIMARY KEY (id);

ALTER TABLE myapp_storage_public.app_files 
  ADD COLUMN created_at timestamptz;

ALTER TABLE myapp_storage_public.app_files 
  ALTER COLUMN created_at SET DEFAULT now();

ALTER TABLE myapp_storage_public.app_files 
  ADD COLUMN updated_at timestamptz;

ALTER TABLE myapp_storage_public.app_files 
  ALTER COLUMN updated_at SET DEFAULT now();

CREATE TRIGGER timestamps_tg
  BEFORE INSERT OR UPDATE
  ON myapp_storage_public.app_files
  FOR EACH ROW
  EXECUTE PROCEDURE stamps.timestamps();

CREATE INDEX app_files_created_at_idx ON myapp_storage_public.app_files (created_at);

CREATE INDEX app_files_updated_at_idx ON myapp_storage_public.app_files (updated_at);

ALTER TABLE myapp_storage_public.app_files 
  ADD COLUMN key text;

ALTER TABLE myapp_storage_public.app_files 
  ALTER COLUMN key SET NOT NULL;

COMMENT ON COLUMN myapp_storage_public.app_files.key IS 'S3 object key for this file, unique within its bucket';

ALTER TABLE myapp_storage_public.app_files 
  ADD COLUMN content_hash text;

COMMENT ON COLUMN myapp_storage_public.app_files.content_hash IS 'SHA-256 content hash for integrity verification and dedup. In default mode, equals the S3 key. In custom key mode, stored separately.';

ALTER TABLE myapp_storage_public.app_files 
  ADD COLUMN bucket_id uuid;

ALTER TABLE myapp_storage_public.app_files 
  ALTER COLUMN bucket_id SET NOT NULL;

COMMENT ON COLUMN myapp_storage_public.app_files.bucket_id IS 'Bucket this file belongs to. Determines owner_id and is_public via inheritance trigger.';

ALTER TABLE myapp_storage_public.app_files 
  ADD COLUMN actor_id uuid;

ALTER TABLE myapp_storage_public.app_files 
  ALTER COLUMN actor_id SET NOT NULL;

COMMENT ON COLUMN myapp_storage_public.app_files.actor_id IS 'User who uploaded this file. Forced to current_user_id() on INSERT. Used for UPDATE/DELETE authorization.';

ALTER TABLE myapp_storage_public.app_files 
  ADD COLUMN is_public boolean;

ALTER TABLE myapp_storage_public.app_files 
  ALTER COLUMN is_public SET NOT NULL;

ALTER TABLE myapp_storage_public.app_files 
  ALTER COLUMN is_public SET DEFAULT false;

COMMENT ON COLUMN myapp_storage_public.app_files.is_public IS 'Whether this file is publicly readable. Inherited from bucket on INSERT.';

ALTER TABLE myapp_storage_public.app_files 
  ADD COLUMN mime_type text;

ALTER TABLE myapp_storage_public.app_files 
  ALTER COLUMN mime_type SET NOT NULL;

COMMENT ON COLUMN myapp_storage_public.app_files.mime_type IS 'MIME type of the file (e.g. image/png, application/pdf). Immutable after INSERT.';

ALTER TABLE myapp_storage_public.app_files 
  ADD COLUMN size bigint;

ALTER TABLE myapp_storage_public.app_files 
  ALTER COLUMN size SET NOT NULL;

COMMENT ON COLUMN myapp_storage_public.app_files.size IS 'File size in bytes. Immutable after INSERT.';

ALTER TABLE myapp_storage_public.app_files 
  ADD COLUMN description text;

COMMENT ON COLUMN myapp_storage_public.app_files.description IS 'Human-readable description or alt text for the file (mutable)';

ALTER TABLE myapp_storage_public.app_files 
  ADD COLUMN tags text[];

COMMENT ON COLUMN myapp_storage_public.app_files.tags IS 'User-defined tags for categorization and search (mutable)';

ALTER TABLE myapp_storage_public.app_files 
  ADD COLUMN filename text;

COMMENT ON COLUMN myapp_storage_public.app_files.filename IS 'Original filename provided by the uploader. Used for display and Content-Disposition header on download.';

ALTER TABLE myapp_storage_public.app_files 
  ADD COLUMN status myapp_storage_public.file_status;

ALTER TABLE myapp_storage_public.app_files 
  ALTER COLUMN status SET NOT NULL;

ALTER TABLE myapp_storage_public.app_files 
  ALTER COLUMN status SET DEFAULT 'requested';

COMMENT ON COLUMN myapp_storage_public.app_files.status IS 'File lifecycle status: requested (presigned URL generated, not yet in S3), uploaded (file in S3, ready for basic use), processed (MIME verified, image resized, embedding computed).';

ALTER TABLE myapp_storage_public.app_files 
  ADD COLUMN upload upload;

COMMENT ON COLUMN myapp_storage_public.app_files.upload IS 'Processed file reference (upload domain). Populated by processing jobs after file is uploaded. Copy this value to other tables to reference the file.';

ALTER TABLE myapp_storage_public.app_files 
  ADD CONSTRAINT app_files_bucket_id_fkey
    FOREIGN KEY(bucket_id)
    REFERENCES myapp_storage_public.app_buckets (id)
    ON DELETE RESTRICT;

ALTER TABLE myapp_storage_public.app_files 
  ADD CONSTRAINT app_files_bucket_id_key_key 
    UNIQUE (bucket_id, key);

CREATE INDEX app_files_bucket_id_idx ON myapp_storage_public.app_files (bucket_id);

CREATE INDEX app_files_bucket_id_content_hash_idx ON myapp_storage_public.app_files (bucket_id, content_hash);

CREATE INDEX app_files_actor_id_idx ON myapp_storage_public.app_files (actor_id);

CREATE INDEX app_files_is_public_idx ON myapp_storage_public.app_files (is_public);

CREATE FUNCTION myapp_app_private.app_files_inherit_from_parent() RETURNS trigger AS $EOFCODE$
BEGIN
  SELECT p.is_public
  FROM ONLY myapp_storage_public.app_buckets AS p
  WHERE
    p.id = NEW.bucket_id INTO NEW.is_public;
  IF NOT (FOUND) THEN
    RAISE EXCEPTION 'Parent not found: %', NEW.bucket_id;
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE;

CREATE TRIGGER app_files_inherit_from_parent_tg
  BEFORE INSERT
  ON myapp_storage_public.app_files
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_app_private.app_files_inherit_from_parent();

CREATE FUNCTION myapp_app_private.app_files_force_current_user_actor_id() RETURNS trigger AS $EOFCODE$
BEGIN
  IF jwt_public.current_user_id() IS NOT NULL THEN
    SELECT jwt_public.current_user_id() INTO NEW.actor_id;
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE;

CREATE TRIGGER app_files_force_current_user_actor_id_tg
  BEFORE INSERT
  ON myapp_storage_public.app_files
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_app_private.app_files_force_current_user_actor_id();

CREATE FUNCTION myapp_app_private.app_files_immutable_fields() RETURNS trigger AS $EOFCODE$
BEGIN
  IF (((((NEW.key IS DISTINCT FROM OLD.key OR NEW.bucket_id IS DISTINCT FROM OLD.bucket_id) OR NEW.actor_id IS DISTINCT FROM OLD.actor_id) OR NEW.is_public IS DISTINCT FROM OLD.is_public) OR NEW.mime_type IS DISTINCT FROM OLD.mime_type) OR NEW.size IS DISTINCT FROM OLD.size) OR NEW.content_hash IS DISTINCT FROM OLD.content_hash THEN
    RAISE EXCEPTION 'Cannot modify immutable fields on app_files';
  END IF;
  RETURN NEW;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE;

CREATE TRIGGER app_files_immutable_fields_tg
  BEFORE UPDATE
  ON myapp_storage_public.app_files
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_app_private.app_files_immutable_fields();

COMMENT ON TABLE myapp_storage_public.app_files IS '@storageFiles
Individual file records within buckets, with immutable identity fields and mutable metadata';

CREATE FUNCTION myapp_storage_public.app_files_rename(
  IN file_id pg_catalog.uuid,
  IN new_filename pg_catalog.text
) RETURNS myapp_storage_public.app_files AS $EOFCODE$
UPDATE myapp_storage_public.app_files SET
filename = new_filename
WHERE
  id = file_id
RETURNING *
$EOFCODE$ LANGUAGE sql VOLATILE;

GRANT EXECUTE ON FUNCTION myapp_storage_public.app_files_rename TO authenticated;

CREATE FUNCTION myapp_storage_public.app_files_file_path(
  IN f myapp_storage_public.app_files
) RETURNS text AS $EOFCODE$
SELECT f.filename
$EOFCODE$ LANGUAGE sql STABLE;

GRANT EXECUTE ON FUNCTION myapp_storage_public.app_files_file_path TO authenticated;

CREATE FUNCTION myapp_storage_private.app_files_gc_storage_object() RETURNS trigger AS $EOFCODE$
BEGIN
  PERFORM app_jobs.add_job(identifier:='delete_s3_object', payload:=json_build_object('table', 'app_files', 'schema', 'myapp_storage_public', 'bucket_id', OLD.bucket_id, 'key', OLD.key), queue_name:='storage_gc', run_at:=now() + '5 seconds'::interval, max_attempts:=5, priority:=100);
  RETURN OLD;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE;

CREATE TRIGGER app_files_gc_storage_object_tg
  AFTER DELETE
  ON myapp_storage_public.app_files
  FOR EACH ROW
  EXECUTE PROCEDURE myapp_storage_private.app_files_gc_storage_object();

INSERT INTO myapp_permissions_public.app_permissions (
  bitnum,
  name,
  description
) VALUES
  (13, 'write_files', 'Update metadata on any member''s files (escalation beyond own files).'),
  (14, 'delete_files', 'Delete any member''s files (escalation beyond own files).'),
  (15, 'share_files', 'Manage path shares for files and folders.'),
  (16, 'read_files', 'Read files when restrict_reads is enabled (opt-in restrictive mode).'),
  (17, 'manage_storage', 'Create, configure, and delete storage buckets (beyond file-level permissions).');

ALTER TABLE myapp_storage_public.app_buckets 
  ENABLE ROW LEVEL SECURITY;

GRANT SELECT ON myapp_storage_public.app_buckets TO authenticated;

GRANT INSERT ON myapp_storage_public.app_buckets TO authenticated;

GRANT UPDATE ON myapp_storage_public.app_buckets TO authenticated;

GRANT DELETE ON myapp_storage_public.app_buckets TO authenticated;

ALTER TABLE myapp_storage_public.app_files 
  ENABLE ROW LEVEL SECURITY;

GRANT SELECT ON myapp_storage_public.app_files TO authenticated;

GRANT INSERT ON myapp_storage_public.app_files TO authenticated;

GRANT UPDATE ( filename, description, tags ) ON myapp_storage_public.app_files TO authenticated;

GRANT DELETE ON myapp_storage_public.app_files TO authenticated;

CREATE POLICY auth_sel_pub
  ON myapp_storage_public.app_buckets
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    is_public = true
  );

CREATE POLICY auth_sel_mem
  ON myapp_storage_public.app_buckets
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id())
  );

CREATE POLICY auth_ins_adm
  ON myapp_storage_public.app_buckets
  AS PERMISSIVE
  FOR INSERT
  TO authenticated
  WITH CHECK (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND app_sprt.is_admin IS TRUE)
  );

CREATE POLICY auth_upd_adm
  ON myapp_storage_public.app_buckets
  AS PERMISSIVE
  FOR UPDATE
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND app_sprt.is_admin IS TRUE)
  );

CREATE POLICY auth_del_adm
  ON myapp_storage_public.app_buckets
  AS PERMISSIVE
  FOR DELETE
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND app_sprt.is_admin IS TRUE)
  );

CREATE POLICY auth_sel_pub
  ON myapp_storage_public.app_files
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    is_public = true
  );

CREATE POLICY auth_sel_mem
  ON myapp_storage_public.app_files
  AS PERMISSIVE
  FOR SELECT
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id())
  );

CREATE POLICY auth_ins_mem
  ON myapp_storage_public.app_files
  AS PERMISSIVE
  FOR INSERT
  TO authenticated
  WITH CHECK (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id())
  );

CREATE POLICY auth_upd_own
  ON myapp_storage_public.app_files
  AS PERMISSIVE
  FOR UPDATE
  TO authenticated
  USING (
    actor_id = jwt_public.current_principal_id()
      AND EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id())
  );

CREATE POLICY auth_del_own
  ON myapp_storage_public.app_files
  AS PERMISSIVE
  FOR DELETE
  TO authenticated
  USING (
    actor_id = jwt_public.current_principal_id()
      AND EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id())
  );

CREATE POLICY auth_upd_esc_write
  ON myapp_storage_public.app_files
  AS PERMISSIVE
  FOR UPDATE
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND app_sprt.is_admin IS TRUE)
  );

CREATE POLICY auth_del_esc_del
  ON myapp_storage_public.app_files
  AS PERMISSIVE
  FOR DELETE
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND app_sprt.is_admin IS TRUE)
  );

CREATE POLICY auth_ins_insert_chk
  ON myapp_users_public.users
  AS PERMISSIVE
  FOR INSERT
  TO authenticated
  WITH CHECK (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      (app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000010000') = '0000000000000000000000000000000000000000000000000000000000010000'))
      AND type = 2
  );

CREATE POLICY auth_upd_com
  ON myapp_users_public.users
  AS PERMISSIVE
  FOR UPDATE
  TO authenticated
  USING (
    id IN (SELECT org_sprt.entity_id
    FROM myapp_memberships_private.org_memberships_sprt AS org_sprt
    WHERE
      org_sprt.actor_id = jwt_public.current_principal_id()
      AND (org_sprt.permissions & '0000000000000000000000000000000000000000000000000000000100000000') = '0000000000000000000000000000000000000000000000000000000100000000')
  );

CREATE POLICY auth_del_com
  ON myapp_users_public.users
  AS PERMISSIVE
  FOR DELETE
  TO authenticated
  USING (
    id IN (SELECT org_sprt.entity_id
    FROM myapp_memberships_private.org_memberships_sprt AS org_sprt
    WHERE
      org_sprt.actor_id = jwt_public.current_principal_id()
      AND org_sprt.is_owner IS TRUE)
  );

CREATE POLICY auth_upd_admin_updates
  ON myapp_users_public.users
  AS PERMISSIVE
  FOR UPDATE
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000000001') = '0000000000000000000000000000000000000000000000000000000000000001')
  );

CREATE POLICY auth_del_admin_deletes
  ON myapp_users_public.users
  AS PERMISSIVE
  FOR DELETE
  TO authenticated
  USING (
    EXISTS (SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE
      app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000000001') = '0000000000000000000000000000000000000000000000000000000000000001')
  );

CREATE FUNCTION myapp_invites_public.send_app_invite(
  IN email text DEFAULT NULL,
  IN phone text DEFAULT NULL,
  IN expires_at timestamptz DEFAULT now() + '6 months'::interval,
  IN multiple boolean DEFAULT false,
  IN invite_limit int DEFAULT -1,
  IN profile_id uuid DEFAULT NULL,
  IN channel text DEFAULT 'email',
  IN data pg_catalog.json DEFAULT NULL
) RETURNS myapp_invites_public.app_invites AS $EOFCODE$
DECLARE
  invite_row myapp_invites_public.app_invites;
  has_permission boolean;
BEGIN
  SELECT EXISTS (
    SELECT 1
    FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
    WHERE app_sprt.actor_id = jwt_public.current_principal_id()
      AND (app_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000000010') = '0000000000000000000000000000000000000000000000000000000000000010'
  ) INTO has_permission;

  IF has_permission IS NOT TRUE THEN
    RAISE EXCEPTION 'PERMISSION_DENIED';
  END IF;

  INSERT INTO myapp_invites_public.app_invites (
    channel, email, phone, expires_at, multiple, invite_limit, profile_id, data
  )
  VALUES
    (send_app_invite.channel, send_app_invite.email, send_app_invite.phone,
     send_app_invite.expires_at, send_app_invite.multiple, send_app_invite.invite_limit,
     send_app_invite.profile_id, send_app_invite.data)
  RETURNING * INTO invite_row;

  RETURN invite_row;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

GRANT EXECUTE ON FUNCTION myapp_invites_public.send_app_invite TO authenticated;

CREATE FUNCTION myapp_invites_public.send_org_invite(
  IN entity_id uuid,
  IN email text DEFAULT NULL,
  IN phone text DEFAULT NULL,
  IN expires_at timestamptz DEFAULT now() + '6 months'::interval,
  IN multiple boolean DEFAULT false,
  IN invite_limit int DEFAULT -1,
  IN profile_id uuid DEFAULT NULL,
  IN is_read_only boolean DEFAULT false,
  IN receiver_id uuid DEFAULT NULL,
  IN channel text DEFAULT 'email',
  IN data pg_catalog.json DEFAULT NULL
) RETURNS myapp_invites_public.org_invites AS $EOFCODE$
DECLARE
  invite_row myapp_invites_public.org_invites;
  has_permission boolean;
BEGIN
  SELECT EXISTS (
    SELECT 1
    FROM myapp_memberships_private.org_memberships_sprt AS org_sprt
    WHERE org_sprt.actor_id = jwt_public.current_principal_id()
      AND org_sprt.entity_id = send_org_invite.entity_id
      AND (org_sprt.permissions & '0000000000000000000000000000000000000000000000000000000000000010') = '0000000000000000000000000000000000000000000000000000000000000010'
  ) INTO has_permission;

  IF has_permission IS NOT TRUE THEN
    RAISE EXCEPTION 'PERMISSION_DENIED';
  END IF;

  INSERT INTO myapp_invites_public.org_invites (
    channel, email, phone, expires_at, multiple, invite_limit,
    profile_id, is_read_only, receiver_id, entity_id, data
  )
  VALUES
    (send_org_invite.channel, send_org_invite.email, send_org_invite.phone,
     send_org_invite.expires_at, send_org_invite.multiple, send_org_invite.invite_limit,
     send_org_invite.profile_id, send_org_invite.is_read_only, send_org_invite.receiver_id,
     send_org_invite.entity_id, send_org_invite.data)
  RETURNING * INTO invite_row;

  RETURN invite_row;
END;
$EOFCODE$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

GRANT EXECUTE ON FUNCTION myapp_invites_public.send_org_invite TO authenticated;