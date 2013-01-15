--
-- Name: charities; Type: TABLE; Schema: public; Owner: foodcircles; Tablespace: 
--

CREATE TABLE charities (
    id integer NOT NULL,
    name character varying(255),
    web character varying(255),
    region_id integer,
    address character varying(255),
    city character varying(255),
    state_id integer,
    zip character varying(255),
    description text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    image_uid character varying(255)
);


ALTER TABLE public.charities OWNER TO foodcircles;

--
-- Name: charities_id_seq; Type: SEQUENCE; Schema: public; Owner: foodcircles
--

CREATE SEQUENCE charities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.charities_id_seq OWNER TO foodcircles;

--
-- Name: charities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: foodcircles
--

ALTER SEQUENCE charities_id_seq OWNED BY charities.id;


--
-- Name: charities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: foodcircles
--

SELECT pg_catalog.setval('charities_id_seq', 2, true);


--
-- Name: delayed_jobs; Type: TABLE; Schema: public; Owner: foodcircles; Tablespace: 
--

CREATE TABLE delayed_jobs (
    id integer NOT NULL,
    priority integer DEFAULT 0,
    attempts integer DEFAULT 0,
    handler text,
    last_error text,
    run_at timestamp without time zone,
    locked_at timestamp without time zone,
    failed_at timestamp without time zone,
    locked_by character varying(255),
    queue character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.delayed_jobs OWNER TO foodcircles;

--
-- Name: delayed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: foodcircles
--

CREATE SEQUENCE delayed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.delayed_jobs_id_seq OWNER TO foodcircles;

--
-- Name: delayed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: foodcircles
--

ALTER SEQUENCE delayed_jobs_id_seq OWNED BY delayed_jobs.id;


--
-- Name: delayed_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: foodcircles
--

SELECT pg_catalog.setval('delayed_jobs_id_seq', 481, true);


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: foodcircles; Tablespace: 
--

CREATE TABLE notifications (
    id integer NOT NULL,
    content character varying(255),
    ticker character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.notifications OWNER TO foodcircles;

--
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: foodcircles
--

CREATE SEQUENCE notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notifications_id_seq OWNER TO foodcircles;

--
-- Name: notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: foodcircles
--

ALTER SEQUENCE notifications_id_seq OWNED BY notifications.id;


--
-- Name: notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: foodcircles
--

SELECT pg_catalog.setval('notifications_id_seq', 3, true);


--
-- Name: offers; Type: TABLE; Schema: public; Owner: foodcircles; Tablespace: 
--

CREATE TABLE offers (
    id integer NOT NULL,
    venue_id integer,
    name character varying(255),
    details text,
    min_diners integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.offers OWNER TO foodcircles;

--
-- Name: offers_id_seq; Type: SEQUENCE; Schema: public; Owner: foodcircles
--

CREATE SEQUENCE offers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.offers_id_seq OWNER TO foodcircles;

--
-- Name: offers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: foodcircles
--

ALTER SEQUENCE offers_id_seq OWNED BY offers.id;


--
-- Name: offers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: foodcircles
--

SELECT pg_catalog.setval('offers_id_seq', 67, true);


--
-- Name: open_times; Type: TABLE; Schema: public; Owner: foodcircles; Tablespace: 
--

CREATE TABLE open_times (
    id integer NOT NULL,
    openable_id integer,
    openable_type character varying(255),
    start integer,
    "end" integer,
    start_date date,
    end_date date,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.open_times OWNER TO foodcircles;

--
-- Name: open_times_id_seq; Type: SEQUENCE; Schema: public; Owner: foodcircles
--

CREATE SEQUENCE open_times_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.open_times_id_seq OWNER TO foodcircles;

--
-- Name: open_times_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: foodcircles
--

ALTER SEQUENCE open_times_id_seq OWNED BY open_times.id;


--
-- Name: open_times_id_seq; Type: SEQUENCE SET; Schema: public; Owner: foodcircles
--

SELECT pg_catalog.setval('open_times_id_seq', 684, true);


--
-- Name: rails_admin_histories; Type: TABLE; Schema: public; Owner: foodcircles; Tablespace: 
--

CREATE TABLE rails_admin_histories (
    id integer NOT NULL,
    message text,
    username character varying(255),
    item integer,
    "table" character varying(255),
    month smallint,
    year bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.rails_admin_histories OWNER TO foodcircles;

--
-- Name: rails_admin_histories_id_seq; Type: SEQUENCE; Schema: public; Owner: foodcircles
--

CREATE SEQUENCE rails_admin_histories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rails_admin_histories_id_seq OWNER TO foodcircles;

--
-- Name: rails_admin_histories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: foodcircles
--

ALTER SEQUENCE rails_admin_histories_id_seq OWNED BY rails_admin_histories.id;


--
-- Name: rails_admin_histories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: foodcircles
--

SELECT pg_catalog.setval('rails_admin_histories_id_seq', 1, false);


--
-- Name: regions; Type: TABLE; Schema: public; Owner: foodcircles; Tablespace: 
--

CREATE TABLE regions (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.regions OWNER TO foodcircles;

--
-- Name: regions_id_seq; Type: SEQUENCE; Schema: public; Owner: foodcircles
--

CREATE SEQUENCE regions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.regions_id_seq OWNER TO foodcircles;

--
-- Name: regions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: foodcircles
--

ALTER SEQUENCE regions_id_seq OWNED BY regions.id;


--
-- Name: regions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: foodcircles
--

SELECT pg_catalog.setval('regions_id_seq', 2, true);


--
-- Name: remind_lists; Type: TABLE; Schema: public; Owner: foodcircles; Tablespace: 
--

CREATE TABLE remind_lists (
    id integer NOT NULL,
    phone character varying(255),
    email character varying(255),
    blah character varying(255),
    last_reminded timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.remind_lists OWNER TO foodcircles;

--
-- Name: remind_lists_id_seq; Type: SEQUENCE; Schema: public; Owner: foodcircles
--

CREATE SEQUENCE remind_lists_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.remind_lists_id_seq OWNER TO foodcircles;

--
-- Name: remind_lists_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: foodcircles
--

ALTER SEQUENCE remind_lists_id_seq OWNED BY remind_lists.id;


--
-- Name: remind_lists_id_seq; Type: SEQUENCE SET; Schema: public; Owner: foodcircles
--

SELECT pg_catalog.setval('remind_lists_id_seq', 84, true);


--
-- Name: reservations; Type: TABLE; Schema: public; Owner: foodcircles; Tablespace: 
--

CREATE TABLE reservations (
    id integer NOT NULL,
    user_id integer,
    venue_id integer,
    offer_id integer,
    charity_id integer,
    num_diners integer,
    occasion character varying(255),
    confirmed boolean,
    time_confirmed timestamp without time zone,
    coupon character varying(255),
    name character varying(255),
    phone character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    called boolean DEFAULT false
);


ALTER TABLE public.reservations OWNER TO foodcircles;

--
-- Name: reservations_id_seq; Type: SEQUENCE; Schema: public; Owner: foodcircles
--

CREATE SEQUENCE reservations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reservations_id_seq OWNER TO foodcircles;

--
-- Name: reservations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: foodcircles
--

ALTER SEQUENCE reservations_id_seq OWNED BY reservations.id;


--
-- Name: reservations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: foodcircles
--

SELECT pg_catalog.setval('reservations_id_seq', 722, true);


--
-- Name: reviews; Type: TABLE; Schema: public; Owner: foodcircles; Tablespace: 
--

CREATE TABLE reviews (
    id integer NOT NULL,
    author_name character varying(255),
    content text,
    rating integer,
    venue_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    "time" integer
);


ALTER TABLE public.reviews OWNER TO foodcircles;

--
-- Name: reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: foodcircles
--

CREATE SEQUENCE reviews_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reviews_id_seq OWNER TO foodcircles;

--
-- Name: reviews_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: foodcircles
--

ALTER SEQUENCE reviews_id_seq OWNED BY reviews.id;


--
-- Name: reviews_id_seq; Type: SEQUENCE SET; Schema: public; Owner: foodcircles
--

SELECT pg_catalog.setval('reviews_id_seq', 467, true);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: foodcircles; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO foodcircles;

--
-- Name: states; Type: TABLE; Schema: public; Owner: foodcircles; Tablespace: 
--

CREATE TABLE states (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.states OWNER TO foodcircles;

--
-- Name: states_id_seq; Type: SEQUENCE; Schema: public; Owner: foodcircles
--

CREATE SEQUENCE states_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.states_id_seq OWNER TO foodcircles;

--
-- Name: states_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: foodcircles
--

ALTER SEQUENCE states_id_seq OWNED BY states.id;


--
-- Name: states_id_seq; Type: SEQUENCE SET; Schema: public; Owner: foodcircles
--

SELECT pg_catalog.setval('states_id_seq', 1, true);


--
-- Name: time_zones; Type: TABLE; Schema: public; Owner: foodcircles; Tablespace: 
--

CREATE TABLE time_zones (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.time_zones OWNER TO foodcircles;

--
-- Name: time_zones_id_seq; Type: SEQUENCE; Schema: public; Owner: foodcircles
--

CREATE SEQUENCE time_zones_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.time_zones_id_seq OWNER TO foodcircles;

--
-- Name: time_zones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: foodcircles
--

ALTER SEQUENCE time_zones_id_seq OWNED BY time_zones.id;


--
-- Name: time_zones_id_seq; Type: SEQUENCE SET; Schema: public; Owner: foodcircles
--

SELECT pg_catalog.setval('time_zones_id_seq', 1, true);


--
-- Name: users; Type: TABLE; Schema: public; Owner: foodcircles; Tablespace: 
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
    name character varying(255),
    phone character varying(255),
    admin boolean DEFAULT false
);


ALTER TABLE public.users OWNER TO foodcircles;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: foodcircles
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO foodcircles;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: foodcircles
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: foodcircles
--

SELECT pg_catalog.setval('users_id_seq', 234, true);


--
-- Name: venue_taggables; Type: TABLE; Schema: public; Owner: foodcircles; Tablespace: 
--

CREATE TABLE venue_taggables (
    id integer NOT NULL,
    venue_tag_id integer,
    venue_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.venue_taggables OWNER TO foodcircles;

--
-- Name: venue_taggables_id_seq; Type: SEQUENCE; Schema: public; Owner: foodcircles
--

CREATE SEQUENCE venue_taggables_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.venue_taggables_id_seq OWNER TO foodcircles;

--
-- Name: venue_taggables_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: foodcircles
--

ALTER SEQUENCE venue_taggables_id_seq OWNED BY venue_taggables.id;


--
-- Name: venue_taggables_id_seq; Type: SEQUENCE SET; Schema: public; Owner: foodcircles
--

SELECT pg_catalog.setval('venue_taggables_id_seq', 19, true);


--
-- Name: venue_tags; Type: TABLE; Schema: public; Owner: foodcircles; Tablespace: 
--

CREATE TABLE venue_tags (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.venue_tags OWNER TO foodcircles;

--
-- Name: venue_tags_id_seq; Type: SEQUENCE; Schema: public; Owner: foodcircles
--

CREATE SEQUENCE venue_tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.venue_tags_id_seq OWNER TO foodcircles;

--
-- Name: venue_tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: foodcircles
--

ALTER SEQUENCE venue_tags_id_seq OWNED BY venue_tags.id;


--
-- Name: venue_tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: foodcircles
--

SELECT pg_catalog.setval('venue_tags_id_seq', 7, true);


--
-- Name: venues; Type: TABLE; Schema: public; Owner: foodcircles; Tablespace: 
--

CREATE TABLE venues (
    id integer NOT NULL,
    name character varying(255),
    user_id integer,
    description text,
    address character varying(255),
    city character varying(255),
    state_id integer,
    zip character varying(255),
    neighborhood character varying(255),
    web character varying(255),
    price integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    image_uid character varying(255),
    phone character varying(255),
    circle_image_uid character varying(255),
    time_zone_id integer,
    rating double precision,
    reference character varying(255),
    active boolean DEFAULT true,
    --latlon postgis.geography(Point,4326)
);


ALTER TABLE public.venues OWNER TO foodcircles;

--
-- Name: venues_id_seq; Type: SEQUENCE; Schema: public; Owner: foodcircles
--

CREATE SEQUENCE venues_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.venues_id_seq OWNER TO foodcircles;

--
-- Name: venues_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: foodcircles
--

ALTER SEQUENCE venues_id_seq OWNED BY venues.id;


--
-- Name: venues_id_seq; Type: SEQUENCE SET; Schema: public; Owner: foodcircles
--

SELECT pg_catalog.setval('venues_id_seq', 21, true);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: foodcircles
--

ALTER TABLE ONLY charities ALTER COLUMN id SET DEFAULT nextval('charities_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: foodcircles
--

ALTER TABLE ONLY delayed_jobs ALTER COLUMN id SET DEFAULT nextval('delayed_jobs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: foodcircles
--

ALTER TABLE ONLY notifications ALTER COLUMN id SET DEFAULT nextval('notifications_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: foodcircles
--

ALTER TABLE ONLY offers ALTER COLUMN id SET DEFAULT nextval('offers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: foodcircles
--

ALTER TABLE ONLY open_times ALTER COLUMN id SET DEFAULT nextval('open_times_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: foodcircles
--

ALTER TABLE ONLY rails_admin_histories ALTER COLUMN id SET DEFAULT nextval('rails_admin_histories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: foodcircles
--

ALTER TABLE ONLY regions ALTER COLUMN id SET DEFAULT nextval('regions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: foodcircles
--

ALTER TABLE ONLY remind_lists ALTER COLUMN id SET DEFAULT nextval('remind_lists_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: foodcircles
--

ALTER TABLE ONLY reservations ALTER COLUMN id SET DEFAULT nextval('reservations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: foodcircles
--

ALTER TABLE ONLY reviews ALTER COLUMN id SET DEFAULT nextval('reviews_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: foodcircles
--

ALTER TABLE ONLY states ALTER COLUMN id SET DEFAULT nextval('states_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: foodcircles
--

ALTER TABLE ONLY time_zones ALTER COLUMN id SET DEFAULT nextval('time_zones_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: foodcircles
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: foodcircles
--

ALTER TABLE ONLY venue_taggables ALTER COLUMN id SET DEFAULT nextval('venue_taggables_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: foodcircles
--

ALTER TABLE ONLY venue_tags ALTER COLUMN id SET DEFAULT nextval('venue_tags_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: foodcircles
--

ALTER TABLE ONLY venues ALTER COLUMN id SET DEFAULT nextval('venues_id_seq'::regclass);


SET search_path = postgis, pg_catalog;


