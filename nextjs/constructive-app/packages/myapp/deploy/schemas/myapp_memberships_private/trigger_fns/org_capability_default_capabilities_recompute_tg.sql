-- Deploy: schemas/myapp_memberships_private/trigger_fns/org_capability_default_capabilities_recompute_tg
-- made with <3 @ constructive.io

-- requires: schemas/myapp_memberships_private/schema
-- requires: schemas/myapp_capabilities_public/tables/org_capabilities/table
-- requires: schemas/myapp_capabilities_public/tables/org_capability_defaults/table
-- requires: schemas/myapp_memberships_public/tables/org_capability_default_capabilities/table


CREATE FUNCTION myapp_memberships_private.org_capability_default_capabilities_recompute_tg() RETURNS TRIGGER AS $_PGFN_$
DECLARE
  v_entity_id uuid;
  v_capabilities bit(64);
BEGIN
  IF TG_OP = 'DELETE' THEN
    SELECT OLD.entity_id INTO v_entity_id;
  ELSE
    SELECT NEW.entity_id INTO v_entity_id;
  END IF;
  SELECT coalesce(bit_or(p.bitstr), (lpad('', 64, '0'))::bit(64)::bit(64))
  FROM myapp_memberships_public.org_capability_default_capabilities AS pp INNER JOIN myapp_capabilities_public.org_capabilities AS p ON p.id = pp.capability_id
  WHERE
    pp.entity_id = v_entity_id INTO v_capabilities;
  UPDATE myapp_capabilities_public.org_capability_defaults SET
  capabilities = v_capabilities
  WHERE
    entity_id = v_entity_id;
  IF TG_OP = 'DELETE' THEN
    RETURN OLD;
  END IF;
  RETURN NEW;
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

