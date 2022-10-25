--
-- PostgreSQL database dump
--

-- Dumped from database version 14.5
-- Dumped by pg_dump version 14.5

-- Started on 2022-10-05 11:29:06

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 210 (class 1259 OID 52275)
-- Name: aikuinenvasa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aikuinenvasa (
    ikaluokka character varying(10) NOT NULL
);


ALTER TABLE public.aikuinenvasa OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 52285)
-- Name: elain; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.elain (
    elaimen_nimi character varying(20) NOT NULL
);


ALTER TABLE public.elain OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 52332)
-- Name: jakoryhma; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jakoryhma (
    ryhma_id integer NOT NULL,
    seurue_id integer NOT NULL,
    ryhman_nimi character varying(50) NOT NULL
);


ALTER TABLE public.jakoryhma OWNER TO postgres;

--
-- TOC entry 3456 (class 0 OID 0)
-- Dependencies: 225
-- Name: TABLE jakoryhma; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.jakoryhma IS 'Ryhmä, jolle lihaa jaetaan';


--
-- TOC entry 227 (class 1259 OID 52338)
-- Name: jakotapahtuma; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jakotapahtuma (
    tapahtuma_id integer NOT NULL,
    paiva date NOT NULL,
    ryhma_id integer NOT NULL,
    osnimitys character varying(20) NOT NULL,
    maara real NOT NULL,
    kaato_id integer
);


ALTER TABLE public.jakotapahtuma OWNER TO postgres;

--
-- TOC entry 3457 (class 0 OID 0)
-- Dependencies: 227
-- Name: COLUMN jakotapahtuma.maara; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.jakotapahtuma.maara IS 'Jaettu lihamäärä kiloina';


--
-- TOC entry 234 (class 1259 OID 68394)
-- Name: jaetut_lihat; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.jaetut_lihat AS
 SELECT jakoryhma.ryhman_nimi,
    sum(jakotapahtuma.maara) AS "yhteensä"
   FROM (public.jakoryhma
     LEFT JOIN public.jakotapahtuma ON ((jakotapahtuma.ryhma_id = jakoryhma.ryhma_id)))
  GROUP BY jakoryhma.ryhman_nimi
  ORDER BY jakoryhma.ryhman_nimi;


ALTER TABLE public.jaetut_lihat OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 52431)
-- Name: jakoryhma_ryhma_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.jakoryhma_ryhma_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.jakoryhma_ryhma_id_seq OWNER TO postgres;

--
-- TOC entry 3458 (class 0 OID 0)
-- Dependencies: 230
-- Name: jakoryhma_ryhma_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.jakoryhma_ryhma_id_seq OWNED BY public.jakoryhma.ryhma_id;


--
-- TOC entry 229 (class 1259 OID 52345)
-- Name: jasenyys; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jasenyys (
    jasenyys_id integer NOT NULL,
    ryhma_id integer NOT NULL,
    jasen_id integer NOT NULL,
    liittyi date NOT NULL,
    poistui date,
    osuus integer DEFAULT 100 NOT NULL
);


ALTER TABLE public.jasenyys OWNER TO postgres;

--
-- TOC entry 3459 (class 0 OID 0)
-- Dependencies: 229
-- Name: COLUMN jasenyys.osuus; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.jasenyys.osuus IS 'Muuta pakolliseksi (NOT NULL)';


--
-- TOC entry 233 (class 1259 OID 68385)
-- Name: jakoryhma_yhteenveto; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.jakoryhma_yhteenveto AS
 SELECT jakoryhma.ryhman_nimi AS "ryhmä",
    count(jasenyys.jasen_id) AS "jäseniä",
    ((sum(jasenyys.osuus))::double precision / (100)::real) AS "yhteensä"
   FROM (public.jakoryhma
     JOIN public.jasenyys ON ((jasenyys.ryhma_id = jakoryhma.ryhma_id)))
  GROUP BY jakoryhma.ryhman_nimi
  ORDER BY jakoryhma.ryhman_nimi;


ALTER TABLE public.jakoryhma_yhteenveto OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 52337)
-- Name: jakotapahtuma_tapahtuma_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.jakotapahtuma_tapahtuma_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.jakotapahtuma_tapahtuma_id_seq OWNER TO postgres;

--
-- TOC entry 3460 (class 0 OID 0)
-- Dependencies: 226
-- Name: jakotapahtuma_tapahtuma_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.jakotapahtuma_tapahtuma_id_seq OWNED BY public.jakotapahtuma.tapahtuma_id;


--
-- TOC entry 216 (class 1259 OID 52298)
-- Name: jasen; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jasen (
    jasen_id integer NOT NULL,
    etunimi character varying(50) NOT NULL,
    sukunimi character varying(50) NOT NULL,
    jakeluosoite character varying(30) NOT NULL,
    postinumero character varying(10) NOT NULL,
    postitoimipaikka character varying(30) NOT NULL
);


ALTER TABLE public.jasen OWNER TO postgres;

--
-- TOC entry 3461 (class 0 OID 0)
-- Dependencies: 216
-- Name: TABLE jasen; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.jasen IS 'Henkilö joka osallistuu metsästykseen tai lihanjakoon';


--
-- TOC entry 215 (class 1259 OID 52297)
-- Name: jasen_jasen_id_seq_1; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.jasen_jasen_id_seq_1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.jasen_jasen_id_seq_1 OWNER TO postgres;

--
-- TOC entry 3462 (class 0 OID 0)
-- Dependencies: 215
-- Name: jasen_jasen_id_seq_1; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.jasen_jasen_id_seq_1 OWNED BY public.jasen.jasen_id;


--
-- TOC entry 228 (class 1259 OID 52344)
-- Name: jasenyys_jasenyys_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.jasenyys_jasenyys_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.jasenyys_jasenyys_id_seq OWNER TO postgres;

--
-- TOC entry 3463 (class 0 OID 0)
-- Dependencies: 228
-- Name: jasenyys_jasenyys_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.jasenyys_jasenyys_id_seq OWNED BY public.jasenyys.jasenyys_id;


--
-- TOC entry 218 (class 1259 OID 52305)
-- Name: kaato; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kaato (
    kaato_id integer NOT NULL,
    jasen_id integer NOT NULL,
    kaatopaiva date NOT NULL,
    ruhopaino real NOT NULL,
    paikka_teksti character varying(100) NOT NULL,
    paikka_koordinaatti character varying(100) NOT NULL,
    kasittelyid integer NOT NULL,
    elaimen_nimi character varying(20) NOT NULL,
    sukupuoli character varying(10) NOT NULL,
    ikaluokka character varying(10) NOT NULL
);


ALTER TABLE public.kaato OWNER TO postgres;

--
-- TOC entry 3464 (class 0 OID 0)
-- Dependencies: 218
-- Name: TABLE kaato; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.kaato IS 'Ampumatapahtuman tiedot';


--
-- TOC entry 3465 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN kaato.ruhopaino; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.kaato.ruhopaino IS 'paino kiloina';


--
-- TOC entry 3466 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN kaato.paikka_koordinaatti; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.kaato.paikka_koordinaatti IS 'Tämän kentän tietotyyppi pitää oikeasti olla geometry (Postgis-tietotyyppi)';


--
-- TOC entry 217 (class 1259 OID 52304)
-- Name: kaato_kaato_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.kaato_kaato_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.kaato_kaato_id_seq OWNER TO postgres;

--
-- TOC entry 3467 (class 0 OID 0)
-- Dependencies: 217
-- Name: kaato_kaato_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.kaato_kaato_id_seq OWNED BY public.kaato.kaato_id;


--
-- TOC entry 214 (class 1259 OID 52291)
-- Name: kasittely; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kasittely (
    kasittelyid integer NOT NULL,
    kasittely_teksti character varying(50) NOT NULL
);


ALTER TABLE public.kasittely OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 52290)
-- Name: kasittely_kasittelyid_seq_1; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.kasittely_kasittelyid_seq_1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.kasittely_kasittelyid_seq_1 OWNER TO postgres;

--
-- TOC entry 3468 (class 0 OID 0)
-- Dependencies: 213
-- Name: kasittely_kasittelyid_seq_1; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.kasittely_kasittelyid_seq_1 OWNED BY public.kasittely.kasittelyid;


--
-- TOC entry 222 (class 1259 OID 52319)
-- Name: lupa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lupa (
    luparivi_id integer NOT NULL,
    seura_id integer NOT NULL,
    lupavuosi character varying(4) NOT NULL,
    elaimen_nimi character varying(20) NOT NULL,
    sukupuoli character varying(10) NOT NULL,
    ikaluokka character varying(10) NOT NULL,
    maara integer NOT NULL
);


ALTER TABLE public.lupa OWNER TO postgres;

--
-- TOC entry 3469 (class 0 OID 0)
-- Dependencies: 222
-- Name: TABLE lupa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.lupa IS 'Vuosittaiset kaatoluvat';


--
-- TOC entry 221 (class 1259 OID 52318)
-- Name: lupa_luparivi_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.lupa_luparivi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lupa_luparivi_id_seq OWNER TO postgres;

--
-- TOC entry 3470 (class 0 OID 0)
-- Dependencies: 221
-- Name: lupa_luparivi_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.lupa_luparivi_id_seq OWNED BY public.lupa.luparivi_id;


--
-- TOC entry 209 (class 1259 OID 52270)
-- Name: ruhonosa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ruhonosa (
    osnimitys character varying(20) NOT NULL
);


ALTER TABLE public.ruhonosa OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 68381)
-- Name: ryhmien_osuudet; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.ryhmien_osuudet AS
 SELECT jasenyys.ryhma_id AS "ryhmä",
    sum(jasenyys.osuus) AS "yhteensä"
   FROM public.jasenyys
  GROUP BY jasenyys.ryhma_id
  ORDER BY jasenyys.ryhma_id;


ALTER TABLE public.ryhmien_osuudet OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 52312)
-- Name: seura; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.seura (
    seura_id integer NOT NULL,
    seuran_nimi character varying(50) NOT NULL,
    jakeluosoite character varying(30) NOT NULL,
    postinumero character varying(10) NOT NULL,
    postitoimipaikka character varying(30) NOT NULL
);


ALTER TABLE public.seura OWNER TO postgres;

--
-- TOC entry 3471 (class 0 OID 0)
-- Dependencies: 220
-- Name: TABLE seura; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.seura IS 'Metsästysseuran tiedot';


--
-- TOC entry 219 (class 1259 OID 52311)
-- Name: seura_seura_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seura_seura_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seura_seura_id_seq OWNER TO postgres;

--
-- TOC entry 3472 (class 0 OID 0)
-- Dependencies: 219
-- Name: seura_seura_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.seura_seura_id_seq OWNED BY public.seura.seura_id;


--
-- TOC entry 224 (class 1259 OID 52326)
-- Name: seurue; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.seurue (
    seurue_id integer NOT NULL,
    seura_id integer NOT NULL,
    seurueen_nimi character varying(50) NOT NULL,
    jasen_id integer NOT NULL
);


ALTER TABLE public.seurue OWNER TO postgres;

--
-- TOC entry 3473 (class 0 OID 0)
-- Dependencies: 224
-- Name: TABLE seurue; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.seurue IS 'Metsästystä harjoittavan seurueen tiedot
';


--
-- TOC entry 3474 (class 0 OID 0)
-- Dependencies: 224
-- Name: COLUMN seurue.jasen_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.seurue.jasen_id IS 'Seurueen johtajan tunniste';


--
-- TOC entry 223 (class 1259 OID 52325)
-- Name: seurue_seurue_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seurue_seurue_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seurue_seurue_id_seq OWNER TO postgres;

--
-- TOC entry 3475 (class 0 OID 0)
-- Dependencies: 223
-- Name: seurue_seurue_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.seurue_seurue_id_seq OWNED BY public.seurue.seurue_id;


--
-- TOC entry 211 (class 1259 OID 52280)
-- Name: sukupuoli; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sukupuoli (
    sukupuoli character varying(10) NOT NULL
);


ALTER TABLE public.sukupuoli OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 52433)
-- Name: testi_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.testi_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.testi_seq OWNER TO postgres;

--
-- TOC entry 3476 (class 0 OID 0)
-- Dependencies: 231
-- Name: testi_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.testi_seq OWNED BY public.jakoryhma.ryhma_id;


--
-- TOC entry 3239 (class 2604 OID 52432)
-- Name: jakoryhma ryhma_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jakoryhma ALTER COLUMN ryhma_id SET DEFAULT nextval('public.jakoryhma_ryhma_id_seq'::regclass);


--
-- TOC entry 3240 (class 2604 OID 52341)
-- Name: jakotapahtuma tapahtuma_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jakotapahtuma ALTER COLUMN tapahtuma_id SET DEFAULT nextval('public.jakotapahtuma_tapahtuma_id_seq'::regclass);


--
-- TOC entry 3234 (class 2604 OID 52301)
-- Name: jasen jasen_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jasen ALTER COLUMN jasen_id SET DEFAULT nextval('public.jasen_jasen_id_seq_1'::regclass);


--
-- TOC entry 3241 (class 2604 OID 52348)
-- Name: jasenyys jasenyys_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jasenyys ALTER COLUMN jasenyys_id SET DEFAULT nextval('public.jasenyys_jasenyys_id_seq'::regclass);


--
-- TOC entry 3235 (class 2604 OID 52308)
-- Name: kaato kaato_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kaato ALTER COLUMN kaato_id SET DEFAULT nextval('public.kaato_kaato_id_seq'::regclass);


--
-- TOC entry 3233 (class 2604 OID 52294)
-- Name: kasittely kasittelyid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kasittely ALTER COLUMN kasittelyid SET DEFAULT nextval('public.kasittely_kasittelyid_seq_1'::regclass);


--
-- TOC entry 3237 (class 2604 OID 52322)
-- Name: lupa luparivi_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lupa ALTER COLUMN luparivi_id SET DEFAULT nextval('public.lupa_luparivi_id_seq'::regclass);


--
-- TOC entry 3236 (class 2604 OID 52315)
-- Name: seura seura_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seura ALTER COLUMN seura_id SET DEFAULT nextval('public.seura_seura_id_seq'::regclass);


--
-- TOC entry 3238 (class 2604 OID 52329)
-- Name: seurue seurue_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seurue ALTER COLUMN seurue_id SET DEFAULT nextval('public.seurue_seurue_id_seq'::regclass);


--
-- TOC entry 3429 (class 0 OID 52275)
-- Dependencies: 210
-- Data for Name: aikuinenvasa; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.aikuinenvasa VALUES ('Aikuinen');
INSERT INTO public.aikuinenvasa VALUES ('Vasa');


--
-- TOC entry 3431 (class 0 OID 52285)
-- Dependencies: 212
-- Data for Name: elain; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.elain VALUES ('Hirvi');
INSERT INTO public.elain VALUES ('Valkohäntäpeura');


--
-- TOC entry 3444 (class 0 OID 52332)
-- Dependencies: 225
-- Data for Name: jakoryhma; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.jakoryhma VALUES (1, 1, 'Ryhmä 1');
INSERT INTO public.jakoryhma VALUES (2, 1, 'Ryhmä 2');
INSERT INTO public.jakoryhma VALUES (3, 2, 'Ryhmä 3');


--
-- TOC entry 3446 (class 0 OID 52338)
-- Dependencies: 227
-- Data for Name: jakotapahtuma; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.jakotapahtuma VALUES (1, '2022-10-05', 1, 'Koko', 210, NULL);
INSERT INTO public.jakotapahtuma VALUES (2, '2022-10-02', 1, 'Puolikas', 75, NULL);
INSERT INTO public.jakotapahtuma VALUES (3, '2022-10-02', 2, 'Puolikas', 75, NULL);


--
-- TOC entry 3435 (class 0 OID 52298)
-- Dependencies: 216
-- Data for Name: jasen; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.jasen VALUES (1, 'Janne', 'Jousi', 'Kotikatu 2', '21200', 'Raisio');
INSERT INTO public.jasen VALUES (2, 'Tauno', 'Tappara', 'Viertotie 5', '23100', 'Mynämäki');
INSERT INTO public.jasen VALUES (3, 'Kalle', 'Kaaripyssy', 'Isotie 144', '23100', 'Mynämäki');
INSERT INTO public.jasen VALUES (4, 'Heikki', 'Haulikko', 'Pikkutie 22', '23100', 'Mynämäki');
INSERT INTO public.jasen VALUES (5, 'Tauno', 'Tussari', 'Isotie 210', '23100', 'Mynämäki');
INSERT INTO public.jasen VALUES (6, 'Piia', 'Pyssy', 'Jokikatu 2', '23100', 'Mynämäki');
INSERT INTO public.jasen VALUES (7, 'Tiina', 'Talikko', 'Kirkkotie 7', '23100', 'Mynämäki');
INSERT INTO public.jasen VALUES (8, 'Bertil', 'Bössa', 'Hemväg 4', '20100', 'Åbo');
INSERT INTO public.jasen VALUES (9, 'Ville', 'Vesuri', 'Jokikatu 2', '23100', 'Mynämäki');
INSERT INTO public.jasen VALUES (10, 'Kurt', 'Kirves', 'Pohjanperkontie 122', '23100', 'Mynämäki');


--
-- TOC entry 3448 (class 0 OID 52345)
-- Dependencies: 229
-- Data for Name: jasenyys; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.jasenyys VALUES (1, 1, 1, '2022-01-01', NULL, 100);
INSERT INTO public.jasenyys VALUES (2, 1, 2, '2022-01-01', NULL, 100);
INSERT INTO public.jasenyys VALUES (3, 1, 3, '2022-01-01', NULL, 100);
INSERT INTO public.jasenyys VALUES (4, 2, 4, '2022-01-01', NULL, 100);
INSERT INTO public.jasenyys VALUES (6, 2, 6, '2022-01-01', NULL, 100);
INSERT INTO public.jasenyys VALUES (7, 3, 7, '2022-01-01', NULL, 100);
INSERT INTO public.jasenyys VALUES (8, 3, 8, '2022-01-01', NULL, 100);
INSERT INTO public.jasenyys VALUES (9, 3, 9, '2022-01-01', NULL, 50);


--
-- TOC entry 3437 (class 0 OID 52305)
-- Dependencies: 218
-- Data for Name: kaato; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.kaato VALUES (1, 5, '2022-09-28', 250, 'Takapellon eteläpää, Jyrkkälä', '61.58,21.54', 1, 'Hirvi', 'Uros', 'Aikuinen');
INSERT INTO public.kaato VALUES (2, 6, '2022-09-28', 200, 'Takapellon eteläpää, Jyrkkälä', '61.58,21.54', 2, 'Hirvi', 'Naaras', 'Aikuinen');


--
-- TOC entry 3433 (class 0 OID 52291)
-- Dependencies: 214
-- Data for Name: kasittely; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.kasittely VALUES (1, 'Seuralle');
INSERT INTO public.kasittely VALUES (2, 'Seurueelle');
INSERT INTO public.kasittely VALUES (3, 'Myyntiin');
INSERT INTO public.kasittely VALUES (4, 'Hävitetään');


--
-- TOC entry 3441 (class 0 OID 52319)
-- Dependencies: 222
-- Data for Name: lupa; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.lupa VALUES (1, 1, '2022', 'Hirvi', 'Uros', 'Aikuinen', 10);
INSERT INTO public.lupa VALUES (2, 1, '2022', 'Hirvi', 'Naaras', 'Aikuinen', 15);
INSERT INTO public.lupa VALUES (3, 1, '2022', 'Valkohäntäpeura', 'Uros', 'Aikuinen', 100);
INSERT INTO public.lupa VALUES (4, 1, '2022', 'Valkohäntäpeura', 'Naaras', 'Aikuinen', 200);
INSERT INTO public.lupa VALUES (5, 1, '2022', 'Hirvi', 'Uros', 'Vasa', 20);


--
-- TOC entry 3428 (class 0 OID 52270)
-- Dependencies: 209
-- Data for Name: ruhonosa; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.ruhonosa VALUES ('Koko');
INSERT INTO public.ruhonosa VALUES ('Puolikas');
INSERT INTO public.ruhonosa VALUES ('Neljännes');


--
-- TOC entry 3439 (class 0 OID 52312)
-- Dependencies: 220
-- Data for Name: seura; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.seura VALUES (1, 'Punaiset hatut ja nenät', 'Keskuskatu 1', '23100', 'Mynämäki');


--
-- TOC entry 3443 (class 0 OID 52326)
-- Dependencies: 224
-- Data for Name: seurue; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.seurue VALUES (1, 1, 'Seurue1', 6);
INSERT INTO public.seurue VALUES (2, 1, 'Seurue2', 1);


--
-- TOC entry 3430 (class 0 OID 52280)
-- Dependencies: 211
-- Data for Name: sukupuoli; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sukupuoli VALUES ('Uros');
INSERT INTO public.sukupuoli VALUES ('Naaras');


--
-- TOC entry 3477 (class 0 OID 0)
-- Dependencies: 230
-- Name: jakoryhma_ryhma_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.jakoryhma_ryhma_id_seq', 3, true);


--
-- TOC entry 3478 (class 0 OID 0)
-- Dependencies: 226
-- Name: jakotapahtuma_tapahtuma_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.jakotapahtuma_tapahtuma_id_seq', 3, true);


--
-- TOC entry 3479 (class 0 OID 0)
-- Dependencies: 215
-- Name: jasen_jasen_id_seq_1; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.jasen_jasen_id_seq_1', 10, true);


--
-- TOC entry 3480 (class 0 OID 0)
-- Dependencies: 228
-- Name: jasenyys_jasenyys_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.jasenyys_jasenyys_id_seq', 9, true);


--
-- TOC entry 3481 (class 0 OID 0)
-- Dependencies: 217
-- Name: kaato_kaato_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.kaato_kaato_id_seq', 2, true);


--
-- TOC entry 3482 (class 0 OID 0)
-- Dependencies: 213
-- Name: kasittely_kasittelyid_seq_1; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.kasittely_kasittelyid_seq_1', 4, true);


--
-- TOC entry 3483 (class 0 OID 0)
-- Dependencies: 221
-- Name: lupa_luparivi_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lupa_luparivi_id_seq', 5, true);


--
-- TOC entry 3484 (class 0 OID 0)
-- Dependencies: 219
-- Name: seura_seura_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seura_seura_id_seq', 1, true);


--
-- TOC entry 3485 (class 0 OID 0)
-- Dependencies: 223
-- Name: seurue_seurue_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seurue_seurue_id_seq', 2, true);


--
-- TOC entry 3486 (class 0 OID 0)
-- Dependencies: 231
-- Name: testi_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.testi_seq', 1, false);


--
-- TOC entry 3246 (class 2606 OID 52279)
-- Name: aikuinenvasa aikuinenvasa_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aikuinenvasa
    ADD CONSTRAINT aikuinenvasa_pk PRIMARY KEY (ikaluokka);


--
-- TOC entry 3250 (class 2606 OID 52289)
-- Name: elain elain_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.elain
    ADD CONSTRAINT elain_pk PRIMARY KEY (elaimen_nimi);


--
-- TOC entry 3264 (class 2606 OID 52336)
-- Name: jakoryhma jakoryhma_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jakoryhma
    ADD CONSTRAINT jakoryhma_pk PRIMARY KEY (ryhma_id);


--
-- TOC entry 3266 (class 2606 OID 52343)
-- Name: jakotapahtuma jakotapahtuma_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jakotapahtuma
    ADD CONSTRAINT jakotapahtuma_pk PRIMARY KEY (tapahtuma_id);


--
-- TOC entry 3254 (class 2606 OID 52303)
-- Name: jasen jasen_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jasen
    ADD CONSTRAINT jasen_pk PRIMARY KEY (jasen_id);


--
-- TOC entry 3268 (class 2606 OID 52350)
-- Name: jasenyys jasenyys_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jasenyys
    ADD CONSTRAINT jasenyys_pk PRIMARY KEY (jasenyys_id);


--
-- TOC entry 3256 (class 2606 OID 52310)
-- Name: kaato kaato_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kaato
    ADD CONSTRAINT kaato_pk PRIMARY KEY (kaato_id);


--
-- TOC entry 3252 (class 2606 OID 52296)
-- Name: kasittely kasittely_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kasittely
    ADD CONSTRAINT kasittely_pk PRIMARY KEY (kasittelyid);


--
-- TOC entry 3260 (class 2606 OID 52324)
-- Name: lupa lupa_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lupa
    ADD CONSTRAINT lupa_pk PRIMARY KEY (luparivi_id);


--
-- TOC entry 3244 (class 2606 OID 52274)
-- Name: ruhonosa ruhonosa_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ruhonosa
    ADD CONSTRAINT ruhonosa_pk PRIMARY KEY (osnimitys);


--
-- TOC entry 3258 (class 2606 OID 52317)
-- Name: seura seura_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seura
    ADD CONSTRAINT seura_pk PRIMARY KEY (seura_id);


--
-- TOC entry 3262 (class 2606 OID 52331)
-- Name: seurue seurue_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seurue
    ADD CONSTRAINT seurue_pk PRIMARY KEY (seurue_id);


--
-- TOC entry 3248 (class 2606 OID 52284)
-- Name: sukupuoli sukupuoli_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sukupuoli
    ADD CONSTRAINT sukupuoli_pk PRIMARY KEY (sukupuoli);


--
-- TOC entry 3269 (class 2606 OID 52361)
-- Name: kaato aikuinen_vasa_kaato_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kaato
    ADD CONSTRAINT aikuinen_vasa_kaato_fk FOREIGN KEY (ikaluokka) REFERENCES public.aikuinenvasa(ikaluokka);


--
-- TOC entry 3274 (class 2606 OID 52356)
-- Name: lupa aikuinen_vasa_lupa_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lupa
    ADD CONSTRAINT aikuinen_vasa_lupa_fk FOREIGN KEY (ikaluokka) REFERENCES public.aikuinenvasa(ikaluokka);


--
-- TOC entry 3271 (class 2606 OID 52381)
-- Name: kaato elain_kaato_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kaato
    ADD CONSTRAINT elain_kaato_fk FOREIGN KEY (elaimen_nimi) REFERENCES public.elain(elaimen_nimi);


--
-- TOC entry 3276 (class 2606 OID 52376)
-- Name: lupa elain_lupa_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lupa
    ADD CONSTRAINT elain_lupa_fk FOREIGN KEY (elaimen_nimi) REFERENCES public.elain(elaimen_nimi);


--
-- TOC entry 3284 (class 2606 OID 52391)
-- Name: jasenyys jasen_jasenyys_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jasenyys
    ADD CONSTRAINT jasen_jasenyys_fk FOREIGN KEY (jasen_id) REFERENCES public.jasen(jasen_id);


--
-- TOC entry 3273 (class 2606 OID 52396)
-- Name: kaato jasen_kaato_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kaato
    ADD CONSTRAINT jasen_kaato_fk FOREIGN KEY (jasen_id) REFERENCES public.jasen(jasen_id);


--
-- TOC entry 3278 (class 2606 OID 52401)
-- Name: seurue jasen_seurue_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seurue
    ADD CONSTRAINT jasen_seurue_fk FOREIGN KEY (jasen_id) REFERENCES public.jasen(jasen_id);


--
-- TOC entry 3283 (class 2606 OID 68389)
-- Name: jakotapahtuma kaato_jakotapahtuma_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jakotapahtuma
    ADD CONSTRAINT kaato_jakotapahtuma_fk FOREIGN KEY (kaato_id) REFERENCES public.kaato(kaato_id) NOT VALID;


--
-- TOC entry 3272 (class 2606 OID 52386)
-- Name: kaato kasittely_kaato_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kaato
    ADD CONSTRAINT kasittely_kaato_fk FOREIGN KEY (kasittelyid) REFERENCES public.kasittely(kasittelyid);


--
-- TOC entry 3281 (class 2606 OID 52351)
-- Name: jakotapahtuma ruhonosa_jakotapahtuma_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jakotapahtuma
    ADD CONSTRAINT ruhonosa_jakotapahtuma_fk FOREIGN KEY (osnimitys) REFERENCES public.ruhonosa(osnimitys);


--
-- TOC entry 3282 (class 2606 OID 52426)
-- Name: jakotapahtuma ryhma_jakotapahtuma_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jakotapahtuma
    ADD CONSTRAINT ryhma_jakotapahtuma_fk FOREIGN KEY (ryhma_id) REFERENCES public.jakoryhma(ryhma_id);


--
-- TOC entry 3285 (class 2606 OID 52421)
-- Name: jasenyys ryhma_jasenyys_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jasenyys
    ADD CONSTRAINT ryhma_jasenyys_fk FOREIGN KEY (ryhma_id) REFERENCES public.jakoryhma(ryhma_id);


--
-- TOC entry 3277 (class 2606 OID 52411)
-- Name: lupa seura_lupa_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lupa
    ADD CONSTRAINT seura_lupa_fk FOREIGN KEY (seura_id) REFERENCES public.seura(seura_id);


--
-- TOC entry 3279 (class 2606 OID 52406)
-- Name: seurue seura_seurue_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seurue
    ADD CONSTRAINT seura_seurue_fk FOREIGN KEY (seura_id) REFERENCES public.seura(seura_id);


--
-- TOC entry 3280 (class 2606 OID 52416)
-- Name: jakoryhma seurue_ryhma_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jakoryhma
    ADD CONSTRAINT seurue_ryhma_fk FOREIGN KEY (seurue_id) REFERENCES public.seurue(seurue_id);


--
-- TOC entry 3270 (class 2606 OID 52371)
-- Name: kaato sukupuoli_kaato_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kaato
    ADD CONSTRAINT sukupuoli_kaato_fk FOREIGN KEY (sukupuoli) REFERENCES public.sukupuoli(sukupuoli);


--
-- TOC entry 3275 (class 2606 OID 52366)
-- Name: lupa sukupuoli_lupa_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lupa
    ADD CONSTRAINT sukupuoli_lupa_fk FOREIGN KEY (sukupuoli) REFERENCES public.sukupuoli(sukupuoli);


-- Completed on 2022-10-05 11:29:06

--
-- PostgreSQL database dump complete
--

