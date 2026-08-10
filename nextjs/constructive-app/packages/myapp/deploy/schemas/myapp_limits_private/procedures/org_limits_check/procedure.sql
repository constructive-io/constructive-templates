-- Deploy: schemas/myapp_limits_private/procedures/org_limits_check/procedure
-- made with <3 @ constructive.io

-- requires: schemas/myapp_limits_private/schema
-- requires: schemas/myapp_limits_public/tables/org_limits/table
-- requires: schemas/myapp_limits_public/tables/org_limit_defaults/table


CREATE FUNCTION myapp_limits_private.org_limits_check(
  IN limitname citext,
  IN entity_id uuid,
  IN amount bigint DEFAULT 1,
  IN actor_id uuid DEFAULT jwt_public.current_user_id()
) RETURNS boolean AS $_PGFN_$
DECLARE
  max_default bigint := 0;
  rec myapp_limits_public.org_limits;
  v_ceiling bigint := 0;
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
    actor_id,
    entity_id
  )
  VALUES
    (org_limits_check.limitname, 0, max_default, org_limits_check.actor_id, org_limits_check.entity_id)
  ON CONFLICT ON CONSTRAINT org_limits_name_actor_id_entity_id_key DO NOTHING;
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
    ((l.name = org_limits_check.limitname AND l.actor_id = org_limits_check.actor_id) AND l.entity_id = org_limits_check.entity_id) AND (l.window_duration IS NOT NULL AND (l.window_start + l.window_duration) <= pg_catalog.now());
  SELECT *
  FROM myapp_limits_public.org_limits
  WHERE
    (name = org_limits_check.limitname AND actor_id = org_limits_check.actor_id) AND entity_id = org_limits_check.entity_id
  FOR UPDATE INTO rec;
  v_ceiling := CASE 
    WHEN (COALESCE(rec.plan_max, max_default, 0)) < 0 THEN -1 
    ELSE ((COALESCE(rec.plan_max, max_default, 0)) + rec.purchased_credits) + (COALESCE(rec.period_credits, 0)) 
  END;
  IF v_ceiling < 0 OR v_ceiling >= (rec.num + org_limits_check.amount) THEN
    RETURN true;
  ELSE
    RETURN false;
  END IF;
  RETURN false;
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

