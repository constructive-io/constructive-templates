-- Deploy: schemas/myapp_auth_public/tables/principals/triggers/timestamps_tg
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principals/table


CREATE TRIGGER timestamps_tg
BEFORE INSERT OR UPDATE ON myapp_auth_public.principals
FOR EACH ROW
EXECUTE PROCEDURE stamps.timestamps ( );

