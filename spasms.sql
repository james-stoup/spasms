--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: gender; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN gender AS character(1)
	CONSTRAINT gender_check CHECK ((VALUE = ANY (ARRAY['m'::bpchar, 'f'::bpchar])));


ALTER DOMAIN public.gender OWNER TO postgres;

--
-- Name: nametypes; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN nametypes AS character varying(10)
	CONSTRAINT nametypes_check CHECK (((VALUE)::text = ANY (ARRAY[('first'::character varying)::text, ('last'::character varying)::text])));


ALTER DOMAIN public.nametypes OWNER TO postgres;

--
-- Name: sentencetypes; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN sentencetypes AS character varying(15)
	CONSTRAINT sentencetypes_check CHECK (((VALUE)::text = ANY (ARRAY[('FluffNoun/AdveAdverb'::character varying)::text, ('Adjective/Noun'::character varying)::text, ('Adjective'::character varying)::text])));


ALTER DOMAIN public.sentencetypes OWNER TO postgres;

--
-- Name: wordtypes; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN wordtypes AS character varying(15)
	CONSTRAINT wordtypes_check CHECK (((VALUE)::text = ANY (ARRAY[('noun'::character varying)::text, ('adjective'::character varying)::text, ('adverb'::character varying)::text, ('verb'::character varying)::text])));


ALTER DOMAIN public.wordtypes OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: locations; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE locations (
    id numeric(9,0) NOT NULL,
    city character varying(20) NOT NULL,
    state character varying(20),
    country character varying(30) NOT NULL
);


ALTER TABLE public.locations OWNER TO postgres;

--
-- Name: names; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE names (
    name character varying(200) NOT NULL,
    name_type nametypes NOT NULL,
    region character varying(250)
);


ALTER TABLE public.names OWNER TO postgres;

--
-- Name: sentence_frag; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sentence_frag (
    fragment character varying(250),
    id numeric(6,0),
    type sentencetypes
);


ALTER TABLE public.sentence_frag OWNER TO postgres;

--
-- Name: twitter_posts; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE twitter_posts (
    user_id numeric(10,0) NOT NULL,
    id numeric(19,0) NOT NULL,
    id_str character(19) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    text character varying(240),
    hashtags character varying(100),
    urls character varying(100),
    user_mention character varying(15),
    symbols character varying(500)
);


ALTER TABLE public.twitter_posts OWNER TO postgres;

--
-- Name: twitter_users; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE twitter_users (
    id numeric(9,0) NOT NULL,
    id_str character(9) NOT NULL,
    screen_name character varying(15) NOT NULL,
    location character varying(50),
    created_at timestamp without time zone NOT NULL,
    followers numeric(9,0) NOT NULL,
    favourites numeric(9,0) NOT NULL,
    statuses numeric(9,0) NOT NULL,
    description character varying(160),
    gender gender NOT NULL,
    group_name character varying(250)
);


ALTER TABLE public.twitter_users OWNER TO postgres;

--
-- Name: words; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE words (
    word character varying(20) NOT NULL,
    sentiment numeric(1,0) NOT NULL,
    type wordtypes
);


ALTER TABLE public.words OWNER TO postgres;

--
-- Data for Name: locations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY locations (id, city, state, country) FROM stdin;
\.


--
-- Data for Name: names; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY names (name, name_type, region) FROM stdin;
\.


--
-- Data for Name: sentence_frag; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sentence_frag (fragment, id, type) FROM stdin;
\.


--
-- Data for Name: twitter_posts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY twitter_posts (user_id, id, id_str, created_at, text, hashtags, urls, user_mention, symbols) FROM stdin;
\.


--
-- Data for Name: twitter_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY twitter_users (id, id_str, screen_name, location, created_at, followers, favourites, statuses, description, gender, group_name) FROM stdin;
\.


--
-- Data for Name: words; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY words (word, sentiment, type) FROM stdin;
\.


--
-- Name: names_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY names
    ADD CONSTRAINT names_pkey PRIMARY KEY (name);


--
-- Name: twitter_posts_id_str_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY twitter_posts
    ADD CONSTRAINT twitter_posts_id_str_key UNIQUE (id_str);


--
-- Name: twitter_posts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY twitter_posts
    ADD CONSTRAINT twitter_posts_pkey PRIMARY KEY (id);


--
-- Name: twitter_posts_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY twitter_posts
    ADD CONSTRAINT twitter_posts_user_id_key UNIQUE (user_id);


--
-- Name: twitter_users_id_str_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY twitter_users
    ADD CONSTRAINT twitter_users_id_str_key UNIQUE (id_str);


--
-- Name: twitter_users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY twitter_users
    ADD CONSTRAINT twitter_users_pkey PRIMARY KEY (id);


--
-- Name: twitter_users_screen_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY twitter_users
    ADD CONSTRAINT twitter_users_screen_name_key UNIQUE (screen_name);


--
-- Name: twitter_posts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY twitter_posts
    ADD CONSTRAINT twitter_posts_user_id_fkey FOREIGN KEY (user_id) REFERENCES twitter_users(id);


--
-- Name: twitter_posts_user_mention_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY twitter_posts
    ADD CONSTRAINT twitter_posts_user_mention_fkey FOREIGN KEY (user_mention) REFERENCES twitter_users(screen_name);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

