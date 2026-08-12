-- Deploy: schemas/myapp_limits_private/procedures/org_limit_aggregates_check/procedure
-- made with <3 @ constructive.io

-- requires: schemas/myapp_limits_private/schema
-- requires: schemas/myapp_limits_public/tables/org_limit_defaults/table
-- requires: schemas/myapp_limits_public/tables/org_limit_aggregates/table


CREATE FUNCTION myapp_limits_private.org_limit_aggregates_check(
  IN limitname citext,
  IN entity_id uuid,
  IN amount bigint DEFAULT 1
) RETURNS boolean AS $_PGFN_$
DECLARE
  max_default bigint := 0;
  rec myapp_limits_public.org_limit_aggregates;
  v_ceiling bigint := 0;
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
    (l.name = org_limit_aggregates_check.limitname AND l.entity_id = org_limit_aggregates_check.entity_id) AND (l.window_duration IS NOT NULL AND (l.window_start + l.window_duration) <= pg_catalog.now());
  SELECT *
  FROM myapp_limits_public.org_limit_aggregates
  WHERE
    name = org_limit_aggregates_check.limitname AND org_limit_aggregates.entity_id = org_limit_aggregates_check.entity_id
  FOR UPDATE INTO rec;
  v_ceiling := CASE 
    WHEN (COALESCE(rec.plan_max, max_default, 0)) < 0 THEN -1 
    ELSE ((COALESCE(rec.plan_max, max_default, 0)) + rec.purchased_credits) + (COALESCE(rec.period_credits, 0)) 
  END;
  IF v_ceiling < 0 OR v_ceiling >= (rec.num + org_limit_aggregates_check.amount) THEN
    RETURN true;
  ELSE
    RETURN false;
  END IF;
  RETURN false;
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

