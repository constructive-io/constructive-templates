-- Deploy: schemas/routing_public/tables/sites/columns/installation_id/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/sites/table
-- requires: schemas/routing_public/tables/sites/columns/installation_id/column
-- requires: schemas/routing_public/tables/sites/columns/installation_member_slug/column


ALTER TABLE routing_public.sites 
  ADD CONSTRAINT sites_installation_id_installation_member_slug_chk 
    CHECK (num_nonnulls(installation_id, installation_member_slug) <> 1);