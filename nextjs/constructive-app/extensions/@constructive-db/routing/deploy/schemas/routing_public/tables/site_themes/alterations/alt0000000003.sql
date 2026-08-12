-- Deploy: schemas/routing_public/tables/site_themes/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/site_themes/table


COMMENT ON TABLE routing_public.site_themes IS '@scope database
@scopeKey database_id
@scopeTier database
Theme (colors, fonts, design tokens) for a site surface';