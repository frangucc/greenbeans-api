--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: beans; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE beans (
    id integer NOT NULL,
    code character varying(255) NOT NULL,
    token_id integer NOT NULL,
    used_on character varying(255) DEFAULT 'none'::character varying,
    redeemed boolean DEFAULT false,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    user_id integer
);


--
-- Name: beans_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE beans_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: beans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE beans_id_seq OWNED BY beans.id;


--
-- Name: merchants; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE merchants (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    name character varying(255) NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    authentication_token character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: merchants_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE merchants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: merchants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE merchants_id_seq OWNED BY merchants.id;


--
-- Name: prizes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE prizes (
    id integer NOT NULL,
    raffle_id integer,
    tier text DEFAULT '---
:first: 0
:second: 0
:third: 0
'::text,
    p_type character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    title character varying(255)
);


--
-- Name: prizes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE prizes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: prizes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE prizes_id_seq OWNED BY prizes.id;


--
-- Name: raffles; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE raffles (
    id integer NOT NULL,
    num_of_winner integer,
    name character varying(255),
    description text,
    drawing_time timestamp without time zone,
    repeat boolean,
    instructions text,
    merchant_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: raffles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE raffles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: raffles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE raffles_id_seq OWNED BY raffles.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: tokens; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE tokens (
    id integer NOT NULL,
    code character varying(255) NOT NULL,
    merchant_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tokens_id_seq OWNED BY tokens.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    authentication_token character varying(255)
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY beans ALTER COLUMN id SET DEFAULT nextval('beans_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY merchants ALTER COLUMN id SET DEFAULT nextval('merchants_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY prizes ALTER COLUMN id SET DEFAULT nextval('prizes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY raffles ALTER COLUMN id SET DEFAULT nextval('raffles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tokens ALTER COLUMN id SET DEFAULT nextval('tokens_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: beans_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY beans
    ADD CONSTRAINT beans_pkey PRIMARY KEY (id);


--
-- Name: merchants_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY merchants
    ADD CONSTRAINT merchants_pkey PRIMARY KEY (id);


--
-- Name: prizes_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY prizes
    ADD CONSTRAINT prizes_pkey PRIMARY KEY (id);


--
-- Name: raffles_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY raffles
    ADD CONSTRAINT raffles_pkey PRIMARY KEY (id);


--
-- Name: tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tokens
    ADD CONSTRAINT tokens_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_beans_on_code; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_beans_on_code ON beans USING btree (code);


--
-- Name: index_beans_on_token_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_beans_on_token_id ON beans USING btree (token_id);


--
-- Name: index_beans_on_used_on; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_beans_on_used_on ON beans USING btree (used_on);


--
-- Name: index_merchants_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_merchants_on_email ON merchants USING btree (email);


--
-- Name: index_merchants_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_merchants_on_name ON merchants USING btree (name);


--
-- Name: index_merchants_on_reset_password_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_merchants_on_reset_password_token ON merchants USING btree (reset_password_token);


--
-- Name: index_prizes_on_raffle_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_prizes_on_raffle_id ON prizes USING btree (raffle_id);


--
-- Name: index_raffles_on_merchant_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_raffles_on_merchant_id ON raffles USING btree (merchant_id);


--
-- Name: index_tokens_on_code; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_tokens_on_code ON tokens USING btree (code);


--
-- Name: index_tokens_on_merchant_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_tokens_on_merchant_id ON tokens USING btree (merchant_id);


--
-- Name: index_tokens_on_merchant_id_and_code; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_tokens_on_merchant_id_and_code ON tokens USING btree (merchant_id, code);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

INSERT INTO schema_migrations (version) VALUES ('20130112035627');

INSERT INTO schema_migrations (version) VALUES ('20130112052921');

INSERT INTO schema_migrations (version) VALUES ('20130112052931');

INSERT INTO schema_migrations (version) VALUES ('20130114070947');

INSERT INTO schema_migrations (version) VALUES ('20130115072448');

INSERT INTO schema_migrations (version) VALUES ('20130115080845');

INSERT INTO schema_migrations (version) VALUES ('20130123033616');

INSERT INTO schema_migrations (version) VALUES ('20130123040305');

INSERT INTO schema_migrations (version) VALUES ('20130212064725');