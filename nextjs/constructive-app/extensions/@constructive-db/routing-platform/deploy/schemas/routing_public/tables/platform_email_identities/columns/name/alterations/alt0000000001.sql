-- Deploy: schemas/routing_public/tables/platform_email_identities/columns/name/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_email_identities/table
-- requires: schemas/routing_public/tables/platform_email_identities/columns/name/column


ALTER TABLE routing_public.platform_email_identities 
  ALTER COLUMN name SET NOT NULL;