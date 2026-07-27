-- Deploy: schemas/myapp_auth_public/tables/principal_entities/triggers/timestamps_tg
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principal_entities/table


CREATE TRIGGER timestamps_tg
BEFORE INSERT OR UPDATE ON myapp_auth_public.principal_entities
FOR EACH ROW
EXECUTE PROCEDURE stamps.timestamps ( );

