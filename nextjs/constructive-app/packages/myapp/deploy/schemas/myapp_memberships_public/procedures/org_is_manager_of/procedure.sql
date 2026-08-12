-- Deploy: schemas/myapp_memberships_public/procedures/org_is_manager_of/procedure
-- made with <3 @ constructive.io

-- requires: schemas/myapp_memberships_public/schema


CREATE FUNCTION myapp_memberships_public.org_is_manager_of(
  IN target_entity_id uuid,
  IN manager_id uuid,
  IN user_id uuid,
  IN max_depth int DEFAULT NULL
) RETURNS boolean AS $_PGFN_$
BEGIN
  RETURN EXISTS (SELECT 1
  FROM myapp_memberships_private.org_hierarchy_sprts AS h
  WHERE
    ((h.entity_id = target_entity_id AND h.ancestor_id = manager_id) AND (h.descendant_id = user_id AND h.ancestor_id <> h.descendant_id)) AND (max_depth IS NULL OR h.depth <= max_depth));
END;
$_PGFN_$ LANGUAGE plpgsql STABLE SECURITY DEFINER;

