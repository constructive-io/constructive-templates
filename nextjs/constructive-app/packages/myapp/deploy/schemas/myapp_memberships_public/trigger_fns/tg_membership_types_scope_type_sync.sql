-- Deploy: schemas/myapp_memberships_public/trigger_fns/tg_membership_types_scope_type_sync
-- made with <3 @ constructive.io

-- requires: schemas/myapp_memberships_public/schema


CREATE FUNCTION myapp_memberships_public.tg_membership_types_scope_type_sync() RETURNS TRIGGER AS $_PGFN_$
BEGIN
  DELETE FROM scope_private.scope_types
  WHERE
    (database_id = '019feb75-7843-7bd5-a19f-88c4cbec0ee6'::uuid AND membership_type = NEW.id) AND scope <> NEW.scope;
  INSERT INTO scope_private.scope_types (
    database_id,
    scope,
    membership_type,
    parent_membership_type
  )
  VALUES
    ('019feb75-7843-7bd5-a19f-88c4cbec0ee6'::uuid, NEW.scope, NEW.id, NEW.parent_membership_type)
  ON CONFLICT (database_id, scope) DO UPDATE SET
  membership_type = EXCLUDED.membership_type, parent_membership_type = EXCLUDED.parent_membership_type;
  RETURN NEW;
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

