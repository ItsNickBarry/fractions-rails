CREATE TABLE "schema_migrations" ("version" varchar NOT NULL);
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "username" varchar, "uuid" varchar NOT NULL, "password_digest" varchar NOT NULL, "session_token" varchar NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "current_character_id" integer);
CREATE INDEX "index_users_on_username" ON "users" ("username");
CREATE UNIQUE INDEX "index_users_on_uuid" ON "users" ("uuid");
CREATE UNIQUE INDEX "index_users_on_session_token" ON "users" ("session_token");
CREATE TABLE "banishments" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "character_id" integer NOT NULL, "fraction_id" integer NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE UNIQUE INDEX "index_banishments_on_character_id_and_fraction_id" ON "banishments" ("character_id", "fraction_id");
CREATE INDEX "index_banishments_on_fraction_id" ON "banishments" ("fraction_id");
CREATE TABLE "positions" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "fraction_id" integer NOT NULL, "name" varchar NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE INDEX "index_positions_on_fraction_id" ON "positions" ("fraction_id");
CREATE TABLE "position_memberships" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "character_id" integer NOT NULL, "position_id" integer NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE UNIQUE INDEX "index_position_memberships_on_character_id_and_position_id" ON "position_memberships" ("character_id", "position_id");
CREATE INDEX "index_position_memberships_on_position_id" ON "position_memberships" ("position_id");
CREATE TABLE "regions" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "fraction_id" integer NOT NULL, "name" varchar NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE INDEX "index_regions_on_fraction_id" ON "regions" ("fraction_id");
CREATE TABLE "electorates" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "fraction_id" integer NOT NULL, "name" varchar NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE INDEX "index_electorates_on_fraction_id" ON "electorates" ("fraction_id");
CREATE TABLE "plots" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "region_id" integer, "world_id" integer NOT NULL, "x" integer NOT NULL, "z" integer NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE INDEX "index_plots_on_region_id" ON "plots" ("region_id");
CREATE UNIQUE INDEX "index_plots_on_world_id_and_x_and_z" ON "plots" ("world_id", "x", "z");
CREATE INDEX "index_plots_on_x" ON "plots" ("x");
CREATE INDEX "index_plots_on_z" ON "plots" ("z");
CREATE TABLE "worlds" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "fractions" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar NOT NULL, "ancestry" varchar, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "founder_id" integer NOT NULL, "founder_type" varchar NOT NULL, "description" text);
CREATE INDEX "index_fractions_on_ancestry" ON "fractions" ("ancestry");
CREATE INDEX "index_fractions_on_founder_type_and_founder_id" ON "fractions" ("founder_type", "founder_id");
CREATE TABLE "government_authorizations" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "authorizer_id" integer NOT NULL, "authorizer_type" varchar NOT NULL, "authorizee_id" integer NOT NULL, "authorizee_type" varchar NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "authorization_type" varchar NOT NULL);
CREATE UNIQUE INDEX "index_government_authorizations_uniquely" ON "government_authorizations" ("authorizer_type", "authorizer_id", "authorizee_type", "authorizee_id", "authorization_type");
CREATE TABLE "land_authorizations" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "authorizer_id" integer NOT NULL, "authorizee_id" integer NOT NULL, "authorizee_type" varchar NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "authorization_type" varchar NOT NULL);
CREATE INDEX "index_land_authorizations_on_authorizee" ON "land_authorizations" ("authorizee_type", "authorizee_id");
CREATE INDEX "index_land_authorizations_on_authorizer_id" ON "land_authorizations" ("authorizer_id");
CREATE TABLE "electorate_memberships" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "electorate_id" integer NOT NULL, "position_id" integer NOT NULL, "caller" boolean DEFAULT 'f' NOT NULL, "electoral" boolean DEFAULT 'f' NOT NULL, "absolute" boolean DEFAULT 'f' NOT NULL, "weight" float DEFAULT 1.0 NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE UNIQUE INDEX "index_electorate_memberships_uniquely" ON "electorate_memberships" ("electorate_id", "position_id");
CREATE UNIQUE INDEX index_fractions_on_name
          ON fractions (name COLLATE nocase)
;
CREATE UNIQUE INDEX index_positions_on_name_and_fraction_id
          ON positions (name COLLATE nocase, fraction_id)
;
CREATE UNIQUE INDEX index_electorates_on_name_and_fraction_id
          ON electorates (name COLLATE nocase, fraction_id)
;
CREATE UNIQUE INDEX index_regions_on_name_and_fraction_id
          ON regions (name COLLATE nocase, fraction_id)
;
CREATE TABLE "characters" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer, "name" varchar NOT NULL, "gender" varchar NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE INDEX "index_characters_on_user_id" ON "characters" ("user_id");
CREATE UNIQUE INDEX "index_characters_on_name" ON "characters" ("name");
CREATE TABLE "fraction_connection_requests" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "requester_id" integer NOT NULL, "requestee_id" integer NOT NULL, "offer" varchar NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE UNIQUE INDEX "index_fraction_connection_requests_uniquely" ON "fraction_connection_requests" ("requester_id", "requestee_id");
CREATE INDEX "index_fraction_connection_requests_on_requestee_id" ON "fraction_connection_requests" ("requestee_id");
CREATE TABLE "fraction_invitations" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "character_id" integer NOT NULL, "fraction_id" integer NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE UNIQUE INDEX "index_fraction_invitations_on_character_id_and_fraction_id" ON "fraction_invitations" ("character_id", "fraction_id");
CREATE INDEX "index_fraction_invitations_on_fraction_id" ON "fraction_invitations" ("fraction_id");
INSERT INTO schema_migrations (version) VALUES ('20150701014936');

INSERT INTO schema_migrations (version) VALUES ('20150702022821');

INSERT INTO schema_migrations (version) VALUES ('20150706001516');

INSERT INTO schema_migrations (version) VALUES ('20150706032347');

INSERT INTO schema_migrations (version) VALUES ('20150707000712');

INSERT INTO schema_migrations (version) VALUES ('20150707001951');

INSERT INTO schema_migrations (version) VALUES ('20150708014018');

INSERT INTO schema_migrations (version) VALUES ('20150709164942');

INSERT INTO schema_migrations (version) VALUES ('20150710194201');

INSERT INTO schema_migrations (version) VALUES ('20150711184320');

INSERT INTO schema_migrations (version) VALUES ('20150711185038');

INSERT INTO schema_migrations (version) VALUES ('20150715212121');

INSERT INTO schema_migrations (version) VALUES ('20150715212122');

INSERT INTO schema_migrations (version) VALUES ('20150829002726');

INSERT INTO schema_migrations (version) VALUES ('20150829214852');

INSERT INTO schema_migrations (version) VALUES ('20150829220612');

INSERT INTO schema_migrations (version) VALUES ('20150902225600');

INSERT INTO schema_migrations (version) VALUES ('20150907182232');

INSERT INTO schema_migrations (version) VALUES ('20150907201532');

INSERT INTO schema_migrations (version) VALUES ('20150907203728');

INSERT INTO schema_migrations (version) VALUES ('20150909212632');

INSERT INTO schema_migrations (version) VALUES ('20150909223605');

INSERT INTO schema_migrations (version) VALUES ('20150910014110');

INSERT INTO schema_migrations (version) VALUES ('20160503015856');

INSERT INTO schema_migrations (version) VALUES ('20160504032115');

INSERT INTO schema_migrations (version) VALUES ('20160504040629');

INSERT INTO schema_migrations (version) VALUES ('20160528232230');

