-- Deploy: schemas/routing_public/tables/site_app_links/columns/team_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/site_app_links/columns/team_id/column


COMMENT ON COLUMN routing_public.site_app_links.team_id IS 'Apple Developer team id (iOS); combined with app_identifier to form the AASA appID';