-- Deploy: schemas/routing_public/tables/email_identities/columns/database_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/email_identities/table
-- requires: schemas/routing_public/tables/email_identities/columns/database_id/column


ALTER TABLE routing_public.email_identities 
  ALTER COLUMN database_id SET NOT NULL;