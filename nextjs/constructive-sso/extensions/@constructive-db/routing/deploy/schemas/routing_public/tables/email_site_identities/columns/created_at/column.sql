-- Deploy: schemas/routing_public/tables/email_site_identities/columns/created_at/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/email_site_identities/table


ALTER TABLE routing_public.email_site_identities 
  ADD COLUMN created_at timestamptz;