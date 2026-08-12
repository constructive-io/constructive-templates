-- Revert: schemas/routing_public/tables/platform_email_identities/columns/reply_to_address/column


ALTER TABLE routing_public.platform_email_identities 
  DROP COLUMN reply_to_address RESTRICT;