-- Deploy: schemas/routing_public/tables/platform_email_identities/columns/id/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_email_identities/table


ALTER TABLE routing_public.platform_email_identities 
  ADD COLUMN id uuid;