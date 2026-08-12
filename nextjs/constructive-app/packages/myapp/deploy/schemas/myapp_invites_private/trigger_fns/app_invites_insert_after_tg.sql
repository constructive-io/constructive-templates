-- Deploy: schemas/myapp_invites_private/trigger_fns/app_invites_insert_after_tg
-- made with <3 @ constructive.io

-- requires: schemas/myapp_invites_private/schema
-- requires: schemas/myapp_users_public/tables/users/table


CREATE FUNCTION myapp_invites_private.app_invites_insert_after_tg() RETURNS TRIGGER AS $_PGFN_$
DECLARE
  v_sender_name text;
BEGIN
  IF NEW.channel = 'email' AND NEW.email IS NOT NULL THEN
    SELECT u.display_name
    FROM myapp_users_public.users AS u
    WHERE
      u.id = NEW.sender_id INTO v_sender_name;
    PERFORM app_jobs.add_job('email:send_verification_link', json_build_object('invite_table', 'app_invites', 'invite_type', '1', 'email_type', 'invite_email', 'email', NEW.email, 'sender_id', NEW.sender_id, 'invite_token', NEW.invite_token, 'sender_name', v_sender_name));
  END IF;
  IF NEW.channel = 'sms' AND NEW.phone IS NOT NULL THEN
    PERFORM app_jobs.add_job('sms:send_invite', json_build_object('invite_table', 'app_invites', 'invite_type', '1', 'phone', NEW.phone, 'sender_id', NEW.sender_id, 'invite_token', NEW.invite_token));
  END IF;
  RETURN NEW;
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

