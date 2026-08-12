-- Deploy: schemas/myapp_app_private/trigger_fns/app_buckets_immutable_fields
-- made with <3 @ constructive.io

-- requires: schemas/myapp_app_private/schema


CREATE FUNCTION myapp_app_private.app_buckets_immutable_fields() RETURNS TRIGGER AS $_PGFN_$
BEGIN
  IF ((((NEW.key IS DISTINCT FROM OLD.key OR NEW.type IS DISTINCT FROM OLD.type) OR NEW.is_public IS DISTINCT FROM OLD.is_public) OR NEW.actor_id IS DISTINCT FROM OLD.actor_id) OR NEW.allow_custom_keys IS DISTINCT FROM OLD.allow_custom_keys) OR NEW.destination_bucket_id IS DISTINCT FROM OLD.destination_bucket_id THEN
    RAISE EXCEPTION 'Cannot modify immutable fields on app_buckets';
  END IF;
  RETURN NEW;
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE;

