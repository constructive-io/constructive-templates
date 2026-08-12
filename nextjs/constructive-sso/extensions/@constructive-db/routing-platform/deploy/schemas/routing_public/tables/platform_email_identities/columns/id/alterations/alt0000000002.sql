-- Deploy: schemas/routing_public/tables/platform_email_identities/columns/id/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_email_identities/table
-- requires: schemas/routing_public/tables/platform_email_identities/columns/id/column


ALTER TABLE routing_public.platform_email_identities 
  ALTER COLUMN id SET DEFAULT uuidv7();