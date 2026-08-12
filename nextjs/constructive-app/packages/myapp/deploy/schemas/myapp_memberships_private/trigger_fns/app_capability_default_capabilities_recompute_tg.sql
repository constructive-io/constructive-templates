-- Deploy: schemas/myapp_memberships_private/trigger_fns/app_capability_default_capabilities_recompute_tg
-- made with <3 @ constructive.io

-- requires: schemas/myapp_memberships_private/schema
-- requires: schemas/myapp_capabilities_public/tables/app_capabilities/table
-- requires: schemas/myapp_capabilities_public/tables/app_capability_defaults/table
-- requires: schemas/myapp_memberships_public/tables/app_capability_default_capabilities/table


CREATE FUNCTION myapp_memberships_private.app_capability_default_capabilities_recompute_tg() RETURNS TRIGGER AS $_PGFN_$
DECLARE
  v_capabilities bit(64);
BEGIN
  SELECT coalesce(bit_or(p.bitstr), (lpad('', 64, '0'))::bit(64)::bit(64))
  FROM myapp_memberships_public.app_capability_default_capabilities AS pp INNER JOIN myapp_capabilities_public.app_capabilities AS p ON p.id = pp.capability_id INTO v_capabilities;
  UPDATE myapp_capabilities_public.app_capability_defaults SET
  capabilities = v_capabilities;
  RETURN NEW;
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

