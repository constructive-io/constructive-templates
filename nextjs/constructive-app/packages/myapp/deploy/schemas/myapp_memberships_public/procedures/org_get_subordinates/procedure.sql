-- Deploy: schemas/myapp_memberships_public/procedures/org_get_subordinates/procedure
-- made with <3 @ constructive.io

-- requires: schemas/myapp_memberships_public/schema


CREATE FUNCTION myapp_memberships_public.org_get_subordinates(
  IN target_entity_id uuid,
  IN target_user_id uuid,
  IN max_depth int DEFAULT NULL
) RETURNS TABLE(user_id uuid, depth int) AS $_PGFN_$
BEGIN
  RETURN QUERY SELECT
    descendant_id AS user_id,
    h.depth
  FROM myapp_memberships_private.org_hierarchy_sprts AS h
  WHERE
    ((h.entity_id = target_entity_id AND h.ancestor_id = target_user_id) AND h.descendant_id <> target_user_id) AND (max_depth IS NULL OR h.depth <= max_depth);
END;
$_PGFN_$ LANGUAGE plpgsql STABLE SECURITY DEFINER;

