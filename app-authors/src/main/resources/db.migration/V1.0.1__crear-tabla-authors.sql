--
-- PostgreSQL database dump
--


CREATE TABLE public.authors (
                                version integer NOT NULL,
                                id bigint NOT NULL,
                                name character varying(255)
);


ALTER TABLE public.authors OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 58448)
-- Name: authors_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.authors_seq
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.authors_seq OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 58449)
-- Name: books; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.books (
                              price numeric NOT NULL,
                              version integer NOT NULL,
                              isbn character varying(255) NOT NULL,
                              title character varying(255)
);


ALTER TABLE public.books OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 58454)
-- Name: books_authors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.books_authors (
                                      authors_id bigint NOT NULL,
                                      books_isbn character varying(255) NOT NULL
);


ALTER TABLE public.books_authors OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 58457)
-- Name: customers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customers (
                                  version integer NOT NULL,
                                  id bigint NOT NULL,
                                  email character varying(255),
                                  name character varying(255)
);


ALTER TABLE public.customers OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 58462)
-- Name: customers_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.customers_seq
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.customers_seq OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 58463)
-- Name: inventory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inventory (
                                  sold integer NOT NULL,
                                  supplied integer NOT NULL,
                                  version integer NOT NULL,
                                  book_isbn character varying(255) NOT NULL
);


ALTER TABLE public.inventory OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 58466)
-- Name: line_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.line_items (
                                   idx integer NOT NULL,
                                   quantity integer NOT NULL,
                                   order_id bigint NOT NULL,
                                   book_isbn character varying(255) NOT NULL
);


ALTER TABLE public.line_items OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 58469)
-- Name: purchase_orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.purchase_orders (
                                        status smallint,
                                        total integer NOT NULL,
                                        customer_id bigint NOT NULL,
                                        delivered_on timestamp(6) without time zone,
                                        id bigint NOT NULL,
                                        placed_on timestamp(6) without time zone,
                                        CONSTRAINT purchase_orders_status_check CHECK (((status >= 0) AND (status <= 1)))
);


ALTER TABLE public.purchase_orders OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 58473)
-- Name: purchase_orders_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.purchase_orders_seq
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.purchase_orders_seq OWNER TO postgres;

--
-- TOC entry 3360 (class 0 OID 58445)
-- Dependencies: 214
-- Data for Name: authors; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.authors VALUES (1, 2, 'Herbert Schildt');
INSERT INTO public.authors VALUES (1, 3, 'Kathy Sierra');
INSERT INTO public.authors VALUES (1, 4, 'Brian Goetz');
INSERT INTO public.authors VALUES (1, 5, 'Robert C. Martin');
INSERT INTO public.authors VALUES (3, 1, 'Joshua Bloch');


--
-- TOC entry 3362 (class 0 OID 58449)
-- Dependencies: 216
-- Data for Name: books; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.books VALUES (45, 1, '978-0134686097', 'Effective Java');
INSERT INTO public.books VALUES (50, 1, '978-1260440232', 'Java: The Complete Reference');
INSERT INTO public.books VALUES (40, 1, '978-0596009205', 'Head First Java');
INSERT INTO public.books VALUES (55, 1, '978-0321349606', 'Java Concurrency in Practice');
INSERT INTO public.books VALUES (50, 1, '978-0136083238', 'Clean Code: A Handbook of Agile Software Craftsmanship');


--
-- TOC entry 3363 (class 0 OID 58454)
-- Dependencies: 217
-- Data for Name: books_authors; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.books_authors VALUES (1, '978-0134686097');
INSERT INTO public.books_authors VALUES (2, '978-1260440232');
INSERT INTO public.books_authors VALUES (3, '978-0596009205');
INSERT INTO public.books_authors VALUES (4, '978-0321349606');
INSERT INTO public.books_authors VALUES (5, '978-0136083238');
INSERT INTO public.books_authors VALUES (5, '978-0134686097');
INSERT INTO public.books_authors VALUES (1, '978-1260440232');
INSERT INTO public.books_authors VALUES (2, '978-0596009205');
INSERT INTO public.books_authors VALUES (3, '978-0321349606');
INSERT INTO public.books_authors VALUES (4, '978-0136083238');
INSERT INTO public.books_authors VALUES (1, '978-0136083238');
INSERT INTO public.books_authors VALUES (2, '978-0136083238');


--
-- TOC entry 3364 (class 0 OID 58457)
-- Dependencies: 218
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3366 (class 0 OID 58463)
-- Dependencies: 220
-- Data for Name: inventory; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3367 (class 0 OID 58466)
-- Dependencies: 221
-- Data for Name: line_items; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3368 (class 0 OID 58469)
-- Dependencies: 222
-- Data for Name: purchase_orders; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3376 (class 0 OID 0)
-- Dependencies: 215
-- Name: authors_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.authors_seq', 1, false);


--
-- TOC entry 3377 (class 0 OID 0)
-- Dependencies: 219
-- Name: customers_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.customers_seq', 1, false);


--
-- TOC entry 3378 (class 0 OID 0)
-- Dependencies: 223
-- Name: purchase_orders_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.purchase_orders_seq', 1, false);


--
-- TOC entry 3201 (class 2606 OID 58475)
-- Name: authors authors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authors
    ADD CONSTRAINT authors_pkey PRIMARY KEY (id);


--
-- TOC entry 3203 (class 2606 OID 58477)
-- Name: books books_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_pkey PRIMARY KEY (isbn);


--
-- TOC entry 3205 (class 2606 OID 58479)
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- TOC entry 3207 (class 2606 OID 58481)
-- Name: inventory inventory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory
    ADD CONSTRAINT inventory_pkey PRIMARY KEY (book_isbn);


--
-- TOC entry 3209 (class 2606 OID 58483)
-- Name: line_items line_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.line_items
    ADD CONSTRAINT line_items_pkey PRIMARY KEY (idx, order_id);


--
-- TOC entry 3211 (class 2606 OID 58485)
-- Name: purchase_orders purchase_orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_orders
    ADD CONSTRAINT purchase_orders_pkey PRIMARY KEY (id);


--
-- TOC entry 3212 (class 2606 OID 58486)
-- Name: books_authors fk20menrngp9wi9at1dsu5cbb8o; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books_authors
    ADD CONSTRAINT fk20menrngp9wi9at1dsu5cbb8o FOREIGN KEY (authors_id) REFERENCES public.authors(id);


--
-- TOC entry 3215 (class 2606 OID 58491)
-- Name: line_items fk5faywgsy47v4g95fhhgkvdgxv; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.line_items
    ADD CONSTRAINT fk5faywgsy47v4g95fhhgkvdgxv FOREIGN KEY (book_isbn) REFERENCES public.books(isbn);


--
-- TOC entry 3213 (class 2606 OID 58496)
-- Name: books_authors fk638vl9wfdvpll0nigsx8hvkf8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books_authors
    ADD CONSTRAINT fk638vl9wfdvpll0nigsx8hvkf8 FOREIGN KEY (books_isbn) REFERENCES public.books(isbn);


--
-- TOC entry 3214 (class 2606 OID 58501)
-- Name: inventory fkdmhkf2qcda7uw8lu688jugu2s; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory
    ADD CONSTRAINT fkdmhkf2qcda7uw8lu688jugu2s FOREIGN KEY (book_isbn) REFERENCES public.books(isbn);


--
-- TOC entry 3217 (class 2606 OID 58506)
-- Name: purchase_orders fkfbqmektiojpqhypnpog4uqk41; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_orders
    ADD CONSTRAINT fkfbqmektiojpqhypnpog4uqk41 FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- TOC entry 3216 (class 2606 OID 58511)
-- Name: line_items fkqxuqc9unf2dsoohy6tef6675b; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.line_items
    ADD CONSTRAINT fkqxuqc9unf2dsoohy6tef6675b FOREIGN KEY (order_id) REFERENCES public.purchase_orders(id);


-- Completed on 2026-01-15 18:49:04

--
-- PostgreSQL database dump complete
--