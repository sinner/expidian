--
-- PostgreSQL database dump
--

-- Dumped from database version 9.1.4
-- Dumped by pg_dump version 9.1.4
-- Started on 2012-07-06 15:11:40

SET statement_timeout = 0;
SET client_encoding = 'WIN1252';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 188 (class 3079 OID 11639)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2070 (class 0 OID 0)
-- Dependencies: 188
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- TOC entry 187 (class 3079 OID 32777)
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- TOC entry 2071 (class 0 OID 0)
-- Dependencies: 187
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


--
-- TOC entry 189 (class 3079 OID 32786)
-- Dependencies: 6
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- TOC entry 2072 (class 0 OID 0)
-- Dependencies: 189
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


SET search_path = public, pg_catalog;

--
-- TOC entry 234 (class 1255 OID 32820)
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
-- TOC entry 161 (class 1259 OID 32821)
-- Dependencies: 6
-- Name: consultas; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE consultas (
    id_consulta integer NOT NULL,
    cedula_de_identidad character varying(15) NOT NULL,
    id_expediente integer NOT NULL,
    fecha_consulta timestamp without time zone NOT NULL
);


ALTER TABLE public.consultas OWNER TO postgres;

--
-- TOC entry 162 (class 1259 OID 32824)
-- Dependencies: 161 6
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
-- TOC entry 2073 (class 0 OID 0)
-- Dependencies: 162
-- Name: consultas_id_consulta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE consultas_id_consulta_seq OWNED BY consultas.id_consulta;


--
-- TOC entry 2074 (class 0 OID 0)
-- Dependencies: 162
-- Name: consultas_id_consulta_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('consultas_id_consulta_seq', 1, false);


--
-- TOC entry 163 (class 1259 OID 32826)
-- Dependencies: 6
-- Name: control_movimientos; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE control_movimientos (
    id_control_movimientos integer NOT NULL,
    id_expidiente integer NOT NULL,
    id_proceso integer NOT NULL,
    id_etapa integer NOT NULL,
    cod_expediente character varying(11) NOT NULL,
    fecha_movimiento timestamp without time zone NOT NULL,
    id_abogado_coord integer,
    id_abogado_asign integer NOT NULL
);


ALTER TABLE public.control_movimientos OWNER TO postgres;

--
-- TOC entry 164 (class 1259 OID 32829)
-- Dependencies: 6 163
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
-- TOC entry 2075 (class 0 OID 0)
-- Dependencies: 164
-- Name: control_movimientos_id_control_movimientos_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE control_movimientos_id_control_movimientos_seq OWNED BY control_movimientos.id_control_movimientos;


--
-- TOC entry 2076 (class 0 OID 0)
-- Dependencies: 164
-- Name: control_movimientos_id_control_movimientos_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('control_movimientos_id_control_movimientos_seq', 1, false);


--
-- TOC entry 165 (class 1259 OID 32836)
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
-- TOC entry 166 (class 1259 OID 32839)
-- Dependencies: 6 165
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
-- TOC entry 2077 (class 0 OID 0)
-- Dependencies: 166
-- Name: etapas_id_etapa_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE etapas_id_etapa_seq OWNED BY etapas.id_etapa;


--
-- TOC entry 2078 (class 0 OID 0)
-- Dependencies: 166
-- Name: etapas_id_etapa_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('etapas_id_etapa_seq', 1, false);


--
-- TOC entry 167 (class 1259 OID 32841)
-- Dependencies: 6
-- Name: expedientes; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE expedientes (
    id_expediente integer NOT NULL,
    id_organismo integer,
    hechos text,
    observaciones text,
    id_proceso_actual integer,
    id_etapa_actual integer,
    fecha_registro timestamp without time zone NOT NULL,
    fecha_solic_invest date,
    id_usuario_ini integer NOT NULL
);


ALTER TABLE public.expedientes OWNER TO postgres;

--
-- TOC entry 168 (class 1259 OID 32847)
-- Dependencies: 6 167
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
-- TOC entry 2079 (class 0 OID 0)
-- Dependencies: 168
-- Name: expedientes_id_expediente_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE expedientes_id_expediente_seq OWNED BY expedientes.id_expediente;


--
-- TOC entry 2080 (class 0 OID 0)
-- Dependencies: 168
-- Name: expedientes_id_expediente_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('expedientes_id_expediente_seq', 1, false);


--
-- TOC entry 169 (class 1259 OID 32849)
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
-- TOC entry 170 (class 1259 OID 32852)
-- Dependencies: 6 169
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
-- TOC entry 2081 (class 0 OID 0)
-- Dependencies: 170
-- Name: interesados_id_interesado_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE interesados_id_interesado_seq OWNED BY interesados.id_interesado;


--
-- TOC entry 2082 (class 0 OID 0)
-- Dependencies: 170
-- Name: interesados_id_interesado_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('interesados_id_interesado_seq', 1, false);


--
-- TOC entry 171 (class 1259 OID 32854)
-- Dependencies: 6
-- Name: logs_usuarios; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE logs_usuarios (
    id_log_usuario integer NOT NULL,
    id_usuario integer NOT NULL,
    log_usuario character varying(250) NOT NULL,
    estatus_final character varying(20),
    fecha_log timestamp without time zone NOT NULL
);


ALTER TABLE public.logs_usuarios OWNER TO postgres;

--
-- TOC entry 172 (class 1259 OID 32857)
-- Dependencies: 6 171
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
-- TOC entry 2083 (class 0 OID 0)
-- Dependencies: 172
-- Name: logs_usuarios_id_log_usuario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE logs_usuarios_id_log_usuario_seq OWNED BY logs_usuarios.id_log_usuario;


--
-- TOC entry 2084 (class 0 OID 0)
-- Dependencies: 172
-- Name: logs_usuarios_id_log_usuario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('logs_usuarios_id_log_usuario_seq', 1, false);


--
-- TOC entry 173 (class 1259 OID 32859)
-- Dependencies: 6
-- Name: observaciones; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE observaciones (
    id_observacion integer NOT NULL,
    id_expidiente integer NOT NULL,
    id_proceso integer NOT NULL,
    id_etapa integer NOT NULL,
    observacion text NOT NULL,
    fecha_registro timestamp without time zone NOT NULL
);


ALTER TABLE public.observaciones OWNER TO postgres;

--
-- TOC entry 174 (class 1259 OID 32865)
-- Dependencies: 6 173
-- Name: observaciones_id_observacion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE observaciones_id_observacion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.observaciones_id_observacion_seq OWNER TO postgres;

--
-- TOC entry 2085 (class 0 OID 0)
-- Dependencies: 174
-- Name: observaciones_id_observacion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE observaciones_id_observacion_seq OWNED BY observaciones.id_observacion;


--
-- TOC entry 2086 (class 0 OID 0)
-- Dependencies: 174
-- Name: observaciones_id_observacion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('observaciones_id_observacion_seq', 1, false);


--
-- TOC entry 175 (class 1259 OID 32867)
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
-- TOC entry 176 (class 1259 OID 32870)
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
-- TOC entry 2087 (class 0 OID 0)
-- Dependencies: 176
-- Name: organismos_id_organismo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE organismos_id_organismo_seq OWNED BY organismos.id_organismo;


--
-- TOC entry 2088 (class 0 OID 0)
-- Dependencies: 176
-- Name: organismos_id_organismo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('organismos_id_organismo_seq', 1, false);


--
-- TOC entry 177 (class 1259 OID 32872)
-- Dependencies: 6
-- Name: paises; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE paises (
    id_pais integer NOT NULL,
    pais character varying(35) NOT NULL
);


ALTER TABLE public.paises OWNER TO postgres;

--
-- TOC entry 178 (class 1259 OID 32875)
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
-- TOC entry 2089 (class 0 OID 0)
-- Dependencies: 178
-- Name: paises_id_pais_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE paises_id_pais_seq OWNED BY paises.id_pais;


--
-- TOC entry 2090 (class 0 OID 0)
-- Dependencies: 178
-- Name: paises_id_pais_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('paises_id_pais_seq', 239, true);


--
-- TOC entry 179 (class 1259 OID 32877)
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
-- TOC entry 180 (class 1259 OID 32880)
-- Dependencies: 6 179
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
-- TOC entry 2091 (class 0 OID 0)
-- Dependencies: 180
-- Name: perfiles_id_perfil_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE perfiles_id_perfil_seq OWNED BY perfiles.id_perfil;


--
-- TOC entry 2092 (class 0 OID 0)
-- Dependencies: 180
-- Name: perfiles_id_perfil_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('perfiles_id_perfil_seq', 3, true);


--
-- TOC entry 181 (class 1259 OID 32882)
-- Dependencies: 6
-- Name: personas; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE personas (
    id_persona integer NOT NULL,
    nombre character varying(60) NOT NULL,
    apellido character varying(60) NOT NULL,
    nacionalidad character varying(1) NOT NULL,
    cedula_de_identidad numeric(15,0) NOT NULL,
    telefono1 numeric(11,0) NOT NULL,
    telefono2 numeric(11,0),
    id_pais integer,
    email character varying(100)
);


ALTER TABLE public.personas OWNER TO postgres;

--
-- TOC entry 182 (class 1259 OID 32885)
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
-- TOC entry 2093 (class 0 OID 0)
-- Dependencies: 182
-- Name: personas_id_persona_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE personas_id_persona_seq OWNED BY personas.id_persona;


--
-- TOC entry 2094 (class 0 OID 0)
-- Dependencies: 182
-- Name: personas_id_persona_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('personas_id_persona_seq', 290, true);


--
-- TOC entry 183 (class 1259 OID 32887)
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
-- TOC entry 184 (class 1259 OID 32890)
-- Dependencies: 183 6
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
-- TOC entry 2095 (class 0 OID 0)
-- Dependencies: 184
-- Name: procesos_id_proceso_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE procesos_id_proceso_seq OWNED BY procesos.id_proceso;


--
-- TOC entry 2096 (class 0 OID 0)
-- Dependencies: 184
-- Name: procesos_id_proceso_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('procesos_id_proceso_seq', 1, false);


--
-- TOC entry 185 (class 1259 OID 32892)
-- Dependencies: 1970 1971 1973 6
-- Name: usuarios; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE usuarios (
    id_usuario integer NOT NULL,
    usuario character varying(15) NOT NULL,
    usuario_encrypt character varying(128) NOT NULL,
    clave character varying(128) NOT NULL,
    fecha_registro timestamp without time zone DEFAULT now() NOT NULL,
    fecha_ultimo_ingreso timestamp without time zone DEFAULT now(),
    es_activo character varying(2) DEFAULT 'NO'::character varying NOT NULL,
    id_persona integer NOT NULL,
    id_perfil integer NOT NULL,
    str_recuperacion_clave character varying(128),
    fecha_recuperacion_clave time without time zone
);


ALTER TABLE public.usuarios OWNER TO postgres;

--
-- TOC entry 186 (class 1259 OID 32897)
-- Dependencies: 185 6
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
-- TOC entry 2097 (class 0 OID 0)
-- Dependencies: 186
-- Name: usuarios_id_usuario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE usuarios_id_usuario_seq OWNED BY usuarios.id_usuario;


--
-- TOC entry 2098 (class 0 OID 0)
-- Dependencies: 186
-- Name: usuarios_id_usuario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('usuarios_id_usuario_seq', 38, true);


--
-- TOC entry 1958 (class 2604 OID 32899)
-- Dependencies: 162 161
-- Name: id_consulta; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY consultas ALTER COLUMN id_consulta SET DEFAULT nextval('consultas_id_consulta_seq'::regclass);


--
-- TOC entry 1959 (class 2604 OID 32900)
-- Dependencies: 164 163
-- Name: id_control_movimientos; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY control_movimientos ALTER COLUMN id_control_movimientos SET DEFAULT nextval('control_movimientos_id_control_movimientos_seq'::regclass);


--
-- TOC entry 1960 (class 2604 OID 32902)
-- Dependencies: 166 165
-- Name: id_etapa; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY etapas ALTER COLUMN id_etapa SET DEFAULT nextval('etapas_id_etapa_seq'::regclass);


--
-- TOC entry 1961 (class 2604 OID 32903)
-- Dependencies: 168 167
-- Name: id_expediente; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY expedientes ALTER COLUMN id_expediente SET DEFAULT nextval('expedientes_id_expediente_seq'::regclass);


--
-- TOC entry 1962 (class 2604 OID 32904)
-- Dependencies: 170 169
-- Name: id_interesado; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY interesados ALTER COLUMN id_interesado SET DEFAULT nextval('interesados_id_interesado_seq'::regclass);


--
-- TOC entry 1963 (class 2604 OID 32905)
-- Dependencies: 172 171
-- Name: id_log_usuario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY logs_usuarios ALTER COLUMN id_log_usuario SET DEFAULT nextval('logs_usuarios_id_log_usuario_seq'::regclass);


--
-- TOC entry 1964 (class 2604 OID 32906)
-- Dependencies: 174 173
-- Name: id_observacion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY observaciones ALTER COLUMN id_observacion SET DEFAULT nextval('observaciones_id_observacion_seq'::regclass);


--
-- TOC entry 1965 (class 2604 OID 32907)
-- Dependencies: 176 175
-- Name: id_organismo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organismos ALTER COLUMN id_organismo SET DEFAULT nextval('organismos_id_organismo_seq'::regclass);


--
-- TOC entry 1966 (class 2604 OID 32908)
-- Dependencies: 178 177
-- Name: id_pais; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY paises ALTER COLUMN id_pais SET DEFAULT nextval('paises_id_pais_seq'::regclass);


--
-- TOC entry 1967 (class 2604 OID 32909)
-- Dependencies: 180 179
-- Name: id_perfil; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY perfiles ALTER COLUMN id_perfil SET DEFAULT nextval('perfiles_id_perfil_seq'::regclass);


--
-- TOC entry 1968 (class 2604 OID 32910)
-- Dependencies: 182 181
-- Name: id_persona; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY personas ALTER COLUMN id_persona SET DEFAULT nextval('personas_id_persona_seq'::regclass);


--
-- TOC entry 1969 (class 2604 OID 32911)
-- Dependencies: 184 183
-- Name: id_proceso; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY procesos ALTER COLUMN id_proceso SET DEFAULT nextval('procesos_id_proceso_seq'::regclass);


--
-- TOC entry 1972 (class 2604 OID 32912)
-- Dependencies: 186 185
-- Name: id_usuario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuarios ALTER COLUMN id_usuario SET DEFAULT nextval('usuarios_id_usuario_seq'::regclass);


--
-- TOC entry 2052 (class 0 OID 32821)
-- Dependencies: 161
-- Data for Name: consultas; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2053 (class 0 OID 32826)
-- Dependencies: 163
-- Data for Name: control_movimientos; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2054 (class 0 OID 32836)
-- Dependencies: 165
-- Data for Name: etapas; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2055 (class 0 OID 32841)
-- Dependencies: 167
-- Data for Name: expedientes; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2056 (class 0 OID 32849)
-- Dependencies: 169
-- Data for Name: interesados; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2057 (class 0 OID 32854)
-- Dependencies: 171
-- Data for Name: logs_usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2058 (class 0 OID 32859)
-- Dependencies: 173
-- Data for Name: observaciones; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2059 (class 0 OID 32867)
-- Dependencies: 175
-- Data for Name: organismos; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2060 (class 0 OID 32872)
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
-- TOC entry 2061 (class 0 OID 32877)
-- Dependencies: 179
-- Data for Name: perfiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO perfiles (id_perfil, perfil, descripcion_perfil) VALUES (3, 'Abogado Asignado', 'Representa al Abogado al cual le es asignado un expediente, tiene permisos de llevar a cabo todos los cambios en las etapas de un expediente en el proceso en el cual le fué asignado dicho expediente.');
INSERT INTO perfiles (id_perfil, perfil, descripcion_perfil) VALUES (1, 'Administrador', 'Tiene todos los derechos de Superusuario');
INSERT INTO perfiles (id_perfil, perfil, descripcion_perfil) VALUES (2, 'Abogado Coordinador', 'Representa el Abogado Jefe y tiene los permisos para cerrar casos así como realizar la asignación de expedientes en un determinado proceso a otros abogados.');


--
-- TOC entry 2062 (class 0 OID 32882)
-- Dependencies: 181
-- Data for Name: personas; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO personas (id_persona, nombre, apellido, nacionalidad, cedula_de_identidad, telefono1, telefono2, id_pais, email) VALUES (1, 'José Gabriel', 'Gonzalez', 'V', 17693788, 4166075731, 4265124336, 233, 'jgabrielsinner10@gmail.com');


--
-- TOC entry 2063 (class 0 OID 32887)
-- Dependencies: 183
-- Data for Name: procesos; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2064 (class 0 OID 32892)
-- Dependencies: 185
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO usuarios (id_usuario, usuario, usuario_encrypt, clave, fecha_registro, fecha_ultimo_ingreso, es_activo, id_persona, id_perfil, str_recuperacion_clave, fecha_recuperacion_clave) VALUES (1, '17693788', 'b87eedb67d0ac6a5b410031d35839371d27666ade08c55ba71cc5e30b775765d1d0d7cbe642b7fe27b493131e7f24e7953efdbf65d29cf71f9ecaa152e582eb9', '3c9909afec25354d551dae21590bb26e38d53f2173b8d3dc3eee4c047e7ab1c1eb8b85103e3be7ba613b31bb5c9c36214dc9f14a42fd7a2fdb84856bca5c44c2', '2012-04-10 00:46:51.91009', '2012-04-10 00:46:51.91009', 'SI', 1, 1, NULL, NULL);


--
-- TOC entry 2013 (class 2606 OID 37450)
-- Dependencies: 181 181
-- Name: cedula_de_identidad_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY personas
    ADD CONSTRAINT cedula_de_identidad_uk UNIQUE (cedula_de_identidad);


--
-- TOC entry 1975 (class 2606 OID 37452)
-- Dependencies: 161 161
-- Name: consulta_id_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY consultas
    ADD CONSTRAINT consulta_id_pk PRIMARY KEY (id_consulta);


--
-- TOC entry 1977 (class 2606 OID 37454)
-- Dependencies: 163 163
-- Name: control_mov_id_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY control_movimientos
    ADD CONSTRAINT control_mov_id_pk PRIMARY KEY (id_control_movimientos);


--
-- TOC entry 1979 (class 2606 OID 37456)
-- Dependencies: 163 163 163 163
-- Name: control_movimiento_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY control_movimientos
    ADD CONSTRAINT control_movimiento_uk UNIQUE (id_expidiente, id_proceso, id_etapa);


--
-- TOC entry 1981 (class 2606 OID 37460)
-- Dependencies: 165 165
-- Name: etaba_abrev_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY etapas
    ADD CONSTRAINT etaba_abrev_uk UNIQUE (etapa_abrev);


--
-- TOC entry 1983 (class 2606 OID 37462)
-- Dependencies: 165 165
-- Name: etapa_consecutivo_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY etapas
    ADD CONSTRAINT etapa_consecutivo_uk UNIQUE (nro_consecutivo_etapa);


--
-- TOC entry 1985 (class 2606 OID 37464)
-- Dependencies: 165 165
-- Name: etapa_desc_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY etapas
    ADD CONSTRAINT etapa_desc_uk UNIQUE (etapa);


--
-- TOC entry 1987 (class 2606 OID 37466)
-- Dependencies: 165 165
-- Name: etapa_id_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY etapas
    ADD CONSTRAINT etapa_id_pk PRIMARY KEY (id_etapa);


--
-- TOC entry 1989 (class 2606 OID 37468)
-- Dependencies: 167 167
-- Name: id_expediente_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY expedientes
    ADD CONSTRAINT id_expediente_pk PRIMARY KEY (id_expediente);


--
-- TOC entry 1991 (class 2606 OID 37470)
-- Dependencies: 169 169
-- Name: id_interesado_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY interesados
    ADD CONSTRAINT id_interesado_pk PRIMARY KEY (id_interesado);


--
-- TOC entry 2009 (class 2606 OID 37472)
-- Dependencies: 179 179
-- Name: id_perfil_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY perfiles
    ADD CONSTRAINT id_perfil_pk PRIMARY KEY (id_perfil);


--
-- TOC entry 2025 (class 2606 OID 37474)
-- Dependencies: 185 185
-- Name: id_usuario_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY usuarios
    ADD CONSTRAINT id_usuario_pk PRIMARY KEY (id_usuario);


--
-- TOC entry 1993 (class 2606 OID 37476)
-- Dependencies: 171 171
-- Name: log_usuario_id_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY logs_usuarios
    ADD CONSTRAINT log_usuario_id_pk PRIMARY KEY (id_log_usuario);


--
-- TOC entry 1995 (class 2606 OID 37478)
-- Dependencies: 173 173
-- Name: observ_mov_id_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY observaciones
    ADD CONSTRAINT observ_mov_id_pk PRIMARY KEY (id_observacion);


--
-- TOC entry 1997 (class 2606 OID 37480)
-- Dependencies: 173 173 173 173
-- Name: observ_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY observaciones
    ADD CONSTRAINT observ_uk UNIQUE (id_expidiente, id_proceso, id_etapa);


--
-- TOC entry 1999 (class 2606 OID 37482)
-- Dependencies: 175 175
-- Name: organismo_id_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY organismos
    ADD CONSTRAINT organismo_id_pk PRIMARY KEY (id_organismo);


--
-- TOC entry 2001 (class 2606 OID 37484)
-- Dependencies: 175 175
-- Name: organismo_nombre_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY organismos
    ADD CONSTRAINT organismo_nombre_uk UNIQUE (nombre_organismo);


--
-- TOC entry 2003 (class 2606 OID 37486)
-- Dependencies: 175 175
-- Name: organismo_rif_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY organismos
    ADD CONSTRAINT organismo_rif_uk UNIQUE (rif);


--
-- TOC entry 2005 (class 2606 OID 37488)
-- Dependencies: 177 177
-- Name: pais_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY paises
    ADD CONSTRAINT pais_pk PRIMARY KEY (id_pais);


--
-- TOC entry 2007 (class 2606 OID 37490)
-- Dependencies: 177 177
-- Name: pais_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY paises
    ADD CONSTRAINT pais_uk UNIQUE (pais);


--
-- TOC entry 2011 (class 2606 OID 37492)
-- Dependencies: 179 179
-- Name: perfil; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY perfiles
    ADD CONSTRAINT perfil UNIQUE (perfil);


--
-- TOC entry 2015 (class 2606 OID 37494)
-- Dependencies: 181 181
-- Name: personas_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY personas
    ADD CONSTRAINT personas_pk PRIMARY KEY (id_persona);


--
-- TOC entry 2017 (class 2606 OID 37496)
-- Dependencies: 183 183
-- Name: proceso_abrev_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY procesos
    ADD CONSTRAINT proceso_abrev_uk UNIQUE (proceso_abrev);


--
-- TOC entry 2019 (class 2606 OID 37498)
-- Dependencies: 183 183
-- Name: proceso_consecutivo_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY procesos
    ADD CONSTRAINT proceso_consecutivo_uk UNIQUE (nro_consecutivo_proceso);


--
-- TOC entry 2021 (class 2606 OID 37500)
-- Dependencies: 183 183
-- Name: proceso_desc_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY procesos
    ADD CONSTRAINT proceso_desc_uk UNIQUE (proceso_abrev);


--
-- TOC entry 2023 (class 2606 OID 37502)
-- Dependencies: 183 183
-- Name: proceso_id_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY procesos
    ADD CONSTRAINT proceso_id_pk PRIMARY KEY (id_proceso);


--
-- TOC entry 2027 (class 2606 OID 37504)
-- Dependencies: 185 185
-- Name: usuario_encrypt_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY usuarios
    ADD CONSTRAINT usuario_encrypt_uk UNIQUE (usuario_encrypt);


--
-- TOC entry 2029 (class 2606 OID 37506)
-- Dependencies: 185 185
-- Name: usuario_persona_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY usuarios
    ADD CONSTRAINT usuario_persona_uk UNIQUE (id_persona);


--
-- TOC entry 2031 (class 2606 OID 37508)
-- Dependencies: 185 185
-- Name: usuario_uk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY usuarios
    ADD CONSTRAINT usuario_uk UNIQUE (usuario);


--
-- TOC entry 2043 (class 2606 OID 37509)
-- Dependencies: 181 169 2012
-- Name: cedula_de_identidad_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY interesados
    ADD CONSTRAINT cedula_de_identidad_fk FOREIGN KEY (cedula_de_identidad) REFERENCES personas(cedula_de_identidad);


--
-- TOC entry 2032 (class 2606 OID 37514)
-- Dependencies: 1988 161 167
-- Name: consulta_expediente_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY consultas
    ADD CONSTRAINT consulta_expediente_fk FOREIGN KEY (id_expediente) REFERENCES expedientes(id_expediente);


--
-- TOC entry 2033 (class 2606 OID 37519)
-- Dependencies: 163 185 2024
-- Name: control_abog_asignado_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY control_movimientos
    ADD CONSTRAINT control_abog_asignado_fk FOREIGN KEY (id_abogado_asign) REFERENCES usuarios(id_usuario);


--
-- TOC entry 2034 (class 2606 OID 37524)
-- Dependencies: 2024 185 163
-- Name: control_abog_coordinador_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY control_movimientos
    ADD CONSTRAINT control_abog_coordinador_fk FOREIGN KEY (id_abogado_coord) REFERENCES usuarios(id_usuario);


--
-- TOC entry 2035 (class 2606 OID 37529)
-- Dependencies: 163 165 1986
-- Name: control_etapa_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY control_movimientos
    ADD CONSTRAINT control_etapa_fk FOREIGN KEY (id_etapa) REFERENCES etapas(id_etapa);


--
-- TOC entry 2036 (class 2606 OID 37534)
-- Dependencies: 167 1988 163
-- Name: control_expediente_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY control_movimientos
    ADD CONSTRAINT control_expediente_fk FOREIGN KEY (id_expidiente) REFERENCES expedientes(id_expediente);


--
-- TOC entry 2037 (class 2606 OID 37539)
-- Dependencies: 163 2022 183
-- Name: control_proceso_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY control_movimientos
    ADD CONSTRAINT control_proceso_fk FOREIGN KEY (id_proceso) REFERENCES procesos(id_proceso);


--
-- TOC entry 2038 (class 2606 OID 37549)
-- Dependencies: 2022 183 165
-- Name: etapa_de_proceso_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY etapas
    ADD CONSTRAINT etapa_de_proceso_fk FOREIGN KEY (id_proceso) REFERENCES procesos(id_proceso);


--
-- TOC entry 2039 (class 2606 OID 37554)
-- Dependencies: 165 1986 167
-- Name: id_etapa_actual_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY expedientes
    ADD CONSTRAINT id_etapa_actual_fk FOREIGN KEY (id_etapa_actual) REFERENCES etapas(id_etapa);


--
-- TOC entry 2044 (class 2606 OID 37559)
-- Dependencies: 1988 167 169
-- Name: id_expediente_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY interesados
    ADD CONSTRAINT id_expediente_fk FOREIGN KEY (id_expediente) REFERENCES expedientes(id_expediente);


--
-- TOC entry 2040 (class 2606 OID 37564)
-- Dependencies: 167 175 1998
-- Name: id_organismo_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY expedientes
    ADD CONSTRAINT id_organismo_fk FOREIGN KEY (id_organismo) REFERENCES organismos(id_organismo);


--
-- TOC entry 2041 (class 2606 OID 37569)
-- Dependencies: 167 183 2022
-- Name: id_proceso_actual_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY expedientes
    ADD CONSTRAINT id_proceso_actual_fk FOREIGN KEY (id_proceso_actual) REFERENCES procesos(id_proceso);


--
-- TOC entry 2042 (class 2606 OID 37574)
-- Dependencies: 167 2024 185
-- Name: id_usuario_reg_inicial_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY expedientes
    ADD CONSTRAINT id_usuario_reg_inicial_fk FOREIGN KEY (id_usuario_ini) REFERENCES usuarios(id_usuario);


--
-- TOC entry 2045 (class 2606 OID 37579)
-- Dependencies: 2024 185 171
-- Name: log_usuario_reg_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY logs_usuarios
    ADD CONSTRAINT log_usuario_reg_fk FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario);


--
-- TOC entry 2046 (class 2606 OID 37584)
-- Dependencies: 1986 173 165
-- Name: observ_etapa_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY observaciones
    ADD CONSTRAINT observ_etapa_fk FOREIGN KEY (id_etapa) REFERENCES etapas(id_etapa);


--
-- TOC entry 2047 (class 2606 OID 37589)
-- Dependencies: 173 1988 167
-- Name: observ_expediente_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY observaciones
    ADD CONSTRAINT observ_expediente_fk FOREIGN KEY (id_expidiente) REFERENCES expedientes(id_expediente);


--
-- TOC entry 2048 (class 2606 OID 37594)
-- Dependencies: 183 173 2022
-- Name: observ_proceso_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY observaciones
    ADD CONSTRAINT observ_proceso_fk FOREIGN KEY (id_proceso) REFERENCES procesos(id_proceso);


--
-- TOC entry 2049 (class 2606 OID 37604)
-- Dependencies: 2004 177 181
-- Name: persona_pais_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY personas
    ADD CONSTRAINT persona_pais_fk FOREIGN KEY (id_pais) REFERENCES paises(id_pais);


--
-- TOC entry 2050 (class 2606 OID 37873)
-- Dependencies: 185 2008 179
-- Name: usuario_perfil_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuarios
    ADD CONSTRAINT usuario_perfil_fk FOREIGN KEY (id_perfil) REFERENCES perfiles(id_perfil);


--
-- TOC entry 2051 (class 2606 OID 37878)
-- Dependencies: 185 2014 181
-- Name: usuario_persona_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuarios
    ADD CONSTRAINT usuario_persona_fk FOREIGN KEY (id_persona) REFERENCES personas(id_persona);


--
-- TOC entry 2069 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2012-07-06 15:11:42

--
-- PostgreSQL database dump complete
--

