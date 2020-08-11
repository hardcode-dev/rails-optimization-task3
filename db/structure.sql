SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA public;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_stat_statements IS 'track execution statistics of all SQL statements executed';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: buses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.buses (
    id bigint NOT NULL,
    number character varying,
    model character varying
);


--
-- Name: buses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.buses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: buses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.buses_id_seq OWNED BY public.buses.id;


--
-- Name: buses_services; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.buses_services (
    id bigint NOT NULL,
    bus_id integer,
    service_id integer
);


--
-- Name: buses_services_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.buses_services_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: buses_services_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.buses_services_id_seq OWNED BY public.buses_services.id;


--
-- Name: cities; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cities (
    id bigint NOT NULL,
    name character varying
);


--
-- Name: cities_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cities_id_seq OWNED BY public.cities.id;


--
-- Name: pghero_query_stats; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pghero_query_stats (
    id bigint NOT NULL,
    database text,
    "user" text,
    query text,
    query_hash bigint,
    total_time double precision,
    calls bigint,
    captured_at timestamp without time zone
);


--
-- Name: pghero_query_stats_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pghero_query_stats_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pghero_query_stats_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pghero_query_stats_id_seq OWNED BY public.pghero_query_stats.id;


--
-- Name: pghero_space_stats; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pghero_space_stats (
    id bigint NOT NULL,
    database text,
    schema text,
    relation text,
    size bigint,
    captured_at timestamp without time zone
);


--
-- Name: pghero_space_stats_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pghero_space_stats_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pghero_space_stats_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pghero_space_stats_id_seq OWNED BY public.pghero_space_stats.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: services; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.services (
    id bigint NOT NULL,
    name character varying
);


--
-- Name: services_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.services_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: services_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.services_id_seq OWNED BY public.services.id;


--
-- Name: trips; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.trips (
    id bigint NOT NULL,
    from_id integer NOT NULL,
    to_id integer NOT NULL,
    start_time character varying,
    duration_minutes integer NOT NULL,
    price_cents integer NOT NULL,
    bus_id integer,
    CONSTRAINT check_greater_then_zero_duration_minutes CHECK ((duration_minutes > 0)),
    CONSTRAINT check_greater_then_zero_price_cents CHECK ((price_cents > 0)),
    CONSTRAINT check_start_time_with_regex CHECK (((start_time)::text ~* '([0-1][0-9]|[2][0-3]):[0-5][0-9]'::text))
);


--
-- Name: trips_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.trips_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: trips_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.trips_id_seq OWNED BY public.trips.id;


--
-- Name: buses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.buses ALTER COLUMN id SET DEFAULT nextval('public.buses_id_seq'::regclass);


--
-- Name: buses_services id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.buses_services ALTER COLUMN id SET DEFAULT nextval('public.buses_services_id_seq'::regclass);


--
-- Name: cities id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cities ALTER COLUMN id SET DEFAULT nextval('public.cities_id_seq'::regclass);


--
-- Name: pghero_query_stats id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pghero_query_stats ALTER COLUMN id SET DEFAULT nextval('public.pghero_query_stats_id_seq'::regclass);


--
-- Name: pghero_space_stats id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pghero_space_stats ALTER COLUMN id SET DEFAULT nextval('public.pghero_space_stats_id_seq'::regclass);


--
-- Name: services id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.services ALTER COLUMN id SET DEFAULT nextval('public.services_id_seq'::regclass);


--
-- Name: trips id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.trips ALTER COLUMN id SET DEFAULT nextval('public.trips_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: buses buses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.buses
    ADD CONSTRAINT buses_pkey PRIMARY KEY (id);


--
-- Name: buses_services buses_services_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.buses_services
    ADD CONSTRAINT buses_services_pkey PRIMARY KEY (id);


--
-- Name: cities cities_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_pkey PRIMARY KEY (id);


--
-- Name: pghero_query_stats pghero_query_stats_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pghero_query_stats
    ADD CONSTRAINT pghero_query_stats_pkey PRIMARY KEY (id);


--
-- Name: pghero_space_stats pghero_space_stats_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pghero_space_stats
    ADD CONSTRAINT pghero_space_stats_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: services services_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_pkey PRIMARY KEY (id);


--
-- Name: trips trips_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.trips
    ADD CONSTRAINT trips_pkey PRIMARY KEY (id);


--
-- Name: index_buses_on_number_and_model; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_buses_on_number_and_model ON public.buses USING btree (number, model);


--
-- Name: index_pghero_query_stats_on_database_and_captured_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pghero_query_stats_on_database_and_captured_at ON public.pghero_query_stats USING btree (database, captured_at);


--
-- Name: index_pghero_space_stats_on_database_and_captured_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pghero_space_stats_on_database_and_captured_at ON public.pghero_space_stats USING btree (database, captured_at);


--
-- Name: index_trips_on_from_id_and_to_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_trips_on_from_id_and_to_id ON public.trips USING btree (from_id, to_id);


--
-- Name: trips fk_rails_7059af2548; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.trips
    ADD CONSTRAINT fk_rails_7059af2548 FOREIGN KEY (from_id) REFERENCES public.cities(id);


--
-- Name: trips fk_rails_9d797532ab; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.trips
    ADD CONSTRAINT fk_rails_9d797532ab FOREIGN KEY (to_id) REFERENCES public.cities(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20190330192820'),
('20190330192933'),
('20190330193017'),
('20190330193027'),
('20190330193044'),
('20200809171338'),
('20200809171428'),
('20200809175146'),
('20200811064938');


