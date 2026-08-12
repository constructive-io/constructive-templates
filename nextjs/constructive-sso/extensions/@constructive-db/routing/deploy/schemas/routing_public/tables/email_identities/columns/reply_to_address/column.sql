-- Deploy: schemas/routing_public/tables/email_identities/columns/reply_to_address/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/email_identities/table


ALTER TABLE routing_public.email_identities 
  ADD COLUMN reply_to_address text;