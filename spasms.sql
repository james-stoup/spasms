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

SET default_tablespace = '';

SET default_with_oids = false;

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
    gender character(1) NOT NULL,
    group_name character varying(250)
);


ALTER TABLE public.twitter_users OWNER TO postgres;

--
-- Data for Name: twitter_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY twitter_users (id, id_str, screen_name, location, created_at, followers, favourites, statuses, description, gender, group_name) FROM stdin;
\.


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
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

