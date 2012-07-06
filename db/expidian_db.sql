--
-- PostgreSQL database dump
--

-- Dumped from database version 9.1.4
-- Dumped by pg_dump version 9.1.4
-- Started on 2012-07-01 21:11:41

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 188 (class 3079 OID 11639)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2074 (class 0 OID 0)
-- Dependencies: 188
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- TOC entry 187 (class 3079 OID 17839)
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- TOC entry 2075 (class 0 OID 0)
-- Dependencies: 187
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


--
-- TOC entry 189 (class 3079 OID 17848)
-- Dependencies: 6
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- TOC entry 2076 (class 0 OID 0)
-- Dependencies: 189
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


SET search_path = public, pg_catalog;

--
-- TOC entry 234 (class 1255 OID 17882)
-- Dependencies: 6
-- Name: sha512(bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION sha512(bytea) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
    SELECT encode(digest($1, 'sha512'), 'hex')
$_$;


ALTER FUNCTION public.sha512(bytea) OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = true;

--
-- TOC entry 161 (class 1259 OID 17883)
-- Dependencies: 1958 6
-- Name: bitacoras; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE bitacoras (
    id_bitacora integer NOT NULL,
    id_expidiente integer NOT NULL,
    bitacora text NOT NULL,
    fecha_registro date DEFAULT now() NOT NULL
);


ALTER TABLE public.bitacoras OWNER TO postgres;

--
-- TOC entry 162 (class 1259 OID 17890)
-- Dependencies: 6 161
-- Name: bitacoras_id_bitacora_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE bitacoras_id_bitacora_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bitacoras_id_bitacora_seq OWNER TO postgres;

--
-- TOC entry 2077 (class 0 OID 0)
-- Dependencies: 162
-- Name: bitacoras_id_bitacora_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE bitacoras_id_bitacora_seq OWNED BY bitacoras.id_bitacora;


--
-- TOC entry 2078 (class 0 OID 0)
-- Dependencies: 162
-- Name: bitacoras_id_bitacora_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('bitacoras_id_bitacora_seq', 1, false);


--
-- TOC entry 163 (class 1259 OID 17892)
-- Dependencies: 1960 6
-- Name: consultas; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE consultas (
    id_consulta integer NOT NULL,
    cedula_de_identidad character varying(15) NOT NULL,
    id_expediente integer NOT NULL,
    fecha_consulta date DEFAULT now() NOT NULL
);


ALTER TABLE public.consultas OWNER TO postgres;

--
-- TOC entry 164 (class 1259 OID 17896)
-- Dependencies: 6 163
-- Name: consultas_id_consulta_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE consultas_id_consulta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.consultas_id_consulta_seq OWNER TO postgres;

--
-- TOC entry 2079 (class 0 OID 0)
-- Dependencies: 164
-- Name: consultas_id_consulta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE consultas_id_consulta_seq OWNED BY consultas.id_consulta;


--
-- TOC entry 2080 (class 0 OID 0)
-- Dependencies: 164
-- Name: consultas_id_consulta_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('consultas_id_consulta_seq', 1, false);


--
-- TOC entry 165 (class 1259 OID 17898)
-- Dependencies: 1962 6
-- Name: control_movimientos; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE control_movimientos (
    id_control_movimientos integer NOT NULL,
    id_expidiente integer NOT NULL,
    id_proceso integer NOT NULL,
    id_etapa integer NOT NULL,
    cod_expediente character varying(11) NOT NULL,
    id_abogado_coord integer,
    id_abogado_asign integer NOT NULL,
    fecha_movimiento date DEFAULT now() NOT NULL
);


ALTER TABLE public.control_movimientos OWNER TO postgres;

--
-- TOC entry 166 (class 1259 OID 17902)
-- Dependencies: 165 6
-- Name: control_movimientos_id_control_movimientos_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE control_movimientos_id_control_movimientos_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.control_movimientos_id_control_movimientos_seq OWNER TO postgres;

--
-- TOC entry 2081 (class 0 OID 0)
-- Dependencies: 166
-- Name: control_movimientos_id_control_movimientos_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE control_movimientos_id_control_movimientos_seq OWNED BY control_movimientos.id_control_movimientos;


--
-- TOC entry 2082 (class 0 OID 0)
-- Dependencies: 166
-- Name: control_movimientos_id_control_movimientos_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('control_movimientos_id_control_movimientos_seq', 1, false);


--
-- TOC entry 167 (class 1259 OID 17909)
-- Dependencies: 6
-- Name: etapas; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE etapas (
    id_etapa integer NOT NULL,
    etapa_abrev character varying(5) NOT NULL,
    etapa character varying(60) NOT NULL,
    nro_consecutivo_etapa integer NOT NULL,
    id_proceso integer NOT NULL
);


ALTER TABLE public.etapas OWNER TO postgres;

--
-- TOC entry 168 (class 1259 OID 17912)
-- Dependencies: 167 6
-- Name: etapas_id_etapa_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE etapas_id_etapa_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.etapas_id_etapa_seq OWNER TO postgres;

--
-- TOC entry 2083 (class 0 OID 0)
-- Dependencies: 168
-- Name: etapas_id_etapa_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE etapas_id_etapa_seq OWNED BY etapas.id_etapa;


--
-- TOC entry 2084 (class 0 OID 0)
-- Dependencies: 168
-- Name: etapas_id_etapa_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('etapas_id_etapa_seq', 1, false);


--
-- TOC entry 169 (class 1259 OID 17914)
-- Dependencies: 1965 1966 6
-- Name: expedientes; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE expedientes (
    id_expediente integer NOT NULL,
    id_organismo integer,
    hechos text,
    observaciones text,
    id_proceso_actual integer,
    id_etapa_actual integer,
    id_usuario_ini integer NOT NULL,
    sesssion_id character varying(255),
    confirm_inicial character varying(10) DEFAULT 'NO CONFIRMADO'::character varying,
    fecha_registro date DEFAULT now() NOT NULL,
    fecha_solic_invest date
);


ALTER TABLE public.expedientes OWNER TO postgres;

--
-- TOC entry 170 (class 1259 OID 17922)
-- Dependencies: 169 6
-- Name: expedientes_id_expediente_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE expedientes_id_expediente_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.expedientes_id_expediente_seq OWNER TO postgres;

--
-- TOC entry 2085 (class 0 OID 0)
-- Dependencies: 170
-- Name: expedientes_id_expediente_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE expedientes_id_expediente_seq OWNED BY expedientes.id_expediente;


--
-- TOC entry 2086 (class 0 OID 0)
-- Dependencies: 170
-- Name: expedientes_id_expediente_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('expedientes_id_expediente_seq', 1, false);


--
-- TOC entry 171 (class 1259 OID 17924)
-- Dependencies: 6
-- Name: interesados; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE interesados (
    id_interesado integer NOT NULL,
    id_expediente integer,
    cedula_de_identidad integer
);


ALTER TABLE public.interesados OWNER TO postgres;

--
-- TOC entry 172 (class 1259 OID 17927)
-- Dependencies: 6 171
-- Name: interesados_id_interesado_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE interesados_id_interesado_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.interesados_id_interesado_seq OWNER TO postgres;

--
-- TOC entry 2087 (class 0 OID 0)
-- Dependencies: 172
-- Name: interesados_id_interesado_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE interesados_id_interesado_seq OWNED BY interesados.id_interesado;


--
-- TOC entry 2088 (class 0 OID 0)
-- Dependencies: 172
-- Name: interesados_id_interesado_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('interesados_id_interesado_seq', 1, false);


--
-- TOC entry 173 (class 1259 OID 17929)
-- Dependencies: 1969 6
-- Name: logs_usuarios; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE logs_usuarios (
    id_log_usuario integer NOT NULL,
    id_usuario integer NOT NULL,
    log_usuario character varying(300) NOT NULL,
    estatus_final character varying(20),
    fecha_log timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.logs_usuarios OWNER TO postgres;

--
-- TOC entry 174 (class 1259 OID 17933)
-- Dependencies: 6 173
-- Name: logs_usuarios_id_log_usuario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE logs_usuarios_id_log_usuario_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.logs_usuarios_id_log_usuario_seq OWNER TO postgres;

--
-- TOC entry 2089 (class 0 OID 0)
-- Dependencies: 174
-- Name: logs_usuarios_id_log_usuario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE logs_usuarios_id_log_usuario_seq OWNED BY logs_usuarios.id_log_usuario;


--
-- TOC entry 2090 (class 0 OID 0)
-- Dependencies: 174
-- Name: logs_usuarios_id_log_usuario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('logs_usuarios_id_log_usuario_seq', 17, true);


--
-- TOC entry 175 (class 1259 OID 17935)
-- Dependencies: 6
-- Name: organismos; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE organismos (
    id_organismo integer NOT NULL,
    rif character varying(12) NOT NULL,
    nombre_organismo character varying(60) NOT NULL,
    sector character varying(20) NOT NULL
);


ALTER TABLE public.organismos OWNER TO postgres;

--
-- TOC entry 176 (class 1259 OID 17938)
-- Dependencies: 6 175
-- Name: organismos_id_organismo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE organismos_id_organismo_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.organismos_id_organismo_seq OWNER TO postgres;

--
-- TOC entry 2091 (class 0 OID 0)
-- Dependencies: 176
-- Name: organismos_id_organismo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE organismos_id_organismo_seq OWNED BY organismos.id_organismo;


--
-- TOC entry 2092 (class 0 OID 0)
-- Dependencies: 176
-- Name: organismos_id_organismo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('organismos_id_organismo_seq', 1, false);


--
-- TOC entry 177 (class 1259 OID 17940)
-- Dependencies: 6
-- Name: paises; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE paises (
    id_pais integer NOT NULL,
    pais character varying(35) NOT NULL
);


ALTER TABLE public.paises OWNER TO postgres;

--
-- TOC entry 178 (class 1259 OID 17943)
-- Dependencies: 6 177
-- Name: paises_id_pais_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE paises_id_pais_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.paises_id_pais_seq OWNER TO postgres;

--
-- TOC entry 2093 (class 0 OID 0)
-- Dependencies: 178
-- Name: paises_id_pais_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE paises_id_pais_seq OWNED BY paises.id_pais;


--
-- TOC entry 2094 (class 0 OID 0)
-- Dependencies: 178
-- Name: paises_id_pais_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('paises_id_pais_seq', 239, true);


--
-- TOC entry 179 (class 1259 OID 17945)
-- Dependencies: 6
-- Name: perfiles; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE perfiles (
    id_perfil integer NOT NULL,
    perfil character varying(50) NOT NULL,
    descripcion_perfil character varying(200) NOT NULL
);


ALTER TABLE public.perfiles OWNER TO postgres;

--
-- TOC entry 180 (class 1259 OID 17948)
-- Dependencies: 179 6
-- Name: perfiles_id_perfil_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE perfiles_id_perfil_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.perfiles_id_perfil_seq OWNER TO postgres;

--
-- TOC entry 2095 (class 0 OID 0)
-- Dependencies: 180
-- Name: perfiles_id_perfil_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE perfiles_id_perfil_seq OWNED BY perfiles.id_perfil;


--
-- TOC entry 2096 (class 0 OID 0)
-- Dependencies: 180
-- Name: perfiles_id_perfil_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('perfiles_id_perfil_seq', 3, true);


--
-- TOC entry 181 (class 1259 OID 17950)
-- Dependencies: 1974 1976 6
-- Name: personas; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE personas (
    id_persona integer NOT NULL,
    nombre character varying(60) NOT NULL,
    apellido character varying(60) NOT NULL,
    nacionalidad character varying(1) DEFAULT 'V'::character varying,
    cedula_de_identidad numeric(15,0) NOT NULL,
    telefono1 numeric(11,0),
    telefono2 numeric(11,0),
    id_pais integer DEFAULT 233,
    email character varying(255)
);


ALTER TABLE public.personas OWNER TO postgres;

--
-- TOC entry 182 (class 1259 OID 17954)
-- Dependencies: 6 181
-- Name: personas_id_persona_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE personas_id_persona_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.personas_id_persona_seq OWNER TO postgres;

--
-- TOC entry 2097 (class 0 OID 0)
-- Dependencies: 182
-- Name: personas_id_persona_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE personas_id_persona_seq OWNED BY personas.id_persona;


--
-- TOC entry 2098 (class 0 OID 0)
-- Dependencies: 182
-- Name: personas_id_persona_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('personas_id_persona_seq', 297, true);


--
-- TOC entry 183 (class 1259 OID 17956)
-- Dependencies: 6
-- Name: procesos; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE procesos (
    id_proceso integer NOT NULL,
    proceso_abrev character varying(5),
    proceso character varying(60),
    nro_consecutivo_proceso integer NOT NULL
);


ALTER TABLE public.procesos OWNER TO postgres;

--
-- TOC entry 184 (class 1259 OID 17959)
-- Dependencies: 6 183
-- Name: procesos_id_proceso_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE procesos_id_proceso_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.procesos_id_proceso_seq OWNER TO postgres;

--
-- TOC entry 2099 (class 0 OID 0)
-- Dependencies: 184
-- Name: procesos_id_proceso_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE procesos_id_proceso_seq OWNED BY procesos.id_proceso;


--
-- TOC entry 2100 (class 0 OID 0)
-- Dependencies: 184
-- Name: procesos_id_proceso_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('procesos_id_proceso_seq', 1, false);


--
-- TOC entry 185 (class 1259 OID 17961)
-- Dependencies: 1978 1979 1981 6
-- Name: usuarios; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE usuarios (
    id_usuario integer NOT NULL,
    usuario character varying(15) NOT NULL,
    usuario_encrypt character varying(128) NOT NULL,
    clave character varying(128) NOT NULL,
    es_activo character varying(2) DEFAULT 'NO'::character varying NOT NULL,
    id_persona integer NOT NULL,
    id_perfil integer DEFAULT 1 NOT NULL,
    fecha_registro date DEFAULT now() NOT NULL,
    fecha_ultimo_ingreso timestamp without time zone
);


ALTER TABLE public.usuarios OWNER TO postgres;

--
-- TOC entry 186 (class 1259 OID 17966)
-- Dependencies: 6 185
-- Name: usuarios_id_usuario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE usuarios_id_usuario_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.usuarios_id_usuario_seq OWNER TO postgres;

--
-- TOC entry 2101 (class 0 OID 0)
-- Dependencies: 186
-- Name: usuarios_id_usuario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE usuarios_id_usuario_seq OWNED BY usuarios.id_usuario;


--
-- TOC entry 2102 (class 0 OID 0)
-- Dependencies: 186
-- Name: usuarios_id_usuario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('usuarios_id_usuario_seq', 3, true);


--
-- TOC entry 1959 (class 2604 OID 17968)
-- Dependencies: 162 161
-- Name: id_bitacora; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY bitacoras ALTER COLUMN id_bitacora SET DEFAULT nextval('bitacoras_id_bitacora_seq'::regclass);


--
-- TOC entry 1961 (class 2604 OID 17969)
-- Dependencies: 164 163
-- Name: id_consulta; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY consultas ALTER COLUMN id_consulta SET DEFAULT nextval('consultas_id_consulta_seq'::regclass);


--
-- TOC entry 1963 (class 2604 OID 17970)
-- Dependencies: 166 165
-- Name: id_control_movimientos; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY control_movimientos ALTER COLUMN id_control_movimientos SET DEFAULT nextval('control_movimientos_id_control_movimientos_seq'::regclass);


--
-- TOC entry 1964 (class 2604 OID 17972)
-- Dependencies: 168 167
-- Name: id_etapa; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY etapas ALTER COLUMN id_etapa SET DEFAULT nextval('etapas_id_etapa_seq'::regclass);


--
-- TOC entry 1967 (class 2604 OID 17973)
-- Dependencies: 170 169
-- Name: id_expediente; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY expedientes ALTER COLUMN id_expediente SET DEFAULT nextval('expedientes_id_expediente_seq'::regclass);


--
-- TOC entry 1968 (class 2604 OID 17974)
-- Dependencies: 172 171
-- Name: id_interesado; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY interesados ALTER COLUMN id_interesado SET DEFAULT nextval('interesados_id_interesado_seq'::regclass);


--
-- TOC entry 1970 (class 2604 OID 17975)
-- Dependencies: 174 173
-- Name: id_log_usuario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY logs_usuarios ALTER COLUMN id_log_usuario SET DEFAULT nextval('logs_usuarios_id_log_usuario_seq'::regclass);


--
-- TOC entry 1971 (class 2604 OID 17976)
-- Dependencies: 176 175
-- Name: id_organismo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organismos ALTER COLUMN id_organismo SET DEFAULT nextval('organismos_id_organismo_seq'::regclass);


--
-- TOC entry 1972 (class 2604 OID 17977)
-- Dependencies: 178 177
-- Name: id_pais; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY paises ALTER COLUMN id_pais SET DEFAULT nextval('paises_id_pais_seq'::regclass);


--
-- TOC entry 1973 (class 2604 OID 17978)
-- Dependencies: 180 179
-- Name: id_perfil; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY perfiles ALTER COLUMN id_perfil SET DEFAULT nextval('perfiles_id_perfil_seq'::regclass);


--
-- TOC entry 1975 (class 2604 OID 17979)
-- Dependencies: 182 181
-- Name: id_persona; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY personas ALTER COLUMN id_persona SET DEFAULT nextval('personas_id_persona_seq'::regclass);


--
-- TOC entry 1977 (class 2604 OID 17980)
-- Dependencies: 184 183
-- Name: id_proceso; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY procesos ALTER COLUMN id_proceso SET DEFAULT nextval('procesos_id_proceso_seq'::regclass);


--
-- TOC entry 1980 (class 2604 OID 17981)
-- Dependencies: 186 185
-- Name: id_usuario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuarios ALTER COLUMN id_usuario SET DEFAULT nextval('usuarios_id_usuario_seq'::regclass);


--
-- TOC entry 2056 (class 0 OID 17883)
-- Dependencies: 161
-- Data for Name: bitacoras; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY bitacoras (id_bitacora, id_expidiente, bitacora, fecha_registro) FROM stdin;
\.


--
-- TOC entry 2057 (class 0 OID 17892)
-- Dependencies: 163
-- Data for Name: consultas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY consultas (id_consulta, cedula_de_identidad, id_expediente, fecha_consulta) FROM stdin;
\.


--
-- TOC entry 2058 (class 0 OID 17898)
-- Dependencies: 165
-- Data for Name: control_movimientos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY control_movimientos (id_control_movimientos, id_expidiente, id_proceso, id_etapa, cod_expediente, id_abogado_coord, id_abogado_asign, fecha_movimiento) FROM stdin;
\.


--
-- TOC entry 2059 (class 0 OID 17909)
-- Dependencies: 167
-- Data for Name: etapas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY etapas (id_etapa, etapa_abrev, etapa, nro_consecutivo_etapa, id_proceso) FROM stdin;
\.


--
-- TOC entry 2060 (class 0 OID 17914)
-- Dependencies: 169
-- Data for Name: expedientes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY expedientes (id_expediente, id_organismo, hechos, observaciones, id_proceso_actual, id_etapa_actual, id_usuario_ini, sesssion_id, confirm_inicial, fecha_registro, fecha_solic_invest) FROM stdin;
\.


--
-- TOC entry 2061 (class 0 OID 17924)
-- Dependencies: 171
-- Data for Name: interesados; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY interesados (id_interesado, id_expediente, cedula_de_identidad) FROM stdin;
\.


--
-- TOC entry 2062 (class 0 OID 17929)
-- Dependencies: 173
-- Data for Name: logs_usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY logs_usuarios (id_log_usuario, id_usuario, log_usuario, estatus_final, fecha_log) FROM stdin;
5	1	El usuario con la C.I. 17693788 ha sido autenticado correctamente y ha ingresado al sistema.	EXITOSO	2012-05-06 18:39:52
6	1	El usuario con la C.I. 17693788 ha sido autenticado correctamente y ha ingresado al sistema.	EXITOSO	2012-05-08 06:55:05
7	1	El usuario con la C.I. 17693788 ha sido autenticado correctamente y ha ingresado al sistema.	EXITOSO	2012-05-16 23:50:08
8	1	El usuario con la C.I. 17693788 ha sido autenticado correctamente y ha ingresado al sistema.	EXITOSO	2012-05-17 05:59:17
9	1	El usuario con la C.I. 17693788 ha sido autenticado correctamente y ha ingresado al sistema.	EXITOSO	2012-06-23 21:26:19
10	1	El usuario con la C.I. 17693788 ha sido autenticado correctamente y ha ingresado al sistema.	EXITOSO	2012-06-23 21:28:23
11	1	El usuario con la C.I. 17693788 ha sido autenticado correctamente y ha ingresado al sistema.	EXITOSO	2012-06-23 21:28:49
12	1	El usuario con la C.I. 17693788 ha sido autenticado correctamente y ha ingresado al sistema.	EXITOSO	2012-06-25 04:24:39
13	1	El usuario con la C.I. 17693788 ha sido autenticado correctamente y ha ingresado al sistema.	EXITOSO	2012-06-26 10:43:37
14	1	El usuario con la C.I. 17693788 ha sido autenticado correctamente y ha ingresado al sistema.	EXITOSO	2012-06-30 19:40:31
15	1	El usuario con la C.I. 17693788 ha sido autenticado correctamente y ha ingresado al sistema.	EXITOSO	2012-07-01 12:30:26
16	1	El usuario con la C.I. 17693788 ha sido autenticado correctamente y ha ingresado al sistema.	EXITOSO	2012-07-01 22:59:10
17	1	El usuario con la C.I. 17693788 ha sido autenticado correctamente y ha ingresado al sistema.	EXITOSO	2012-07-01 23:01:46
\.


--
-- TOC entry 2063 (class 0 OID 17935)
-- Dependencies: 175
-- Data for Name: organismos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY organismos (id_organismo, rif, nombre_organismo, sector) FROM stdin;
\.


--
-- TOC entry 2064 (class 0 OID 17940)
-- Dependencies: 177
-- Data for Name: paises; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY paises (id_pais, pais) FROM stdin;
1	Afganistan
2	Albania
3	Alemania
4	American Samoa
5	Andorra
6	Angola
7	Anguila
8	Antigua and Barbuda
9	Antillas Holandesas
10	Antartida
11	Arabia Saudita
12	Argelia
13	Argentina
14	Armenia
15	Aruba
17	Australia
18	Austria
19	Azerbaijan
20	Bahamas
21	Bahrein
22	Bangladesh
23	Barbados
24	Belice
25	Benin
26	Bermuda
27	Bielorrusia
28	Bolivia
29	Bosnia y Herzegovina
30	Botsuana
31	Bouvet Island
32	Brasil
33	British Indian Ocean Territory
34	Brunei Darussalam
35	Bulgaria
36	Burkina Faso
37	Burundi
38	Butan
39	Belgica
40	Cabo Verda
41	Camboya
42	Camerun
44	Canada
45	Chad
46	Chile
47	China
48	Chipre
49	Colombia
50	Comores
51	Congo
52	Corea del Norte
53	Corea del Sur
54	Costa Rica
55	Cote D Ivoire
56	Croacia
57	Cuba
58	Dinamarca
59	Djibouti
60	Dominica
61	East Timor
62	Ecuador
63	Egipto
64	El Salvador
65	El Vaticano
66	Emiratos Arabes Unidos
67	Eritrea
68	Eslovaquia
69	Eslovenia
70	España
71	Estados Unidos
72	Estonia
73	Etiopia
74	Fiji
75	Filipinas
76	Finlandia
77	Francia
78	French Guiana
79	French Polynesia
80	French Southern Territories
81	Gabon
82	Gambia
83	Georgia
84	Ghana
85	Gibraltar
86	Granada
87	Grecia
88	Groenlandia
89	Guadalupe
90	Guam
91	Guatemala
92	Guinea
93	Guinea Ecuatorial
94	Guinea-Bissau
95	Guyana
96	Haiti
97	Heard Island and McDonald Isla
98	Holanda
99	Honduras
100	Hong Kong
101	Hungria
102	India
103	Indonesia
104	Iraq
105	Irlanda
106	Isalas Cocos
107	Isla Christmas
108	Islandia
109	Islas Caiman
110	Islas Cook
111	Islas Feroe
112	Islas Malvinas
113	Islas Marshall
114	Islas Mauricio
115	Islas Salomon
116	Islas Sandwhich
117	Islas Turks y Caicos
118	Islas Wallis y Futuna
119	Israel
120	Italia
121	Jamaica
122	Japon
123	Jordania
124	Kazakhstan
125	Kenia
126	Kiribati
127	Kuwait
128	Kyrgyzstan
129	Laos
130	Latvia
131	Lesoto
132	Liberia
133	Libia
134	Liechtenstein
135	Lituania
136	Luxemburgo
137	Libano
138	Macao
139	Macedonia
140	Madagascar
141	Malasia
142	Malaui
143	Maldivas
144	Malta
145	Mali
146	Marruecos
147	Martinique
148	Mauritania
149	Mayotte
150	Micronesia
151	Moldavia
152	Mongolia
153	Montserrat
154	Mozambique
155	Myanmar
156	Mexico
157	Monaco
158	Namibia
159	Nauru
160	Nepal
161	Nicaragua
162	Nigeria
163	Niue
164	Norfolk Island
165	Northern Mariana Islands
166	Noruega
167	Nueva Caledonia
168	Nueva Zelanda
169	Niger
170	Oman
171	Pakistan
172	Palau
173	Palestinian Territory
174	Panama
175	Papua Nueva Guinea
176	Paraguay
177	Peru
178	Pitcairn
179	Polonia
180	Portugal
181	Puerto Rico
182	Qatar
183	Reino Unido
184	Republica Centroafricana
185	Republica Checa
186	Republica Democratica del Cong
187	Republica Dominicana
188	Republica Islamica de Iran
189	Ruanda
190	Rumania
191	Rusian
192	Saint Kitts and Nevis
193	Saint Pierre y Miquelon
194	Samoa
195	San Marino
196	San Vicente y Las Granadinas
197	Santa Elena
198	Santa Lucia
199	Sao Tome and Principe
200	Senegal
201	Serbia y Montenegro
202	Seychelles
203	Sierra Leona
204	Singapur
205	Siria
206	Somalia
207	Sri Lanka
208	Suazilandia
209	Sudafrica
210	Sudan
211	Suecia
212	Suiza
213	Surinam
214	Svalbard and Jan Mayen
215	Tailandia
216	Taiwan
217	Tajikistan
218	Tanzania
219	Togo
220	Tonga
221	Toquelau
222	Trinidad y Tobago
223	Turkmenistan
224	Turquia
225	Tuvalu
226	Tunez
227	Ucrania
228	Uganda
229	United States Minor Outlying I
230	Uruguay
231	Uzbekistan
232	Vanuatu
233	Venezuela
234	Vietnam
235	Virgin Islands British
236	Virgin Islands U.S.
237	Western Sahara
238	Yemen
239	Zaire
240	Zambia
241	Zimbabue
\.


--
-- TOC entry 2065 (class 0 OID 17945)
-- Dependencies: 179
-- Data for Name: perfiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY perfiles (id_perfil, perfil, descripcion_perfil) FROM stdin;
3	Administrador	Tiene todos los derechos de Superusuario
2	Abogado Coordinador	Representa el Abogado Jefe y tiene los permisos para cerrar casos así como realizar la asignación de expedientes en un determinado proceso a otros abogados.
1	Abogado Asignado	Representa al Abogado al cual le es asignado un expediente, tiene permisos de llevar a cabo todos los cambios en las etapas de un expediente en el proceso en el cual le fué asignado dicho expediente.
\.


--
-- TOC entry 2066 (class 0 OID 17950)
-- Dependencies: 181
-- Data for Name: personas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY personas (id_persona, nombre, apellido, nacionalidad, cedula_de_identidad, telefono1, telefono2, id_pais, email) FROM stdin;
1	José Gabriel	González Pérez	V	17693788	4166075731	4265124336	233	jgabrielsinner10@gmail.com
\.


--
-- TOC entry 2067 (class 0 OID 17956)
-- Dependencies: 183
-- Data for Name: procesos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY procesos (id_proceso, proceso_abrev, proceso, nro_consecutivo_proceso) FROM stdin;
\.


--
-- TOC entry 2068 (class 0 OID 17961)
-- Dependencies: 185
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY usuarios (id_usuario, usuario, usuario_encrypt, clave, es_activo, id_persona, id_perfil, fecha_registro, fecha_ultimo_ingreso) FROM stdin;
1	17693788	b87eedb67d0ac6a5b410031d35839371d27666ade08c55ba71cc5e30b775765d1d0d7cbe642b7fe27b493131e7f24e7953efdbf65d29cf71f9ecaa152e582eb9	3c9909afec25354d551dae21590bb26e38d53f2173b8d3dc3eee4c047e7ab1c1eb8b85103e3be7ba613b31bb5c9c36214dc9f14a42fd7a2fdb84856bca5c44c2	SI	1	3	2012-05-16	\N
\.


--
-- TOC entry 1983 (class 2606 OID 22523)
-- Dependencies: 161 161
-- Name: bitaco_mov_id_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY bitacoras
    ADD CONSTRAINT bitaco_mov_id_pk PRIMARY KEY (id_bitacora);


--
-- TOC entry 2019 (class 2606 OID 22525)
-- Dependencies: 181 181
-- Name: cedula_de_identidad_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY personas
    ADD CONSTRAINT cedula_de_identidad_uk UNIQUE (cedula_de_identidad);


--
-- TOC entry 1985 (class 2606 OID 22527)
-- Dependencies: 163 163
-- Name: consulta_id_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY consultas
    ADD CONSTRAINT consulta_id_pk PRIMARY KEY (id_consulta);


--
-- TOC entry 1987 (class 2606 OID 22529)
-- Dependencies: 165 165
-- Name: control_mov_id_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY control_movimientos
    ADD CONSTRAINT control_mov_id_pk PRIMARY KEY (id_control_movimientos);


--
-- TOC entry 1989 (class 2606 OID 22531)
-- Dependencies: 165 165 165 165
-- Name: control_movimiento_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY control_movimientos
    ADD CONSTRAINT control_movimiento_uk UNIQUE (id_expidiente, id_proceso, id_etapa);


--
-- TOC entry 1991 (class 2606 OID 22535)
-- Dependencies: 167 167
-- Name: etaba_abrev_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY etapas
    ADD CONSTRAINT etaba_abrev_uk UNIQUE (etapa_abrev);


--
-- TOC entry 1993 (class 2606 OID 22537)
-- Dependencies: 167 167
-- Name: etapa_consecutivo_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY etapas
    ADD CONSTRAINT etapa_consecutivo_uk UNIQUE (nro_consecutivo_etapa);


--
-- TOC entry 1995 (class 2606 OID 22539)
-- Dependencies: 167 167
-- Name: etapa_desc_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY etapas
    ADD CONSTRAINT etapa_desc_uk UNIQUE (etapa);


--
-- TOC entry 1997 (class 2606 OID 22541)
-- Dependencies: 167 167
-- Name: etapa_id_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY etapas
    ADD CONSTRAINT etapa_id_pk PRIMARY KEY (id_etapa);


--
-- TOC entry 1999 (class 2606 OID 22543)
-- Dependencies: 169 169
-- Name: id_expediente_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY expedientes
    ADD CONSTRAINT id_expediente_pk PRIMARY KEY (id_expediente);


--
-- TOC entry 2001 (class 2606 OID 22545)
-- Dependencies: 171 171
-- Name: id_interesado_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY interesados
    ADD CONSTRAINT id_interesado_pk PRIMARY KEY (id_interesado);


--
-- TOC entry 2015 (class 2606 OID 22547)
-- Dependencies: 179 179
-- Name: id_perfil_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY perfiles
    ADD CONSTRAINT id_perfil_pk PRIMARY KEY (id_perfil);


--
-- TOC entry 2031 (class 2606 OID 22549)
-- Dependencies: 185 185
-- Name: id_usuario_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY usuarios
    ADD CONSTRAINT id_usuario_pk PRIMARY KEY (id_usuario);


--
-- TOC entry 2003 (class 2606 OID 22551)
-- Dependencies: 173 173
-- Name: log_usuario_id_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY logs_usuarios
    ADD CONSTRAINT log_usuario_id_pk PRIMARY KEY (id_log_usuario);


--
-- TOC entry 2005 (class 2606 OID 22553)
-- Dependencies: 175 175
-- Name: organismo_id_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY organismos
    ADD CONSTRAINT organismo_id_pk PRIMARY KEY (id_organismo);


--
-- TOC entry 2007 (class 2606 OID 22555)
-- Dependencies: 175 175
-- Name: organismo_nombre_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY organismos
    ADD CONSTRAINT organismo_nombre_uk UNIQUE (nombre_organismo);


--
-- TOC entry 2009 (class 2606 OID 22557)
-- Dependencies: 175 175
-- Name: organismo_rif_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY organismos
    ADD CONSTRAINT organismo_rif_uk UNIQUE (rif);


--
-- TOC entry 2011 (class 2606 OID 22559)
-- Dependencies: 177 177
-- Name: pais_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY paises
    ADD CONSTRAINT pais_pk PRIMARY KEY (id_pais);


--
-- TOC entry 2013 (class 2606 OID 22561)
-- Dependencies: 177 177
-- Name: pais_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY paises
    ADD CONSTRAINT pais_uk UNIQUE (pais);


--
-- TOC entry 2017 (class 2606 OID 22563)
-- Dependencies: 179 179
-- Name: perfil; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY perfiles
    ADD CONSTRAINT perfil UNIQUE (perfil);


--
-- TOC entry 2021 (class 2606 OID 22565)
-- Dependencies: 181 181
-- Name: personas_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY personas
    ADD CONSTRAINT personas_pk PRIMARY KEY (id_persona);


--
-- TOC entry 2023 (class 2606 OID 22567)
-- Dependencies: 183 183
-- Name: proceso_abrev_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY procesos
    ADD CONSTRAINT proceso_abrev_uk UNIQUE (proceso_abrev);


--
-- TOC entry 2025 (class 2606 OID 22569)
-- Dependencies: 183 183
-- Name: proceso_consecutivo_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY procesos
    ADD CONSTRAINT proceso_consecutivo_uk UNIQUE (nro_consecutivo_proceso);


--
-- TOC entry 2027 (class 2606 OID 22571)
-- Dependencies: 183 183
-- Name: proceso_desc_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY procesos
    ADD CONSTRAINT proceso_desc_uk UNIQUE (proceso_abrev);


--
-- TOC entry 2029 (class 2606 OID 22573)
-- Dependencies: 183 183
-- Name: proceso_id_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY procesos
    ADD CONSTRAINT proceso_id_pk PRIMARY KEY (id_proceso);


--
-- TOC entry 2033 (class 2606 OID 22575)
-- Dependencies: 185 185
-- Name: usuario_encrypt_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY usuarios
    ADD CONSTRAINT usuario_encrypt_uk UNIQUE (usuario_encrypt);


--
-- TOC entry 2035 (class 2606 OID 22577)
-- Dependencies: 185 185
-- Name: usuario_persona_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY usuarios
    ADD CONSTRAINT usuario_persona_uk UNIQUE (id_persona);


--
-- TOC entry 2037 (class 2606 OID 22579)
-- Dependencies: 185 185
-- Name: usuario_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY usuarios
    ADD CONSTRAINT usuario_uk UNIQUE (usuario);


--
-- TOC entry 2038 (class 2606 OID 22580)
-- Dependencies: 161 169 1998
-- Name: bitaco_expediente_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY bitacoras
    ADD CONSTRAINT bitaco_expediente_fk FOREIGN KEY (id_expidiente) REFERENCES expedientes(id_expediente);


--
-- TOC entry 2050 (class 2606 OID 22585)
-- Dependencies: 2018 171 181
-- Name: cedula_de_identidad_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY interesados
    ADD CONSTRAINT cedula_de_identidad_fk FOREIGN KEY (cedula_de_identidad) REFERENCES personas(cedula_de_identidad);


--
-- TOC entry 2039 (class 2606 OID 22590)
-- Dependencies: 163 1998 169
-- Name: consulta_expediente_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY consultas
    ADD CONSTRAINT consulta_expediente_fk FOREIGN KEY (id_expediente) REFERENCES expedientes(id_expediente);


--
-- TOC entry 2040 (class 2606 OID 22595)
-- Dependencies: 185 165 2030
-- Name: control_abog_asignado_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY control_movimientos
    ADD CONSTRAINT control_abog_asignado_fk FOREIGN KEY (id_abogado_asign) REFERENCES usuarios(id_usuario);


--
-- TOC entry 2041 (class 2606 OID 22600)
-- Dependencies: 185 165 2030
-- Name: control_abog_coordinador_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY control_movimientos
    ADD CONSTRAINT control_abog_coordinador_fk FOREIGN KEY (id_abogado_coord) REFERENCES usuarios(id_usuario);


--
-- TOC entry 2042 (class 2606 OID 22605)
-- Dependencies: 165 1996 167
-- Name: control_etapa_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY control_movimientos
    ADD CONSTRAINT control_etapa_fk FOREIGN KEY (id_etapa) REFERENCES etapas(id_etapa);


--
-- TOC entry 2043 (class 2606 OID 22610)
-- Dependencies: 165 1998 169
-- Name: control_expediente_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY control_movimientos
    ADD CONSTRAINT control_expediente_fk FOREIGN KEY (id_expidiente) REFERENCES expedientes(id_expediente);


--
-- TOC entry 2044 (class 2606 OID 22615)
-- Dependencies: 183 165 2028
-- Name: control_proceso_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY control_movimientos
    ADD CONSTRAINT control_proceso_fk FOREIGN KEY (id_proceso) REFERENCES procesos(id_proceso);


--
-- TOC entry 2045 (class 2606 OID 22625)
-- Dependencies: 183 167 2028
-- Name: etapa_de_proceso_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY etapas
    ADD CONSTRAINT etapa_de_proceso_fk FOREIGN KEY (id_proceso) REFERENCES procesos(id_proceso);


--
-- TOC entry 2046 (class 2606 OID 22630)
-- Dependencies: 169 167 1996
-- Name: id_etapa_actual_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY expedientes
    ADD CONSTRAINT id_etapa_actual_fk FOREIGN KEY (id_etapa_actual) REFERENCES etapas(id_etapa);


--
-- TOC entry 2051 (class 2606 OID 22635)
-- Dependencies: 169 171 1998
-- Name: id_expediente_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY interesados
    ADD CONSTRAINT id_expediente_fk FOREIGN KEY (id_expediente) REFERENCES expedientes(id_expediente);


--
-- TOC entry 2047 (class 2606 OID 22640)
-- Dependencies: 2004 175 169
-- Name: id_organismo_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY expedientes
    ADD CONSTRAINT id_organismo_fk FOREIGN KEY (id_organismo) REFERENCES organismos(id_organismo);


--
-- TOC entry 2048 (class 2606 OID 22645)
-- Dependencies: 169 2028 183
-- Name: id_proceso_actual_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY expedientes
    ADD CONSTRAINT id_proceso_actual_fk FOREIGN KEY (id_proceso_actual) REFERENCES procesos(id_proceso);


--
-- TOC entry 2049 (class 2606 OID 22650)
-- Dependencies: 185 2030 169
-- Name: id_usuario_reg_inicial_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY expedientes
    ADD CONSTRAINT id_usuario_reg_inicial_fk FOREIGN KEY (id_usuario_ini) REFERENCES usuarios(id_usuario);


--
-- TOC entry 2052 (class 2606 OID 22655)
-- Dependencies: 2030 173 185
-- Name: log_usuario_reg_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY logs_usuarios
    ADD CONSTRAINT log_usuario_reg_fk FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario);


--
-- TOC entry 2053 (class 2606 OID 22892)
-- Dependencies: 181 177 2010
-- Name: persona_pais_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY personas
    ADD CONSTRAINT persona_pais_fk FOREIGN KEY (id_pais) REFERENCES paises(id_pais);


--
-- TOC entry 2054 (class 2606 OID 22898)
-- Dependencies: 2014 179 185
-- Name: usuario_perfil_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuarios
    ADD CONSTRAINT usuario_perfil_fk FOREIGN KEY (id_perfil) REFERENCES perfiles(id_perfil);


--
-- TOC entry 2055 (class 2606 OID 22903)
-- Dependencies: 2020 181 185
-- Name: usuario_persona_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuarios
    ADD CONSTRAINT usuario_persona_fk FOREIGN KEY (id_persona) REFERENCES personas(id_persona);


--
-- TOC entry 2073 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2012-07-01 21:11:41

--
-- PostgreSQL database dump complete
--

