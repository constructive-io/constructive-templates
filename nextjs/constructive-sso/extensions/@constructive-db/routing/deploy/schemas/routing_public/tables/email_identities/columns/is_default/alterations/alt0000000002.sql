-- Deploy: schemas/routing_public/tables/email_identities/columns/is_default/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/email_identities/table
-- requires: schemas/routing_public/tables/email_identities/columns/is_default/column


ALTER TABLE routing_public.email_identities 
  ALTER COLUMN is_default SET DEFAULT false;