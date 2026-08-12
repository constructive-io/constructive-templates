-- Deploy: schemas/routing_public/tables/email_identities/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/email_identities/table


ALTER TABLE routing_public.email_identities 
  DISABLE ROW LEVEL SECURITY;