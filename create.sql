SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;
CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
SET default_tablespace = '';
SET default_with_oids = false;


CREATE TABLE public.building (
    id bigint NOT NULL,
    src_packet_id bigint NOT NULL,
    object_id character varying(40) NOT NULL,
    object_type character varying(30) DEFAULT 'building'::character varying NOT NULL,
    object_time timestamp with time zone NOT NULL,
    parent_object_id character varying(40) NOT NULL,
    parent_type character varying(30) NOT NULL,
    insert_time timestamp with time zone DEFAULT now() NOT NULL,
    name character varying(2000) NOT NULL,
    code character varying(10) NOT NULL,
    num character varying(10) NOT NULL,
    contract_object_id character varying(40) NOT NULL,
    gip character varying(100)
);
COMMENT ON TABLE public.building IS 'Здание/Сооружение';
COMMENT ON COLUMN public.building.parent_object_id IS 'Идентификатор объекта в который входит здание/сооружение';
COMMENT ON COLUMN public.building.parent_type IS 'Тип объекта в который входит здание/сооружение';
COMMENT ON COLUMN public.building.name IS 'Наименование здания/соооружения';
COMMENT ON COLUMN public.building.code IS 'Код здания, сооружения (8-й атрибут обозначения)';
COMMENT ON COLUMN public.building.num IS 'Порядковый номер (9-й атрибут обозначения)';
COMMENT ON COLUMN public.building.contract_object_id IS 'Договор (GUID)';
COMMENT ON COLUMN public.building.gip IS 'ГИП';
CREATE SEQUENCE public.building_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.building_id_seq OWNED BY public.building.id;


CREATE TABLE public.constrpart (
    id bigint NOT NULL,
    src_packet_id bigint NOT NULL,
    object_id character varying(40) NOT NULL,
    object_type character varying(30) DEFAULT 'constrpart'::character varying NOT NULL,
    object_time timestamp with time zone NOT NULL,
    parent_object_id character varying(40) NOT NULL,
    parent_type character varying(30) NOT NULL,
    insert_time timestamp with time zone DEFAULT now() NOT NULL,
    name character varying(2000) NOT NULL,
    code character varying(10) NOT NULL,
    num character varying(10) NOT NULL,
    gip character varying(100)
);
COMMENT ON TABLE public.constrpart IS 'Часть комплекса';
COMMENT ON COLUMN public.constrpart.parent_object_id IS 'Идентификатор объекта в который входит часть комплекса';
COMMENT ON COLUMN public.constrpart.parent_type IS 'Тип объекта в который входит часть комплекса';
COMMENT ON COLUMN public.constrpart.name IS 'Наименование части комплекса';
COMMENT ON COLUMN public.constrpart.code IS 'Код вида части комплекса (6-й атрибут обозначения)';
COMMENT ON COLUMN public.constrpart.num IS 'Порядковый номер части комплекса (7-й атрибут обозначения)';
COMMENT ON COLUMN public.constrpart.gip IS 'ГИП';
CREATE SEQUENCE public.constrpart_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.constrpart_id_seq OWNED BY public.constrpart.id;


CREATE TABLE public.construction (
    id bigint NOT NULL,
    src_packet_id bigint NOT NULL,
    object_id character varying(40) NOT NULL,
    object_type character varying(30) DEFAULT 'construction'::character varying NOT NULL,
    object_time timestamp with time zone NOT NULL,
    insert_time timestamp with time zone DEFAULT now() NOT NULL,
    oip_ks character varying(10) NOT NULL,
    name character varying(2000) NOT NULL,
    gip character varying(100) NOT NULL
);
COMMENT ON TABLE public.construction IS 'Комплекс';
COMMENT ON COLUMN public.construction.oip_ks IS 'Шифр объекта (1-й атрибут обозначения)';
COMMENT ON COLUMN public.construction.name IS 'Наименование комплекса';
COMMENT ON COLUMN public.construction.gip IS 'ГИП';
CREATE SEQUENCE public.construction_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.construction_id_seq OWNED BY public.construction.id;


CREATE TABLE public.contract (
    id bigint NOT NULL,
    src_packet_id bigint NOT NULL,
    object_id character varying(40) NOT NULL,
    object_type character varying(30) DEFAULT 'contract'::character varying NOT NULL,
    object_time timestamp with time zone NOT NULL,
    insert_time timestamp with time zone DEFAULT now() NOT NULL,
    cdate date,
    name character varying(2000),
    year character varying(10),
    dev character varying(10),
    inner_number character varying(100),
    oip_ks character varying(10) NOT NULL,
    ccode character varying(10),
    num character varying(10) NOT NULL,
    gip character varying(100)
);
COMMENT ON TABLE public.contract IS 'Договор';
COMMENT ON COLUMN public.contract.cdate IS 'Дата договора';
COMMENT ON COLUMN public.contract.name IS 'Наименование договора';
COMMENT ON COLUMN public.contract.year IS 'Год составления договора';
COMMENT ON COLUMN public.contract.dev IS 'Код ответственного филиала';
COMMENT ON COLUMN public.contract.inner_number IS 'Внутренний номер договора одной строкой';
COMMENT ON COLUMN public.contract.oip_ks IS 'Шифр объекта (1-й атрибут обозначения)';
COMMENT ON COLUMN public.contract.ccode IS 'Код заказчика (2-й атрибут обозначения)';
COMMENT ON COLUMN public.contract.num IS 'Номер договора (3-й атрибут обозначения)';
COMMENT ON COLUMN public.contract.gip IS 'ГИП';
CREATE SEQUENCE public.contract_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.contract_id_seq OWNED BY public.contract.id;


CREATE TABLE public.docset (
    id bigint NOT NULL,
    src_packet_id bigint NOT NULL,
    object_id character varying(40) NOT NULL,
    object_type character varying(30) DEFAULT 'docset'::character varying NOT NULL,
    object_time timestamp with time zone NOT NULL,
    parent_object_id character varying(40) NOT NULL,
    parent_type character varying(30) NOT NULL,
    insert_time timestamp with time zone DEFAULT now() NOT NULL,
    name character varying(2000) NOT NULL,
    cipher character varying(100) NOT NULL,
    dev_dep character varying(30) NOT NULL,
    oip_ks character varying(30) NOT NULL,
    ccode character varying(10) NOT NULL,
    num character varying(10) NOT NULL,
    pstage character varying(10) NOT NULL,
    dev_org character varying(10) NOT NULL,
    cpcode character varying(10) NOT NULL,
    cpnum character varying(30) NOT NULL,
    bcode character varying(10) NOT NULL,
    bnum character varying(30) NOT NULL,
    mark character varying(10) NOT NULL,
    mark_path character varying(30),
    cipher_doc character varying(20),
    bstage character varying(1000),
    cstage character varying(1000),
    izm_num integer NOT NULL,
    gip character varying(100),
    status character varying(100) NOT NULL,
    is_actual boolean
);
COMMENT ON TABLE public.docset IS 'Составной документ';
COMMENT ON COLUMN public.docset.parent_object_id IS 'Идентификатор объекта которому принадлежит документ';
COMMENT ON COLUMN public.docset.parent_type IS 'Тип объекта которому принадлежит документ';
COMMENT ON COLUMN public.docset.name IS 'Наименование с титульного листа';
COMMENT ON COLUMN public.docset.cipher IS 'Шифр комплекта в соответствии с Регламентом Р-08{LLE{0}}';
COMMENT ON COLUMN public.docset.dev_dep IS 'Код подразделения-исполнителя внутри филиала';
COMMENT ON COLUMN public.docset.oip_ks IS 'Шифр объекта (1-й атрибут обозначения)';
COMMENT ON COLUMN public.docset.ccode IS 'Код заказчика (2-й атрибут обозначения)';
COMMENT ON COLUMN public.docset.num IS 'Номер договора (3-й атрибут обозначения)';
COMMENT ON COLUMN public.docset.pstage IS 'Стадия проектирования (4-й атрибут обозначения)';
COMMENT ON COLUMN public.docset.dev_org IS 'Субъект разработки (5-й атрибут обозначения)';
COMMENT ON COLUMN public.docset.cpcode IS 'Код части комплекса стройки (6-й атрибут обозначения)';
COMMENT ON COLUMN public.docset.cpnum IS 'Порядковый № части комплекса стройки (7-й атрибут обозначения)';
COMMENT ON COLUMN public.docset.bcode IS 'Код здания, сооружения (8-й атрибут обозначения)';
COMMENT ON COLUMN public.docset.bnum IS 'Порядковый номер позиции по генплану (9-й атрибут обозначения)';
COMMENT ON COLUMN public.docset.mark IS 'Марка основного комплекта (10-й атрибут обозначения){LLE}0}}';
COMMENT ON COLUMN public.docset.mark_path IS '№ части марки (11-й атрибут обозначения){LLE}0}}';
COMMENT ON COLUMN public.docset.cipher_doc IS 'Шифр документа (12-й атрибут обозначения){LLE}0}}';
COMMENT ON COLUMN public.docset.bstage IS 'Этап строительства по договору';
COMMENT ON COLUMN public.docset.cstage IS '№ этапа по генподрядному договору';
COMMENT ON COLUMN public.docset.izm_num IS 'Номер изменения';
COMMENT ON COLUMN public.docset.gip IS 'ГИП';
COMMENT ON COLUMN public.docset.status IS 'Статус документа в исторической системе';
CREATE SEQUENCE public.docset_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.docset_id_seq OWNED BY public.docset.id;


CREATE TABLE public.document (
    id bigint NOT NULL,
    src_packet_id bigint NOT NULL,
    object_id character varying(40) NOT NULL,
    object_type character varying(30) DEFAULT 'document'::character varying NOT NULL,
    object_time timestamp with time zone NOT NULL,
    parent_object_id character varying(40) NOT NULL,
    parent_type character varying(30) NOT NULL,
    insert_time timestamp with time zone DEFAULT now() NOT NULL,
    cipher character varying(100) NOT NULL,
    cipher_doc character varying(20),
    name character varying(2000) NOT NULL,
    dev_dep character varying(30) NOT NULL,
    izm_num integer NOT NULL,
    status character varying(100) NOT NULL,
    is_actual boolean
);
COMMENT ON TABLE public.document IS 'Документ в составе составного документа';
COMMENT ON COLUMN public.document.parent_object_id IS 'Идентификатор объекта которому принадлежит документ';
COMMENT ON COLUMN public.document.parent_type IS 'Тип объекта которому принадлежит документ';
COMMENT ON COLUMN public.document.cipher IS 'Обозначение документа в соответствии с Регламентом Р-08';
COMMENT ON COLUMN public.document.cipher_doc IS 'Шифр документа (12-й атрибут обозначения)';
COMMENT ON COLUMN public.document.name IS 'Наименование с титульного листа';
COMMENT ON COLUMN public.document.dev_dep IS 'Код подразделения-исполнителя внутри филиала';
COMMENT ON COLUMN public.document.izm_num IS 'Номер изменения';
COMMENT ON COLUMN public.document.status IS 'Статус документа в исторической системе';
COMMENT ON COLUMN public.document.is_actual IS 'Признак актуальности документа';
CREATE SEQUENCE public.document_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.document_id_seq OWNED BY public.document.id;


CREATE TABLE public.file (
    id bigint NOT NULL,
    src_packet_id bigint NOT NULL,
    owner_id bigint NOT NULL,
    object_type character varying(30) DEFAULT 'file'::character varying NOT NULL,
    parent_object_id character varying(40) NOT NULL,
    parent_type character varying(30) NOT NULL,
    insert_time timestamp with time zone DEFAULT now() NOT NULL,
    file_name character varying(2000) NOT NULL,
    file_size bigint,
    file_modify_time timestamp with time zone NOT NULL,
    file_type_id bigint
);
COMMENT ON TABLE public.file IS 'Файл документа';
COMMENT ON COLUMN public.file.parent_object_id IS 'Идентификатор объекта которому принадлежит файл';
COMMENT ON COLUMN public.file.parent_type IS 'Тип объекта которому принадлежит файл';
COMMENT ON COLUMN public.file.file_name IS 'Имя файла без пути';
COMMENT ON COLUMN public.file.file_size IS 'Размер файла в байтах';
COMMENT ON COLUMN public.file.file_modify_time IS 'Дата/время последней модификации файла';
COMMENT ON COLUMN public.file.file_type_id IS 'Тип файла: 0-UNKNOWN, 1-Скан с подписями, 2-Файл в редартируемом формате, (>=3)-Зарезервировано';
CREATE SEQUENCE public.file_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.file_id_seq OWNED BY public.file.id;


CREATE TABLE public.invoice (
    id bigint NOT NULL,
    src_packet_id bigint NOT NULL,
    object_id character varying(40) NOT NULL,
    object_type character varying(30) DEFAULT 'invoice'::character varying NOT NULL,
    object_time timestamp with time zone NOT NULL,
    insert_time timestamp with time zone DEFAULT now() NOT NULL,
    invoice_num character varying(100) NOT NULL,
    invoice_date date NOT NULL,
    recipient character varying(2000) NOT NULL,
    status character varying(100) NOT NULL
);
COMMENT ON TABLE public.invoice IS 'Накладная';
COMMENT ON COLUMN public.invoice.invoice_num IS 'Номер накладной';
COMMENT ON COLUMN public.invoice.invoice_date IS 'Дата накладной';
COMMENT ON COLUMN public.invoice.recipient IS 'Получатель';
COMMENT ON COLUMN public.invoice.status IS 'Статус накладной в исторической системе';
CREATE SEQUENCE public.invoice_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.invoice_id_seq OWNED BY public.invoice.id;


CREATE TABLE public.obj_ref (
    id bigint NOT NULL,
    src_packet_id bigint NOT NULL,
    owner_id bigint NOT NULL,
    parent_object_id character varying(40) NOT NULL,
    parent_type character varying(30) NOT NULL,
    insert_time timestamp with time zone DEFAULT now() NOT NULL,
    ref_object_id character varying(40) NOT NULL
);
COMMENT ON TABLE public.obj_ref IS 'Ссылка на документ из другого документа';
COMMENT ON COLUMN public.obj_ref.owner_id IS 'Идентификатор документа которому принадлежит ссылка (аналог parent_object_id)';
COMMENT ON COLUMN public.obj_ref.parent_object_id IS 'Идентификатор объекта в составе которого находится ссылка';
COMMENT ON COLUMN public.obj_ref.parent_type IS 'Тип объекта в составе которого находится ссылка';
COMMENT ON COLUMN public.obj_ref.ref_object_id IS 'Иденификатор ссылочного объекта';
CREATE SEQUENCE public.obj_ref_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.obj_ref_id_seq OWNED BY public.obj_ref.id;


CREATE TABLE public.packet (
    id bigint NOT NULL,
    file_name character varying(255) NOT NULL,
    file_sha256 character varying(44) NOT NULL,
    file_content xml,
    file_modification_time timestamp with time zone NOT NULL,
    file_size bigint NOT NULL,
    status_id bigint DEFAULT 0 NOT NULL,
    status_time timestamp with time zone DEFAULT now() NOT NULL
);
COMMENT ON TABLE public.packet IS 'Пакет';
CREATE SEQUENCE public.packet_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.packet_id_seq OWNED BY public.packet.id;


CREATE TABLE public.packet_log (
    id bigint NOT NULL,
    packet_id bigint NOT NULL,
    status_id bigint NOT NULL,
    msg_time timestamp with time zone NOT NULL,
    msg_type_id bigint NOT NULL,
    msg_text character varying(2048)
);
COMMENT ON TABLE public.packet_log IS 'Журнал изменения статусов пакета';
CREATE SEQUENCE public.packet_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.packet_log_id_seq OWNED BY public.packet_log.id;
ALTER TABLE ONLY public.building ALTER COLUMN id SET DEFAULT nextval('public.building_id_seq'::regclass);
ALTER TABLE ONLY public.constrpart ALTER COLUMN id SET DEFAULT nextval('public.constrpart_id_seq'::regclass);
ALTER TABLE ONLY public.construction ALTER COLUMN id SET DEFAULT nextval('public.construction_id_seq'::regclass);
ALTER TABLE ONLY public.contract ALTER COLUMN id SET DEFAULT nextval('public.contract_id_seq'::regclass);
ALTER TABLE ONLY public.docset ALTER COLUMN id SET DEFAULT nextval('public.docset_id_seq'::regclass);
ALTER TABLE ONLY public.document ALTER COLUMN id SET DEFAULT nextval('public.document_id_seq'::regclass);
ALTER TABLE ONLY public.file ALTER COLUMN id SET DEFAULT nextval('public.file_id_seq'::regclass);
ALTER TABLE ONLY public.invoice ALTER COLUMN id SET DEFAULT nextval('public.invoice_id_seq'::regclass);
ALTER TABLE ONLY public.obj_ref ALTER COLUMN id SET DEFAULT nextval('public.obj_ref_id_seq'::regclass);
ALTER TABLE ONLY public.packet ALTER COLUMN id SET DEFAULT nextval('public.packet_id_seq'::regclass);
ALTER TABLE ONLY public.packet_log ALTER COLUMN id SET DEFAULT nextval('public.packet_log_id_seq'::regclass);
ALTER TABLE ONLY public.building
    ADD CONSTRAINT building_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.constrpart
    ADD CONSTRAINT constrpart_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.construction
    ADD CONSTRAINT construction_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.contract
    ADD CONSTRAINT contract_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.docset
    ADD CONSTRAINT docset_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.document
    ADD CONSTRAINT document_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.file
    ADD CONSTRAINT file_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.invoice
    ADD CONSTRAINT invoice_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.obj_ref
    ADD CONSTRAINT obj_ref_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.packet_log
    ADD CONSTRAINT packet_log_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.packet
    ADD CONSTRAINT packet_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.packet_log
    ADD CONSTRAINT packet_log_packet_id FOREIGN KEY (packet_id) REFERENCES public.packet(id);

