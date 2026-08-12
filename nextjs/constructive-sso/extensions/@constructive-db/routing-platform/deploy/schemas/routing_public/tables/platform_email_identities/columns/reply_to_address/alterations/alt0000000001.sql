-- Deploy: schemas/routing_public/tables/platform_email_identities/columns/reply_to_address/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_email_identities/columns/reply_to_address/column


COMMENT ON COLUMN routing_public.platform_email_identities.reply_to_address IS 'Reply-To address when replies should not go to the from address';