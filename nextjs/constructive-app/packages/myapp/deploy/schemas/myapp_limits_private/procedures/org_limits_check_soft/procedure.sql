-- Deploy: schemas/myapp_limits_private/procedures/org_limits_check_soft/procedure
-- made with <3 @ constructive.io

-- requires: schemas/myapp_limits_private/schema
-- requires: schemas/myapp_limits_public/tables/org_limits/table
-- requires: schemas/myapp_limits_public/tables/org_limit_defaults/table


CREATE FUNCTION myapp_limits_private.org_limits_check_soft(
  IN limitname citext,
  IN entity_id uuid,
  IN actor_id uuid DEFAULT jwt_public.current_user_id()
) RETURNS boolean AS $_PGFN_$
DECLARE
  rec myapp_limits_public.org_limits;
BEGIN
  UPDATE myapp_limits_public.org_limits AS l SET
  num = 0, period_credits = 0, max = CASE 
    WHEN (COALESCE(l.plan_max, (SELECT d.max
  FROM myapp_limits_public.org_limit_defaults AS d
  WHERE
      d.name = l.name), 0)) < 0 THEN -1 
    ELSE (COALESCE(l.plan_max, (SELECT d.max
  FROM myapp_limits_public.org_limit_defaults AS d
  WHERE
      d.name = l.name), 0)) + l.purchased_credits 
  END, window_start = pg_catalog.now()
  WHERE
    ((l.name = org_limits_check_soft.limitname AND l.actor_id = org_limits_check_soft.actor_id) AND l.entity_id = org_limits_check_soft.entity_id) AND (l.window_duration IS NOT NULL AND (l.window_start + l.window_duration) <= pg_catalog.now());
  SELECT *
  FROM myapp_limits_public.org_limits
  WHERE
    (name = org_limits_check_soft.limitname AND actor_id = org_limits_check_soft.actor_id) AND entity_id = org_limits_check_soft.entity_id INTO rec;
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
$_PGFN_$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

