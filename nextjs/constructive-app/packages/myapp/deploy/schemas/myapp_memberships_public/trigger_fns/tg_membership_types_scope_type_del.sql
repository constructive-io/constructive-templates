-- Deploy: schemas/myapp_memberships_public/trigger_fns/tg_membership_types_scope_type_del
-- made with <3 @ constructive.io

-- requires: schemas/myapp_memberships_public/schema


CREATE FUNCTION myapp_memberships_public.tg_membership_types_scope_type_del() RETURNS TRIGGER AS $_PGFN_$
BEGIN
  DELETE FROM scope_private.scope_types
  WHERE
    database_id = '019feb75-7843-7bd5-a19f-88c4cbec0ee6'::uuid AND membership_type = OLD.id;
  RETURN OLD;
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

