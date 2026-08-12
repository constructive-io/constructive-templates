-- Deploy: schemas/myapp_auth_private/trigger_fns/org_memberships_sprt_principal_sync_tg
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_public/tables/principals/table
-- requires: schemas/myapp_auth_public/tables/principal_scope_overrides/table
-- requires: schemas/myapp_memberships_private/tables/org_memberships_sprt/table


CREATE FUNCTION myapp_auth_private.org_memberships_sprt_principal_sync_tg() RETURNS TRIGGER AS $_PGFN_$
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
        capabilities,
        actor_id,
        entity_id,
        is_read_only
      )
      SELECT
        false,
        NEW.is_admin AND COALESCE(o.use_admin_owner, p.use_admin_owner),
        NEW.capabilities & (COALESCE(o.allowed_mask, (repeat('1', bit_length(NEW.capabilities)))::varbit)),
        p.user_id,
        NEW.entity_id,
        (NEW.is_read_only OR p.is_read_only) OR COALESCE(o.is_read_only, false)
      FROM myapp_auth_public.principals AS p LEFT OUTER JOIN myapp_auth_public.principal_scope_overrides AS o ON o.principal_id = p.id AND o.membership_type = 2
      WHERE
        p.owner_id = NEW.actor_id AND o.is_active IS NOT FALSE
      ON CONFLICT (actor_id, entity_id) DO UPDATE SET
      is_owner = EXCLUDED.is_owner, is_admin = EXCLUDED.is_admin, capabilities = EXCLUDED.capabilities, is_read_only = EXCLUDED.is_read_only;
    EXCEPTION
      WHEN undefined_table THEN
        SELECT NULL;
    END;
    RETURN NEW;
  END IF;
  RETURN NULL;
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

