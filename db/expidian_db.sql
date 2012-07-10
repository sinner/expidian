--
-- PostgreSQL database dump
--

-- Dumped from database version 9.1.4
-- Dumped by pg_dump version 9.1.4
-- Started on 2012-07-10 06:52:04

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
-- Dependencies: 1957 6
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
-- Dependencies: 1959 6
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
-- Dependencies: 163 6
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
-- Dependencies: 6
-- Name: control_movimientos; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE control_movimientos (
    id_control_movimientos integer NOT NULL,
    id_expidiente integer NOT NULL,
    id_proceso integer NOT NULL,
    id_etapa integer NOT NULL,
    cod_expediente character varying(20) NOT NULL,
    id_abogado_coord integer,
    id_abogado_asign integer NOT NULL,
    fecha_movimiento date
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

SELECT pg_catalog.setval('control_movimientos_id_control_movimientos_seq', 7, true);


--
-- TOC entry 167 (class 1259 OID 17909)
-- Dependencies: 1963 6
-- Name: etapas; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE etapas (
    id_etapa integer NOT NULL,
    etapa_abrev character varying(5) NOT NULL,
    etapa character varying(60) NOT NULL,
    nro_consecutivo_etapa integer NOT NULL,
    id_proceso integer NOT NULL,
    is_final character varying(2) DEFAULT 'NO'::character varying NOT NULL
);


ALTER TABLE public.etapas OWNER TO postgres;

--
-- TOC entry 168 (class 1259 OID 17912)
-- Dependencies: 6 167
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

SELECT pg_catalog.setval('etapas_id_etapa_seq', 24, true);


--
-- TOC entry 169 (class 1259 OID 17914)
-- Dependencies: 1964 1965 6
-- Name: expedientes; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE expedientes (
    id_expediente integer NOT NULL,
    id_organismo integer,
    nombre character varying(20),
    codigo_actual character varying(20),
    id_proceso_actual integer,
    id_etapa_actual integer,
    id_usuario_ini integer NOT NULL,
    sesssion_id character varying(255),
    confirm_inicial character varying(10) DEFAULT 'NO CONFIRMADO'::character varying,
    fecha_registro date DEFAULT now() NOT NULL,
    id_usuario_act integer NOT NULL
);


ALTER TABLE public.expedientes OWNER TO postgres;

--
-- TOC entry 170 (class 1259 OID 17922)
-- Dependencies: 6 169
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

SELECT pg_catalog.setval('expedientes_id_expediente_seq', 19, true);


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
-- Dependencies: 1968 6
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
-- Dependencies: 173 6
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

SELECT pg_catalog.setval('logs_usuarios_id_log_usuario_seq', 23, true);


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
-- Dependencies: 175 6
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

SELECT pg_catalog.setval('organismos_id_organismo_seq', 19, true);


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
-- Dependencies: 1973 1975 6
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
-- Dependencies: 181 6
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

SELECT pg_catalog.setval('personas_id_persona_seq', 372, true);


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

SELECT pg_catalog.setval('procesos_id_proceso_seq', 5, true);


--
-- TOC entry 185 (class 1259 OID 17961)
-- Dependencies: 1977 1978 1980 6
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

SELECT pg_catalog.setval('usuarios_id_usuario_seq', 42, true);


--
-- TOC entry 1958 (class 2604 OID 17968)
-- Dependencies: 162 161
-- Name: id_bitacora; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY bitacoras ALTER COLUMN id_bitacora SET DEFAULT nextval('bitacoras_id_bitacora_seq'::regclass);


--
-- TOC entry 1960 (class 2604 OID 17969)
-- Dependencies: 164 163
-- Name: id_consulta; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY consultas ALTER COLUMN id_consulta SET DEFAULT nextval('consultas_id_consulta_seq'::regclass);


--
-- TOC entry 1961 (class 2604 OID 17970)
-- Dependencies: 166 165
-- Name: id_control_movimientos; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY control_movimientos ALTER COLUMN id_control_movimientos SET DEFAULT nextval('control_movimientos_id_control_movimientos_seq'::regclass);


--
-- TOC entry 1962 (class 2604 OID 17972)
-- Dependencies: 168 167
-- Name: id_etapa; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY etapas ALTER COLUMN id_etapa SET DEFAULT nextval('etapas_id_etapa_seq'::regclass);


--
-- TOC entry 1966 (class 2604 OID 17973)
-- Dependencies: 170 169
-- Name: id_expediente; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY expedientes ALTER COLUMN id_expediente SET DEFAULT nextval('expedientes_id_expediente_seq'::regclass);


--
-- TOC entry 1967 (class 2604 OID 17974)
-- Dependencies: 172 171
-- Name: id_interesado; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY interesados ALTER COLUMN id_interesado SET DEFAULT nextval('interesados_id_interesado_seq'::regclass);


--
-- TOC entry 1969 (class 2604 OID 17975)
-- Dependencies: 174 173
-- Name: id_log_usuario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY logs_usuarios ALTER COLUMN id_log_usuario SET DEFAULT nextval('logs_usuarios_id_log_usuario_seq'::regclass);


--
-- TOC entry 1970 (class 2604 OID 17976)
-- Dependencies: 176 175
-- Name: id_organismo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organismos ALTER COLUMN id_organismo SET DEFAULT nextval('organismos_id_organismo_seq'::regclass);


--
-- TOC entry 1971 (class 2604 OID 17977)
-- Dependencies: 178 177
-- Name: id_pais; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY paises ALTER COLUMN id_pais SET DEFAULT nextval('paises_id_pais_seq'::regclass);


--
-- TOC entry 1972 (class 2604 OID 17978)
-- Dependencies: 180 179
-- Name: id_perfil; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY perfiles ALTER COLUMN id_perfil SET DEFAULT nextval('perfiles_id_perfil_seq'::regclass);


--
-- TOC entry 1974 (class 2604 OID 17979)
-- Dependencies: 182 181
-- Name: id_persona; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY personas ALTER COLUMN id_persona SET DEFAULT nextval('personas_id_persona_seq'::regclass);


--
-- TOC entry 1976 (class 2604 OID 17980)
-- Dependencies: 184 183
-- Name: id_proceso; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY procesos ALTER COLUMN id_proceso SET DEFAULT nextval('procesos_id_proceso_seq'::regclass);


--
-- TOC entry 1979 (class 2604 OID 17981)
-- Dependencies: 186 185
-- Name: id_usuario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuarios ALTER COLUMN id_usuario SET DEFAULT nextval('usuarios_id_usuario_seq'::regclass);


--
-- TOC entry 2056 (class 0 OID 17883)
-- Dependencies: 161
-- Data for Name: bitacoras; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2057 (class 0 OID 17892)
-- Dependencies: 163
-- Data for Name: consultas; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2058 (class 0 OID 17898)
-- Dependencies: 165
-- Data for Name: control_movimientos; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO control_movimientos (id_control_movimientos, id_expidiente, id_proceso, id_etapa, cod_expediente, id_abogado_coord, id_abogado_asign, fecha_movimiento) VALUES (4, 16, 2, 1, 'VA-0000000001-12', 1, 1, '2012-07-09');
INSERT INTO control_movimientos (id_control_movimientos, id_expidiente, id_proceso, id_etapa, cod_expediente, id_abogado_coord, id_abogado_asign, fecha_movimiento) VALUES (5, 17, 2, 1, 'VA-0000000002-12', 1, 22, '2012-07-09');
INSERT INTO control_movimientos (id_control_movimientos, id_expidiente, id_proceso, id_etapa, cod_expediente, id_abogado_coord, id_abogado_asign, fecha_movimiento) VALUES (6, 18, 2, 1, 'VA-0000000003-12', 1, 23, '2012-07-09');
INSERT INTO control_movimientos (id_control_movimientos, id_expidiente, id_proceso, id_etapa, cod_expediente, id_abogado_coord, id_abogado_asign, fecha_movimiento) VALUES (7, 19, 2, 1, 'VA-0000000004-12', 1, 31, '2012-07-09');


--
-- TOC entry 2059 (class 0 OID 17909)
-- Dependencies: 167
-- Data for Name: etapas; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO etapas (id_etapa, etapa_abrev, etapa, nro_consecutivo_etapa, id_proceso, is_final) VALUES (1, 'EI', 'En Investigación', 1, 2, 'NO');
INSERT INTO etapas (id_etapa, etapa_abrev, etapa, nro_consecutivo_etapa, id_proceso, is_final) VALUES (3, 'EE', 'En Estudio', 1, 3, 'NO');
INSERT INTO etapas (id_etapa, etapa_abrev, etapa, nro_consecutivo_etapa, id_proceso, is_final) VALUES (6, 'AP', 'En Auto de Proceder', 2, 3, 'NO');
INSERT INTO etapas (id_etapa, etapa_abrev, etapa, nro_consecutivo_etapa, id_proceso, is_final) VALUES (7, 'EN', 'En Notificación', 3, 3, 'NO');
INSERT INTO etapas (id_etapa, etapa_abrev, etapa, nro_consecutivo_etapa, id_proceso, is_final) VALUES (10, 'EP', 'En Promoción', 4, 3, 'NO');
INSERT INTO etapas (id_etapa, etapa_abrev, etapa, nro_consecutivo_etapa, id_proceso, is_final) VALUES (11, 'EV', 'En Evacuación', 5, 3, 'NO');
INSERT INTO etapas (id_etapa, etapa_abrev, etapa, nro_consecutivo_etapa, id_proceso, is_final) VALUES (13, 'AA', 'En Auto de Apertura', 1, 4, 'NO');
INSERT INTO etapas (id_etapa, etapa_abrev, etapa, nro_consecutivo_etapa, id_proceso, is_final) VALUES (17, 'NR', 'En Notificación', 2, 4, 'NO');
INSERT INTO etapas (id_etapa, etapa_abrev, etapa, nro_consecutivo_etapa, id_proceso, is_final) VALUES (18, 'PR', 'En Promoción', 3, 4, 'NO');
INSERT INTO etapas (id_etapa, etapa_abrev, etapa, nro_consecutivo_etapa, id_proceso, is_final) VALUES (19, 'ER', 'En Evacuación', 4, 4, 'NO');
INSERT INTO etapas (id_etapa, etapa_abrev, etapa, nro_consecutivo_etapa, id_proceso, is_final) VALUES (22, 'AO', 'Acto Oral', 5, 4, 'NO');
INSERT INTO etapas (id_etapa, etapa_abrev, etapa, nro_consecutivo_etapa, id_proceso, is_final) VALUES (2, 'PP', 'Pase a Potestad Investigativa', 2, 2, 'SI');
INSERT INTO etapas (id_etapa, etapa_abrev, etapa, nro_consecutivo_etapa, id_proceso, is_final) VALUES (12, 'PD', 'Pase a Determinación de Responsabilidades', 6, 3, 'SI');
INSERT INTO etapas (id_etapa, etapa_abrev, etapa, nro_consecutivo_etapa, id_proceso, is_final) VALUES (24, 'AR', 'Archivo', 1, 5, 'SI');
INSERT INTO etapas (id_etapa, etapa_abrev, etapa, nro_consecutivo_etapa, id_proceso, is_final) VALUES (23, 'DE', 'Decisión', 6, 4, 'SI');


--
-- TOC entry 2060 (class 0 OID 17914)
-- Dependencies: 169
-- Data for Name: expedientes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO expedientes (id_expediente, id_organismo, nombre, codigo_actual, id_proceso_actual, id_etapa_actual, id_usuario_ini, sesssion_id, confirm_inicial, fecha_registro, id_usuario_act) VALUES (16, 14, 'Expediente Test', 'VA-0000000001-12', 2, 1, 1, '2ds9q5h2cdfha9a9q2pnkbur77', NULL, '2012-07-09', 1);
INSERT INTO expedientes (id_expediente, id_organismo, nombre, codigo_actual, id_proceso_actual, id_etapa_actual, id_usuario_ini, sesssion_id, confirm_inicial, fecha_registro, id_usuario_act) VALUES (17, 16, 'Expediente de Prueba', 'VA-0000000002-12', 2, 1, 1, '2ds9q5h2cdfha9a9q2pnkbur77', NULL, '2012-07-09', 22);
INSERT INTO expedientes (id_expediente, id_organismo, nombre, codigo_actual, id_proceso_actual, id_etapa_actual, id_usuario_ini, sesssion_id, confirm_inicial, fecha_registro, id_usuario_act) VALUES (18, 17, 'Expediente Test2', 'VA-0000000003-12', 2, 1, 1, '2ds9q5h2cdfha9a9q2pnkbur77', NULL, '2012-07-09', 23);
INSERT INTO expedientes (id_expediente, id_organismo, nombre, codigo_actual, id_proceso_actual, id_etapa_actual, id_usuario_ini, sesssion_id, confirm_inicial, fecha_registro, id_usuario_act) VALUES (19, 2, 'Exp Prueba5', 'VA-0000000004-12', 2, 1, 1, '108l1rin8014fs8qkttun7oq14', NULL, '2012-07-09', 31);


--
-- TOC entry 2061 (class 0 OID 17924)
-- Dependencies: 171
-- Data for Name: interesados; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2062 (class 0 OID 17929)
-- Dependencies: 173
-- Data for Name: logs_usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO logs_usuarios (id_log_usuario, id_usuario, log_usuario, estatus_final, fecha_log) VALUES (5, 1, 'El usuario con la C.I. 17693788 ha sido autenticado correctamente y ha ingresado al sistema.', 'EXITOSO', '2012-05-06 18:39:52');
INSERT INTO logs_usuarios (id_log_usuario, id_usuario, log_usuario, estatus_final, fecha_log) VALUES (6, 1, 'El usuario con la C.I. 17693788 ha sido autenticado correctamente y ha ingresado al sistema.', 'EXITOSO', '2012-05-08 06:55:05');
INSERT INTO logs_usuarios (id_log_usuario, id_usuario, log_usuario, estatus_final, fecha_log) VALUES (7, 1, 'El usuario con la C.I. 17693788 ha sido autenticado correctamente y ha ingresado al sistema.', 'EXITOSO', '2012-05-16 23:50:08');
INSERT INTO logs_usuarios (id_log_usuario, id_usuario, log_usuario, estatus_final, fecha_log) VALUES (8, 1, 'El usuario con la C.I. 17693788 ha sido autenticado correctamente y ha ingresado al sistema.', 'EXITOSO', '2012-05-17 05:59:17');
INSERT INTO logs_usuarios (id_log_usuario, id_usuario, log_usuario, estatus_final, fecha_log) VALUES (9, 1, 'El usuario con la C.I. 17693788 ha sido autenticado correctamente y ha ingresado al sistema.', 'EXITOSO', '2012-06-23 21:26:19');
INSERT INTO logs_usuarios (id_log_usuario, id_usuario, log_usuario, estatus_final, fecha_log) VALUES (10, 1, 'El usuario con la C.I. 17693788 ha sido autenticado correctamente y ha ingresado al sistema.', 'EXITOSO', '2012-06-23 21:28:23');
INSERT INTO logs_usuarios (id_log_usuario, id_usuario, log_usuario, estatus_final, fecha_log) VALUES (11, 1, 'El usuario con la C.I. 17693788 ha sido autenticado correctamente y ha ingresado al sistema.', 'EXITOSO', '2012-06-23 21:28:49');
INSERT INTO logs_usuarios (id_log_usuario, id_usuario, log_usuario, estatus_final, fecha_log) VALUES (12, 1, 'El usuario con la C.I. 17693788 ha sido autenticado correctamente y ha ingresado al sistema.', 'EXITOSO', '2012-06-25 04:24:39');
INSERT INTO logs_usuarios (id_log_usuario, id_usuario, log_usuario, estatus_final, fecha_log) VALUES (13, 1, 'El usuario con la C.I. 17693788 ha sido autenticado correctamente y ha ingresado al sistema.', 'EXITOSO', '2012-06-26 10:43:37');
INSERT INTO logs_usuarios (id_log_usuario, id_usuario, log_usuario, estatus_final, fecha_log) VALUES (14, 1, 'El usuario con la C.I. 17693788 ha sido autenticado correctamente y ha ingresado al sistema.', 'EXITOSO', '2012-06-30 19:40:31');
INSERT INTO logs_usuarios (id_log_usuario, id_usuario, log_usuario, estatus_final, fecha_log) VALUES (15, 1, 'El usuario con la C.I. 17693788 ha sido autenticado correctamente y ha ingresado al sistema.', 'EXITOSO', '2012-07-01 12:30:26');
INSERT INTO logs_usuarios (id_log_usuario, id_usuario, log_usuario, estatus_final, fecha_log) VALUES (16, 1, 'El usuario con la C.I. 17693788 ha sido autenticado correctamente y ha ingresado al sistema.', 'EXITOSO', '2012-07-01 22:59:10');
INSERT INTO logs_usuarios (id_log_usuario, id_usuario, log_usuario, estatus_final, fecha_log) VALUES (17, 1, 'El usuario con la C.I. 17693788 ha sido autenticado correctamente y ha ingresado al sistema.', 'EXITOSO', '2012-07-01 23:01:46');
INSERT INTO logs_usuarios (id_log_usuario, id_usuario, log_usuario, estatus_final, fecha_log) VALUES (18, 1, 'El usuario con la C.I. 17693788 ha sido autenticado correctamente y ha ingresado al sistema.', 'EXITOSO', '2012-07-08 20:02:34');
INSERT INTO logs_usuarios (id_log_usuario, id_usuario, log_usuario, estatus_final, fecha_log) VALUES (19, 1, 'El usuario con la C.I. 17693788 ha sido autenticado correctamente y ha ingresado al sistema.', 'EXITOSO', '2012-07-09 11:05:17');
INSERT INTO logs_usuarios (id_log_usuario, id_usuario, log_usuario, estatus_final, fecha_log) VALUES (20, 1, 'El usuario con la C.I. 17693788 José Gabriel González Pérez (Administrador) ha sido autenticado correctamente y ha ingresado al sistema.', 'EXITOSO', '2012-07-09 16:58:25');
INSERT INTO logs_usuarios (id_log_usuario, id_usuario, log_usuario, estatus_final, fecha_log) VALUES (21, 1, 'El usuario con la C.I. 17693788 José Gabriel González Pérez (Administrador) ha sido autenticado correctamente y ha ingresado al sistema.', 'EXITOSO', '2012-07-09 23:25:19');
INSERT INTO logs_usuarios (id_log_usuario, id_usuario, log_usuario, estatus_final, fecha_log) VALUES (22, 1, 'El usuario con la C.I. 17693788 José Gabriel González Pérez (Administrador) ha sido autenticado correctamente y ha ingresado al sistema.', 'EXITOSO', '2012-07-09 23:27:56');
INSERT INTO logs_usuarios (id_log_usuario, id_usuario, log_usuario, estatus_final, fecha_log) VALUES (23, 1, 'El usuario con la C.I. 17693788 José Gabriel González Pérez (Administrador) ha sido autenticado correctamente y ha ingresado al sistema.', 'EXITOSO', '2012-07-10 11:17:46');


--
-- TOC entry 2063 (class 0 OID 17935)
-- Dependencies: 175
-- Data for Name: organismos; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO organismos (id_organismo, rif, nombre_organismo, sector) VALUES (1, 'G00000000009', 'Ministerio del Poder Popular para la Educación', 'Educación');
INSERT INTO organismos (id_organismo, rif, nombre_organismo, sector) VALUES (5, 'G00000000002', 'Ministerio del Poder Popular para La Salud', 'Salud');
INSERT INTO organismos (id_organismo, rif, nombre_organismo, sector) VALUES (14, 'G00000000016', 'CONATEL', 'Comunicación');
INSERT INTO organismos (id_organismo, rif, nombre_organismo, sector) VALUES (16, 'G00000012533', 'Alcaldía del Municipio Sucre', 'Social');
INSERT INTO organismos (id_organismo, rif, nombre_organismo, sector) VALUES (17, 'G00011235160', 'Tribunal Supremo de Justicia', 'Social');
INSERT INTO organismos (id_organismo, rif, nombre_organismo, sector) VALUES (18, 'G08764323456', 'Consejo Nacional Electoral', 'Social');
INSERT INTO organismos (id_organismo, rif, nombre_organismo, sector) VALUES (2, 'G00000000001', 'Ministerio del Poder Popular para La Ciencia y La Tecnología', 'Tecnología');
INSERT INTO organismos (id_organismo, rif, nombre_organismo, sector) VALUES (12, 'G00000001536', 'CANTV', 'Tecnología');
INSERT INTO organismos (id_organismo, rif, nombre_organismo, sector) VALUES (15, 'G00001673829', 'CNTI', 'Tecnología');
INSERT INTO organismos (id_organismo, rif, nombre_organismo, sector) VALUES (9, 'G00000000012', 'Ministerio del Poder Popular para La Agricultura y Minas', 'Industrial');
INSERT INTO organismos (id_organismo, rif, nombre_organismo, sector) VALUES (7, 'G00000000004', 'Ministerio del Poder Popular para Las Industrias Intermedias', 'Industrial');
INSERT INTO organismos (id_organismo, rif, nombre_organismo, sector) VALUES (19, 'G02837902030', 'Ministerio del Poder Popular Para Las Comunicaciones', 'Transporte');


--
-- TOC entry 2064 (class 0 OID 17940)
-- Dependencies: 177
-- Data for Name: paises; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO paises (id_pais, pais) VALUES (1, 'Afganistan');
INSERT INTO paises (id_pais, pais) VALUES (2, 'Albania');
INSERT INTO paises (id_pais, pais) VALUES (3, 'Alemania');
INSERT INTO paises (id_pais, pais) VALUES (4, 'American Samoa');
INSERT INTO paises (id_pais, pais) VALUES (5, 'Andorra');
INSERT INTO paises (id_pais, pais) VALUES (6, 'Angola');
INSERT INTO paises (id_pais, pais) VALUES (7, 'Anguila');
INSERT INTO paises (id_pais, pais) VALUES (8, 'Antigua and Barbuda');
INSERT INTO paises (id_pais, pais) VALUES (9, 'Antillas Holandesas');
INSERT INTO paises (id_pais, pais) VALUES (10, 'Antartida');
INSERT INTO paises (id_pais, pais) VALUES (11, 'Arabia Saudita');
INSERT INTO paises (id_pais, pais) VALUES (12, 'Argelia');
INSERT INTO paises (id_pais, pais) VALUES (13, 'Argentina');
INSERT INTO paises (id_pais, pais) VALUES (14, 'Armenia');
INSERT INTO paises (id_pais, pais) VALUES (15, 'Aruba');
INSERT INTO paises (id_pais, pais) VALUES (17, 'Australia');
INSERT INTO paises (id_pais, pais) VALUES (18, 'Austria');
INSERT INTO paises (id_pais, pais) VALUES (19, 'Azerbaijan');
INSERT INTO paises (id_pais, pais) VALUES (20, 'Bahamas');
INSERT INTO paises (id_pais, pais) VALUES (21, 'Bahrein');
INSERT INTO paises (id_pais, pais) VALUES (22, 'Bangladesh');
INSERT INTO paises (id_pais, pais) VALUES (23, 'Barbados');
INSERT INTO paises (id_pais, pais) VALUES (24, 'Belice');
INSERT INTO paises (id_pais, pais) VALUES (25, 'Benin');
INSERT INTO paises (id_pais, pais) VALUES (26, 'Bermuda');
INSERT INTO paises (id_pais, pais) VALUES (27, 'Bielorrusia');
INSERT INTO paises (id_pais, pais) VALUES (28, 'Bolivia');
INSERT INTO paises (id_pais, pais) VALUES (29, 'Bosnia y Herzegovina');
INSERT INTO paises (id_pais, pais) VALUES (30, 'Botsuana');
INSERT INTO paises (id_pais, pais) VALUES (31, 'Bouvet Island');
INSERT INTO paises (id_pais, pais) VALUES (32, 'Brasil');
INSERT INTO paises (id_pais, pais) VALUES (33, 'British Indian Ocean Territory');
INSERT INTO paises (id_pais, pais) VALUES (34, 'Brunei Darussalam');
INSERT INTO paises (id_pais, pais) VALUES (35, 'Bulgaria');
INSERT INTO paises (id_pais, pais) VALUES (36, 'Burkina Faso');
INSERT INTO paises (id_pais, pais) VALUES (37, 'Burundi');
INSERT INTO paises (id_pais, pais) VALUES (38, 'Butan');
INSERT INTO paises (id_pais, pais) VALUES (39, 'Belgica');
INSERT INTO paises (id_pais, pais) VALUES (40, 'Cabo Verda');
INSERT INTO paises (id_pais, pais) VALUES (41, 'Camboya');
INSERT INTO paises (id_pais, pais) VALUES (42, 'Camerun');
INSERT INTO paises (id_pais, pais) VALUES (44, 'Canada');
INSERT INTO paises (id_pais, pais) VALUES (45, 'Chad');
INSERT INTO paises (id_pais, pais) VALUES (46, 'Chile');
INSERT INTO paises (id_pais, pais) VALUES (47, 'China');
INSERT INTO paises (id_pais, pais) VALUES (48, 'Chipre');
INSERT INTO paises (id_pais, pais) VALUES (49, 'Colombia');
INSERT INTO paises (id_pais, pais) VALUES (50, 'Comores');
INSERT INTO paises (id_pais, pais) VALUES (51, 'Congo');
INSERT INTO paises (id_pais, pais) VALUES (52, 'Corea del Norte');
INSERT INTO paises (id_pais, pais) VALUES (53, 'Corea del Sur');
INSERT INTO paises (id_pais, pais) VALUES (54, 'Costa Rica');
INSERT INTO paises (id_pais, pais) VALUES (55, 'Cote D Ivoire');
INSERT INTO paises (id_pais, pais) VALUES (56, 'Croacia');
INSERT INTO paises (id_pais, pais) VALUES (57, 'Cuba');
INSERT INTO paises (id_pais, pais) VALUES (58, 'Dinamarca');
INSERT INTO paises (id_pais, pais) VALUES (59, 'Djibouti');
INSERT INTO paises (id_pais, pais) VALUES (60, 'Dominica');
INSERT INTO paises (id_pais, pais) VALUES (61, 'East Timor');
INSERT INTO paises (id_pais, pais) VALUES (62, 'Ecuador');
INSERT INTO paises (id_pais, pais) VALUES (63, 'Egipto');
INSERT INTO paises (id_pais, pais) VALUES (64, 'El Salvador');
INSERT INTO paises (id_pais, pais) VALUES (65, 'El Vaticano');
INSERT INTO paises (id_pais, pais) VALUES (66, 'Emiratos Arabes Unidos');
INSERT INTO paises (id_pais, pais) VALUES (67, 'Eritrea');
INSERT INTO paises (id_pais, pais) VALUES (68, 'Eslovaquia');
INSERT INTO paises (id_pais, pais) VALUES (69, 'Eslovenia');
INSERT INTO paises (id_pais, pais) VALUES (70, 'España');
INSERT INTO paises (id_pais, pais) VALUES (71, 'Estados Unidos');
INSERT INTO paises (id_pais, pais) VALUES (72, 'Estonia');
INSERT INTO paises (id_pais, pais) VALUES (73, 'Etiopia');
INSERT INTO paises (id_pais, pais) VALUES (74, 'Fiji');
INSERT INTO paises (id_pais, pais) VALUES (75, 'Filipinas');
INSERT INTO paises (id_pais, pais) VALUES (76, 'Finlandia');
INSERT INTO paises (id_pais, pais) VALUES (77, 'Francia');
INSERT INTO paises (id_pais, pais) VALUES (78, 'French Guiana');
INSERT INTO paises (id_pais, pais) VALUES (79, 'French Polynesia');
INSERT INTO paises (id_pais, pais) VALUES (80, 'French Southern Territories');
INSERT INTO paises (id_pais, pais) VALUES (81, 'Gabon');
INSERT INTO paises (id_pais, pais) VALUES (82, 'Gambia');
INSERT INTO paises (id_pais, pais) VALUES (83, 'Georgia');
INSERT INTO paises (id_pais, pais) VALUES (84, 'Ghana');
INSERT INTO paises (id_pais, pais) VALUES (85, 'Gibraltar');
INSERT INTO paises (id_pais, pais) VALUES (86, 'Granada');
INSERT INTO paises (id_pais, pais) VALUES (87, 'Grecia');
INSERT INTO paises (id_pais, pais) VALUES (88, 'Groenlandia');
INSERT INTO paises (id_pais, pais) VALUES (89, 'Guadalupe');
INSERT INTO paises (id_pais, pais) VALUES (90, 'Guam');
INSERT INTO paises (id_pais, pais) VALUES (91, 'Guatemala');
INSERT INTO paises (id_pais, pais) VALUES (92, 'Guinea');
INSERT INTO paises (id_pais, pais) VALUES (93, 'Guinea Ecuatorial');
INSERT INTO paises (id_pais, pais) VALUES (94, 'Guinea-Bissau');
INSERT INTO paises (id_pais, pais) VALUES (95, 'Guyana');
INSERT INTO paises (id_pais, pais) VALUES (96, 'Haiti');
INSERT INTO paises (id_pais, pais) VALUES (97, 'Heard Island and McDonald Isla');
INSERT INTO paises (id_pais, pais) VALUES (98, 'Holanda');
INSERT INTO paises (id_pais, pais) VALUES (99, 'Honduras');
INSERT INTO paises (id_pais, pais) VALUES (100, 'Hong Kong');
INSERT INTO paises (id_pais, pais) VALUES (101, 'Hungria');
INSERT INTO paises (id_pais, pais) VALUES (102, 'India');
INSERT INTO paises (id_pais, pais) VALUES (103, 'Indonesia');
INSERT INTO paises (id_pais, pais) VALUES (104, 'Iraq');
INSERT INTO paises (id_pais, pais) VALUES (105, 'Irlanda');
INSERT INTO paises (id_pais, pais) VALUES (106, 'Isalas Cocos');
INSERT INTO paises (id_pais, pais) VALUES (107, 'Isla Christmas');
INSERT INTO paises (id_pais, pais) VALUES (108, 'Islandia');
INSERT INTO paises (id_pais, pais) VALUES (109, 'Islas Caiman');
INSERT INTO paises (id_pais, pais) VALUES (110, 'Islas Cook');
INSERT INTO paises (id_pais, pais) VALUES (111, 'Islas Feroe');
INSERT INTO paises (id_pais, pais) VALUES (112, 'Islas Malvinas');
INSERT INTO paises (id_pais, pais) VALUES (113, 'Islas Marshall');
INSERT INTO paises (id_pais, pais) VALUES (114, 'Islas Mauricio');
INSERT INTO paises (id_pais, pais) VALUES (115, 'Islas Salomon');
INSERT INTO paises (id_pais, pais) VALUES (116, 'Islas Sandwhich');
INSERT INTO paises (id_pais, pais) VALUES (117, 'Islas Turks y Caicos');
INSERT INTO paises (id_pais, pais) VALUES (118, 'Islas Wallis y Futuna');
INSERT INTO paises (id_pais, pais) VALUES (119, 'Israel');
INSERT INTO paises (id_pais, pais) VALUES (120, 'Italia');
INSERT INTO paises (id_pais, pais) VALUES (121, 'Jamaica');
INSERT INTO paises (id_pais, pais) VALUES (122, 'Japon');
INSERT INTO paises (id_pais, pais) VALUES (123, 'Jordania');
INSERT INTO paises (id_pais, pais) VALUES (124, 'Kazakhstan');
INSERT INTO paises (id_pais, pais) VALUES (125, 'Kenia');
INSERT INTO paises (id_pais, pais) VALUES (126, 'Kiribati');
INSERT INTO paises (id_pais, pais) VALUES (127, 'Kuwait');
INSERT INTO paises (id_pais, pais) VALUES (128, 'Kyrgyzstan');
INSERT INTO paises (id_pais, pais) VALUES (129, 'Laos');
INSERT INTO paises (id_pais, pais) VALUES (130, 'Latvia');
INSERT INTO paises (id_pais, pais) VALUES (131, 'Lesoto');
INSERT INTO paises (id_pais, pais) VALUES (132, 'Liberia');
INSERT INTO paises (id_pais, pais) VALUES (133, 'Libia');
INSERT INTO paises (id_pais, pais) VALUES (134, 'Liechtenstein');
INSERT INTO paises (id_pais, pais) VALUES (135, 'Lituania');
INSERT INTO paises (id_pais, pais) VALUES (136, 'Luxemburgo');
INSERT INTO paises (id_pais, pais) VALUES (137, 'Libano');
INSERT INTO paises (id_pais, pais) VALUES (138, 'Macao');
INSERT INTO paises (id_pais, pais) VALUES (139, 'Macedonia');
INSERT INTO paises (id_pais, pais) VALUES (140, 'Madagascar');
INSERT INTO paises (id_pais, pais) VALUES (141, 'Malasia');
INSERT INTO paises (id_pais, pais) VALUES (142, 'Malaui');
INSERT INTO paises (id_pais, pais) VALUES (143, 'Maldivas');
INSERT INTO paises (id_pais, pais) VALUES (144, 'Malta');
INSERT INTO paises (id_pais, pais) VALUES (145, 'Mali');
INSERT INTO paises (id_pais, pais) VALUES (146, 'Marruecos');
INSERT INTO paises (id_pais, pais) VALUES (147, 'Martinique');
INSERT INTO paises (id_pais, pais) VALUES (148, 'Mauritania');
INSERT INTO paises (id_pais, pais) VALUES (149, 'Mayotte');
INSERT INTO paises (id_pais, pais) VALUES (150, 'Micronesia');
INSERT INTO paises (id_pais, pais) VALUES (151, 'Moldavia');
INSERT INTO paises (id_pais, pais) VALUES (152, 'Mongolia');
INSERT INTO paises (id_pais, pais) VALUES (153, 'Montserrat');
INSERT INTO paises (id_pais, pais) VALUES (154, 'Mozambique');
INSERT INTO paises (id_pais, pais) VALUES (155, 'Myanmar');
INSERT INTO paises (id_pais, pais) VALUES (156, 'Mexico');
INSERT INTO paises (id_pais, pais) VALUES (157, 'Monaco');
INSERT INTO paises (id_pais, pais) VALUES (158, 'Namibia');
INSERT INTO paises (id_pais, pais) VALUES (159, 'Nauru');
INSERT INTO paises (id_pais, pais) VALUES (160, 'Nepal');
INSERT INTO paises (id_pais, pais) VALUES (161, 'Nicaragua');
INSERT INTO paises (id_pais, pais) VALUES (162, 'Nigeria');
INSERT INTO paises (id_pais, pais) VALUES (163, 'Niue');
INSERT INTO paises (id_pais, pais) VALUES (164, 'Norfolk Island');
INSERT INTO paises (id_pais, pais) VALUES (165, 'Northern Mariana Islands');
INSERT INTO paises (id_pais, pais) VALUES (166, 'Noruega');
INSERT INTO paises (id_pais, pais) VALUES (167, 'Nueva Caledonia');
INSERT INTO paises (id_pais, pais) VALUES (168, 'Nueva Zelanda');
INSERT INTO paises (id_pais, pais) VALUES (169, 'Niger');
INSERT INTO paises (id_pais, pais) VALUES (170, 'Oman');
INSERT INTO paises (id_pais, pais) VALUES (171, 'Pakistan');
INSERT INTO paises (id_pais, pais) VALUES (172, 'Palau');
INSERT INTO paises (id_pais, pais) VALUES (173, 'Palestinian Territory');
INSERT INTO paises (id_pais, pais) VALUES (174, 'Panama');
INSERT INTO paises (id_pais, pais) VALUES (175, 'Papua Nueva Guinea');
INSERT INTO paises (id_pais, pais) VALUES (176, 'Paraguay');
INSERT INTO paises (id_pais, pais) VALUES (177, 'Peru');
INSERT INTO paises (id_pais, pais) VALUES (178, 'Pitcairn');
INSERT INTO paises (id_pais, pais) VALUES (179, 'Polonia');
INSERT INTO paises (id_pais, pais) VALUES (180, 'Portugal');
INSERT INTO paises (id_pais, pais) VALUES (181, 'Puerto Rico');
INSERT INTO paises (id_pais, pais) VALUES (182, 'Qatar');
INSERT INTO paises (id_pais, pais) VALUES (183, 'Reino Unido');
INSERT INTO paises (id_pais, pais) VALUES (184, 'Republica Centroafricana');
INSERT INTO paises (id_pais, pais) VALUES (185, 'Republica Checa');
INSERT INTO paises (id_pais, pais) VALUES (186, 'Republica Democratica del Cong');
INSERT INTO paises (id_pais, pais) VALUES (187, 'Republica Dominicana');
INSERT INTO paises (id_pais, pais) VALUES (188, 'Republica Islamica de Iran');
INSERT INTO paises (id_pais, pais) VALUES (189, 'Ruanda');
INSERT INTO paises (id_pais, pais) VALUES (190, 'Rumania');
INSERT INTO paises (id_pais, pais) VALUES (191, 'Rusian');
INSERT INTO paises (id_pais, pais) VALUES (192, 'Saint Kitts and Nevis');
INSERT INTO paises (id_pais, pais) VALUES (193, 'Saint Pierre y Miquelon');
INSERT INTO paises (id_pais, pais) VALUES (194, 'Samoa');
INSERT INTO paises (id_pais, pais) VALUES (195, 'San Marino');
INSERT INTO paises (id_pais, pais) VALUES (196, 'San Vicente y Las Granadinas');
INSERT INTO paises (id_pais, pais) VALUES (197, 'Santa Elena');
INSERT INTO paises (id_pais, pais) VALUES (198, 'Santa Lucia');
INSERT INTO paises (id_pais, pais) VALUES (199, 'Sao Tome and Principe');
INSERT INTO paises (id_pais, pais) VALUES (200, 'Senegal');
INSERT INTO paises (id_pais, pais) VALUES (201, 'Serbia y Montenegro');
INSERT INTO paises (id_pais, pais) VALUES (202, 'Seychelles');
INSERT INTO paises (id_pais, pais) VALUES (203, 'Sierra Leona');
INSERT INTO paises (id_pais, pais) VALUES (204, 'Singapur');
INSERT INTO paises (id_pais, pais) VALUES (205, 'Siria');
INSERT INTO paises (id_pais, pais) VALUES (206, 'Somalia');
INSERT INTO paises (id_pais, pais) VALUES (207, 'Sri Lanka');
INSERT INTO paises (id_pais, pais) VALUES (208, 'Suazilandia');
INSERT INTO paises (id_pais, pais) VALUES (209, 'Sudafrica');
INSERT INTO paises (id_pais, pais) VALUES (210, 'Sudan');
INSERT INTO paises (id_pais, pais) VALUES (211, 'Suecia');
INSERT INTO paises (id_pais, pais) VALUES (212, 'Suiza');
INSERT INTO paises (id_pais, pais) VALUES (213, 'Surinam');
INSERT INTO paises (id_pais, pais) VALUES (214, 'Svalbard and Jan Mayen');
INSERT INTO paises (id_pais, pais) VALUES (215, 'Tailandia');
INSERT INTO paises (id_pais, pais) VALUES (216, 'Taiwan');
INSERT INTO paises (id_pais, pais) VALUES (217, 'Tajikistan');
INSERT INTO paises (id_pais, pais) VALUES (218, 'Tanzania');
INSERT INTO paises (id_pais, pais) VALUES (219, 'Togo');
INSERT INTO paises (id_pais, pais) VALUES (220, 'Tonga');
INSERT INTO paises (id_pais, pais) VALUES (221, 'Toquelau');
INSERT INTO paises (id_pais, pais) VALUES (222, 'Trinidad y Tobago');
INSERT INTO paises (id_pais, pais) VALUES (223, 'Turkmenistan');
INSERT INTO paises (id_pais, pais) VALUES (224, 'Turquia');
INSERT INTO paises (id_pais, pais) VALUES (225, 'Tuvalu');
INSERT INTO paises (id_pais, pais) VALUES (226, 'Tunez');
INSERT INTO paises (id_pais, pais) VALUES (227, 'Ucrania');
INSERT INTO paises (id_pais, pais) VALUES (228, 'Uganda');
INSERT INTO paises (id_pais, pais) VALUES (229, 'United States Minor Outlying I');
INSERT INTO paises (id_pais, pais) VALUES (230, 'Uruguay');
INSERT INTO paises (id_pais, pais) VALUES (231, 'Uzbekistan');
INSERT INTO paises (id_pais, pais) VALUES (232, 'Vanuatu');
INSERT INTO paises (id_pais, pais) VALUES (233, 'Venezuela');
INSERT INTO paises (id_pais, pais) VALUES (234, 'Vietnam');
INSERT INTO paises (id_pais, pais) VALUES (235, 'Virgin Islands British');
INSERT INTO paises (id_pais, pais) VALUES (236, 'Virgin Islands U.S.');
INSERT INTO paises (id_pais, pais) VALUES (237, 'Western Sahara');
INSERT INTO paises (id_pais, pais) VALUES (238, 'Yemen');
INSERT INTO paises (id_pais, pais) VALUES (239, 'Zaire');
INSERT INTO paises (id_pais, pais) VALUES (240, 'Zambia');
INSERT INTO paises (id_pais, pais) VALUES (241, 'Zimbabue');


--
-- TOC entry 2065 (class 0 OID 17945)
-- Dependencies: 179
-- Data for Name: perfiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO perfiles (id_perfil, perfil, descripcion_perfil) VALUES (3, 'Administrador', 'Tiene todos los derechos de Superusuario');
INSERT INTO perfiles (id_perfil, perfil, descripcion_perfil) VALUES (2, 'Abogado Coordinador', 'Representa el Abogado Jefe y tiene los permisos para cerrar casos así como realizar la asignación de expedientes en un determinado proceso a otros abogados.');
INSERT INTO perfiles (id_perfil, perfil, descripcion_perfil) VALUES (1, 'Abogado Asignado', 'Representa al Abogado al cual le es asignado un expediente, tiene permisos de llevar a cabo todos los cambios en las etapas de un expediente en el proceso en el cual le fué asignado dicho expediente.');


--
-- TOC entry 2066 (class 0 OID 17950)
-- Dependencies: 181
-- Data for Name: personas; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO personas (id_persona, nombre, apellido, nacionalidad, cedula_de_identidad, telefono1, telefono2, id_pais, email) VALUES (1, 'José Gabriel', 'González Pérez', 'V', 17693788, 4166075731, 4265124336, 233, 'jgabrielsinner10@gmail.com');
INSERT INTO personas (id_persona, nombre, apellido, nacionalidad, cedula_de_identidad, telefono1, telefono2, id_pais, email) VALUES (334, 'Ricardo Daniel', 'Gonzalez Perez', 'V', 25221860, 4165382905, 2123642288, 233, 'ricardogonzalez@expidian.com');
INSERT INTO personas (id_persona, nombre, apellido, nacionalidad, cedula_de_identidad, telefono1, telefono2, id_pais, email) VALUES (335, 'NombreUsuario', 'ApellidoUsuario', 'V', 12345678, 1234567890, NULL, 233, 'prueba@host.com');
INSERT INTO personas (id_persona, nombre, apellido, nacionalidad, cedula_de_identidad, telefono1, telefono2, id_pais, email) VALUES (337, 'Gabriel', 'Pirela', 'V', 1234561, 2125555555, NULL, 233, 'gabriel1@hotmail.com');
INSERT INTO personas (id_persona, nombre, apellido, nacionalidad, cedula_de_identidad, telefono1, telefono2, id_pais, email) VALUES (339, 'Gabriel', 'Pirela', 'V', 1234563, 2125555555, NULL, 233, 'gabriel3@hotmail.com');
INSERT INTO personas (id_persona, nombre, apellido, nacionalidad, cedula_de_identidad, telefono1, telefono2, id_pais, email) VALUES (340, 'Maria', 'Hernandez', 'V', 1234564, 2125555555, NULL, 233, 'maria4@hotmail.com');
INSERT INTO personas (id_persona, nombre, apellido, nacionalidad, cedula_de_identidad, telefono1, telefono2, id_pais, email) VALUES (341, 'Daniel', 'Vargas', 'V', 1234565, 2125555555, NULL, 233, 'daniel5@hotmail.com');
INSERT INTO personas (id_persona, nombre, apellido, nacionalidad, cedula_de_identidad, telefono1, telefono2, id_pais, email) VALUES (342, 'Daniel', 'Vargas', 'V', 1234566, 2125555555, NULL, 233, 'daniel6@hotmail.com');
INSERT INTO personas (id_persona, nombre, apellido, nacionalidad, cedula_de_identidad, telefono1, telefono2, id_pais, email) VALUES (343, 'Ricardo', 'Mata', 'V', 1234567, 2125555555, NULL, 233, 'ricardo7@hotmail.com');
INSERT INTO personas (id_persona, nombre, apellido, nacionalidad, cedula_de_identidad, telefono1, telefono2, id_pais, email) VALUES (344, 'Daniel', 'Lozada', 'V', 1234568, 2125555555, NULL, 233, 'daniel8@hotmail.com');
INSERT INTO personas (id_persona, nombre, apellido, nacionalidad, cedula_de_identidad, telefono1, telefono2, id_pais, email) VALUES (345, 'Andreina', 'Bolivar', 'V', 1234569, 2125555555, NULL, 233, 'andreina9@hotmail.com');
INSERT INTO personas (id_persona, nombre, apellido, nacionalidad, cedula_de_identidad, telefono1, telefono2, id_pais, email) VALUES (346, 'Ignacio', 'Pulido', 'V', 12345610, 2125555555, NULL, 233, 'ignacio10@hotmail.com');
INSERT INTO personas (id_persona, nombre, apellido, nacionalidad, cedula_de_identidad, telefono1, telefono2, id_pais, email) VALUES (347, 'Ignacio', 'Pulido', 'V', 12345611, 2125555555, NULL, 233, 'ignacio11@hotmail.com');
INSERT INTO personas (id_persona, nombre, apellido, nacionalidad, cedula_de_identidad, telefono1, telefono2, id_pais, email) VALUES (348, 'Ignacio', 'Pulido', 'V', 12345612, 2125555555, NULL, 233, 'ignacio12@hotmail.com');
INSERT INTO personas (id_persona, nombre, apellido, nacionalidad, cedula_de_identidad, telefono1, telefono2, id_pais, email) VALUES (349, 'Leonel', 'Perez', 'V', 12345613, 2125555555, NULL, 233, 'leonel13@hotmail.com');
INSERT INTO personas (id_persona, nombre, apellido, nacionalidad, cedula_de_identidad, telefono1, telefono2, id_pais, email) VALUES (350, 'Jose', 'Espinoza', 'V', 12345614, 2125555555, NULL, 233, 'jose14@hotmail.com');
INSERT INTO personas (id_persona, nombre, apellido, nacionalidad, cedula_de_identidad, telefono1, telefono2, id_pais, email) VALUES (351, 'Daniel', 'Lozada', 'V', 12345615, 2125555555, NULL, 233, 'daniel15@hotmail.com');
INSERT INTO personas (id_persona, nombre, apellido, nacionalidad, cedula_de_identidad, telefono1, telefono2, id_pais, email) VALUES (352, 'Daniel', 'Vargas', 'V', 12345616, 2125555555, NULL, 233, 'daniel16@hotmail.com');
INSERT INTO personas (id_persona, nombre, apellido, nacionalidad, cedula_de_identidad, telefono1, telefono2, id_pais, email) VALUES (353, 'Ricardo', 'Mata', 'V', 12345617, 2125555555, NULL, 233, 'ricardo17@hotmail.com');
INSERT INTO personas (id_persona, nombre, apellido, nacionalidad, cedula_de_identidad, telefono1, telefono2, id_pais, email) VALUES (354, 'Leonel', 'Perez', 'V', 12345618, 2125555555, NULL, 233, 'leonel18@hotmail.com');
INSERT INTO personas (id_persona, nombre, apellido, nacionalidad, cedula_de_identidad, telefono1, telefono2, id_pais, email) VALUES (355, 'Andreina', 'Bolivar', 'V', 12345619, 2125555555, NULL, 233, 'andreina19@hotmail.com');
INSERT INTO personas (id_persona, nombre, apellido, nacionalidad, cedula_de_identidad, telefono1, telefono2, id_pais, email) VALUES (356, 'Gabriel', 'Pirela', 'V', 12345620, 2125555555, NULL, 233, 'gabriel20@hotmail.com');
INSERT INTO personas (id_persona, nombre, apellido, nacionalidad, cedula_de_identidad, telefono1, telefono2, id_pais, email) VALUES (357, 'Leonel', 'Perez', 'V', 12345621, 2125555555, NULL, 233, 'leonel21@hotmail.com');
INSERT INTO personas (id_persona, nombre, apellido, nacionalidad, cedula_de_identidad, telefono1, telefono2, id_pais, email) VALUES (358, 'Rosbely', 'Silva', 'V', 12345622, 2125555555, NULL, 233, 'rosbely22@hotmail.com');
INSERT INTO personas (id_persona, nombre, apellido, nacionalidad, cedula_de_identidad, telefono1, telefono2, id_pais, email) VALUES (359, 'Ricardo', 'Mata', 'V', 12345623, 2125555555, NULL, 233, 'ricardo23@hotmail.com');
INSERT INTO personas (id_persona, nombre, apellido, nacionalidad, cedula_de_identidad, telefono1, telefono2, id_pais, email) VALUES (360, 'Leonel', 'Perez', 'V', 12345624, 2125555555, NULL, 233, 'leonel24@hotmail.com');
INSERT INTO personas (id_persona, nombre, apellido, nacionalidad, cedula_de_identidad, telefono1, telefono2, id_pais, email) VALUES (361, 'Daniel', 'Vargas', 'V', 12345625, 2125555555, NULL, 233, 'daniel25@hotmail.com');
INSERT INTO personas (id_persona, nombre, apellido, nacionalidad, cedula_de_identidad, telefono1, telefono2, id_pais, email) VALUES (362, 'Rosbely', 'Silva', 'V', 12345626, 2125555555, NULL, 233, 'rosbely26@hotmail.com');
INSERT INTO personas (id_persona, nombre, apellido, nacionalidad, cedula_de_identidad, telefono1, telefono2, id_pais, email) VALUES (363, 'Rosbely', 'Silva', 'V', 12345627, 2125555555, NULL, 233, 'rosbely27@hotmail.com');
INSERT INTO personas (id_persona, nombre, apellido, nacionalidad, cedula_de_identidad, telefono1, telefono2, id_pais, email) VALUES (364, 'Leonel', 'Perez', 'V', 12345628, 2125555555, NULL, 233, 'leonel28@hotmail.com');
INSERT INTO personas (id_persona, nombre, apellido, nacionalidad, cedula_de_identidad, telefono1, telefono2, id_pais, email) VALUES (365, 'Daniel', 'Vargas', 'V', 12345629, 2125555555, NULL, 233, 'daniel29@hotmail.com');
INSERT INTO personas (id_persona, nombre, apellido, nacionalidad, cedula_de_identidad, telefono1, telefono2, id_pais, email) VALUES (366, 'Daniel', 'Vargas', 'V', 12345630, 2125555555, NULL, 233, 'daniel30@hotmail.com');
INSERT INTO personas (id_persona, nombre, apellido, nacionalidad, cedula_de_identidad, telefono1, telefono2, id_pais, email) VALUES (367, 'Maria', 'Hernandez', 'V', 12345631, 2125555555, NULL, 233, 'maria31@hotmail.com');
INSERT INTO personas (id_persona, nombre, apellido, nacionalidad, cedula_de_identidad, telefono1, telefono2, id_pais, email) VALUES (368, 'Gabriel', 'Pirela', 'V', 12345632, 2125555555, NULL, 233, 'gabriel32@hotmail.com');
INSERT INTO personas (id_persona, nombre, apellido, nacionalidad, cedula_de_identidad, telefono1, telefono2, id_pais, email) VALUES (369, 'Andreina', 'Bolivar', 'V', 12345633, 2125555555, NULL, 233, 'andreina33@hotmail.com');
INSERT INTO personas (id_persona, nombre, apellido, nacionalidad, cedula_de_identidad, telefono1, telefono2, id_pais, email) VALUES (370, 'Ricardo', 'Mata', 'V', 12345634, 2125555555, NULL, 233, 'ricardo34@hotmail.com');
INSERT INTO personas (id_persona, nombre, apellido, nacionalidad, cedula_de_identidad, telefono1, telefono2, id_pais, email) VALUES (371, 'Leonel', 'Perez', 'V', 12345635, 2125555555, NULL, 233, 'leonel35@hotmail.com');
INSERT INTO personas (id_persona, nombre, apellido, nacionalidad, cedula_de_identidad, telefono1, telefono2, id_pais, email) VALUES (338, 'Daniel Eduardo', 'Lozada Prieto', 'V', 1234562, 2125555555, NULL, 233, 'daniel2@hotmail.com');
INSERT INTO personas (id_persona, nombre, apellido, nacionalidad, cedula_de_identidad, telefono1, telefono2, id_pais, email) VALUES (336, 'Alejandra', 'Hernández', 'V', 1234560, 2125555555, NULL, 233, 'maria0@hotmail.com');
INSERT INTO personas (id_persona, nombre, apellido, nacionalidad, cedula_de_identidad, telefono1, telefono2, id_pais, email) VALUES (372, 'Andreina', 'De Freites', 'V', 123456, 12223233423, NULL, 233, 'adefreites@ht24552.do');


--
-- TOC entry 2067 (class 0 OID 17956)
-- Dependencies: 183
-- Data for Name: procesos; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO procesos (id_proceso, proceso_abrev, proceso, nro_consecutivo_proceso) VALUES (2, 'VA', 'Valoración de Meritos', 1);
INSERT INTO procesos (id_proceso, proceso_abrev, proceso, nro_consecutivo_proceso) VALUES (3, 'PI', 'Potestad Investigativa', 2);
INSERT INTO procesos (id_proceso, proceso_abrev, proceso, nro_consecutivo_proceso) VALUES (4, 'DR', 'Determinación de Responsabilidades', 3);
INSERT INTO procesos (id_proceso, proceso_abrev, proceso, nro_consecutivo_proceso) VALUES (5, 'AR', 'Archivo', 4);


--
-- TOC entry 2068 (class 0 OID 17961)
-- Dependencies: 185
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO usuarios (id_usuario, usuario, usuario_encrypt, clave, es_activo, id_persona, id_perfil, fecha_registro, fecha_ultimo_ingreso) VALUES (1, '17693788', 'b87eedb67d0ac6a5b410031d35839371d27666ade08c55ba71cc5e30b775765d1d0d7cbe642b7fe27b493131e7f24e7953efdbf65d29cf71f9ecaa152e582eb9', '3c9909afec25354d551dae21590bb26e38d53f2173b8d3dc3eee4c047e7ab1c1eb8b85103e3be7ba613b31bb5c9c36214dc9f14a42fd7a2fdb84856bca5c44c2', 'SI', 1, 3, '2012-05-16', NULL);
INSERT INTO usuarios (id_usuario, usuario, usuario_encrypt, clave, es_activo, id_persona, id_perfil, fecha_registro, fecha_ultimo_ingreso) VALUES (4, '25221860', 'fd6327bfcec34accc721accfceced4e6e32c9e2cb95fca68e6dc8af2a2df8ebb318a5fbc627ceb282f4f3aa9b793c661a8d78978e47cc25be258e6db1b4f44bf', 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413', 'SI', 334, 2, '2012-07-06', NULL);
INSERT INTO usuarios (id_usuario, usuario, usuario_encrypt, clave, es_activo, id_persona, id_perfil, fecha_registro, fecha_ultimo_ingreso) VALUES (5, '12345678', 'fa585d89c851dd338a70dcf535aa2a92fee7836dd6aff1226583e88e0996293f16bc009c652826e0fc5c706695a03cddce372f139eff4d13959da6f1f5d3eabe', 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413', 'NO', 335, 3, '2012-07-06', NULL);
INSERT INTO usuarios (id_usuario, usuario, usuario_encrypt, clave, es_activo, id_persona, id_perfil, fecha_registro, fecha_ultimo_ingreso) VALUES (7, '1234561', '1bf4548a8612bd1cd052a0a4e47dd5716a58914a5bdca52f7bd5d8bdee40cc070a75e671ae22265134ef6b278eae6c49d4ea0f70a93549fed88466fcf254f6f9', 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413', 'NO', 337, 2, '2012-07-06', NULL);
INSERT INTO usuarios (id_usuario, usuario, usuario_encrypt, clave, es_activo, id_persona, id_perfil, fecha_registro, fecha_ultimo_ingreso) VALUES (9, '1234563', 'f82a524b464cdce750c4901dacd239c5c9d03a96415da351b1edf156ffbabd72cdbdc0a6ada09748d4349c85a69642f201187835aefbf275cd2c0ec9594e8122', 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413', 'NO', 339, 2, '2012-07-06', NULL);
INSERT INTO usuarios (id_usuario, usuario, usuario_encrypt, clave, es_activo, id_persona, id_perfil, fecha_registro, fecha_ultimo_ingreso) VALUES (10, '1234564', '5ccb02b1343ef1388470c31ad574410dcf33d539c2d847850dd18a9c439d38bb7ca5c014f8a88a8dd92fbb4fa5d5f5912939827ae4118ba83a5f0b3f78a5d9f2', 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413', 'SI', 340, 1, '2012-07-06', NULL);
INSERT INTO usuarios (id_usuario, usuario, usuario_encrypt, clave, es_activo, id_persona, id_perfil, fecha_registro, fecha_ultimo_ingreso) VALUES (11, '1234565', '0f84901d0da95d80b329cf0f9e5537183bf3447ef3a373c55cb914c762fcb30ba225ade6805a9a6b8c61b4d752afc1470e68e6e8186610dbd0ed770fe4cd2f74', 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413', 'SI', 341, 1, '2012-07-06', NULL);
INSERT INTO usuarios (id_usuario, usuario, usuario_encrypt, clave, es_activo, id_persona, id_perfil, fecha_registro, fecha_ultimo_ingreso) VALUES (12, '1234566', '19d1f195d8cc712d748f63379ced780e1bcf70f3738fabb25f0bcf6e92a76e3550e6fbeb11e0593f95783edf47aed88480149f51f3aadc40902e9b28c2a85fbd', 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413', 'NO', 342, 2, '2012-07-06', NULL);
INSERT INTO usuarios (id_usuario, usuario, usuario_encrypt, clave, es_activo, id_persona, id_perfil, fecha_registro, fecha_ultimo_ingreso) VALUES (13, '1234567', 'e13efc991a9bf44bbb4da87cdbb725240184585ccaf270523170e008cf2a3b85f45f86c3da647f69780fb9e971caf5437b3d06d418355a68c9760c70a31d05c7', 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413', 'SI', 343, 1, '2012-07-06', NULL);
INSERT INTO usuarios (id_usuario, usuario, usuario_encrypt, clave, es_activo, id_persona, id_perfil, fecha_registro, fecha_ultimo_ingreso) VALUES (14, '1234568', '650d268b1d43e84dcb4ce0a369f7843a6df17d27631ffbe6a72aa76e41aeec5c3652ab334700a6beecee4974832f9a4ff258bf758f7b40b42b37e84bbee1e341', 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413', 'SI', 344, 1, '2012-07-06', NULL);
INSERT INTO usuarios (id_usuario, usuario, usuario_encrypt, clave, es_activo, id_persona, id_perfil, fecha_registro, fecha_ultimo_ingreso) VALUES (15, '1234569', 'd7ec786f3155f94121df9658afa2c3dbb7fdb07d526b73c615045eada4f552b9c56ca4d53c9b66ce072e0f193b7a7a6f2534470eecc1a475d5fd7d74dbce57a9', 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413', 'SI', 345, 1, '2012-07-06', NULL);
INSERT INTO usuarios (id_usuario, usuario, usuario_encrypt, clave, es_activo, id_persona, id_perfil, fecha_registro, fecha_ultimo_ingreso) VALUES (16, '12345610', '622ebf95b008badf48cb1cde2a069728b3b5168728cae04462669e9b4782667203c37550dc7afe1b6c5b1dbc323283d4401956b736a673f42eac3e96d08838c3', 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413', 'SI', 346, 1, '2012-07-06', NULL);
INSERT INTO usuarios (id_usuario, usuario, usuario_encrypt, clave, es_activo, id_persona, id_perfil, fecha_registro, fecha_ultimo_ingreso) VALUES (17, '12345611', 'd55597ba93119d47724c3f77f4ddc3e0fa315c6dc355dcac46eb90c521d5a1695e7cb11bc867b72b4d6dce3ca17564c90b92fcc10eeb493c0473f33c3d26101f', 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413', 'SI', 347, 1, '2012-07-06', NULL);
INSERT INTO usuarios (id_usuario, usuario, usuario_encrypt, clave, es_activo, id_persona, id_perfil, fecha_registro, fecha_ultimo_ingreso) VALUES (18, '12345612', 'a1b4806a7c3a781504f393cbebab89da183839c924cf99e2bdd89bf8b23d1fd55d9d887c07e0e945b1958afa2388615e975859ae2038fd76da32d47ca5c7f1e4', 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413', 'NO', 348, 2, '2012-07-06', NULL);
INSERT INTO usuarios (id_usuario, usuario, usuario_encrypt, clave, es_activo, id_persona, id_perfil, fecha_registro, fecha_ultimo_ingreso) VALUES (19, '12345613', 'fe16de064e32af1ecbc669b02027e917b3e13ec89f0e48c34bbd66843f9a1dbf837f5702f4aaec9e390b4945c36782e51e52c4e4a0c6352f3166d4fa09f7e36b', 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413', 'NO', 349, 2, '2012-07-06', NULL);
INSERT INTO usuarios (id_usuario, usuario, usuario_encrypt, clave, es_activo, id_persona, id_perfil, fecha_registro, fecha_ultimo_ingreso) VALUES (20, '12345614', '53a4214105dc0f7304c80abe7f41062b4393ffa6b70c98b1cc2a988a78f0a4a11507cacf21db9fa8ed89765e871b59a2bb4d182228277680bb0fa092853afbb1', 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413', 'NO', 350, 2, '2012-07-06', NULL);
INSERT INTO usuarios (id_usuario, usuario, usuario_encrypt, clave, es_activo, id_persona, id_perfil, fecha_registro, fecha_ultimo_ingreso) VALUES (21, '12345615', 'a5c933a2848e08aeb14540fd5585019b54cf82d68323e93bbe13481867f8ea00549838be4f488776987120d04587333009efc0998e2c0504fe4a72ced34fc705', 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413', 'NO', 351, 2, '2012-07-06', NULL);
INSERT INTO usuarios (id_usuario, usuario, usuario_encrypt, clave, es_activo, id_persona, id_perfil, fecha_registro, fecha_ultimo_ingreso) VALUES (22, '12345616', '5ad77565a66d29d75a8791539fe67464550b3f89be8ae83b3ce7aab52ee6741d84c06a2f5c94af2d88b69504f4c0a32e01738755a9a718ed97441a0e5c9d36aa', 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413', 'NO', 352, 2, '2012-07-06', NULL);
INSERT INTO usuarios (id_usuario, usuario, usuario_encrypt, clave, es_activo, id_persona, id_perfil, fecha_registro, fecha_ultimo_ingreso) VALUES (23, '12345617', '3a2af5e43c9ceddc397037408d301129f62d26e4fd26f2cc40aec402f57527e0f978aeae9b9e7c04829998f56d2aa79d29a9c99cd9028a56f5ad551e244ccdcc', 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413', 'SI', 353, 1, '2012-07-06', NULL);
INSERT INTO usuarios (id_usuario, usuario, usuario_encrypt, clave, es_activo, id_persona, id_perfil, fecha_registro, fecha_ultimo_ingreso) VALUES (24, '12345618', '6fb9bdee39c3c4f6ed57f8c7b6a995b50468e7f7e5125c7eb78a67baae1866b7463cab15e149edb0f4695deac4ce772d0e2adc160740698db2f0f50e6d286d1e', 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413', 'SI', 354, 1, '2012-07-06', NULL);
INSERT INTO usuarios (id_usuario, usuario, usuario_encrypt, clave, es_activo, id_persona, id_perfil, fecha_registro, fecha_ultimo_ingreso) VALUES (25, '12345619', 'a8b39a2c13cb414d80578df3528b0193d93d3b891f638f6ec98dfae614a7cf931966f8a2ed51ad2c914de783f08cd5f0217ef06d70f51fa0f3275d97d0c3fa9c', 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413', 'SI', 355, 1, '2012-07-06', NULL);
INSERT INTO usuarios (id_usuario, usuario, usuario_encrypt, clave, es_activo, id_persona, id_perfil, fecha_registro, fecha_ultimo_ingreso) VALUES (26, '12345620', 'e3c47d2364a0792460e23dcf53247f5a829322d2a192e140802b3f72622db7c614003908359652289fdfa4abb8ff60a3b97f83ad53a45ef1bb57fa4fa03e2b58', 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413', 'NO', 356, 2, '2012-07-06', NULL);
INSERT INTO usuarios (id_usuario, usuario, usuario_encrypt, clave, es_activo, id_persona, id_perfil, fecha_registro, fecha_ultimo_ingreso) VALUES (6, '1234560', '2c7ffd10b1a294ba549750298e793fc1962a989a4541ce90925c76674d020a67d309e1e7f71d895ec5b07c342f9f93f074bedd75b9f97acaadac9de03e4b9759', 'e13efc991a9bf44bbb4da87cdbb725240184585ccaf270523170e008cf2a3b85f45f86c3da647f69780fb9e971caf5437b3d06d418355a68c9760c70a31d05c7', 'SI', 336, 1, '2012-07-06', NULL);
INSERT INTO usuarios (id_usuario, usuario, usuario_encrypt, clave, es_activo, id_persona, id_perfil, fecha_registro, fecha_ultimo_ingreso) VALUES (27, '12345621', 'a6fde99412324b701e2c2a68b0ca3b0cd6c53e273e0ad50c59bcb11bf63ecd27b629cc81f858a591cd86e927cdf8e38c8ceb3264e0ba79d253aaea1741947e6d', 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413', 'NO', 357, 2, '2012-07-06', NULL);
INSERT INTO usuarios (id_usuario, usuario, usuario_encrypt, clave, es_activo, id_persona, id_perfil, fecha_registro, fecha_ultimo_ingreso) VALUES (28, '12345622', '5e0c375a13ef224438a1704d36e40f4841dd7342d8bbdb270cdd7c3c96cd153ab8a146a79a4081fb0a107f8a3028a6771d82f670c49a84019803a5a98d1caaa5', 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413', 'NO', 358, 2, '2012-07-06', NULL);
INSERT INTO usuarios (id_usuario, usuario, usuario_encrypt, clave, es_activo, id_persona, id_perfil, fecha_registro, fecha_ultimo_ingreso) VALUES (29, '12345623', '4c32e71972431c431e74810a1e4fa62d74e4c83ea636ecaec860f79e14c592b0498336f7fe4e5d043d5d8fe65c7da2f44e112ab59d74d95f85bf581838eac4e8', 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413', 'NO', 359, 2, '2012-07-06', NULL);
INSERT INTO usuarios (id_usuario, usuario, usuario_encrypt, clave, es_activo, id_persona, id_perfil, fecha_registro, fecha_ultimo_ingreso) VALUES (30, '12345624', '36129c0abcdc748fb4559e5c5af985f6bcc2bedf00d29d1acd2754aa97d26ac70df0a06f5b31d69526d7ee1a9e846172a4adafe7081ac4e281eb801f516c7356', 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413', 'NO', 360, 2, '2012-07-06', NULL);
INSERT INTO usuarios (id_usuario, usuario, usuario_encrypt, clave, es_activo, id_persona, id_perfil, fecha_registro, fecha_ultimo_ingreso) VALUES (31, '12345625', '62a0acf5a0ebd32fb3c5dc1dc3995f74eb98e69f5dca31147e67f61d6ac90f3a494f48de5af0e8d0fcf23bb22bda612cf353e2fcb295edcaf24bdb97323e6661', 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413', 'SI', 361, 1, '2012-07-06', NULL);
INSERT INTO usuarios (id_usuario, usuario, usuario_encrypt, clave, es_activo, id_persona, id_perfil, fecha_registro, fecha_ultimo_ingreso) VALUES (32, '12345626', 'de78dd37d8be383517a115d9e6d11e61c422eb6924150a49ab7ba728bbc7ab1b8a2d91128e78be6546cae840ddab4cce6931e77f1eeb286f9d93472eb3cb6cca', 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413', 'SI', 362, 1, '2012-07-06', NULL);
INSERT INTO usuarios (id_usuario, usuario, usuario_encrypt, clave, es_activo, id_persona, id_perfil, fecha_registro, fecha_ultimo_ingreso) VALUES (33, '12345627', '11b9cd7420b5658ace23fc1c36821bb056661c8900a7e8763b42036d4098eff576895986dcaa2692a8c5a7746a67d46b718ce9101609d5395dc9b516abf7c4c3', 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413', 'SI', 363, 1, '2012-07-06', NULL);
INSERT INTO usuarios (id_usuario, usuario, usuario_encrypt, clave, es_activo, id_persona, id_perfil, fecha_registro, fecha_ultimo_ingreso) VALUES (34, '12345628', '43bac3bbfcfd724aca0de604fed94aa1dcfd46ee34288b9193ebb8c91e3a63ae226696be29411665acf3692dd77e2386f5daa54312fc4a18e2404449ee797a49', 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413', 'SI', 364, 1, '2012-07-06', NULL);
INSERT INTO usuarios (id_usuario, usuario, usuario_encrypt, clave, es_activo, id_persona, id_perfil, fecha_registro, fecha_ultimo_ingreso) VALUES (35, '12345629', 'e53ef07058b1cc8d4e3b2e9a80d2efb9fde30c60edb8fcaddfab30abe023b1ee97ee65e1535d7f56bd21521ffbf723cd06784a6f1a78eb12891d1f84b82ffd71', 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413', 'NO', 365, 2, '2012-07-06', NULL);
INSERT INTO usuarios (id_usuario, usuario, usuario_encrypt, clave, es_activo, id_persona, id_perfil, fecha_registro, fecha_ultimo_ingreso) VALUES (36, '12345630', 'f3e2e135a52d6bc565414657c844b464c76a83ddce88207a6aeb3223e4d923d27fc50df22a32d3a55739ae8a240929fd713e171db3fa8f317719a3375c7090c3', 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413', 'NO', 366, 2, '2012-07-06', NULL);
INSERT INTO usuarios (id_usuario, usuario, usuario_encrypt, clave, es_activo, id_persona, id_perfil, fecha_registro, fecha_ultimo_ingreso) VALUES (37, '12345631', 'c6a76ede900139234073ce7d5d0eef7e70d76de6c3acd3647441c14ce1421721b30ee25ad6312e436faea1f522264f53dbda1bda6bb44afc7e143eca7b3a2c0a', 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413', 'NO', 367, 2, '2012-07-06', NULL);
INSERT INTO usuarios (id_usuario, usuario, usuario_encrypt, clave, es_activo, id_persona, id_perfil, fecha_registro, fecha_ultimo_ingreso) VALUES (38, '12345632', '38121d2f656f0b1f5990a2ace9710bf8ac852ee93cefd486ae8932ad383a19a9c854368439e3f4b34d9122e9ffe194cfaea343f1a17f368177f2b15b47e2c9db', 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413', 'NO', 368, 2, '2012-07-06', NULL);
INSERT INTO usuarios (id_usuario, usuario, usuario_encrypt, clave, es_activo, id_persona, id_perfil, fecha_registro, fecha_ultimo_ingreso) VALUES (39, '12345633', 'fa971040eef51cf68294b101d44be70b580745122894215b4ef653dc7a5c117df5864b748f4a9c24c93c00bcfed50b3d804eba8a97a39b0804b176f9e88f0719', 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413', 'NO', 369, 2, '2012-07-06', NULL);
INSERT INTO usuarios (id_usuario, usuario, usuario_encrypt, clave, es_activo, id_persona, id_perfil, fecha_registro, fecha_ultimo_ingreso) VALUES (40, '12345634', '5588d087ba69a550810440211a2cd118a97a3e53a0fc55a1b68cf0ee274565f800b885b39deda94273040fd0fcec176d720eb7be6401dbb48b63f72e591d05ac', 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413', 'NO', 370, 2, '2012-07-06', NULL);
INSERT INTO usuarios (id_usuario, usuario, usuario_encrypt, clave, es_activo, id_persona, id_perfil, fecha_registro, fecha_ultimo_ingreso) VALUES (41, '12345635', 'b8974b6e6400b13f68d6c62c854d6bff3bdb30f806c02182fae39151f9de9559705f770dae24d9b65d7644325b383e723465c6bf6514ec87c01a9fa986e1a90e', 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413', 'SI', 371, 1, '2012-07-06', NULL);
INSERT INTO usuarios (id_usuario, usuario, usuario_encrypt, clave, es_activo, id_persona, id_perfil, fecha_registro, fecha_ultimo_ingreso) VALUES (8, '1234562', '2fcaa7f1460e8cb10c705035f7e77b03af8596504b00c93cddcbfaf2f15c16651b6fe17f53a9544025ad83f3691c9cb71bf085fa98aa1dfe023cb53fd529e2aa', '12b03226a6d8be9c6e8cd5e55dc6c7920caaa39df14aab92d5e3ea9340d1c8a4d3d0b8e4314f1f6ef131ba4bf1ceb9186ab87c801af0d5c95b1befb8cedae2b9', 'SI', 338, 2, '2012-07-06', NULL);
INSERT INTO usuarios (id_usuario, usuario, usuario_encrypt, clave, es_activo, id_persona, id_perfil, fecha_registro, fecha_ultimo_ingreso) VALUES (42, '123456', 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413', 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413', 'SI', 372, 2, '2012-07-09', NULL);


--
-- TOC entry 1982 (class 2606 OID 22523)
-- Dependencies: 161 161
-- Name: bitaco_mov_id_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY bitacoras
    ADD CONSTRAINT bitaco_mov_id_pk PRIMARY KEY (id_bitacora);


--
-- TOC entry 2018 (class 2606 OID 22525)
-- Dependencies: 181 181
-- Name: cedula_de_identidad_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY personas
    ADD CONSTRAINT cedula_de_identidad_uk UNIQUE (cedula_de_identidad);


--
-- TOC entry 1984 (class 2606 OID 22527)
-- Dependencies: 163 163
-- Name: consulta_id_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY consultas
    ADD CONSTRAINT consulta_id_pk PRIMARY KEY (id_consulta);


--
-- TOC entry 1986 (class 2606 OID 22529)
-- Dependencies: 165 165
-- Name: control_mov_id_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY control_movimientos
    ADD CONSTRAINT control_mov_id_pk PRIMARY KEY (id_control_movimientos);


--
-- TOC entry 1988 (class 2606 OID 22531)
-- Dependencies: 165 165 165 165
-- Name: control_movimiento_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY control_movimientos
    ADD CONSTRAINT control_movimiento_uk UNIQUE (id_expidiente, id_proceso, id_etapa);


--
-- TOC entry 1990 (class 2606 OID 22535)
-- Dependencies: 167 167
-- Name: etaba_abrev_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY etapas
    ADD CONSTRAINT etaba_abrev_uk UNIQUE (etapa_abrev);


--
-- TOC entry 1992 (class 2606 OID 23070)
-- Dependencies: 167 167 167
-- Name: etapa_consecutivo_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY etapas
    ADD CONSTRAINT etapa_consecutivo_uk UNIQUE (nro_consecutivo_etapa, id_proceso);


--
-- TOC entry 1994 (class 2606 OID 23092)
-- Dependencies: 167 167 167
-- Name: etapa_desc_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY etapas
    ADD CONSTRAINT etapa_desc_uk UNIQUE (etapa, id_proceso);


--
-- TOC entry 1996 (class 2606 OID 22541)
-- Dependencies: 167 167
-- Name: etapa_id_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY etapas
    ADD CONSTRAINT etapa_id_pk PRIMARY KEY (id_etapa);


--
-- TOC entry 1998 (class 2606 OID 22543)
-- Dependencies: 169 169
-- Name: id_expediente_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY expedientes
    ADD CONSTRAINT id_expediente_pk PRIMARY KEY (id_expediente);


--
-- TOC entry 2000 (class 2606 OID 22545)
-- Dependencies: 171 171
-- Name: id_interesado_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY interesados
    ADD CONSTRAINT id_interesado_pk PRIMARY KEY (id_interesado);


--
-- TOC entry 2014 (class 2606 OID 22547)
-- Dependencies: 179 179
-- Name: id_perfil_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY perfiles
    ADD CONSTRAINT id_perfil_pk PRIMARY KEY (id_perfil);


--
-- TOC entry 2030 (class 2606 OID 22549)
-- Dependencies: 185 185
-- Name: id_usuario_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY usuarios
    ADD CONSTRAINT id_usuario_pk PRIMARY KEY (id_usuario);


--
-- TOC entry 2002 (class 2606 OID 22551)
-- Dependencies: 173 173
-- Name: log_usuario_id_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY logs_usuarios
    ADD CONSTRAINT log_usuario_id_pk PRIMARY KEY (id_log_usuario);


--
-- TOC entry 2004 (class 2606 OID 22553)
-- Dependencies: 175 175
-- Name: organismo_id_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY organismos
    ADD CONSTRAINT organismo_id_pk PRIMARY KEY (id_organismo);


--
-- TOC entry 2006 (class 2606 OID 22555)
-- Dependencies: 175 175
-- Name: organismo_nombre_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY organismos
    ADD CONSTRAINT organismo_nombre_uk UNIQUE (nombre_organismo);


--
-- TOC entry 2008 (class 2606 OID 22557)
-- Dependencies: 175 175
-- Name: organismo_rif_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY organismos
    ADD CONSTRAINT organismo_rif_uk UNIQUE (rif);


--
-- TOC entry 2010 (class 2606 OID 22559)
-- Dependencies: 177 177
-- Name: pais_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY paises
    ADD CONSTRAINT pais_pk PRIMARY KEY (id_pais);


--
-- TOC entry 2012 (class 2606 OID 22561)
-- Dependencies: 177 177
-- Name: pais_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY paises
    ADD CONSTRAINT pais_uk UNIQUE (pais);


--
-- TOC entry 2016 (class 2606 OID 22563)
-- Dependencies: 179 179
-- Name: perfil; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY perfiles
    ADD CONSTRAINT perfil UNIQUE (perfil);


--
-- TOC entry 2020 (class 2606 OID 22565)
-- Dependencies: 181 181
-- Name: personas_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY personas
    ADD CONSTRAINT personas_pk PRIMARY KEY (id_persona);


--
-- TOC entry 2022 (class 2606 OID 22567)
-- Dependencies: 183 183
-- Name: proceso_abrev_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY procesos
    ADD CONSTRAINT proceso_abrev_uk UNIQUE (proceso_abrev);


--
-- TOC entry 2024 (class 2606 OID 22569)
-- Dependencies: 183 183
-- Name: proceso_consecutivo_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY procesos
    ADD CONSTRAINT proceso_consecutivo_uk UNIQUE (nro_consecutivo_proceso);


--
-- TOC entry 2026 (class 2606 OID 22571)
-- Dependencies: 183 183
-- Name: proceso_desc_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY procesos
    ADD CONSTRAINT proceso_desc_uk UNIQUE (proceso_abrev);


--
-- TOC entry 2028 (class 2606 OID 22573)
-- Dependencies: 183 183
-- Name: proceso_id_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY procesos
    ADD CONSTRAINT proceso_id_pk PRIMARY KEY (id_proceso);


--
-- TOC entry 2032 (class 2606 OID 22575)
-- Dependencies: 185 185
-- Name: usuario_encrypt_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY usuarios
    ADD CONSTRAINT usuario_encrypt_uk UNIQUE (usuario_encrypt);


--
-- TOC entry 2034 (class 2606 OID 22577)
-- Dependencies: 185 185
-- Name: usuario_persona_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY usuarios
    ADD CONSTRAINT usuario_persona_uk UNIQUE (id_persona);


--
-- TOC entry 2036 (class 2606 OID 22579)
-- Dependencies: 185 185
-- Name: usuario_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY usuarios
    ADD CONSTRAINT usuario_uk UNIQUE (usuario);


--
-- TOC entry 2037 (class 2606 OID 22580)
-- Dependencies: 161 169 1997
-- Name: bitaco_expediente_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY bitacoras
    ADD CONSTRAINT bitaco_expediente_fk FOREIGN KEY (id_expidiente) REFERENCES expedientes(id_expediente);


--
-- TOC entry 2050 (class 2606 OID 22585)
-- Dependencies: 2017 171 181
-- Name: cedula_de_identidad_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY interesados
    ADD CONSTRAINT cedula_de_identidad_fk FOREIGN KEY (cedula_de_identidad) REFERENCES personas(cedula_de_identidad);


--
-- TOC entry 2038 (class 2606 OID 22590)
-- Dependencies: 163 1997 169
-- Name: consulta_expediente_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY consultas
    ADD CONSTRAINT consulta_expediente_fk FOREIGN KEY (id_expediente) REFERENCES expedientes(id_expediente);


--
-- TOC entry 2039 (class 2606 OID 31266)
-- Dependencies: 185 2029 165
-- Name: control_abog_asignado_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY control_movimientos
    ADD CONSTRAINT control_abog_asignado_fk FOREIGN KEY (id_abogado_asign) REFERENCES usuarios(id_usuario);


--
-- TOC entry 2040 (class 2606 OID 31271)
-- Dependencies: 2029 185 165
-- Name: control_abog_coordinador_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY control_movimientos
    ADD CONSTRAINT control_abog_coordinador_fk FOREIGN KEY (id_abogado_coord) REFERENCES usuarios(id_usuario);


--
-- TOC entry 2041 (class 2606 OID 31276)
-- Dependencies: 167 165 1995
-- Name: control_etapa_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY control_movimientos
    ADD CONSTRAINT control_etapa_fk FOREIGN KEY (id_etapa) REFERENCES etapas(id_etapa);


--
-- TOC entry 2042 (class 2606 OID 31281)
-- Dependencies: 169 165 1997
-- Name: control_expediente_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY control_movimientos
    ADD CONSTRAINT control_expediente_fk FOREIGN KEY (id_expidiente) REFERENCES expedientes(id_expediente);


--
-- TOC entry 2043 (class 2606 OID 31286)
-- Dependencies: 183 165 2027
-- Name: control_proceso_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY control_movimientos
    ADD CONSTRAINT control_proceso_fk FOREIGN KEY (id_proceso) REFERENCES procesos(id_proceso);


--
-- TOC entry 2044 (class 2606 OID 31299)
-- Dependencies: 183 167 2027
-- Name: etapa_de_proceso_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY etapas
    ADD CONSTRAINT etapa_de_proceso_fk FOREIGN KEY (id_proceso) REFERENCES procesos(id_proceso);


--
-- TOC entry 2045 (class 2606 OID 31236)
-- Dependencies: 167 1995 169
-- Name: id_etapa_actual_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY expedientes
    ADD CONSTRAINT id_etapa_actual_fk FOREIGN KEY (id_etapa_actual) REFERENCES etapas(id_etapa);


--
-- TOC entry 2051 (class 2606 OID 22635)
-- Dependencies: 171 1997 169
-- Name: id_expediente_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY interesados
    ADD CONSTRAINT id_expediente_fk FOREIGN KEY (id_expediente) REFERENCES expedientes(id_expediente);


--
-- TOC entry 2046 (class 2606 OID 31241)
-- Dependencies: 175 169 2003
-- Name: id_organismo_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY expedientes
    ADD CONSTRAINT id_organismo_fk FOREIGN KEY (id_organismo) REFERENCES organismos(id_organismo);


--
-- TOC entry 2047 (class 2606 OID 31246)
-- Dependencies: 2027 183 169
-- Name: id_proceso_actual_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY expedientes
    ADD CONSTRAINT id_proceso_actual_fk FOREIGN KEY (id_proceso_actual) REFERENCES procesos(id_proceso);


--
-- TOC entry 2049 (class 2606 OID 31256)
-- Dependencies: 185 2029 169
-- Name: id_usuario_asig_actual_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY expedientes
    ADD CONSTRAINT id_usuario_asig_actual_fk FOREIGN KEY (id_usuario_act) REFERENCES usuarios(id_usuario);


--
-- TOC entry 2048 (class 2606 OID 31251)
-- Dependencies: 185 2029 169
-- Name: id_usuario_reg_inicial_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY expedientes
    ADD CONSTRAINT id_usuario_reg_inicial_fk FOREIGN KEY (id_usuario_ini) REFERENCES usuarios(id_usuario);


--
-- TOC entry 2052 (class 2606 OID 22655)
-- Dependencies: 185 173 2029
-- Name: log_usuario_reg_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY logs_usuarios
    ADD CONSTRAINT log_usuario_reg_fk FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario);


--
-- TOC entry 2053 (class 2606 OID 22892)
-- Dependencies: 177 181 2009
-- Name: persona_pais_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY personas
    ADD CONSTRAINT persona_pais_fk FOREIGN KEY (id_pais) REFERENCES paises(id_pais);


--
-- TOC entry 2054 (class 2606 OID 22898)
-- Dependencies: 2013 179 185
-- Name: usuario_perfil_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuarios
    ADD CONSTRAINT usuario_perfil_fk FOREIGN KEY (id_perfil) REFERENCES perfiles(id_perfil);


--
-- TOC entry 2055 (class 2606 OID 22903)
-- Dependencies: 2019 185 181
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


-- Completed on 2012-07-10 06:52:05

--
-- PostgreSQL database dump complete
--

