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
	CONSTRAINT nametypes_check CHECK (((VALUE)::text = ANY (ARRAY[('first_m'::character varying)::text, ('first_f'::character varying)::text, ('last'::character varying)::text])));


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
	CONSTRAINT wordtypes_check CHECK (((VALUE)::text = ANY ((ARRAY['adjective'::character varying, 'adverb'::character varying, 'verb'::character varying])::text[])));


ALTER DOMAIN public.wordtypes OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: locations; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE locations (
    id numeric(9,0) NOT NULL,
    city character varying(500) NOT NULL,
    state character varying(500),
    country character varying(500) NOT NULL
);


ALTER TABLE public.locations OWNER TO postgres;

--
-- Name: names; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE names (
    name character varying(200) NOT NULL,
    name_type nametypes NOT NULL,
    region character varying(250) NOT NULL
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
    symbols character varying(500),
    topic character varying(300) NOT NULL
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
    word character varying(100) NOT NULL,
    sentiment numeric(8,6) NOT NULL,
    type wordtypes NOT NULL
);


ALTER TABLE public.words OWNER TO postgres;

--
-- Data for Name: locations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY locations (id, city, state, country) FROM stdin;
1	name	subcountry	country
2	les Escaldes	Escaldes-Engordany	Andorra
3	Andorra la Vella	Andorra la Vella	Andorra
4	Umm al Qaywayn	Umm al Qaywayn	United Arab Emirates
918	Boussu	Wallonia	Belgium
919	Bornem	Flanders	Belgium
920	Boom	Flanders	Belgium
921	Blankenberge	Flanders	Belgium
922	Binche	Wallonia	Belgium
923	Bilzen	Flanders	Belgium
924	Beveren	Flanders	Belgium
925	Beringen	Flanders	Belgium
926	Beersel	Flanders	Belgium
927	Beerse	Flanders	Belgium
928	Balen	Flanders	Belgium
929	Ath	Wallonia	Belgium
930	Asse	Flanders	Belgium
931	Arlon	Wallonia	Belgium
932	Antwerpen	Flanders	Belgium
933	Ans	Wallonia	Belgium
934	Andenne	Wallonia	Belgium
935	Aarschot	Flanders	Belgium
936	Aalter	Flanders	Belgium
937	Aalst	Flanders	Belgium
938	Zorgo	Plateau-Central	Burkina Faso
939	Yako	Nord	Burkina Faso
940	Tougan	Boucle du Mouhoun	Burkina Faso
941	Titao	Nord	Burkina Faso
942	Tenkodogo	Centre-Est	Burkina Faso
945	Ouahigouya	Nord	Burkina Faso
946	Ouagadougou	Centre	Burkina Faso
947	Nouna	Boucle du Mouhoun	Burkina Faso
948	Manga	Centre-Sud	Burkina Faso
951	Koudougou	Centre-Ouest	Burkina Faso
952	Kongoussi	Centre-Nord	Burkina Faso
953	Kombissiri	Centre-Sud	Burkina Faso
954	Kokologo	Centre-Ouest	Burkina Faso
955	Kaya	Centre-Nord	Burkina Faso
957	Gourcy	Nord	Burkina Faso
958	Garango	Centre-Est	Burkina Faso
1585	Salvador	Bahia	Brazil
1588	Salinas	Minas Gerais	Brazil
1589	Sacramento	Minas Gerais	Brazil
1590	Ruy Barbosa	Bahia	Brazil
1594	Rolante	Rio Grande do Sul	Brazil
1596	Rio Verde de Mato Grosso	Mato Grosso do Sul	Brazil
1597	Rio Real	Bahia	Brazil
1598	Rio Pardo	Rio Grande do Sul	Brazil
1600	Rio Negrinho	Santa Catarina	Brazil
1602	Rio Grande	Rio Grande do Sul	Brazil
1603	Rio do Sul	Santa Catarina	Brazil
1604	Rio de Janeiro	Rio de Janeiro	Brazil
1606	Rio das Ostras	Rio de Janeiro	Brazil
1608	Rio Brilhante	Mato Grosso do Sul	Brazil
1610	Rio Bonito	Rio de Janeiro	Brazil
1615	Ribeira do Pombal	Bahia	Brazil
1617	Resplendor	Minas Gerais	Brazil
1618	Resende	Rio de Janeiro	Brazil
1623	Queimados	Rio de Janeiro	Brazil
1632	Prata	Minas Gerais	Brazil
1634	Prado	Bahia	Brazil
1635	Pouso Alegre	Minas Gerais	Brazil
1638	Porto Seguro	Bahia	Brazil
1641	Porto Alegre	Rio Grande do Sul	Brazil
1644	Pontes e Lacerda	Mato Grosso	Brazil
1645	Ponte Nova	Minas Gerais	Brazil
1651	Pomerode	Santa Catarina	Brazil
1659	Pitangui	Minas Gerais	Brazil
1662	Piritiba	Bahia	Brazil
1666	Pirapora	Minas Gerais	Brazil
1675	Pinheiral	Rio de Janeiro	Brazil
1686	Penha	Santa Catarina	Brazil
1687	Penedo	Alagoas	Brazil
1689	Pelotas	Rio Grande do Sul	Brazil
1690	Pedro Leopoldo	Minas Gerais	Brazil
1692	Pedra Azul	Minas Gerais	Brazil
1696	Patos de Minas	Minas Gerais	Brazil
1698	Paty do Alferes	Rio de Janeiro	Brazil
1699	Passos	Minas Gerais	Brazil
1700	Passo Fundo	Rio Grande do Sul	Brazil
1702	Paraty	Rio de Janeiro	Brazil
1711	Paracatu	Minas Gerais	Brazil
1712	Paracambi	Rio de Janeiro	Brazil
1713	Panambi	Rio Grande do Sul	Brazil
1722	Ouro Preto	Minas Gerais	Brazil
1723	Ouro Branco	Minas Gerais	Brazil
1728	Orleans	Santa Catarina	Brazil
1730	Oliveira	Minas Gerais	Brazil
1733	Novo Hamburgo	Rio Grande do Sul	Brazil
1736	Nova Prata	Rio Grande do Sul	Brazil
1740	Nova Lima	Minas Gerais	Brazil
1743	Nova Friburgo	Rio de Janeiro	Brazil
1744	Nova Era	Minas Gerais	Brazil
1745	Nossa Senhora do Socorro	Sergipe	Brazil
1751	Nepomuceno	Minas Gerais	Brazil
1754	Navegantes	Santa Catarina	Brazil
1755	Nanuque	Minas Gerais	Brazil
1756	Muzambinho	Minas Gerais	Brazil
1757	Muritiba	Bahia	Brazil
1759	Mucuri	Bahia	Brazil
1763	Montes Claros	Minas Gerais	Brazil
1764	Monte Santo de Minas	Minas Gerais	Brazil
1765	Montenegro	Rio Grande do Sul	Brazil
1767	Monte Carmelo	Minas Gerais	Brazil
1777	Miracema	Rio de Janeiro	Brazil
1779	Miguel Pereira	Rio de Janeiro	Brazil
1781	Mendes	Rio de Janeiro	Brazil
1783	Medeiros Neto	Bahia	Brazil
1785	Matozinhos	Minas Gerais	Brazil
1786	Mateus Leme	Minas Gerais	Brazil
1789	Mascote	Bahia	Brazil
1794	Mariana	Minas Gerais	Brazil
1797	Marau	Rio Grande do Sul	Brazil
1799	Maragogipe	Bahia	Brazil
1801	Maracaju	Mato Grosso do Sul	Brazil
1802	Manhumirim	Minas Gerais	Brazil
1804	Mangaratiba	Rio de Janeiro	Brazil
1808	Mafra	Santa Catarina	Brazil
1809	Machado	Minas Gerais	Brazil
1813	Lucas	Mato Grosso	Brazil
1818	Livramento do Brumado	Bahia	Brazil
1822	Leopoldina	Minas Gerais	Brazil
1825	Lavras	Minas Gerais	Brazil
1827	Laranjeiras	Sergipe	Brazil
1830	Lajinha	Minas Gerais	Brazil
1831	Lages	Santa Catarina	Brazil
1832	Lajeado	Rio Grande do Sul	Brazil
1833	Laguna	Santa Catarina	Brazil
1834	Lagoa Vermelha	Rio Grande do Sul	Brazil
1835	Lagoa Santa	Minas Gerais	Brazil
1836	Lagoa da Prata	Minas Gerais	Brazil
1837	Lagarto	Sergipe	Brazil
1841	Juiz de Fora	Minas Gerais	Brazil
1842	Juatuba	Minas Gerais	Brazil
1844	Joinville	Santa Catarina	Brazil
1848	Jeremoabo	Bahia	Brazil
1849	Jequitinhonha	Minas Gerais	Brazil
1855	Jardim	Mato Grosso do Sul	Brazil
1858	Japeri	Rio de Janeiro	Brazil
1866	Jaguarari	Bahia	Brazil
1868	Jaguaquara	Bahia	Brazil
1869	Jacutinga	Minas Gerais	Brazil
1870	Jacobina	Bahia	Brazil
1871	Jaciara	Mato Grosso	Brazil
1875	Ivoti	Rio Grande do Sul	Brazil
1877	Iturama	Minas Gerais	Brazil
1880	Ituiutaba	Minas Gerais	Brazil
1888	Itaqui	Rio Grande do Sul	Brazil
1896	Itapetinga	Bahia	Brazil
1897	Itaperuna	Rio de Janeiro	Brazil
1900	Itapema	Santa Catarina	Brazil
1902	Itapecerica	Minas Gerais	Brazil
1903	Itaparica	Bahia	Brazil
1905	Itaocara	Rio de Janeiro	Brazil
1908	Itamarandiba	Minas Gerais	Brazil
1909	Itamaraju	Bahia	Brazil
1915	Itabuna	Bahia	Brazil
1917	Itabirito	Minas Gerais	Brazil
1918	Itabira	Minas Gerais	Brazil
1920	Itaberaba	Bahia	Brazil
1921	Itabaianinha	Sergipe	Brazil
1922	Itabaiana	Sergipe	Brazil
1930	Ipatinga	Minas Gerais	Brazil
1932	Ipaba	Minas Gerais	Brazil
1935	Indaial	Santa Catarina	Brazil
1937	Imbituba	Santa Catarina	Brazil
1943	Igrejinha	Rio Grande do Sul	Brazil
1948	Ibotirama	Bahia	Brazil
1952	Ibirataia	Bahia	Brazil
1953	Ibirama	Santa Catarina	Brazil
1961	Herval	Rio Grande do Sul	Brazil
1962	Gurupi	Tocantins	Brazil
1974	Guaramirim	Santa Catarina	Brazil
1977	Guapimirim	Rio de Janeiro	Brazil
1979	Guanambi	Bahia	Brazil
1983	Governador Valadares	Minas Gerais	Brazil
1989	Gaspar	Santa Catarina	Brazil
1990	Garibaldi	Rio Grande do Sul	Brazil
1992	Gandu	Bahia	Brazil
1993	Frutal	Minas Gerais	Brazil
1994	Frederico Westphalen	Rio Grande do Sul	Brazil
2000	Forquilhinha	Santa Catarina	Brazil
2002	Formiga	Minas Gerais	Brazil
2004	Flores da Cunha	Rio Grande do Sul	Brazil
2007	Feira de Santana	Bahia	Brazil
2008	Farroupilha	Rio Grande do Sul	Brazil
2009	Euclides da Cunha	Bahia	Brazil
2010	Estrela	Rio Grande do Sul	Brazil
2011	Esteio	Rio Grande do Sul	Brazil
2014	Esplanada	Bahia	Brazil
2015	Espinosa	Minas Gerais	Brazil
2016	Esmeraldas	Minas Gerais	Brazil
2017	Erechim	Rio Grande do Sul	Brazil
2018	Entre Rios	Bahia	Brazil
2019	Encruzilhada do Sul	Rio Grande do Sul	Brazil
2020	Encantado	Rio Grande do Sul	Brazil
2024	Duque de Caxias	Rio de Janeiro	Brazil
2025	Dourados	Mato Grosso do Sul	Brazil
2026	Dom Pedrito	Rio Grande do Sul	Brazil
2030	Diamantino	Mato Grosso	Brazil
2031	Diamantina	Minas Gerais	Brazil
2034	Curvelo	Minas Gerais	Brazil
2035	Curitibanos	Santa Catarina	Brazil
2041	Cruz das Almas	Bahia	Brazil
2042	Cruz Alta	Rio Grande do Sul	Brazil
2046	Coxim	Mato Grosso do Sul	Brazil
2049	Coruripe	Alagoas	Brazil
2052	Coronel Fabriciano	Minas Gerais	Brazil
2053	Coromandel	Minas Gerais	Brazil
2055	Corinto	Minas Gerais	Brazil
2057	Cordeiro	Rio de Janeiro	Brazil
2058	Contagem	Minas Gerais	Brazil
2059	Conselheiro Lafaiete	Minas Gerais	Brazil
2060	Congonhas	Minas Gerais	Brazil
2061	Conde	Bahia	Brazil
2072	Coaraci	Bahia	Brazil
2076	Charqueadas	Rio Grande do Sul	Brazil
2080	Celso Ramos	Santa Catarina	Brazil
2081	Caxias do Sul	Rio Grande do Sul	Brazil
2082	Caxambu	Minas Gerais	Brazil
2083	Catu	Bahia	Brazil
2086	Cataguases	Minas Gerais	Brazil
2090	Casimiro de Abreu	Rio de Janeiro	Brazil
2094	Carmo do Cajuru	Minas Gerais	Brazil
2095	Carlos Barbosa	Rio Grande do Sul	Brazil
2096	Carazinho	Rio Grande do Sul	Brazil
2097	Caratinga	Minas Gerais	Brazil
2099	Carangola	Minas Gerais	Brazil
2103	Capinzal	Santa Catarina	Brazil
2104	Capim Grosso	Bahia	Brazil
2105	Capelinha	Minas Gerais	Brazil
2106	Capela	Sergipe	Brazil
2109	Canoinhas	Santa Catarina	Brazil
2110	Canoas	Rio Grande do Sul	Brazil
2112	Canela	Rio Grande do Sul	Brazil
2115	Canavieiras	Bahia	Brazil
2116	Campo Verde	Mato Grosso do Sul	Brazil
2117	Campos Novos	Santa Catarina	Brazil
2118	Campos Gerais	Minas Gerais	Brazil
2121	Campos	Rio de Janeiro	Brazil
2124	Campo Grande	Mato Grosso do Sul	Brazil
2125	Campo Formoso	Bahia	Brazil
2126	Campo Belo	Minas Gerais	Brazil
2133	Camanducaia	Minas Gerais	Brazil
2143	Cachoeirinha	Rio Grande do Sul	Brazil
2144	Cachoeiras de Macacu	Rio de Janeiro	Brazil
2145	Cachoeira do Sul	Rio Grande do Sul	Brazil
2146	Cachoeira	Bahia	Brazil
2151	Cabo Frio	Rio de Janeiro	Brazil
2153	Buritizeiro	Minas Gerais	Brazil
2154	Buritis	Minas Gerais	Brazil
2156	Buerarema	Bahia	Brazil
2157	Brusque	Santa Catarina	Brazil
2158	Brumado	Bahia	Brazil
2159	Brumadinho	Minas Gerais	Brazil
2166	Bom Jesus do Itabapoana	Rio de Janeiro	Brazil
2167	Bom Jesus da Lapa	Bahia	Brazil
2168	Bom Despacho	Minas Gerais	Brazil
2172	Blumenau	Santa Catarina	Brazil
2176	Betim	Minas Gerais	Brazil
2179	Belo Oriente	Minas Gerais	Brazil
2180	Belo Horizonte	Minas Gerais	Brazil
2181	Belford Roxo	Rio de Janeiro	Brazil
2182	Bela Vista	Mato Grosso do Sul	Brazil
2188	Barroso	Minas Gerais	Brazil
2192	Barreiras	Bahia	Brazil
2193	Barra Velha	Santa Catarina	Brazil
2194	Barra Mansa	Rio de Janeiro	Brazil
2195	Barra dos Coqueiros	Sergipe	Brazil
2198	Barra do Bugres	Mato Grosso	Brazil
2201	Barra	Bahia	Brazil
2203	Barbacena	Minas Gerais	Brazil
2216	Arroio Grande	Rio Grande do Sul	Brazil
2217	Arroio do Meio	Rio Grande do Sul	Brazil
2218	Arraial do Cabo	Rio de Janeiro	Brazil
2220	Arcos	Minas Gerais	Brazil
2223	Araruama	Rio de Janeiro	Brazil
2228	Araguari	Minas Gerais	Brazil
2233	Araci	Bahia	Brazil
2235	Aracaju	Sergipe	Brazil
2236	Aquidauana	Mato Grosso do Sul	Brazil
2239	Aparecida do Taboado	Mato Grosso do Sul	Brazil
2243	Angra dos Reis	Rio de Janeiro	Brazil
2245	Andradas	Minas Gerais	Brazil
2251	Amargosa	Bahia	Brazil
2254	Almenara	Minas Gerais	Brazil
2255	Alfenas	Minas Gerais	Brazil
2257	Alegrete	Rio Grande do Sul	Brazil
2259	Alagoinhas	Bahia	Brazil
2268	Palmas	Tocantins	Brazil
2271	Tabatinga	Amazonas	Brazil
2272	Sena Madureira	Acre	Brazil
2274	Rio Branco	Acre	Brazil
2276	Manaus	Amazonas	Brazil
2277	Manacapuru	Amazonas	Brazil
2279	Fonte Boa	Amazonas	Brazil
2281	Cruzeiro do Sul	Acre	Brazil
2282	Coari	Amazonas	Brazil
2283	Carauari	Amazonas	Brazil
2284	Boa Vista	Roraima	Brazil
2296	Campinas	Santa Catarina	Brazil
2298	Lauro de Freitas	Bahia	Brazil
2300	Rio Preto da Eva	Amazonas	Brazil
2302	Sinop	Mato Grosso	Brazil
2304	Trindade	Santa Catarina	Brazil
2305	Freguesia do Ribeirao da Ilha	Santa Catarina	Brazil
2306	Nassau	New Providence	Bahamas
2307	Lucaya	Freeport	Bahamas
2308	Freeport	Freeport	Bahamas
2309	Thimphu	Thimphu	Bhutan
2310	Punakha	Punakha	Bhutan
2311	Phuntsholing	Chukha District	Bhutan
2312	Tsirang	Chirang	Bhutan
2313	Tonota	Central	Botswana
2314	Thamaga	Kweneng	Botswana
2315	Serowe	Central	Botswana
2316	Selebi-Phikwe	Central	Botswana
2317	Ramotswa	South East	Botswana
2318	Palapye	Central	Botswana
2319	Mosopa	Southern	Botswana
2320	Molepolole	Kweneng	Botswana
2321	Mogoditshane	Kweneng	Botswana
2322	Mochudi	Kgatleng	Botswana
2323	Maun	North West	Botswana
2324	Mahalapye	Central	Botswana
2325	Lobatse	South East	Botswana
2326	Letlhakane	Central	Botswana
2327	Kanye	Southern	Botswana
2328	Janeng	South East	Botswana
2329	Gaborone	South East	Botswana
2330	Francistown	North East	Botswana
2331	Horad Zhodzina	Minsk	Belarus
2332	Zhlobin	Gomel	Belarus
2333	Vitebsk	Vitebsk	Belarus
2334	Vilyeyka	Minsk	Belarus
2335	Vawkavysk	Grodnenskaya	Belarus
2336	Svyetlahorsk	Gomel	Belarus
2337	Stowbtsy	Minsk	Belarus
2339	Slutsk	Minsk	Belarus
2340	Slonim	Grodnenskaya	Belarus
2341	Shchuchin	Grodnenskaya	Belarus
2342	Salihorsk	Minsk	Belarus
2343	Rahachow	Gomel	Belarus
2344	Rechytsa	Gomel	Belarus
2345	Pruzhany	Brest	Belarus
2346	Polatsk	Vitebsk	Belarus
2347	Pinsk	Brest	Belarus
2348	Pastavy	Vitebsk	Belarus
2349	Asipovichy	Mogilev	Belarus
2350	Orsha	Vitebsk	Belarus
2351	Novoye Medvezhino	Minsk City	Belarus
2352	Navapolatsk	Vitebsk	Belarus
2353	Navahrudak	Grodnenskaya	Belarus
2354	Minsk	Minsk City	Belarus
2355	Mazyr	Gomel	Belarus
2356	Masty	Grodnenskaya	Belarus
2358	Maladzyechna	Minsk	Belarus
2359	Mahilyow	Mogilev	Belarus
2361	Luninyets	Brest	Belarus
2362	Lida	Grodnenskaya	Belarus
2363	Krychaw	Mogilev	Belarus
2364	Kalodzishchy	Minsk	Belarus
2365	Kobryn	Brest	Belarus
2366	Kalinkavichy	Gomel	Belarus
2367	Ivatsevichy	Brest	Belarus
2368	Hrodna	Grodnenskaya	Belarus
2369	Horki	Mogilev	Belarus
2370	Gomel	Gomel	Belarus
2371	Hlybokaye	Vitebsk	Belarus
2372	Dzyarzhynsk	Minsk	Belarus
2373	Dobrush	Gomel	Belarus
2374	Bykhaw	Mogilev	Belarus
2375	Byaroza	Brest	Belarus
2376	Brest	Brest	Belarus
2377	Horad Barysaw	Minsk	Belarus
2378	Baranovichi	Brest	Belarus
2379	Babruysk	Mogilev	Belarus
2380	Malinovka	Minsk City	Belarus
2381	San Ignacio	Cayo	Belize
2382	Orange Walk	Orange Walk	Belize
2383	Belmopan	Cayo	Belize
2384	Belize City	Belize	Belize
2385	Abbotsford	British Columbia	Canada
2386	Airdrie	Alberta	Canada
2387	Ajax	Ontario	Canada
2388	Alma	Quebec	Canada
2389	Amos	Quebec	Canada
2390	Anmore	British Columbia	Canada
2391	Baie-Comeau	Quebec	Canada
2392	Barrie	Ontario	Canada
2393	Beaconsfield	Quebec	Canada
2394	Belleville	Ontario	Canada
2395	Beloeil	Quebec	Canada
2396	Blainville	Quebec	Canada
2397	Boisbriand	Quebec	Canada
2398	Boucherville	Quebec	Canada
2399	Bradford West Gwillimbury	Ontario	Canada
2400	Brampton	Ontario	Canada
2401	Brandon	Manitoba	Canada
2402	Brant	Ontario	Canada
2403	Brantford	Ontario	Canada
2404	Brockville	Ontario	Canada
2405	Brossard	Quebec	Canada
2406	Burlington	Ontario	Canada
2407	Burnaby	British Columbia	Canada
2408	Calgary	Alberta	Canada
2409	Cambridge	Ontario	Canada
2410	Campbell River	British Columbia	Canada
2411	Camrose	Alberta	Canada
2412	Candiac	Quebec	Canada
2413	Chambly	Quebec	Canada
2414	Charlottetown	Prince Edward Island	Canada
2416	Chilliwack	British Columbia	Canada
2417	Clarence-Rockland	Ontario	Canada
2418	Cobourg	Ontario	Canada
2419	Cochrane	Alberta	Canada
2420	Collingwood	Ontario	Canada
2421	Conception Bay South	Newfoundland and Labrador	Canada
2422	Coquitlam	British Columbia	Canada
2423	Corner Brook	Newfoundland and Labrador	Canada
2424	Cornwall	Ontario	Canada
2426	Courtenay	British Columbia	Canada
2427	Cranbrook	British Columbia	Canada
2428	Dartmouth	Nova Scotia	Canada
2429	Delta	British Columbia	Canada
2430	Deux-Montagnes	Quebec	Canada
2431	Dieppe	New Brunswick	Canada
2432	Dollard-Des Ormeaux	Quebec	Canada
2433	Dorval	Quebec	Canada
2434	Drummondville	Quebec	Canada
2435	Duncan	British Columbia	Canada
2436	Edmonton	Alberta	Canada
2437	Etobicoke	Ontario	Canada
2438	Fort Erie	Ontario	Canada
2439	Fort McMurray	Alberta	Canada
2440	Fort St. John	British Columbia	Canada
2441	Fredericton	New Brunswick	Canada
2442	Gatineau	Quebec	Canada
2443	Glace Bay	Nova Scotia	Canada
2444	Granby	Quebec	Canada
2445	Grande Prairie	Alberta	Canada
2446	Greater Sudbury	Ontario	Canada
2447	Greater Napanee	Ontario	Canada
2448	Guelph	Ontario	Canada
2449	Hamilton	Ontario	Canada
2450	Huntsville	Ontario	Canada
2451	Joliette	Quebec	Canada
2452	Kamloops	British Columbia	Canada
2453	Kelowna	British Columbia	Canada
2454	Keswick	Ontario	Canada
2455	Kingston	Ontario	Canada
2456	Kirkland	Quebec	Canada
2457	Kitchener	Ontario	Canada
2458	Langford	British Columbia	Canada
2459	Langley	British Columbia	Canada
2460	Langley	British Columbia	Canada
2461	La Prairie	Quebec	Canada
2565	Vancouver	British Columbia	Canada
2566	Varennes	Quebec	Canada
2567	Vaudreuil-Dorion	Quebec	Canada
2568	Vaughan	Ontario	Canada
2569	Vernon	British Columbia	Canada
2570	Victoria	British Columbia	Canada
2571	Victoriaville	Quebec	Canada
2572	Waterloo	Ontario	Canada
2573	Welland	Ontario	Canada
2574	West End	British Columbia	Canada
2575	Westmount	Quebec	Canada
2576	Whitehorse	Yukon	Canada
2577	White Rock	British Columbia	Canada
2578	Windsor	Ontario	Canada
2579	Winnipeg	Manitoba	Canada
2580	Woodstock	Ontario	Canada
2581	Yellowknife	Northwest Territories	Canada
2582	Yorkton	Saskatchewan	Canada
2583	Halifax	Nova Scotia	Canada
2591	Edmundston	New Brunswick	Canada
2592	Thetford-Mines	Quebec	Canada
2593	Scarborough	Ontario	Canada
2594	Cole Harbour	Nova Scotia	Canada
2595	Okanagan	British Columbia	Canada
2596	West Kelowna	British Columbia	Canada
2597	Bellechasse Regional County Municipality	Quebec	Canada
2599	Saint-Augustin-de-Desmaures	Quebec	Canada
2600	Ladner	British Columbia	Canada
2601	Walnut Grove	British Columbia	Canada
2602	Ancaster	Ontario	Canada
2603	West Vancouver	British Columbia	Canada
2604	Willowdale	Ontario	Canada
2605	Lower Sacvkille	Nova Scotia	Canada
2606	West Island	N/A	Cocos Islands
2607	Yangambi	Eastern Province	Democratic Republic of the Congo
2608	Watsa	Eastern Province	Democratic Republic of the Congo
2609	Wamba	Eastern Province	Democratic Republic of the Congo
2610	Uvira	South Kivu	Democratic Republic of the Congo
2612	Sake	Nord Kivu	Democratic Republic of the Congo
2621	Kongolo	Katanga	Democratic Republic of the Congo
2622	Kisangani	Eastern Province	Democratic Republic of the Congo
2623	Kindu	Maniema	Democratic Republic of the Congo
2624	Kasongo	Maniema	Democratic Republic of the Congo
2626	Kampene	Maniema	Democratic Republic of the Congo
2627	Kamina	Katanga	Democratic Republic of the Congo
2628	Kalemie	Katanga	Democratic Republic of the Congo
2630	Kabare	South Kivu	Democratic Republic of the Congo
2631	Kabalo	Katanga	Democratic Republic of the Congo
2632	Isiro	Eastern Province	Democratic Republic of the Congo
2634	Goma	Nord Kivu	Democratic Republic of the Congo
2638	Butembo	Nord Kivu	Democratic Republic of the Congo
2639	Buta	Eastern Province	Democratic Republic of the Congo
2641	Bunia	Eastern Province	Democratic Republic of the Congo
2643	Bukavu	South Kivu	Democratic Republic of the Congo
2644	Bukama	Katanga	Democratic Republic of the Congo
2645	Bondo	Eastern Province	Democratic Republic of the Congo
2647	Beni	Nord Kivu	Democratic Republic of the Congo
2648	Basoko	Eastern Province	Democratic Republic of the Congo
2649	Aketi	Eastern Province	Democratic Republic of the Congo
2650	Lubumbashi	Katanga	Democratic Republic of the Congo
2651	Likasi	Katanga	Democratic Republic of the Congo
2652	Kolwezi	Katanga	Democratic Republic of the Congo
2653	Kipushi	Katanga	Democratic Republic of the Congo
2654	Kambove	Katanga	Democratic Republic of the Congo
2655	Tshela	Bas-Congo	Democratic Republic of the Congo
2656	Nioki	Bandundu	Democratic Republic of the Congo
2657	Mushie	Bandundu	Democratic Republic of the Congo
2658	Mbanza-Ngungu	Bas-Congo	Democratic Republic of the Congo
2660	Matadi	Bas-Congo	Democratic Republic of the Congo
2661	Mangai	Bandundu	Democratic Republic of the Congo
2663	Kinshasa	Kinshasa	Democratic Republic of the Congo
2664	Kikwit	Bandundu	Democratic Republic of the Congo
2665	Kasongo-Lunda	Bandundu	Democratic Republic of the Congo
2666	Kasangulu	Bas-Congo	Democratic Republic of the Congo
2667	Inongo	Bandundu	Democratic Republic of the Congo
2669	Bulungu	Bandundu	Democratic Republic of the Congo
2670	Bolobo	Bandundu	Democratic Republic of the Congo
2671	Bandundu	Bandundu	Democratic Republic of the Congo
2672	Masina	Kinshasa	Democratic Republic of the Congo
2673	Mobaye	Basse-Kotto	Central African Republic
2674	Ippy	Ouaka	Central African Republic
2675	Bria	Haute-Kotto	Central African Republic
2676	Bangassou	Mbomou	Central African Republic
2677	Bambari	Ouaka	Central African Republic
2683	Damara	Ombella-Mpoko	Central African Republic
2687	Bossangoa	Ouham	Central African Republic
2688	Boda	Lobaye	Central African Republic
2689	Bimbo	Ombella-Mpoko	Central African Republic
2691	Batangafo	Ouham	Central African Republic
2692	Bangui	Bangui	Central African Republic
2694	Pointe-Noire	Pointe-Noire	Republic of the Congo
2695	Owando	Cuvette	Republic of the Congo
2697	Mossendjo	Niari	Republic of the Congo
2698	Madingou	Bouenza	Republic of the Congo
2699	Dolisie	Niari	Republic of the Congo
2700	Loandjili	Pointe-Noire	Republic of the Congo
2701	Kayes	Bouenza	Republic of the Congo
2702	Impfondo	Likouala	Republic of the Congo
2703	Gamboma	Plateaux	Republic of the Congo
2704	Brazzaville	Brazzaville	Republic of the Congo
2706	Zug	Zug	Switzerland
2707	Yverdon-les-Bains	Vaud	Switzerland
2708	Winterthur	Zurich	Switzerland
2709	Wil	Saint Gallen	Switzerland
2710	Wettingen	Aargau	Switzerland
2711	Vevey	Vaud	Switzerland
2712	Vernier	Geneva	Switzerland
2713	Uster	Zurich	Switzerland
2714	Thun	Bern	Switzerland
2715	Steffisburg	Bern	Switzerland
2716	Sitten	Valais	Switzerland
2717	Sierre	Valais	Switzerland
2719	Schaffhausen	Schaffhausen	Switzerland
2720	Sankt Gallen	Saint Gallen	Switzerland
2721	Renens	Vaud	Switzerland
2722	Rapperswil	Saint Gallen	Switzerland
2723	Pully	Vaud	Switzerland
2724	Onex	Geneva	Switzerland
2725	Olten	Solothurn	Switzerland
2727	Nyon	Vaud	Switzerland
2729	Muttenz	Basel-Landschaft	Switzerland
2730	Montreux	Vaud	Switzerland
2731	Monthey	Valais	Switzerland
2732	Meyrin	Geneva	Switzerland
2733	Luzern	Lucerne	Switzerland
2734	Lugano	Ticino	Switzerland
2735	Littau	Lucerne	Switzerland
2737	Lausanne	Vaud	Switzerland
2739	Kriens	Lucerne	Switzerland
2740	Kreuzlingen	Thurgau	Switzerland
2742	Kloten	Zurich	Switzerland
2743	Jona	Saint Gallen	Switzerland
2744	Horgen	Zurich	Switzerland
2746	Herisau	Appenzell Ausserrhoden	Switzerland
2747	Grenchen	Solothurn	Switzerland
2748	Gossau	Saint Gallen	Switzerland
2750	Fribourg	Fribourg	Switzerland
2751	Frauenfeld	Thurgau	Switzerland
2752	Emmen	Lucerne	Switzerland
2754	Dietikon	Zurich	Switzerland
2755	Chur	Grisons	Switzerland
2756	Carouge	Geneva	Switzerland
2757	Biel/Bienne	Bern	Switzerland
2758	Bern	Bern	Switzerland
2759	Bellinzona	Ticino	Switzerland
2760	Basel	Basel-City	Switzerland
2761	Baden	Aargau	Switzerland
2762	Baar	Zug	Switzerland
2764	Allschwil	Basel-Landschaft	Switzerland
2765	Adliswil	Zurich	Switzerland
2766	Aarau	Aargau	Switzerland
2767	Riehen	Basel-City	Switzerland
2775	Stadt Winterthur (Kreis 1)	Zurich	Switzerland
2777	Seen (Kreis 3)	Zurich	Switzerland
2781	Oberwinterthur (Kreis 2)	Zurich	Switzerland
2787	Lancy	Geneva	Switzerland
2789	Yamoussoukro	Lacs	Ivory Coast
2790	Vavoua	Haut-Sassandra	Ivory Coast
2791	Toumodi	Lacs	Ivory Coast
2792	Touba	Bafing	Ivory Coast
2793	Tengrela	Savanes	Ivory Coast
2795	Tanda	Zanzan	Ivory Coast
2796	Tabou	Bas-Sassandra	Ivory Coast
2797	Sinfra	Zanzan	Ivory Coast
2798	Sassandra	Bas-Sassandra	Ivory Coast
2803	Mankono	Worodougou	Ivory Coast
2804	Man	Dix-Huit Montagnes	Ivory Coast
2805	Lakota	Sud-Bandama	Ivory Coast
2806	Korhogo	Savanes	Ivory Coast
2808	Issia	Haut-Sassandra	Ivory Coast
2809	Guiglo	Dix-Huit Montagnes	Ivory Coast
2811	Affery	Lagunes	Ivory Coast
2812	Gagnoa	Fromager	Ivory Coast
2815	Divo	Sud-Bandama	Ivory Coast
2816	Dimbokro	Lacs	Ivory Coast
2863	San Javier	Maule	Chile
2866	San Bernardo	Santiago Metropolitan	Chile
2873	Punta Arenas	Magallanes	Chile
2874	Puerto Varas	Los Lagos	Chile
2876	Puerto Natales	Magallanes	Chile
2877	Puerto Montt	Los Lagos	Chile
2879	Puente Alto	Santiago Metropolitan	Chile
2883	Parral	Maule	Chile
2885	Paine	Santiago Metropolitan	Chile
2886	Ovalle	Coquimbo	Chile
2887	Osorno	Los Lagos	Chile
2891	Molina	Maule	Chile
2892	Melipilla	Santiago Metropolitan	Chile
2912	Frutillar	Los Lagos	Chile
2913	El Monte	Santiago Metropolitan	Chile
2914	Diego de Almagro	Atacama	Chile
2918	Coquimbo	Coquimbo	Chile
3270	Qingdao	Shandong Sheng	China
3271	Qingyuan	Guangdong	China
3272	Hongqiao	Hunan	China
3273	Puyang Chengguanzhen	Henan Sheng	China
3274	Puyang	Zhejiang Sheng	China
3275	Putian	Fujian	China
3276	Puqi	Hubei	China
3277	Pumiao	Guangxi Zhuangzu Zizhiqu	China
3278	Pulandian	Liaoning	China
3279	Poyang	Jiangxi Sheng	China
3280	Pingyin	Shandong Sheng	China
3281	Pingyi	Shandong Sheng	China
3282	Gutao	Shanxi Sheng	China
3283	Pingxiang	Jiangxi Sheng	China
3284	Pingshan	Guangdong	China
3285	Pingnan	Guangxi Zhuangzu Zizhiqu	China
3286	Pingliang	Gansu Sheng	China
3287	Pingdu	Shandong Sheng	China
3288	Pingdingshan	Henan Sheng	China
3289	Pengcheng	Hebei	China
3290	Dadukou	Sichuan	China
3291	Ningyang	Shandong Sheng	China
3292	Yutan	Hunan	China
3293	Ninghai	Shandong Sheng	China
3294	Ninghai	Zhejiang Sheng	China
3295	Ningbo	Zhejiang Sheng	China
3296	Neijiang	Sichuan	China
3297	Nanzhou	Hunan	China
3298	Nanzhang Chengguanzhen	Hubei	China
3299	Nanyang	Henan Sheng	China
3300	Nantong	Jiangsu	China
3301	Pucheng	Fujian	China
3302	Nanping	Fujian	China
3303	Nanning	Guangxi Zhuangzu Zizhiqu	China
3304	Nanma	Shandong Sheng	China
3305	Nanlong	Sichuan	China
3306	Nanjing	Jiangsu	China
3307	Nangong	Hebei	China
3308	Nanfeng	Guangdong	China
3309	Nandu	Guangxi Zhuangzu Zizhiqu	China
3310	Nanding	Shandong Sheng	China
3311	Nanchong	Sichuan	China
3312	Nanchang	Jiangxi Sheng	China
3313	Miyang	Yunnan	China
3314	Mingshui	Shandong Sheng	China
3315	Mingguang	Anhui Sheng	China
3316	Minggang	Henan Sheng	China
3317	Mianyang	Sichuan	China
3318	Mentougou	Beijing	China
3319	Mengyin	Shandong Sheng	China
3320	Mengcheng Chengguanzhen	Anhui Sheng	China
3321	Meizhou	Guangdong	China
3322	Wuchuan	Guangdong	China
3323	Majie	Yunnan	China
3324	Zhijiang	Hubei	China
3325	Macheng	Hubei	China
3326	Maba	Guangdong	China
3328	Luqiao	Zhejiang Sheng	China
3329	Luoyang	Henan Sheng	China
3330	Luoyang	Fujian	China
3331	Luoyang	Guangdong	China
3332	Luorong	Guangxi Zhuangzu Zizhiqu	China
3333	Luohe	Henan Sheng	China
3334	Luocheng	Sichuan	China
3335	Lucheng	Anhui Sheng	China
3336	Kangding	Sichuan	China
3337	Lubu	Guangdong	China
3338	Luancheng	Hebei	China
3339	Loudi	Hunan	China
3340	Longquan	Yunnan	China
3341	Longgang	Shandong Sheng	China
3342	Licheng	Jiangsu	China
3343	Guankou	Hunan	China
3344	Puning	Guangdong	China
3345	Lishui	Zhejiang Sheng	China
3346	Lintong	Shaanxi	China
3347	Linyi	Shandong Sheng	China
3348	Linxia Chengguanzhen	Gansu Sheng	China
3349	Linxi	Hebei	China
3350	Linshui	Hebei	China
3351	Linqu	Shandong Sheng	China
3352	Linqiong	Sichuan	China
3353	Qingnian	Shandong Sheng	China
3354	Linping	Zhejiang Sheng	China
3355	Linhai	Zhejiang Sheng	China
3356	Lingcheng	Guangxi Zhuangzu Zizhiqu	China
3357	Lincheng	Hainan	China
3358	Linfen	Shanxi Sheng	China
3359	Xishan	Hunan	China
3360	Lichuan	Hubei	China
3361	Licheng	Guangdong	China
3362	Liaocheng	Shandong Sheng	China
3363	Lianzhou	Guangdong	China
3364	Lianzhou	Guangxi Zhuangzu Zizhiqu	China
3365	Lianran	Yunnan	China
3366	Wuwei	Gansu Sheng	China
3367	Liangxiang	Beijing	China
3368	Lianjiang	Guangdong	China
3369	Leshan	Sichuan	China
3370	Lengshuitan	Hunan	China
3371	Lengshuijiang	Hunan	China
3372	Leiyang	Hunan	China
3373	Lecheng	Guangdong	China
3374	Laohekou	Hubei	China
3375	Lanzhou	Gansu Sheng	China
3376	Lanxi	Zhejiang Sheng	China
3377	Lianyuan	Hunan	China
3378	Langfang	Hebei	China
3379	Weichanglu	Shandong Sheng	China
3380	Laiyang	Shandong Sheng	China
3381	Laiwu	Shandong Sheng	China
3382	Laibin	Guangxi Zhuangzu Zizhiqu	China
3383	Kunyang	Zhejiang Sheng	China
3384	Kunming	Yunnan	China
3385	Kaiyuan	Yunnan	China
3386	Kaihua	Yunnan	China
3387	Kaifeng	Henan Sheng	China
3388	Juye	Shandong Sheng	China
3389	Juegang	Jiangsu	China
3390	Jiujiang	Jiangxi Sheng	China
3391	Jishui	Henan Sheng	China
3392	Qianzhou	Hunan	China
3393	Jinzhou	Liaoning	China
3394	Jinxiang	Zhejiang Sheng	China
3395	Jinshi	Hunan	China
3396	Jinsha	Jiangsu	China
3397	Jinjiang	Hainan	China
3398	Jinji	Guangxi Zhuangzu Zizhiqu	China
3399	Jining	Shandong Sheng	China
3400	Jinhua	Zhejiang Sheng	China
3401	Jingzhou	Hubei	China
3402	Tianchang	Hebei	China
3403	Jingmen	Hubei	China
3404	Jingling	Hubei	China
3405	Jingdezhen	Jiangxi Sheng	China
3406	Jinchang	Gansu Sheng	China
3407	Jincheng	Shanxi Sheng	China
3408	Jinan	Shandong Sheng	China
3409	Jimo	Shandong Sheng	China
3410	Jijiang	Chongqing Shi	China
3411	Jiexiu	Shanxi Sheng	China
3412	Jieshou	Anhui Sheng	China
3413	Jieshi	Guangdong	China
3414	Jiehu	Shandong Sheng	China
3415	Jiazi	Guangdong	China
3416	Jiaxing	Zhejiang Sheng	China
3417	Jiaozuo	Henan Sheng	China
3418	Jiaozhou	Shandong Sheng	China
3419	Ningde	Fujian	China
3421	Jiangyan	Jiangsu	China
3422	Jianguang	Jiangxi Sheng	China
3423	Jiangmen	Guangdong	China
3424	Jiangkou	Fujian	China
3425	Yangjiang	Guangdong	China
3427	Guangyuan	Sichuan	China
3428	Huzhou	Zhejiang Sheng	China
3429	Hutang	Jiangsu	China
3430	Huoqiu Chengguanzhen	Anhui Sheng	China
3431	Humen	Guangdong	China
3432	Huizhou	Guangdong	China
3433	Huilong	Jiangsu	China
3434	Huicheng	Guangdong	China
3435	Xinhui	Guangdong	China
3436	Huazhou	Guangdong	China
3437	Huangzhou	Hubei	China
3438	Huangyan	Zhejiang Sheng	China
3439	Huangshi	Hubei	China
3440	Dasha	Guangdong	China
3441	Huangpi	Hubei	China
3442	Huangmei	Hubei	China
3443	Huanggang	Guangdong	China
3444	Daxing	Beijing	China
3445	Dingcheng	Henan Sheng	China
3446	Huaiyuan Chengguanzhen	Anhui Sheng	China
3447	Huainan	Anhui Sheng	China
3448	Huaicheng	Guangdong	China
3449	Huaihua	Hunan	China
3450	Huaidian	Henan Sheng	China
3451	Huaibei	Anhui Sheng	China
3452	Hongjiang	Hunan	China
3453	Heze	Shandong Sheng	China
3454	Hechuan	Chongqing Shi	China
3455	Yiyang	Hunan	China
3456	Hepo	Guangdong	China
3457	Hengyang	Hunan	China
3458	Hengshui	Hebei	China
3459	Hefei	Anhui Sheng	China
3460	Hede	Jiangsu	China
3461	Hecun	Hebei	China
3462	Hebi	Henan Sheng	China
3463	Hanzhong	Shaanxi	China
3464	Chengyang	Fujian	China
3465	Hanting	Shandong Sheng	China
3466	Hangzhou	Zhejiang Sheng	China
3467	Hangu	Tianjin Shi	China
3468	Handan	Hebei	China
3469	Hanchuan	Hubei	China
3470	Hancheng	Shaanxi	China
3471	Haizhou	Jiangsu	China
3472	Jiaojiang	Zhejiang Sheng	China
3473	Haimen	Guangdong	China
3474	Haikou	Yunnan	China
3475	Haikou	Hainan	China
3476	Guye	Hebei	China
3477	Guozhen	Shaanxi	China
3478	Guli	Zhejiang Sheng	China
3479	Guiyang	Guizhou Sheng	China
3480	Guiren	Jiangsu	China
3481	Guiping	Guangxi Zhuangzu Zizhiqu	China
3482	Guilin	Guangxi Zhuangzu Zizhiqu	China
3483	Guigang	Guangxi Zhuangzu Zizhiqu	China
3484	Gucheng Chengguanzhen	Hubei	China
3485	Guangzhou	Guangdong	China
3486	Guangshui	Hubei	China
3487	Gejiu	Yunnan	China
3488	Gaozhou	Guangdong	China
3489	Gaoyou	Jiangsu	China
3490	Gaoping	Sichuan	China
3491	Gaomi	Shandong Sheng	China
3492	Gaogou	Jiangsu	China
3493	Fuzhou	Fujian	China
3494	Fuyang	Anhui Sheng	China
3495	Fuyang	Zhejiang Sheng	China
3496	Qingyang	Shandong Sheng	China
3497	Fuling	Chongqing Shi	China
3498	Foshan	Guangdong	China
3499	Fenyi	Jiangxi Sheng	China
3500	Fengxian	Jiangsu	China
3501	Fengrun	Hebei	China
3502	Fengkou	Hubei	China
3503	Feicheng	Shandong Sheng	China
3504	Fangshan	Beijing	China
3505	Ezhou	Hubei	China
3506	Enshi	Hubei	China
3507	Encheng	Guangdong	China
3508	Duyun	Guizhou Sheng	China
3509	Duobao	Hubei	China
3510	Ducheng	Guangdong	China
3511	Xinyi	Guangdong	China
3512	Shengli	Shandong Sheng	China
3513	Dongtai	Jiangsu	China
3514	Dongsheng	Inner Mongolia	China
3515	Dongkan	Jiangsu	China
3516	Donghai	Guangdong	China
3517	Dongguan	Guangdong	China
3518	Dongdu	Shandong Sheng	China
3519	Dongcun	Shandong Sheng	China
3520	Dingzhou	Hebei	China
3521	Dingtao	Shandong Sheng	China
3522	Dezhou	Shandong Sheng	China
3523	Deyang	Sichuan	China
3524	Deqing	Zhejiang Sheng	China
3525	Dengzhou	Shandong Sheng	China
3526	Huazhou	Henan Sheng	China
3527	Songyang	Henan Sheng	China
3528	Dazhong	Jiangsu	China
3529	Zhangjiajie	Hunan	China
3530	Daye	Hubei	China
3531	Lijiang	Yunnan	China
3532	Dazhou	Sichuan	China
3533	Dawukou	Ningxia Huizu Zizhiqu	China
3534	Datong	Anhui Sheng	China
3535	Fenghua	Zhejiang Sheng	China
3536	Daokou	Henan Sheng	China
3537	Danshui	Guangdong	China
3538	Danjiangkou	Hubei	China
3539	Gushu	Anhui Sheng	China
3540	Xincheng	Henan Sheng	China
3541	Daliang	Guangdong	China
3542	Dalian	Liaoning	China
3543	Dali	Yunnan	China
3544	Chuzhou	Anhui Sheng	China
3545	Yangchun	Guangdong	China
3546	Yiwu	Zhejiang Sheng	China
3547	Chongqing	Chongqing Shi	China
3548	Chonglong	Sichuan	China
3549	Chizhou	Anhui Sheng	China
3550	Chenzhou	Hunan	China
3551	Chengyang	Shandong Sheng	China
3552	Jiangyin	Jiangsu	China
3553	Chengdu	Sichuan	China
3554	Chenghua	Guangdong	China
3555	Chaozhou	Guangdong	China
3556	Chaohu	Anhui Sheng	China
3557	Changzhou	Jiangsu	China
3558	Changzhi	Shanxi Sheng	China
3559	Changsha	Hunan	China
3560	Changqing	Shandong Sheng	China
3561	Changli	Hebei	China
3562	Changleng	Jiangxi Sheng	China
3563	Caohe	Hubei	China
3564	Weining	Guizhou Sheng	China
3565	Cangzhou	Hebei	China
3566	Caidian	Hubei	China
3567	Buhe	Hubei	China
3568	Bozhou	Anhui Sheng	China
3569	Botou	Hebei	China
3570	Boshan	Shandong Sheng	China
3571	Baise City	Guangxi Zhuangzu Zizhiqu	China
3572	Binzhou	Shandong Sheng	China
3573	Luxu	Guangxi Zhuangzu Zizhiqu	China
3574	Bijie	Guizhou Sheng	China
3575	Bianzhuang	Shandong Sheng	China
3576	Bengbu	Anhui Sheng	China
3577	Beijing	Beijing	China
3578	Beihai	Guangxi Zhuangzu Zizhiqu	China
3579	Beidao	Gansu Sheng	China
3580	Beidaihehaibin	Hebei	China
3581	Beibei	Chongqing Shi	China
3582	Baoying	Jiangsu	China
3583	Langzhong	Sichuan	China
3584	Baoding	Hebei	China
3585	Baiyin	Gansu Sheng	China
3586	Baihe	Guangxi Zhuangzu Zizhiqu	China
3587	Shangyu	Zhejiang Sheng	China
3588	Babu	Guangxi Zhuangzu Zizhiqu	China
3589	Anxiang	Hunan	China
3590	Anshun	Guizhou Sheng	China
3591	Anqiu	Shandong Sheng	China
3592	Anqing	Anhui Sheng	China
3593	Mabai	Yunnan	China
3594	Anlu	Hubei	China
3595	Anjiang	Hunan	China
3596	Anbu	Guangdong	China
3597	Jiangyou	Sichuan	China
3598	Suzhou	Jiangsu	China
3599	Zhoushan	Zhejiang Sheng	China
3600	Mudu	Jiangsu	China
3601	Songling	Jiangsu	China
3602	Zhongshan	Guangdong	China
3603	Lianghu	Zhejiang Sheng	China
3604	Zhoucheng	Shandong Sheng	China
3605	Dalianwan	Liaoning	China
3606	Yueyang	Hunan	China
3607	Bojia	Hunan	China
3608	Zhenlai	Jilin Sheng	China
3609	Zhengjiatun	Jilin Sheng	China
3610	Zhaozhou	Heilongjiang Sheng	China
3611	Zhaoyuan	Heilongjiang Sheng	China
3612	Zhaodong	Heilongjiang Sheng	China
3613	Zhangjiakou	Hebei	China
3614	Zalantun	Inner Mongolia	China
3615	Yushu	Jilin Sheng	China
3616	Youhao	Heilongjiang Sheng	China
3617	Yingkou	Liaoning	China
3618	Yilan	Heilongjiang Sheng	China
3619	Yichun	Heilongjiang Sheng	China
3620	Yebaishou	Liaoning	China
3621	Yantongshan	Jilin Sheng	China
3622	Yanji	Jilin Sheng	China
3623	Yakeshi	Inner Mongolia	China
3624	Zhangjiakou Shi Xuanhua Qu	Hebei	China
3625	Xiuyan	Liaoning	China
3626	Xinqing	Heilongjiang Sheng	China
3627	Xinmin	Liaoning	China
3628	Xinglongshan	Jilin Sheng	China
3629	Xingcheng	Liaoning	China
3630	Xilin Hot	Inner Mongolia	China
3631	Xifeng	Liaoning	China
3632	Xiaoshi	Liaoning	China
3633	Wuchang	Heilongjiang Sheng	China
3634	Wangqing	Jilin Sheng	China
3635	Hepingjie	Jilin Sheng	China
3636	Wangkui	Heilongjiang Sheng	China
3637	Ulanhot	Inner Mongolia	China
3638	Tumen	Jilin Sheng	China
3639	Tongliao	Inner Mongolia	China
3640	Tieling	Liaoning	China
3641	Tieli	Heilongjiang Sheng	China
3642	Guangming	Jilin Sheng	China
3643	Tailai	Heilongjiang Sheng	China
3644	Taikang	Heilongjiang Sheng	China
3645	Tahe	Heilongjiang Sheng	China
3646	Sujiatun	Liaoning	China
3647	Suileng	Heilongjiang Sheng	China
3648	Suihua	Heilongjiang Sheng	China
3649	Suifenhe	Heilongjiang Sheng	China
3650	Songjianghe	Jilin Sheng	China
3651	Siping	Jilin Sheng	China
3652	Shunyi	Beijing	China
3653	Shulan	Jilin Sheng	China
3654	Shuangyashan	Heilongjiang Sheng	China
3655	Shuangyang	Jilin Sheng	China
3656	Shuangcheng	Heilongjiang Sheng	China
3657	Shiguai	Inner Mongolia	China
3658	Shenyang	Liaoning	China
3659	Shanhetun	Heilongjiang Sheng	China
3660	Shanhaiguan	Hebei	China
3661	Shangzhi	Heilongjiang Sheng	China
3662	Sanchazi	Jilin Sheng	China
3663	Salaqi	Inner Mongolia	China
3664	Fendou	Heilongjiang Sheng	China
3665	Taihe	Heilongjiang Sheng	China
3666	Qiqihar	Heilongjiang Sheng	China
3667	Qinggang	Heilongjiang Sheng	China
3668	Qianguo	Jilin Sheng	China
3669	Pingzhuang	Inner Mongolia	China
3670	Panshi	Jilin Sheng	China
3671	Panshan	Liaoning	China
3672	Nianzishan	Heilongjiang Sheng	China
3673	Nenjiang	Heilongjiang Sheng	China
3674	Nehe	Heilongjiang Sheng	China
3675	Nantai	Liaoning	China
3676	Nanpiao	Liaoning	China
3677	Lianhe	Heilongjiang Sheng	China
3678	Mujiayingzi	Inner Mongolia	China
3679	Mudanjiang	Heilongjiang Sheng	China
3680	Mishan	Heilongjiang Sheng	China
3681	Mingyue	Jilin Sheng	China
3682	Mingshui	Heilongjiang Sheng	China
3683	Meihekou	Jilin Sheng	China
3684	Manzhouli	Inner Mongolia	China
3685	Longjing	Jilin Sheng	China
3686	Longjiang	Heilongjiang Sheng	China
3687	Longfeng	Heilongjiang Sheng	China
3688	Liuhe	Jilin Sheng	China
3689	Lishu	Jilin Sheng	China
3690	Linkou	Heilongjiang Sheng	China
3691	Linjiang	Jilin Sheng	China
3692	Lingyuan	Liaoning	China
3693	Lingdong	Heilongjiang Sheng	China
3694	Liaozhong	Liaoning	China
3695	Liaoyuan	Jilin Sheng	China
3696	Liaoyang	Liaoning	China
3697	Lanxi	Heilongjiang Sheng	China
3698	Langxiang	Heilongjiang Sheng	China
3699	Langtou	Liaoning	China
3700	Kuandian	Liaoning	China
3701	Kaiyuan	Liaoning	China
3702	Kaitong	Jilin Sheng	China
3703	Jixi	Heilongjiang Sheng	China
3704	Jiutai	Jilin Sheng	China
3705	Jiupu	Liaoning	China
3706	Jishu	Jilin Sheng	China
3707	Jinzhou	Liaoning	China
3708	Lianshan	Liaoning	China
3709	Jining	Inner Mongolia	China
3710	Jilin	Jilin Sheng	China
3711	Jidong	Heilongjiang Sheng	China
3712	Minzhu	Jilin Sheng	China
3713	Jiamusi	Heilongjiang Sheng	China
3714	Jalai Nur	Inner Mongolia	China
3715	Jagdaqi	Inner Mongolia	China
3716	Hushitai	Liaoning	China
3717	Hunchun	Jilin Sheng	China
3718	Hulan Ergi	Heilongjiang Sheng	China
3719	Hulan	Heilongjiang Sheng	China
3720	Huinan	Jilin Sheng	China
3721	Huanren	Liaoning	China
3722	Huangnihe	Jilin Sheng	China
3723	Huanan	Heilongjiang Sheng	China
3724	Huadian	Jilin Sheng	China
3725	Honggang	Heilongjiang Sheng	China
3726	Hohhot	Inner Mongolia	China
3727	Fendou	Heilongjiang Sheng	China
3728	Helong	Jilin Sheng	China
3729	Heishan	Liaoning	China
3730	Heihe	Heilongjiang Sheng	China
3731	Hegang	Heilongjiang Sheng	China
3732	Harbin	Heilongjiang Sheng	China
3733	Hailun	Heilongjiang Sheng	China
3734	Hailin	Heilongjiang Sheng	China
3735	Hailar	Inner Mongolia	China
3736	Haicheng	Liaoning	China
3737	Gongzhuling	Jilin Sheng	China
3738	Gongchangling	Liaoning	China
3739	Genhe	Inner Mongolia	China
3740	Gannan	Heilongjiang Sheng	China
3741	Fuyuan	Heilongjiang Sheng	China
3742	Fuyu	Heilongjiang Sheng	China
3743	Fuyu	Jilin Sheng	China
3744	Fuxin	Liaoning	China
3745	Fuxin	Liaoning	China
3746	Fushun	Liaoning	China
3747	Fuli	Heilongjiang Sheng	China
3748	Fujin	Heilongjiang Sheng	China
3749	Beichengqu	Inner Mongolia	China
3750	Fengxiang	Heilongjiang Sheng	China
3751	Fengcheng	Liaoning	China
3752	Erenhot	Inner Mongolia	China
3753	Erdaojiang	Jilin Sheng	China
3754	Dunhua	Jilin Sheng	China
3755	Dongning	Heilongjiang Sheng	China
3756	Dongling	Liaoning	China
3757	Dongfeng	Jilin Sheng	China
3758	Dongxing	Heilongjiang Sheng	China
3759	Dehui	Jilin Sheng	China
3760	Datong	Shanxi Sheng	China
3761	Dashitou	Jilin Sheng	China
3762	Dashiqiao	Liaoning	China
3763	Daqing	Heilongjiang Sheng	China
3764	Dandong	Liaoning	China
3765	Linghai	Liaoning	China
3766	Dalai	Jilin Sheng	China
3767	Chifeng	Inner Mongolia	China
3768	Chengzihe	Heilongjiang Sheng	China
3769	Chengde	Hebei	China
3770	Chaoyang	Jilin Sheng	China
3771	Chaoyang	Liaoning	China
3772	Changtu	Liaoning	China
3773	Changping	Beijing	China
3774	Changling	Jilin Sheng	China
3775	Changchun	Jilin Sheng	China
3776	Chaihe	Heilongjiang Sheng	China
3777	Boli	Heilongjiang Sheng	China
3778	Binzhou	Heilongjiang Sheng	China
3779	Benxi	Liaoning	China
3780	Beipiao	Liaoning	China
3782	Bayan	Heilongjiang Sheng	China
3783	Baotou	Inner Mongolia	China
3784	Baoshan	Heilongjiang Sheng	China
3785	Baoqing	Heilongjiang Sheng	China
3786	Bamiantong	Heilongjiang Sheng	China
3787	Baishishan	Jilin Sheng	China
3788	Baiquan	Heilongjiang Sheng	China
3789	Baicheng	Jilin Sheng	China
3790	Baishan	Jilin Sheng	China
3791	Anshan	Liaoning	China
3792	Anda	Heilongjiang Sheng	China
3793	Oroqen Zizhiqi	Inner Mongolia	China
3794	Acheng	Heilongjiang Sheng	China
3795	Songling	Hebei	China
3796	Shilin	Yunnan	China
3797	Changshu City	Jiangsu	China
3798	Shixing	Guangdong	China
3799	Jiashan	Zhejiang Sheng	China
3800	Fenghuang	Hunan	China
3801	Zhu Cheng City	Shandong Sheng	China
3802	Shangri-La	Yunnan	China
3803	Ordos	Inner Mongolia	China
3804	Wenshan City	Yunnan	China
3805	Liupanshui	Guizhou Sheng	China
3807	Zarzal	Valle del Cauca	Colombia
3808	Zaragoza	Antioquia	Colombia
3809	Yumbo	Valle del Cauca	Colombia
3810	Yopal	Casanare	Colombia
3811	Yarumal	Antioquia	Colombia
3812	Viterbo	Caldas	Colombia
3813	Villeta	Cundinamarca	Colombia
3814	Villavicencio	Meta	Colombia
3815	Villa del Rosario	Norte de Santander	Colombia
3816	Villanueva	La Guajira	Colombia
3817	Villanueva	Casanare	Colombia
3819	Valledupar	Cesar	Colombia
3820	Urrao	Antioquia	Colombia
3822	Turbo	Antioquia	Colombia
3830	Tame	Arauca	Colombia
3831	Sucre	Sucre	Colombia
3835	Socorro	Santander	Colombia
3836	Soacha	Cundinamarca	Colombia
3837	Sincelejo	Sucre	Colombia
3840	Sevilla	Valle del Cauca	Colombia
3841	Segovia	Antioquia	Colombia
3842	Santuario	Antioquia	Colombia
3844	Santa Rosa de Cabal	Risaralda	Colombia
3845	Santander de Quilichao	Cauca	Colombia
3846	Santa Marta	Magdalena	Colombia
3848	San Onofre	Sucre	Colombia
3850	San Marcos	Sucre	Colombia
3852	San Juan del Cesar	La Guajira	Colombia
3854	San Gil	Santander	Colombia
3856	San Carlos	Antioquia	Colombia
3857	San Benito Abad	Sucre	Colombia
3860	Salamina	Caldas	Colombia
3862	Sabaneta	Antioquia	Colombia
3865	Roldanillo	Valle del Cauca	Colombia
3866	Riosucio	Caldas	Colombia
3867	Rionegro	Antioquia	Colombia
3872	Puerto Tejada	Cauca	Colombia
3873	Puerto Santander	Norte de Santander	Colombia
3879	Pradera	Valle del Cauca	Colombia
3882	Pivijay	Magdalena	Colombia
3883	Pitalito	Huila	Colombia
3884	Piedecuesta	Santander	Colombia
3885	Pereira	Risaralda	Colombia
3888	Pamplona	Norte de Santander	Colombia
3889	Palmira	Valle del Cauca	Colombia
3891	Belalcazar	Cauca	Colombia
3892	Pacho	Cundinamarca	Colombia
3894	Neiva	Huila	Colombia
3895	Mosquera	Cundinamarca	Colombia
3901	Mocoa	Putumayo	Colombia
3902	Melgar	Tolima	Colombia
3904	Mariquita	Tolima	Colombia
3905	Marinilla	Antioquia	Colombia
3907	Manzanares	Caldas	Colombia
3908	Manizales	Caldas	Colombia
3911	Maicao	La Guajira	Colombia
3913	Madrid	Cundinamarca	Colombia
3914	Los Patios	Norte de Santander	Colombia
3917	Leticia	Amazonas	Colombia
3919	La Virginia	Risaralda	Colombia
3923	La Plata	Huila	Colombia
3924	La Mesa	Cundinamarca	Colombia
3925	La Jagua de Ibirico	Cesar	Colombia
3926	La Estrella	Antioquia	Colombia
3927	La Dorada	Caldas	Colombia
3928	La Ceja	Antioquia	Colombia
3933	Honda	Tolima	Colombia
3935	Granada	Meta	Colombia
3937	Girardot City	Cundinamarca	Colombia
3940	Fusagasuga	Cundinamarca	Colombia
3941	Funza	Cundinamarca	Colombia
3943	Fresno	Tolima	Colombia
3944	Fonseca	La Guajira	Colombia
3945	Floridablanca	Santander	Colombia
3946	Florida	Valle del Cauca	Colombia
3948	Flandes	Tolima	Colombia
3950	Espinal	Tolima	Colombia
3951	Envigado	Antioquia	Colombia
3953	El Copey	Cesar	Colombia
3955	El Cerrito	Valle del Cauca	Colombia
3957	El Banco	Magdalena	Colombia
3958	El Bagre	Antioquia	Colombia
3960	Dos Quebradas	Risaralda	Colombia
3963	Corozal	Sucre	Colombia
3964	Corinto	Cauca	Colombia
3965	Municipio de Copacabana	Antioquia	Colombia
3973	Chimichagua	Cesar	Colombia
3976	Chaparral	Tolima	Colombia
3978	Caucasia	Antioquia	Colombia
3979	Cartago	Valle del Cauca	Colombia
3981	Carmen de Viboral	Antioquia	Colombia
3982	Candelaria	Valle del Cauca	Colombia
3984	Campoalegre	Huila	Colombia
3985	Cali	Valle del Cauca	Colombia
3986	Caldas	Antioquia	Colombia
3989	Caicedonia	Valle del Cauca	Colombia
3990	Buga	Valle del Cauca	Colombia
3991	Buenaventura	Valle del Cauca	Colombia
3992	Buenaventura	Valle del Cauca	Colombia
3993	Bucaramanga	Santander	Colombia
3995	Bello	Antioquia	Colombia
3998	Barrancas	La Guajira	Colombia
3999	Barrancabermeja	Santander	Colombia
4000	Barbosa	Antioquia	Colombia
4001	Barbosa	Santander	Colombia
4007	Arauca	Arauca	Colombia
4008	Aracataca	Magdalena	Colombia
4010	Anserma	Risaralda	Colombia
4011	Andes	Antioquia	Colombia
4013	Aguazul	Casanare	Colombia
4014	Aguadas	Caldas	Colombia
4015	Aguachica	Cesar	Colombia
4017	Morales	Cauca	Colombia
4018	Carepa	Antioquia	Colombia
4021	Plato	Magdalena	Colombia
4023	Turrialba	Cartago	Costa Rica
4029	San Rafael	Alajuela	Costa Rica
4032	San Pablo	Heredia	Costa Rica
4039	San Francisco	Heredia	Costa Rica
4041	San Diego	Cartago	Costa Rica
4042	Quesada	Alajuela	Costa Rica
4044	Puntarenas	Puntarenas	Costa Rica
4048	Nicoya	Guanacaste	Costa Rica
4049	Mercedes	Heredia	Costa Rica
4050	Liberia	Guanacaste	Costa Rica
4052	Heredia	Heredia	Costa Rica
4055	Esparza	Puntarenas	Costa Rica
4058	Chacarita	Puntarenas	Costa Rica
4059	Cartago	Cartago	Costa Rica
4063	Alajuela	Alajuela	Costa Rica
4065	Yara	Granma	Cuba
4070	Varadero	Matanzas	Cuba
4075	Santo Domingo	Villa Clara	Cuba
4076	Santiago de las Vegas	La Habana	Cuba
4077	Santiago de Cuba	Santiago de Cuba	Cuba
4079	Santa Cruz del Norte	Mayabeque	Cuba
4080	Santa Clara	Villa Clara	Cuba
4082	San Luis	Santiago de Cuba	Cuba
4085	San Cristobal	Artemisa	Cuba
4087	Sagua la Grande	Villa Clara	Cuba
4089	Rodas	Cienfuegos	Cuba
4092	Remedios	Villa Clara	Cuba
4093	Regla	La Habana	Cuba
4094	Ranchuelo	Villa Clara	Cuba
4095	Puerto Padre	Las Tunas	Cuba
4097	Placetas	Villa Clara	Cuba
4099	Perico	Matanzas	Cuba
4100	Pedro Betancourt	Matanzas	Cuba
4101	Palmira	Cienfuegos	Cuba
4102	Palma Soriano	Santiago de Cuba	Cuba
4104	Nueva Gerona	Isla de la Juventud	Cuba
4105	Niquero	Granma	Cuba
4110	Media Luna	Granma	Cuba
4111	Matanzas	Matanzas	Cuba
4112	Mariel	Artemisa	Cuba
4113	Manzanillo	Granma	Cuba
4114	Manicaragua	Villa Clara	Cuba
4116	Madruga	Mayabeque	Cuba
4118	Las Tunas	Las Tunas	Cuba
4120	La Salud	Mayabeque	Cuba
4121	Havana	La Habana	Cuba
4122	Jovellanos	Matanzas	Cuba
4124	Jobabo	Las Tunas	Cuba
4128	Jaruco	Mayabeque	Cuba
4131	Guisa	Granma	Cuba
4136	Guanajay	Artemisa	Cuba
4137	Guanabacoa	La Habana	Cuba
4144	Encrucijada	Villa Clara	Cuba
4145	Cumanayagua	Cienfuegos	Cuba
4147	Cruces	Cienfuegos	Cuba
4148	Corralillo	Villa Clara	Cuba
4149	Contramaestre	Santiago de Cuba	Cuba
4153	Colombia	Las Tunas	Cuba
4155	Cifuentes	Villa Clara	Cuba
4156	Cienfuegos	Cienfuegos	Cuba
4159	Cerro	La Habana	Cuba
4160	Cauto Cristo	Granma	Cuba
4162	Campechuela	Granma	Cuba
4165	Calimete	Matanzas	Cuba
4169	Bejucal	Mayabeque	Cuba
4170	Bayamo	Granma	Cuba
4171	Bauta	Artemisa	Cuba
4177	Artemisa	Artemisa	Cuba
4178	Arroyo Naranjo	La Habana	Cuba
4179	Amancio	Las Tunas	Cuba
4181	Alamar	La Habana	Cuba
4182	Aguada de Pasajeros	Cienfuegos	Cuba
4183	Abreus	Cienfuegos	Cuba
4184	Habana del Este	La Habana	Cuba
4185	Centro Habana	La Habana	Cuba
4186	La Habana Vieja	La Habana	Cuba
4189	Arroyo Naranjo	La Habana	Cuba
4190	Boyeros	La Habana	Cuba
4191	Diez de Octubre	La Habana	Cuba
4192	Santa Maria	Sal	Cape Verde
4193	Praia	Praia	Cape Verde
4195	Cova Figueira	Santa Catarina do Fogo	Cape Verde
4196	Willemstad	N/A	Curacao
4197	Flying Fish Cove	N/A	Christmas Island
4198	Protaras	Ammochostos	Cyprus
4199	Paphos	Pafos	Cyprus
4200	Nicosia	Lefkosia	Cyprus
4201	Limassol	Limassol	Cyprus
4202	Larnaca	Larnaka	Cyprus
4203	Kyrenia	Keryneia	Cyprus
4204	Famagusta	Ammochostos	Cyprus
4206	Znojmo	South Moravian	Czech Republic
4233	Prosek	Praha	Czech Republic
4236	Prague	Praha	Czech Republic
4239	Pelhrimov	Vysocina	Czech Republic
4249	Neratovice	Central Bohemia	Czech Republic
4252	Modrany	Praha	Czech Republic
4259	Liben	Praha	Czech Republic
4260	Letnany	Praha	Czech Republic
4264	Kralupy nad Vltavou	Central Bohemia	Czech Republic
4269	Kladno	Central Bohemia	Czech Republic
4276	Jihlava	Vysocina	Czech Republic
4294	Brno	South Moravian	Czech Republic
4295	Breclav	South Moravian	Czech Republic
4299	Blansko	South Moravian	Czech Republic
4302	Beroun	Central Bohemia	Czech Republic
4305	Zwickau	Saxony	Germany
4307	Zulpich	North Rhine-Westphalia	Germany
4308	Zossen	Brandenburg	Germany
4309	Zittau	Saxony	Germany
4310	Zirndorf	Bavaria	Germany
4311	Zerbst	Saxony-Anhalt	Germany
4312	Zeitz	Saxony-Anhalt	Germany
4313	Zehlendorf	Berlin	Germany
4314	Xanten	North Rhine-Westphalia	Germany
4315	Wurzen	Saxony	Germany
4318	Wuppertal	North Rhine-Westphalia	Germany
4319	Wunstorf	Lower Saxony	Germany
4322	Worms	Rheinland-Pfalz	Germany
4323	Wolfsburg	Lower Saxony	Germany
4324	Wolfratshausen	Bavaria	Germany
4326	Wolfen	Saxony-Anhalt	Germany
4327	Witzenhausen	Hesse	Germany
4328	Wittstock	Brandenburg	Germany
4329	Wittmund	Lower Saxony	Germany
4330	Wittlich	Rheinland-Pfalz	Germany
4331	Wittenberge	Brandenburg	Germany
4332	Wittenau	Berlin	Germany
4333	Witten	North Rhine-Westphalia	Germany
4334	Wismar	Mecklenburg-Vorpommern	Germany
4336	Winterhude	Hamburg	Germany
4337	Winsen	Lower Saxony	Germany
4339	Wilnsdorf	North Rhine-Westphalia	Germany
4340	Wilmersdorf	Berlin	Germany
4341	Willich	North Rhine-Westphalia	Germany
4342	Wilhelmstadt	Berlin	Germany
4343	Wilhelmshaven	Lower Saxony	Germany
4344	Wildeshausen	Lower Saxony	Germany
4346	Wiesbaden	Hesse	Germany
4347	Wiehl	North Rhine-Westphalia	Germany
4348	Wetzlar	Hesse	Germany
4349	Wetter (Ruhr)	North Rhine-Westphalia	Germany
4350	Westerstede	Lower Saxony	Germany
4351	Westend	Berlin	Germany
4352	Wesseling	North Rhine-Westphalia	Germany
4353	Wesel	North Rhine-Westphalia	Germany
4355	Wernigerode	Saxony-Anhalt	Germany
4356	Werne	North Rhine-Westphalia	Germany
4357	Wermelskirchen	North Rhine-Westphalia	Germany
4358	Werl	North Rhine-Westphalia	Germany
4359	Werdohl	North Rhine-Westphalia	Germany
4360	Werder	Brandenburg	Germany
4361	Werdau	Saxony	Germany
4363	Wenden	North Rhine-Westphalia	Germany
4364	Wendelstein	Bavaria	Germany
4365	Weiterstadt	Hesse	Germany
4372	Weimar	Thuringia	Germany
4373	Weilheim	Bavaria	Germany
4374	Weilerswist	North Rhine-Westphalia	Germany
4377	Weiden	Bavaria	Germany
4379	Wegberg	North Rhine-Westphalia	Germany
4380	Weener	Lower Saxony	Germany
4381	Wedel	Schleswig-Holstein	Germany
4382	Wedding	Berlin	Germany
4383	Wassenberg	North Rhine-Westphalia	Germany
4384	Warstein	North Rhine-Westphalia	Germany
4385	Warendorf	North Rhine-Westphalia	Germany
4386	Waren	Mecklenburg-Vorpommern	Germany
4387	Wardenburg	Lower Saxony	Germany
4388	Warburg	North Rhine-Westphalia	Germany
4390	Wandlitz	Brandenburg	Germany
4391	Waltrop	North Rhine-Westphalia	Germany
4392	Walsrode	Lower Saxony	Germany
4393	Wallenhorst	Lower Saxony	Germany
4395	Waldkraiburg	Bavaria	Germany
4400	Wadgassen	Saarland	Germany
4401	Wadern	Saarland	Germany
4402	Wachtberg	North Rhine-Westphalia	Germany
4403	Vreden	North Rhine-Westphalia	Germany
4405	Voerde	North Rhine-Westphalia	Germany
4406	Vlotho	North Rhine-Westphalia	Germany
4407	Vilshofen	Bavaria	Germany
4409	Viersen	North Rhine-Westphalia	Germany
4410	Viernheim	Hesse	Germany
4411	Versmold	North Rhine-Westphalia	Germany
4412	Verl	North Rhine-Westphalia	Germany
4413	Verden	Lower Saxony	Germany
4414	Velbert	North Rhine-Westphalia	Germany
4415	Vechta	Lower Saxony	Germany
4416	Vechelde	Lower Saxony	Germany
4417	Vaterstetten	Bavaria	Germany
4418	Varel	Lower Saxony	Germany
4420	Uetersen	Schleswig-Holstein	Germany
4421	Uslar	Lower Saxony	Germany
4423	Unterhaching	Bavaria	Germany
4425	Unna	North Rhine-Westphalia	Germany
4427	Uelzen	Lower Saxony	Germany
4433	Troisdorf	North Rhine-Westphalia	Germany
4434	Trier	Rheinland-Pfalz	Germany
4435	Traunstein	Bavaria	Germany
4436	Traunreut	Bavaria	Germany
4437	Torgau	Saxony	Germany
4440	Templin	Brandenburg	Germany
4441	Tempelhof	Berlin	Germany
4442	Teltow	Brandenburg	Germany
4443	Telgte	North Rhine-Westphalia	Germany
4444	Tegel	Berlin	Germany
4445	Taunusstein	Hesse	Germany
4446	Taufkirchen	Bavaria	Germany
4447	Syke	Lower Saxony	Germany
4448	Sundern	North Rhine-Westphalia	Germany
4449	Sulzbach-Rosenberg	Bavaria	Germany
4450	Sulzbach	Saarland	Germany
4451	Suhl	Thuringia	Germany
4453	Stuhr	Lower Saxony	Germany
4454	Strausberg	Brandenburg	Germany
4455	Straubing	Bavaria	Germany
4456	Stralsund	Mecklenburg-Vorpommern	Germany
4457	Straelen	North Rhine-Westphalia	Germany
4458	Stolberg	North Rhine-Westphalia	Germany
4459	Stockelsdorf	Schleswig-Holstein	Germany
4461	Stendal	Saxony-Anhalt	Germany
4462	Stellingen	Hamburg	Germany
4463	Steinhagen	North Rhine-Westphalia	Germany
4464	Steinfurt	North Rhine-Westphalia	Germany
4465	Steilshoop	Hamburg	Germany
4466	Steglitz	Berlin	Germany
4468	Starnberg	Bavaria	Germany
4469	Stadtlohn	North Rhine-Westphalia	Germany
4470	Stadthagen	Lower Saxony	Germany
4471	Stadtallendorf	Hesse	Germany
4472	Stade	Lower Saxony	Germany
4473	Staaken	Berlin	Germany
4475	Springe	Lower Saxony	Germany
4476	Speyer	Rheinland-Pfalz	Germany
4477	Spenge	North Rhine-Westphalia	Germany
4478	Sonthofen	Bavaria	Germany
4479	Sonneberg	Thuringia	Germany
4480	Sondershausen	Thuringia	Germany
4482	Soltau	Lower Saxony	Germany
4483	Solingen	North Rhine-Westphalia	Germany
4484	Soest	North Rhine-Westphalia	Germany
4485	Sinzig	Rheinland-Pfalz	Germany
4489	Simmerath	North Rhine-Westphalia	Germany
4491	Siegen	North Rhine-Westphalia	Germany
4492	Siegburg	North Rhine-Westphalia	Germany
4493	Senftenberg	Brandenburg	Germany
4494	Senden	North Rhine-Westphalia	Germany
4495	Senden	Bavaria	Germany
4496	Selm	North Rhine-Westphalia	Germany
4497	Seligenstadt	Hesse	Germany
4498	Selb	Bavaria	Germany
4499	Sehnde	Lower Saxony	Germany
4500	Seevetal	Lower Saxony	Germany
4501	Seesen	Lower Saxony	Germany
4502	Seelze	Lower Saxony	Germany
4504	Schwerte	North Rhine-Westphalia	Germany
4505	Schwerin	Mecklenburg-Vorpommern	Germany
4506	Schwelm	North Rhine-Westphalia	Germany
4507	Schweinfurt	Bavaria	Germany
4508	Schwedt (Oder)	Brandenburg	Germany
4509	Schwarzenberg	Saxony	Germany
4510	Schwanewede	Lower Saxony	Germany
4511	Schwandorf in Bayern	Bavaria	Germany
4512	Schwalmtal	North Rhine-Westphalia	Germany
4513	Schwalmstadt	Hesse	Germany
4514	Schwalbach	Saarland	Germany
4517	Schwabach	Bavaria	Germany
4518	Schrobenhausen	Bavaria	Germany
4520	Schortens	Lower Saxony	Germany
4525	Schneverdingen	Lower Saxony	Germany
4526	Schneeberg	Saxony	Germany
4527	Schmelz	Saarland	Germany
4528	Schmargendorf	Berlin	Germany
4529	Schmallenberg	North Rhine-Westphalia	Germany
4530	Schmalkalden	Thuringia	Germany
4532	Schleswig	Schleswig-Holstein	Germany
4533	Schkeuditz	Saxony	Germany
4534	Schiffweiler	Saarland	Germany
4535	Schifferstadt	Rheinland-Pfalz	Germany
4537	Sasel	Hamburg	Germany
4538	Sarstedt	Lower Saxony	Germany
4539	Sankt Wendel	Saarland	Germany
4540	Sankt Ingbert	Saarland	Germany
4541	Sankt Augustin	North Rhine-Westphalia	Germany
4542	Sangerhausen	Saxony-Anhalt	Germany
4543	Salzwedel	Saxony-Anhalt	Germany
4544	Salzkotten	North Rhine-Westphalia	Germany
4545	Saarlouis	Saarland	Germany
4547	Saalfeld	Thuringia	Germany
4549	Rummelsburg	Berlin	Germany
4550	Rudow	Berlin	Germany
4551	Rudolstadt	Thuringia	Germany
4554	Roth	Bavaria	Germany
4555	Rotenburg	Lower Saxony	Germany
4556	Rostock	Mecklenburg-Vorpommern	Germany
4558	Rosenheim	Bavaria	Germany
4559	Ronnenberg	Lower Saxony	Germany
4560	Rinteln	Lower Saxony	Germany
4561	Rietberg	North Rhine-Westphalia	Germany
4562	Riesa	Saxony	Germany
4563	Riegelsberg	Saarland	Germany
4564	Ribnitz-Damgarten	Mecklenburg-Vorpommern	Germany
4566	Rheine	North Rhine-Westphalia	Germany
4567	Rheinberg	North Rhine-Westphalia	Germany
4568	Rheinbach	North Rhine-Westphalia	Germany
4569	Rhede	North Rhine-Westphalia	Germany
4573	Rendsburg	Schleswig-Holstein	Germany
4574	Remscheid	North Rhine-Westphalia	Germany
4575	Remagen	Rheinland-Pfalz	Germany
4576	Reinickendorf	Berlin	Germany
4577	Reinheim	Hesse	Germany
4578	Reinbek	Schleswig-Holstein	Germany
4579	Reichenbach/Vogtland	Saxony	Germany
4580	Regensburg	Bavaria	Germany
4581	Rees	North Rhine-Westphalia	Germany
4582	Recklinghausen	North Rhine-Westphalia	Germany
4584	Ratingen	North Rhine-Westphalia	Germany
4585	Rathenow	Brandenburg	Germany
4586	Ratekau	Schleswig-Holstein	Germany
4587	Rastede	Lower Saxony	Germany
4589	Rahden	North Rhine-Westphalia	Germany
4591	Radevormwald	North Rhine-Westphalia	Germany
4592	Radebeul	Saxony	Germany
4593	Radeberg	Saxony	Germany
4594	Quickborn	Schleswig-Holstein	Germany
4595	Quedlinburg	Saxony-Anhalt	Germany
4597	Pulheim	North Rhine-Westphalia	Germany
4598	Puchheim	Bavaria	Germany
4599	Prenzlauer Berg	Berlin	Germany
4600	Prenzlau	Brandenburg	Germany
4601	Preetz	Schleswig-Holstein	Germany
4602	Potsdam	Brandenburg	Germany
4603	Porta Westfalica	North Rhine-Westphalia	Germany
4605	Plettenberg	North Rhine-Westphalia	Germany
4606	Plauen	Saxony	Germany
4607	Pirna	Saxony	Germany
4608	Pirmasens	Rheinland-Pfalz	Germany
4609	Pinneberg	Schleswig-Holstein	Germany
4610	Pfungstadt	Hesse	Germany
4613	Pfaffenhofen an der Ilm	Bavaria	Germany
4614	Petershagen	North Rhine-Westphalia	Germany
4615	Penzberg	Bavaria	Germany
4616	Peine	Lower Saxony	Germany
4617	Passau	Bavaria	Germany
4618	Pasing	Bavaria	Germany
4619	Parchim	Mecklenburg-Vorpommern	Germany
4620	Papenburg	Lower Saxony	Germany
4621	Pankow	Berlin	Germany
4622	Paderborn	North Rhine-Westphalia	Germany
4623	Oyten	Lower Saxony	Germany
4624	Overath	North Rhine-Westphalia	Germany
4625	Ottweiler	Saarland	Germany
4626	Ottobrunn	Bavaria	Germany
4627	Osterholz-Scharmbeck	Lower Saxony	Germany
4629	Oschersleben	Saxony-Anhalt	Germany
4630	Oschatz	Saxony	Germany
4631	Oranienburg	Brandenburg	Germany
4632	Opladen	North Rhine-Westphalia	Germany
4633	Olsberg	North Rhine-Westphalia	Germany
4634	Olpe	North Rhine-Westphalia	Germany
4635	Oldenburg	Lower Saxony	Germany
4636	Olching	Bavaria	Germany
4639	Offenbach	Hesse	Germany
4640	Oerlinghausen	North Rhine-Westphalia	Germany
4641	Oer-Erkenschwick	North Rhine-Westphalia	Germany
4642	Oelde	North Rhine-Westphalia	Germany
4643	Odenthal	North Rhine-Westphalia	Germany
4644	Ochtrup	North Rhine-Westphalia	Germany
4645	Oberursel	Hesse	Germany
4646	Obertshausen	Hesse	Germany
4648	Ober-Ramstadt	Hesse	Germany
4650	Oberhausen	North Rhine-Westphalia	Germany
4651	Oberasbach	Bavaria	Germany
4655	Nottuln	North Rhine-Westphalia	Germany
4656	Northeim	Lower Saxony	Germany
4658	Nordhorn	Lower Saxony	Germany
4659	Nordhausen	Thuringia	Germany
4660	Norderstedt	Schleswig-Holstein	Germany
4661	Nordenham	Lower Saxony	Germany
4662	Norden	Lower Saxony	Germany
4663	Nippes	North Rhine-Westphalia	Germany
4664	Nikolassee	Berlin	Germany
4665	Nienburg	Lower Saxony	Germany
4668	Niederkassel	North Rhine-Westphalia	Germany
4669	Nieder-Ingelheim	Rheinland-Pfalz	Germany
4670	Nidderau	Hesse	Germany
4671	Nidda	Hesse	Germany
4672	Neu Wulmstorf	Lower Saxony	Germany
4673	Neuwied	Rheinland-Pfalz	Germany
4674	Neu-Ulm	Bavaria	Germany
4675	Neustrelitz	Mecklenburg-Vorpommern	Germany
4676	Neustadt in Holstein	Schleswig-Holstein	Germany
4677	Neustadt bei Coburg	Bavaria	Germany
4678	Neustadt	Rheinland-Pfalz	Germany
4680	Neue Neustadt	Saxony-Anhalt	Germany
4681	Neuss	North Rhine-Westphalia	Germany
4682	Neuruppin	Brandenburg	Germany
4683	Neunkirchen	Saarland	Germany
4685	Neumarkt in der Oberpfalz	Bavaria	Germany
4686	Neu Isenburg	Hesse	Germany
4687	Neufahrn bei Freising	Bavaria	Germany
4688	Neuenhagen	Brandenburg	Germany
4689	Neuburg an der Donau	Bavaria	Germany
4691	Neubrandenburg	Mecklenburg-Vorpommern	Germany
4692	Neu-Anspach	Hesse	Germany
4693	Nettetal	North Rhine-Westphalia	Germany
4694	Netphen	North Rhine-Westphalia	Germany
4696	Naumburg	Saxony-Anhalt	Germany
4697	Nauen	Brandenburg	Germany
4699	Munster	Lower Saxony	Germany
4702	Munich	Bavaria	Germany
4710	Much	North Rhine-Westphalia	Germany
4713	Moosburg	Bavaria	Germany
4714	Monheim am Rhein	North Rhine-Westphalia	Germany
4717	Moers	North Rhine-Westphalia	Germany
4718	Moabit	Berlin	Germany
4719	Mittweida	Saxony	Germany
4720	Minden	North Rhine-Westphalia	Germany
4721	Michelstadt	Hesse	Germany
4723	Mettmann	North Rhine-Westphalia	Germany
4724	Meschede	North Rhine-Westphalia	Germany
4725	Merzig	Saarland	Germany
4726	Merseburg	Saxony-Anhalt	Germany
4727	Meppen	Lower Saxony	Germany
4728	Menden	North Rhine-Westphalia	Germany
4729	Memmingen	Bavaria	Germany
4730	Melle	Lower Saxony	Germany
4731	Meissen	Saxony	Germany
4732	Meiningen	Thuringia	Germany
4733	Meinerzhagen	North Rhine-Westphalia	Germany
4734	Meiderich	North Rhine-Westphalia	Germany
4735	Meerbusch	North Rhine-Westphalia	Germany
4736	Meerane	Saxony	Germany
4737	Meckenheim	North Rhine-Westphalia	Germany
4738	Mechernich	North Rhine-Westphalia	Germany
4739	Mayen	Rheinland-Pfalz	Germany
4740	Marzahn	Berlin	Germany
4741	Marsberg	North Rhine-Westphalia	Germany
4742	Marl	North Rhine-Westphalia	Germany
4743	Marktredwitz	Bavaria	Germany
4744	Marktoberdorf	Bavaria	Germany
4745	Markkleeberg	Saxony	Germany
4747	Marienfelde	Berlin	Germany
4748	Mariendorf	Berlin	Germany
4749	Marburg an der Lahn	Hesse	Germany
4752	Mainz	Rheinland-Pfalz	Germany
4753	Maintal	Hesse	Germany
4754	Mahlsdorf	Berlin	Germany
4755	Magdeburg	Saxony-Anhalt	Germany
4758	Ludwigshafen am Rhein	Rheinland-Pfalz	Germany
4759	Ludwigsfelde	Brandenburg	Germany
4763	Luckenwalde	Brandenburg	Germany
4767	Loxstedt	Lower Saxony	Germany
4768	Losheim	Saarland	Germany
4770	Lohr am Main	Bavaria	Germany
4771	Lohne	Lower Saxony	Germany
4773	Lohmar	North Rhine-Westphalia	Germany
4775	Lippstadt	North Rhine-Westphalia	Germany
4776	Lingen	Lower Saxony	Germany
4777	Lindlar	North Rhine-Westphalia	Germany
4778	Lindau	Bavaria	Germany
4779	Limburg an der Lahn	Hesse	Germany
4780	Limbach-Oberfrohna	Saxony	Germany
4781	Lilienthal	Lower Saxony	Germany
4782	Lichterfelde	Berlin	Germany
4783	Lichtenrade	Berlin	Germany
4784	Lichtenfels	Bavaria	Germany
4785	Lichtenberg	Berlin	Germany
4786	Leverkusen	North Rhine-Westphalia	Germany
4790	Lennestadt	North Rhine-Westphalia	Germany
4791	Lengerich	North Rhine-Westphalia	Germany
4792	Lemgo	North Rhine-Westphalia	Germany
4793	Leipzig	Saxony	Germany
4796	Leichlingen	North Rhine-Westphalia	Germany
4797	Lehrte	Lower Saxony	Germany
4798	Leer	Lower Saxony	Germany
4799	Lebach	Saarland	Germany
4801	Lauf an der Pegnitz	Bavaria	Germany
4802	Lauchhammer	Brandenburg	Germany
4803	Lankwitz	Berlin	Germany
4804	Langenhorn	Hamburg	Germany
4805	Langenhagen	Lower Saxony	Germany
4806	Langenfeld	North Rhine-Westphalia	Germany
4807	Langen	Lower Saxony	Germany
4808	Langen	Hesse	Germany
4809	Landshut	Bavaria	Germany
4810	Landsberg am Lech	Bavaria	Germany
4811	Landau in der Pfalz	Rheinland-Pfalz	Germany
4812	Lampertheim	Hesse	Germany
4814	Lahnstein	Rheinland-Pfalz	Germany
4815	Lage	North Rhine-Westphalia	Germany
4816	Laatzen	Lower Saxony	Germany
4817	Bad Laasphe	North Rhine-Westphalia	Germany
4821	Kulmbach	Bavaria	Germany
4822	Kronberg	Hesse	Germany
4823	Kronach	Bavaria	Germany
4824	Kreuztal	North Rhine-Westphalia	Germany
4825	Kreuzberg	Berlin	Germany
4826	Kreuzau	North Rhine-Westphalia	Germany
4827	Krefeld	North Rhine-Westphalia	Germany
4829	Korschenbroich	North Rhine-Westphalia	Germany
4832	Korbach	Hesse	Germany
4835	Konz	Rheinland-Pfalz	Germany
4843	Kolbermoor	Bavaria	Germany
4844	Koblenz	Rheinland-Pfalz	Germany
4845	Kleve	North Rhine-Westphalia	Germany
4846	Kleinmachnow	Brandenburg	Germany
4847	Kitzingen	Bavaria	Germany
4848	Kirchlengern	North Rhine-Westphalia	Germany
4850	Kirchhain	Hesse	Germany
4851	Kierspe	North Rhine-Westphalia	Germany
4852	Kiel	Schleswig-Holstein	Germany
4853	Kevelaer	North Rhine-Westphalia	Germany
4854	Kerpen	North Rhine-Westphalia	Germany
4856	Kempen	North Rhine-Westphalia	Germany
4857	Kelkheim (Taunus)	Hesse	Germany
4858	Kelheim	Bavaria	Germany
4860	Kaulsdorf	Berlin	Germany
4861	Kaufbeuren	Bavaria	Germany
4862	Kassel	Hesse	Germany
4863	Karow	Berlin	Germany
4864	Karlstadt	Bavaria	Germany
4866	Karlshorst	Berlin	Germany
4867	Karlsfeld	Bavaria	Germany
4868	Karben	Hesse	Germany
4869	Kamp-Lintfort	North Rhine-Westphalia	Germany
4870	Kamenz	Saxony	Germany
4871	Kamen	North Rhine-Westphalia	Germany
4872	Kaltenkirchen	Schleswig-Holstein	Germany
4873	Kaiserslautern	Rheinland-Pfalz	Germany
4874	Kaarst	North Rhine-Westphalia	Germany
4877	Johannisthal	Berlin	Germany
4878	Jena	Thuringia	Germany
4879	Itzehoe	Schleswig-Holstein	Germany
4880	Isernhagen Farster Bauerschaft	Lower Saxony	Germany
4881	Iserlohn	North Rhine-Westphalia	Germany
4882	Ingolstadt	Bavaria	Germany
4883	Ilmenau	Thuringia	Germany
4884	Illingen	Saarland	Germany
4885	Illertissen	Bavaria	Germany
4886	Idstein	Hesse	Germany
4887	Idar-Oberstein	Rheinland-Pfalz	Germany
4889	Husum	Schleswig-Holstein	Germany
4893	Humboldtkolonie	North Rhine-Westphalia	Germany
4894	Hude	Lower Saxony	Germany
4897	Hoyerswerda	Saxony	Germany
4902	Homburg	Saarland	Germany
4903	Holzwickede	North Rhine-Westphalia	Germany
4904	Holzminden	Lower Saxony	Germany
4905	Holzkirchen	Bavaria	Germany
4906	Hohenstein-Ernstthal	Saxony	Germany
4907	Hohen Neuendorf	Brandenburg	Germany
4908	Hofheim am Taunus	Hesse	Germany
4909	Hofgeismar	Hesse	Germany
4910	Hof	Bavaria	Germany
4912	Hochheim am Main	Hesse	Germany
4913	Hochfeld	North Rhine-Westphalia	Germany
4914	Hille	North Rhine-Westphalia	Germany
4915	Hildesheim	Lower Saxony	Germany
4916	Hilden	North Rhine-Westphalia	Germany
4917	Hilchenbach	North Rhine-Westphalia	Germany
4918	Hiddenhausen	North Rhine-Westphalia	Germany
4919	Heusweiler	Saarland	Germany
4920	Heusenstamm	Hesse	Germany
4921	Hettstedt	Saxony-Anhalt	Germany
4922	Hessisch Oldendorf	Lower Saxony	Germany
4923	Herzogenrath	North Rhine-Westphalia	Germany
4924	Herzogenaurach	Bavaria	Germany
4925	Herten	North Rhine-Westphalia	Germany
4927	Herne	North Rhine-Westphalia	Germany
4928	Hermsdorf	Berlin	Germany
4929	Herford	North Rhine-Westphalia	Germany
4930	Herdecke	North Rhine-Westphalia	Germany
4931	Herborn	Hesse	Germany
4932	Heppenheim an der Bergstrasse	Hesse	Germany
4933	Hennigsdorf	Brandenburg	Germany
4934	Hennef	North Rhine-Westphalia	Germany
4935	Hemmingen	Lower Saxony	Germany
4936	Hemer	North Rhine-Westphalia	Germany
4937	Helmstedt	Lower Saxony	Germany
4938	Hellersdorf	Berlin	Germany
4939	Heinsberg	North Rhine-Westphalia	Germany
4940	Heilbad Heiligenstadt	Thuringia	Germany
4941	Heiligensee	Berlin	Germany
4942	Heiligenhaus	North Rhine-Westphalia	Germany
4945	Heidenau	Saxony	Germany
4947	Heide	Schleswig-Holstein	Germany
4949	Hattingen	North Rhine-Westphalia	Germany
4950	Hattersheim	Hesse	Germany
4952	Harsewinkel	North Rhine-Westphalia	Germany
4953	Haren	Lower Saxony	Germany
4954	Harburg	Hamburg	Germany
4955	Hannover	Lower Saxony	Germany
4956	Hanau am Main	Hesse	Germany
4957	Hamminkeln	North Rhine-Westphalia	Germany
4958	Hamm	North Rhine-Westphalia	Germany
4959	Hameln	Lower Saxony	Germany
4960	Wandsbek	Hamburg	Germany
4961	Marienthal	Hamburg	Germany
4962	Hamburg-Mitte	Hamburg	Germany
4964	Altona	Hamburg	Germany
4965	Hamburg	Hamburg	Germany
4966	Halver	North Rhine-Westphalia	Germany
4967	Haltern	North Rhine-Westphalia	Germany
4968	Halstenbek	Schleswig-Holstein	Germany
4969	Halle	North Rhine-Westphalia	Germany
4970	Halle (Saale)	Saxony-Anhalt	Germany
4971	Haldensleben I	Saxony-Anhalt	Germany
4972	Halberstadt	Saxony-Anhalt	Germany
4973	Hakenfelde	Berlin	Germany
4974	Haiger	Hesse	Germany
4975	Hagen	North Rhine-Westphalia	Germany
4976	Haar	Bavaria	Germany
4977	Haan	North Rhine-Westphalia	Germany
4980	Gunzenhausen	Bavaria	Germany
4982	Gummersbach	North Rhine-Westphalia	Germany
4983	Guben	Brandenburg	Germany
4988	Gronau	North Rhine-Westphalia	Germany
4990	Grimma	Saxony	Germany
4991	Griesheim	Hesse	Germany
4992	Grevenbroich	North Rhine-Westphalia	Germany
4993	Greven	North Rhine-Westphalia	Germany
4994	Greiz	Thuringia	Germany
4995	Greifswald	Mecklenburg-Vorpommern	Germany
4996	Grefrath	North Rhine-Westphalia	Germany
4998	Gotha	Thuringia	Germany
4999	Goslar	Lower Saxony	Germany
5002	Goch	North Rhine-Westphalia	Germany
5003	Glinde	Schleswig-Holstein	Germany
5004	Glauchau	Saxony	Germany
5005	Gladbeck	North Rhine-Westphalia	Germany
5006	Ginsheim-Gustavsburg	Hesse	Germany
5007	Gilching	Bavaria	Germany
5008	Gifhorn	Lower Saxony	Germany
5011	Gevelsberg	North Rhine-Westphalia	Germany
5012	Gesundbrunnen	Berlin	Germany
5013	Geseke	North Rhine-Westphalia	Germany
5014	Gescher	North Rhine-Westphalia	Germany
5015	Gersthofen	Bavaria	Germany
5016	Germersheim	Rheinland-Pfalz	Germany
5017	Germering	Bavaria	Germany
5019	Geretsried	Bavaria	Germany
5020	Gera	Thuringia	Germany
5022	Gelsenkirchen	North Rhine-Westphalia	Germany
5023	Gelnhausen	Hesse	Germany
5024	Geldern	North Rhine-Westphalia	Germany
5026	Geilenkirchen	North Rhine-Westphalia	Germany
5027	Geesthacht	Schleswig-Holstein	Germany
5028	Gauting	Bavaria	Germany
5029	Garmisch-Partenkirchen	Bavaria	Germany
5031	Garbsen	Lower Saxony	Germany
5032	Ganderkesee	Lower Saxony	Germany
5037	Fulda	Hesse	Germany
5039	Frohnau	Berlin	Germany
5040	Friesoythe	Lower Saxony	Germany
5041	Friedrichshain	Berlin	Germany
5042	Friedrichshagen	Berlin	Germany
5044	Friedrichsfelde	Berlin	Germany
5045	Friedrichsdorf	Hesse	Germany
5046	Friedenau	Berlin	Germany
5047	Friedberg	Hesse	Germany
5048	Friedberg	Bavaria	Germany
5050	Freudenberg	North Rhine-Westphalia	Germany
5051	Freital	Saxony	Germany
5052	Freising	Bavaria	Germany
5053	Freilassing	Bavaria	Germany
5056	Freiberg	Saxony	Germany
5057	Frechen	North Rhine-Westphalia	Germany
5058	Frankfurt am Main	Hesse	Germany
5059	Frankfurt (Oder)	Brandenburg	Germany
5060	Frankenthal	Rheinland-Pfalz	Germany
5061	Frankenberg	Hesse	Germany
5062	Frankenberg	Saxony	Germany
5063	Forst	Brandenburg	Germany
5064	Forchheim	Bavaria	Germany
5066	Flensburg	Schleswig-Holstein	Germany
5067	Finsterwalde	Brandenburg	Germany
5068	Finnentrop	North Rhine-Westphalia	Germany
5071	Falkensee	Brandenburg	Germany
5072	Eutin	Schleswig-Holstein	Germany
5073	Euskirchen	North Rhine-Westphalia	Germany
5076	Essen	North Rhine-Westphalia	Germany
5077	Espelkamp	North Rhine-Westphalia	Germany
5078	Eschweiler	North Rhine-Westphalia	Germany
5079	Eschwege	Hesse	Germany
5080	Eschborn	Hesse	Germany
5081	Erwitte	North Rhine-Westphalia	Germany
5082	Erlangen	Bavaria	Germany
5083	Erkrath	North Rhine-Westphalia	Germany
5084	Erkelenz	North Rhine-Westphalia	Germany
5085	Erfurt	Thuringia	Germany
5086	Erftstadt	North Rhine-Westphalia	Germany
5087	Erding	Bavaria	Germany
5089	Eppelborn	Saarland	Germany
5090	Ennigerloh	North Rhine-Westphalia	Germany
5091	Ennepetal	North Rhine-Westphalia	Germany
5092	Enger	North Rhine-Westphalia	Germany
5093	Engelskirchen	North Rhine-Westphalia	Germany
5094	Emsdetten	North Rhine-Westphalia	Germany
5095	Emmerich	North Rhine-Westphalia	Germany
5097	Emden	Lower Saxony	Germany
5098	Eltville	Hesse	Germany
5099	Elsdorf	North Rhine-Westphalia	Germany
5100	Elmshorn	Schleswig-Holstein	Germany
5102	Eitorf	North Rhine-Westphalia	Germany
5105	Eisenach	Thuringia	Germany
5106	Einbeck	Lower Saxony	Germany
5107	Eilenburg	Saxony	Germany
5110	Edewecht	Lower Saxony	Germany
5112	Eberswalde	Brandenburg	Germany
5118	Duisburg	North Rhine-Westphalia	Germany
5119	Duderstadt	Lower Saxony	Germany
5120	Dresden	Saxony	Germany
5121	Drensteinfurt	North Rhine-Westphalia	Germany
5122	Dreieich	Hesse	Germany
5123	Dortmund	North Rhine-Westphalia	Germany
5124	Dorsten	North Rhine-Westphalia	Germany
5125	Dormagen	North Rhine-Westphalia	Germany
5130	Dinslaken	North Rhine-Westphalia	Germany
5131	Dingolfing	Bavaria	Germany
5132	Dillingen an der Donau	Bavaria	Germany
5133	Dillingen	Saarland	Germany
5134	Dillenburg	Hesse	Germany
5135	Dietzenbach	Hesse	Germany
5136	Diepholz	Lower Saxony	Germany
5137	Dieburg	Hesse	Germany
5138	Deutz	North Rhine-Westphalia	Germany
5139	Detmold	North Rhine-Westphalia	Germany
5140	Dessau	Saxony-Anhalt	Germany
5141	Delmenhorst	Lower Saxony	Germany
5142	Delitzsch	Saxony	Germany
5144	Deggendorf	Bavaria	Germany
5145	Datteln	North Rhine-Westphalia	Germany
5146	Darmstadt	Hesse	Germany
5147	Damme	Lower Saxony	Germany
5148	Dahlem	Berlin	Germany
5149	Dachau	Bavaria	Germany
5150	Cuxhaven	Lower Saxony	Germany
5151	Crimmitschau	Saxony	Germany
5153	Cottbus	Brandenburg	Germany
5154	Coswig	Saxony	Germany
5155	Coesfeld	North Rhine-Westphalia	Germany
5156	Coburg	Bavaria	Germany
5157	Cloppenburg	Lower Saxony	Germany
5158	Clausthal-Zellerfeld	Lower Saxony	Germany
5159	Chemnitz	Saxony	Germany
5160	Charlottenburg	Berlin	Germany
5161	Cham	Bavaria	Germany
5162	Celle	Lower Saxony	Germany
5163	Castrop-Rauxel	North Rhine-Westphalia	Germany
5165	Buxtehude	Lower Saxony	Germany
5166	Butzbach	Hesse	Germany
5168	Burscheid	North Rhine-Westphalia	Germany
5169	Burghausen	Bavaria	Germany
5170	Burgdorf	Lower Saxony	Germany
5171	Burg bei Magdeburg	Saxony-Anhalt	Germany
5176	Buckow	Berlin	Germany
5178	Buchholz in der Nordheide	Lower Saxony	Germany
5186	Britz	Berlin	Germany
5187	Brilon	North Rhine-Westphalia	Germany
5190	Bremerhaven	Bremen	Germany
5191	Bremen	Bremen	Germany
5192	Braunschweig	Lower Saxony	Germany
5193	Brandenburg an der Havel	Brandenburg	Germany
5194	Bramsche	Lower Saxony	Germany
5195	Brakel	North Rhine-Westphalia	Germany
5196	Brake (Unterweser)	Lower Saxony	Germany
5198	Bottrop	North Rhine-Westphalia	Germany
5199	Bornheim	North Rhine-Westphalia	Germany
5200	Borna	Saxony	Germany
5201	Borken	North Rhine-Westphalia	Germany
5202	Boppard	Rheinland-Pfalz	Germany
5203	Bonn	North Rhine-Westphalia	Germany
5205	Bogenhausen	Bavaria	Germany
5206	Bochum	North Rhine-Westphalia	Germany
5207	Bocholt	North Rhine-Westphalia	Germany
5209	Bobingen	Bavaria	Germany
5210	Blomberg	North Rhine-Westphalia	Germany
5211	Blieskastel	Saarland	Germany
5212	Blankenburg	Saxony-Anhalt	Germany
5213	Bitterfeld-Wolfen	Saxony	Germany
5214	Bingen am Rhein	Rheinland-Pfalz	Germany
5216	Biesdorf	Berlin	Germany
5217	Bielefeld	North Rhine-Westphalia	Germany
5219	Bexbach	Saarland	Germany
5220	Beverungen	North Rhine-Westphalia	Germany
5221	Bernburg	Saxony-Anhalt	Germany
5222	Bernau bei Berlin	Brandenburg	Germany
5223	Berlin	Berlin	Germany
5224	Bergneustadt	North Rhine-Westphalia	Germany
5225	Bergkamen	North Rhine-Westphalia	Germany
5226	Bergisch Gladbach	North Rhine-Westphalia	Germany
5227	Bergheim	North Rhine-Westphalia	Germany
5228	Bensheim	Hesse	Germany
5229	Bendorf	Rheinland-Pfalz	Germany
5230	Bedburg	North Rhine-Westphalia	Germany
5231	Beckum	North Rhine-Westphalia	Germany
5232	Beckingen	Saarland	Germany
5233	Bayreuth	Bavaria	Germany
5234	Bautzen	Saxony	Germany
5235	Baunatal	Hesse	Germany
5236	Baumschulenweg	Berlin	Germany
5237	Bassum	Lower Saxony	Germany
5238	Bamberg	Bavaria	Germany
5241	Baesweiler	North Rhine-Westphalia	Germany
5242	Bad Zwischenahn	Lower Saxony	Germany
5243	Bad Wildungen	Hesse	Germany
5245	Bad Vilbel	Hesse	Germany
5247	Bad Soden am Taunus	Hesse	Germany
5248	Bad Segeberg	Schleswig-Holstein	Germany
5249	Bad Schwartau	Schleswig-Holstein	Germany
5250	Bad Salzungen	Thuringia	Germany
5251	Bad Salzuflen	North Rhine-Westphalia	Germany
5253	Bad Reichenhall	Bavaria	Germany
5255	Bad Pyrmont	Lower Saxony	Germany
5256	Bad Oldesloe	Schleswig-Holstein	Germany
5257	Bad Oeynhausen	North Rhine-Westphalia	Germany
5258	Bad Neustadt an der Saale	Bavaria	Germany
5259	Bad Neuenahr-Ahrweiler	Rheinland-Pfalz	Germany
5260	Bad Nauheim	Hesse	Germany
5264	Bad Lippspringe	North Rhine-Westphalia	Germany
5265	Bad Langensalza	Thuringia	Germany
5266	Bad Kreuznach	Rheinland-Pfalz	Germany
5267	Bad Kissingen	Bavaria	Germany
5268	Bad Honnef	North Rhine-Westphalia	Germany
5270	Bad Hersfeld	Hesse	Germany
5271	Bad Harzburg	Lower Saxony	Germany
5272	Bad Essen	Lower Saxony	Germany
5275	Bad Driburg	North Rhine-Westphalia	Germany
5276	Bad Berleburg	North Rhine-Westphalia	Germany
5277	Bad Bentheim	Lower Saxony	Germany
5278	Bad Aibling	Bavaria	Germany
5280	Babenhausen	Hesse	Germany
5281	Aurich	Lower Saxony	Germany
5282	Augsburg	Bavaria	Germany
5283	Auerbach	Saxony	Germany
5284	Aue	Saxony	Germany
5285	Attendorn	North Rhine-Westphalia	Germany
5286	Aschersleben	Saxony-Anhalt	Germany
5287	Ascheberg	North Rhine-Westphalia	Germany
5288	Aschaffenburg	Bavaria	Germany
5289	Bad Arolsen	Hesse	Germany
5290	Arnstadt	Thuringia	Germany
5291	Arnsberg	North Rhine-Westphalia	Germany
5292	Apolda	Thuringia	Germany
5293	Ansbach	Bavaria	Germany
5294	Annaberg-Buchholz	Saxony	Germany
5296	Andernach	Rheinland-Pfalz	Germany
5297	Amberg	Bavaria	Germany
5298	Alzey	Rheinland-Pfalz	Germany
5299	Alzenau in Unterfranken	Bavaria	Germany
5300	Altglienicke	Berlin	Germany
5301	Altenburg	Thuringia	Germany
5302	Altena	North Rhine-Westphalia	Germany
5303	Altdorf	Bavaria	Germany
5304	Alsfeld	Hesse	Germany
5305	Alsdorf	North Rhine-Westphalia	Germany
5306	Alfter	North Rhine-Westphalia	Germany
5307	Alfeld	Lower Saxony	Germany
5309	Aichach	Bavaria	Germany
5310	Ahrensburg	Schleswig-Holstein	Germany
5311	Ahlen	North Rhine-Westphalia	Germany
5312	Ahaus	North Rhine-Westphalia	Germany
5313	Adlershof	Berlin	Germany
5314	Achim	Lower Saxony	Germany
5317	Vellmar	Hesse	Germany
5318	Henstedt-Ulzburg	Schleswig-Holstein	Germany
5319	Aachen	North Rhine-Westphalia	Germany
5321	Riedstadt	Hesse	Germany
5325	Rodgau	Hesse	Germany
5326	Gropiusstadt	Berlin	Germany
5327	Seeheim-Jugenheim	Hesse	Germany
5328	Charlottenburg-Nord	Berlin	Germany
5329	Mitte	Berlin	Germany
5330	Spremberg	Brandenburg	Germany
5332	Altstadt Sud	North Rhine-Westphalia	Germany
5333	Altstadt Nord	North Rhine-Westphalia	Germany
5334	Neuehrenfeld	North Rhine-Westphalia	Germany
5335	Bilderstoeckchen	North Rhine-Westphalia	Germany
5337	Bochum-Hordel	North Rhine-Westphalia	Germany
5338	St. Pauli	Hamburg	Germany
5339	Eidelstedt	Hamburg	Germany
5340	Halle Neustadt	Saxony-Anhalt	Germany
5341	Bergedorf	Hamburg	Germany
5342	Spandau	Berlin	Germany
5344	Berlin Treptow	Berlin	Germany
5345	Niederrad	Hesse	Germany
5346	Haselbachtal	Saxony	Germany
5347	Barmbek-Nord	Hamburg	Germany
5348	Farmsen-Berne	Hamburg	Germany
5349	Falkenhagener Feld	Berlin	Germany
5352	Fennpfuhl	Berlin	Germany
5353	Hamburg-Nord	Hamburg	Germany
5354	Burg Unter-Falkenstein	Bavaria	Germany
5355	Neustadt/Nord	North Rhine-Westphalia	Germany
5357	Kalk	North Rhine-Westphalia	Germany
5359	Gartenstadt	Rheinland-Pfalz	Germany
5360	Tadjoura	Tadjourah	Djibouti
5361	Obock	Obock	Djibouti
5362	Djibouti	Djibouti	Djibouti
5506	Sidi Abdelli	Tlemcen	Algeria
5509	Sedrata	Souk Ahras	Algeria
5511	Sebdou	Tlemcen	Algeria
5512	Saoula	Tipaza	Algeria
5515	Rouissat	Ouargla	Algeria
5516	Rouiba	Alger	Algeria
5517	Rouached	Mila	Algeria
5518	Robbah	El Oued	Algeria
5519	Remchi	Tlemcen	Algeria
5520	Relizane	Relizane	Algeria
5521	Reguiba	El Oued	Algeria
5523	Reggane	Adrar	Algeria
5526	Oum el Bouaghi	Oum el Bouaghi	Algeria
5527	Ouled Mimoun	Tlemcen	Algeria
5528	Oued Sly	Chlef	Algeria
5529	Oued Rhiou	Relizane	Algeria
5530	Oued Fodda	Chlef	Algeria
5531	Oued el Alleug	Tipaza	Algeria
5532	Oued el Abtal	Mascara	Algeria
5533	Ouargla	Ouargla	Algeria
5534	Oran	Oran	Algeria
5535	Nedroma	Tlemcen	Algeria
5536	Naciria	Boumerdes	Algeria
5894	Akhmim	Suhaj	Egypt
5896	Ad Dilinjat	Al Bu?ayrah	Egypt
5897	Abu Tij	Asyut	Egypt
5898	Abu Qurqas	Al Minya	Egypt
5899	Abu Kabir	Eastern Province	Egypt
5900	Abu al Matamir	Al Bu?ayrah	Egypt
5901	Abnub	Asyut	Egypt
5902	Az Zarqa	Dumyat	Egypt
5903	Ain Sukhna	As Suways	Egypt
5904	Smara	Oued Ed-Dahab-Lagouira	Western Sahara
5906	Dakhla	Oued Ed-Dahab-Lagouira	Western Sahara
5907	Massawa	Northern Red Sea Region	Eritrea
5908	Keren	Anseba	Eritrea
5909	Barentu	Gash Barka	Eritrea
5912	Mendefera	Debub	Eritrea
5913	Zubia	Andalusia	Spain
5914	Zafra	Extremadura	Spain
5915	Yecla	Murcia	Spain
5916	Villena	Valencia	Spain
5917	Villarrobledo	Castille-La Mancha	Spain
5918	Vila-real	Valencia	Spain
5919	Villanueva de la Serena	Extremadura	Spain
5920	Villajoyosa	Valencia	Spain
5923	Valencia	Valencia	Spain
5925	Utrera	Andalusia	Spain
5926	Ubrique	Andalusia	Spain
5928	Totana	Murcia	Spain
5929	Torrox	Andalusia	Spain
5930	Torrevieja	Valencia	Spain
5931	Torre-Pacheco	Murcia	Spain
5932	Torrent	Valencia	Spain
5933	Torremolinos	Andalusia	Spain
5934	Tomelloso	Castille-La Mancha	Spain
5935	Tomares	Andalusia	Spain
5936	Toledo	Castille-La Mancha	Spain
5938	Telde	Canary Islands	Spain
5939	Teguise	Canary Islands	Spain
5940	Tarifa	Andalusia	Spain
5941	Talavera de la Reina	Castille-La Mancha	Spain
5942	Tacoronte	Canary Islands	Spain
5943	Tavernes de la Valldigna	Valencia	Spain
5944	Sueca	Valencia	Spain
5945	Silla	Valencia	Spain
5946	Sevilla	Andalusia	Spain
5947	San Vicent del Raspeig	Valencia	Spain
5948	Santomera	Murcia	Spain
5949	Santa Pola	Valencia	Spain
5953	Santa Cruz de Tenerife	Canary Islands	Spain
5954	Santa Cruz de la Palma	Canary Islands	Spain
5956	San Roque	Andalusia	Spain
5957	San Pedro del Pinatar	Murcia	Spain
5959	San Miguel De Abona	Canary Islands	Spain
5961	San Juan de Aznalfarache	Andalusia	Spain
5962	San Juan de Alicante	Valencia	Spain
5963	San Javier	Murcia	Spain
5964	San Isidro	Canary Islands	Spain
5965	San Fernando	Andalusia	Spain
5966	La Laguna	Canary Islands	Spain
5969	Sant Antoni de Portmany	Balearic Islands	Spain
5970	Sagunto	Valencia	Spain
5971	Rota	Andalusia	Spain
5972	Roquetas de Mar	Andalusia	Spain
5973	Ronda	Andalusia	Spain
5974	Rojales	Valencia	Spain
5976	Ribarroja	Valencia	Spain
5977	Requena	Valencia	Spain
5978	Realejo Alto	Canary Islands	Spain
5980	Puerto Real	Andalusia	Spain
5981	Puertollano	Castille-La Mancha	Spain
5982	Puerto del Rosario	Canary Islands	Spain
5983	Puerto de la Cruz	Canary Islands	Spain
5984	Puente-Genil	Andalusia	Spain
5985	La Pobla de Vallbona	Valencia	Spain
5987	Pozoblanco	Andalusia	Spain
5989	Pilar de la Horadada	Valencia	Spain
5990	Picassent	Valencia	Spain
5991	Paterna	Valencia	Spain
5992	Palma	Balearic Islands	Spain
5995	Paiporta	Valencia	Spain
5996	Osuna	Andalusia	Spain
5997	Orihuela	Valencia	Spain
5998	Ontinyent	Valencia	Spain
5999	Onda	Valencia	Spain
6000	Oliva	Valencia	Spain
6001	Novelda	Valencia	Spain
6003	Nerja	Andalusia	Spain
6004	Navalmoral de la Mata	Extremadura	Spain
6005	Murcia	Murcia	Spain
6006	Mula	Murcia	Spain
6007	Muchamiel	Valencia	Spain
6008	Motril	Andalusia	Spain
6010	Montilla	Andalusia	Spain
6011	Montijo	Extremadura	Spain
6012	Moncada	Valencia	Spain
6013	Molina de Segura	Murcia	Spain
6014	Moguer	Andalusia	Spain
6016	Mislata	Valencia	Spain
6017	Mijas	Andalusia	Spain
6019	Melilla	Melilla	Spain
6021	Maspalomas	Canary Islands	Spain
6022	Massamagrell	Valencia	Spain
6023	Martos	Andalusia	Spain
6025	Marchena	Andalusia	Spain
6026	Marbella	Andalusia	Spain
6027	Maracena	Andalusia	Spain
6028	Manzanares	Castille-La Mancha	Spain
6029	Manises	Valencia	Spain
6030	Manacor	Balearic Islands	Spain
6032	Mairena del Aljarafe	Andalusia	Spain
6033	Mairena del Alcor	Andalusia	Spain
6035	Lucena	Andalusia	Spain
6036	Los Palacios y Villafranca	Andalusia	Spain
6037	Los Llanos de Aridane	Canary Islands	Spain
6038	Los Barrios	Andalusia	Spain
6040	Lorca	Murcia	Spain
6042	Loja	Andalusia	Spain
6043	Llucmajor	Balearic Islands	Spain
6045	Linares	Andalusia	Spain
6046	Lepe	Andalusia	Spain
6047	Lebrija	Andalusia	Spain
6049	Las Torres de Cotillas	Murcia	Spain
6050	Las Palmas de Gran Canaria	Canary Islands	Spain
6051	La Solana	Castille-La Mancha	Spain
6052	Las Cabezas de San Juan	Andalusia	Spain
6053	La Roda	Castille-La Mancha	Spain
6054	La Rinconada	Andalusia	Spain
6055	La Orotava	Canary Islands	Spain
6056	La Oliva	Canary Islands	Spain
6057	la Nucia	Valencia	Spain
6353	Hortaleza	Madrid	Spain
6354	Hernani	Basque Country	Spain
6355	Gernika-Lumo	Basque Country	Spain
6356	Getxo	Basque Country	Spain
6357	Guadalajara	Castille-La Mancha	Spain
6358	Granollers	Catalonia	Spain
6361	Getafe	Madrid	Spain
6362	Girona	Catalonia	Spain
6364	Galdakao	Basque Country	Spain
6365	Galapagar	Madrid	Spain
6366	Hondarribia	Basque Country	Spain
6367	Fuenlabrada	Madrid	Spain
6368	Figueras	Asturias	Spain
6369	Figueres	Catalonia	Spain
6370	Esplugues de Llobregat	Catalonia	Spain
6371	Esparreguera	Catalonia	Spain
6372	Ermua	Basque Country	Spain
6373	Erandio	Basque Country	Spain
6374	El Prat de Llobregat	Catalonia	Spain
6375	Ferrol	Galicia	Spain
6376	El Astillero	Cantabria	Spain
6377	Ejea de los Caballeros	Aragon	Spain
6378	Eibar	Basque Country	Spain
6379	Durango	Basque Country	Spain
6380	Culleredo	Galicia	Spain
6381	Cuenca	Castille-La Mancha	Spain
6382	Coslada	Madrid	Spain
6384	Colmenar Viejo	Madrid	Spain
6385	Collado-Villalba	Madrid	Spain
6386	Ciudad Lineal	Madrid	Spain
6387	Ciutadella	Balearic Islands	Spain
6388	Ciempozuelos	Madrid	Spain
6390	Castro-Urdiales	Cantabria	Spain
6391	Castelldefels	Catalonia	Spain
6393	Cardedeu	Catalonia	Spain
6394	Carballo	Galicia	Spain
6395	Canovelles	Catalonia	Spain
6396	Cangas do Morrazo	Galicia	Spain
6397	Cambrils	Catalonia	Spain
6398	Cambre	Galicia	Spain
6399	Camargo	Cantabria	Spain
6400	Calella	Catalonia	Spain
6401	Caldes de Montbui	Catalonia	Spain
6402	Calatayud	Aragon	Spain
6403	Calahorra	La Rioja	Spain
6404	Calafell	Catalonia	Spain
6405	Burlata	Navarre	Spain
6407	Boiro	Galicia	Spain
6408	Boadilla del Monte	Madrid	Spain
6409	Blanes	Catalonia	Spain
6410	Bilbao	Basque Country	Spain
6411	Bermeo	Basque Country	Spain
6412	Berga	Catalonia	Spain
6417	Barcelona	Catalonia	Spain
6418	Barbastro	Aragon	Spain
6420	Barajas de Madrid	Madrid	Spain
6421	Banyoles	Catalonia	Spain
6422	Balaguer	Catalonia	Spain
6423	Badalona	Catalonia	Spain
6424	Azuqueca de Henares	Castille-La Mancha	Spain
6427	Arteixo	Galicia	Spain
6428	Arganda	Madrid	Spain
6429	Aranjuez	Madrid	Spain
6431	Amposta	Catalonia	Spain
6432	Amorebieta	Basque Country	Spain
6434	Algorta	Basque Country	Spain
6435	Algete	Madrid	Spain
6437	Alcobendas	Madrid	Spain
6440	Nou Barris	Catalonia	Spain
6442	Playa del Ingles	Canary Islands	Spain
6443	Puerto del Carmen	Canary Islands	Spain
6444	Ceuta	Ceuta	Spain
6445	Moncloa-Aravaca	Madrid	Spain
6446	Eixample	Catalonia	Spain
6447	les Corts	Catalonia	Spain
6452	Ciutat Vella	Catalonia	Spain
6453	Arganzuela	Madrid	Spain
6454	San Blas	Madrid	Spain
6455	Latina	Madrid	Spain
6456	Usera	Madrid	Spain
6457	Salamanca	Madrid	Spain
6459	Carabanchel	Madrid	Spain
6460	City Center	Madrid	Spain
6461	Retiro	Madrid	Spain
22431	Echo Park	California	United States
5	Ras al-Khaimah	Ras al Khaymah	United Arab Emirates
6	Khawr Fakkan	Ash Shariqah	United Arab Emirates
7	Dubai	Dubai	United Arab Emirates
8	Dibba Al-Fujairah	Al Fujayrah	United Arab Emirates
9	Dibba Al-Hisn	Al Fujayrah	United Arab Emirates
10	Sharjah	Ash Shariqah	United Arab Emirates
11	Ar Ruways	Abu Dhabi	United Arab Emirates
12	Al Fujayrah	Al Fujayrah	United Arab Emirates
13	Al Ain	Abu Dhabi	United Arab Emirates
14	Ajman	Ajman	United Arab Emirates
15	Adh Dhayd	Ash Shariqah	United Arab Emirates
16	Abu Dhabi	Abu Dhabi	United Arab Emirates
17	Zaranj	Nimruz	Afghanistan
18	Taloqan	Takhar	Afghanistan
19	Shin?an?	Herat	Afghanistan
20	Shibirghan	Jowzjan	Afghanistan
21	Shahrak	Ghowr	Afghanistan
22	Sar-e Pul	Sar-e Pol	Afghanistan
23	Sang-e Charak	Sar-e Pol	Afghanistan
24	Aibak	Samangan	Afghanistan
25	Rustaq	Takhar	Afghanistan
26	Qarqin	Jowzjan	Afghanistan
27	Qarawul	Kunduz	Afghanistan
28	Pul-e Khumri	Wilayat-e Baghlan	Afghanistan
29	Paghman	Kabul	Afghanistan
30	Nahrin	Wilayat-e Baghlan	Afghanistan
31	Maymana	Faryab	Afghanistan
32	Mehtar Lam	Laghman	Afghanistan
33	Mazar-e Sharif	Balkh	Afghanistan
34	Lashkar Gah	Helmand	Afghanistan
35	Kushk	Herat	Afghanistan
36	Kunduz	Kunduz	Afghanistan
37	Khost	Khowst	Afghanistan
38	Khulm	Balkh	Afghanistan
39	Khash	Nimruz	Afghanistan
40	Khanabad	Kunduz	Afghanistan
41	Karukh	Herat	Afghanistan
42	Kandahar	Kandahar	Afghanistan
43	Kabul	Kabul	Afghanistan
44	Jalalabad	Nangarhar	Afghanistan
45	Jabal os Saraj	Parvan	Afghanistan
46	Herat	Herat	Afghanistan
47	Ghormach	Badghis	Afghanistan
48	Ghazni	Ghazni	Afghanistan
49	Gereshk	Helmand	Afghanistan
50	Gardez	Paktia	Afghanistan
51	Fayzabad	Badakhshan	Afghanistan
52	Farah	Farah	Afghanistan
53	Kafir Qala	Herat	Afghanistan
54	Charikar	Parvan	Afghanistan
55	Baraki Barak	Lowgar	Afghanistan
56	Bamyan	Bamian	Afghanistan
57	Balkh	Balkh	Afghanistan
58	Baghlan	Wilayat-e Baghlan	Afghanistan
59	Art Khwajah	Takhar	Afghanistan
60	Asmar	Konar	Afghanistan
61	Asadabad	Konar	Afghanistan
62	Andkhoy	Faryab	Afghanistan
63	Bazarak	Panjshir	Afghanistan
64	Markaz-e Woluswali-ye Achin	Nangarhar	Afghanistan
66	The Valley	N/A	Anguilla
71	Elbasan	Elbasan	Albania
76	Patos Fshat	Fier	Albania
84	Fier	Fier	Albania
86	Berat	Berat	Albania
87	Kapan	Syunik Province	Armenia
88	Goris	Syunik Province	Armenia
90	Artashat	Ararat Province	Armenia
91	Ararat	Ararat Province	Armenia
92	Yerevan	Yerevan	Armenia
93	Ejmiatsin	Armavir Province	Armenia
94	Spitak	Lori Province	Armenia
95	Sevan	Gegharkunik Province	Armenia
96	Masis	Ararat Province	Armenia
97	Vanadzor	Lori Province	Armenia
98	Gavarr	Gegharkunik Province	Armenia
99	Hrazdan	Kotayk Province	Armenia
100	Armavir	Armavir Province	Armenia
101	Gyumri	Shirak Province	Armenia
102	Ashtarak	Aragatsotn Province	Armenia
103	Abovyan	Kotayk Province	Armenia
104	Saurimo	Lunda Sul	Angola
105	Lucapa	Lunda Norte	Angola
106	Luau	Moxico	Angola
108	Soio	Zaire	Angola
109	Nzeto	Zaire	Angola
111	Mbanza Congo	Zaire	Angola
112	Malanje	Malanje	Angola
113	Luanda	Luanda	Angola
114	Caxito	Bengo	Angola
115	Cabinda	Cabinda	Angola
116	Sumbe	Cuanza Sul	Angola
117	Namibe	Namibe	Angola
118	Menongue	Cuando Cubango	Angola
119	Luena	Moxico	Angola
121	Longonjo	Huambo	Angola
122	Lobito	Benguela	Angola
124	Huambo	Huambo	Angola
125	Catumbela	Benguela	Angola
130	Benguela	Benguela	Angola
132	Villa Ocampo	Santa Fe	Argentina
133	Villa Lugano	Buenos Aires F.D.	Argentina
134	Villaguay	Entre Rios	Argentina
135	Villa Gesell	Buenos Aires	Argentina
136	Tigre	Buenos Aires	Argentina
137	Tandil	Buenos Aires	Argentina
138	San Vicente	Misiones	Argentina
140	Santa Elena	Entre Rios	Argentina
141	San Pedro	Misiones	Argentina
142	San Luis del Palmar	Corrientes	Argentina
143	San Lorenzo	Corrientes	Argentina
144	San Javier	Santa Fe	Argentina
145	San Isidro	Buenos Aires	Argentina
146	Saladas	Corrientes	Argentina
147	Retiro	Buenos Aires F.D.	Argentina
148	Resistencia	Chaco	Argentina
149	Reconquista	Santa Fe	Argentina
150	Quilmes	Buenos Aires	Argentina
151	Puerto Rico	Misiones	Argentina
153	Puerto Esperanza	Misiones	Argentina
154	Puerto Eldorado	Misiones	Argentina
155	Posadas	Misiones	Argentina
156	Pontevedra	Buenos Aires	Argentina
158	Paso de los Libres	Corrientes	Argentina
160	Necochea	Buenos Aires	Argentina
162	Monte Caseros	Corrientes	Argentina
163	Montecarlo	Misiones	Argentina
164	Mercedes	Buenos Aires	Argentina
165	Mercedes	Corrientes	Argentina
166	Mar del Plata	Buenos Aires	Argentina
168	La Plata	Buenos Aires	Argentina
169	La Paz	Entre Rios	Argentina
172	Gualeguay	Entre Rios	Argentina
173	Goya	Corrientes	Argentina
177	Formosa	Formosa	Argentina
178	Fontana	Chaco	Argentina
179	Federal	Entre Rios	Argentina
180	Esquina	Corrientes	Argentina
181	El Soberbio	Misiones	Argentina
182	Dolores	Buenos Aires	Argentina
184	Corrientes	Corrientes	Argentina
185	Concordia	Entre Rios	Argentina
187	Colegiales	Buenos Aires F.D.	Argentina
189	Campana	Buenos Aires	Argentina
190	Buenos Aires	Buenos Aires F.D.	Argentina
191	Barranqueras	Chaco	Argentina
192	Azul	Buenos Aires	Argentina
193	Avellaneda	Santa Fe	Argentina
195	Zapala	Neuquen	Argentina
197	Villa Regina	Rio Negro	Argentina
198	Villa Paula de Sarmiento	San Juan	Argentina
199	Villa Nueva	Cordoba	Argentina
201	Villa Dolores	Cordoba	Argentina
203	Villa Carlos Paz	Cordoba	Argentina
205	Villa Allende	Cordoba	Argentina
206	Viedma	Rio Negro	Argentina
207	Victoria	Entre Rios	Argentina
208	Vera	Santa Fe	Argentina
209	Venado Tuerto	Santa Fe	Argentina
210	Veinticinco de Mayo	Buenos Aires	Argentina
211	Ushuaia	Tierra del Fuego	Argentina
212	Unquillo	Cordoba	Argentina
213	Tres Isletas	Chaco	Argentina
214	Tres Arroyos	Buenos Aires	Argentina
215	Trelew	Chubut	Argentina
217	Tartagal	Salta	Argentina
219	Sunchales	Santa Fe	Argentina
221	Santiago del Estero	Santiago del Estero	Argentina
222	Santa Rosa	La Pampa	Argentina
224	Santa Fe de la Vera Cruz	Santa Fe	Argentina
225	San Salvador de Jujuy	Jujuy	Argentina
227	San Rafael	Mendoza	Argentina
228	San Pedro	Jujuy	Argentina
233	San Luis	San Luis	Argentina
234	San Justo	Santa Fe	Argentina
235	San Juan	San Juan	Argentina
237	San Jorge	Santa Fe	Argentina
238	San Francisco	Cordoba	Argentina
239	San Fernando del Valle de Catamarca	Catamarca	Argentina
240	San Antonio Oeste	Rio Negro	Argentina
241	Salta	Salta	Argentina
242	Rufino	Santa Fe	Argentina
243	Rosario	Santa Fe	Argentina
249	Rawson	Chubut	Argentina
250	Rafaela	Santa Fe	Argentina
251	Quitilipi	Chaco	Argentina
252	Punta Alta	Buenos Aires	Argentina
253	Puerto Madryn	Chubut	Argentina
255	Pocito	San Juan	Argentina
256	Plottier	Neuquen	Argentina
257	Pergamino	Buenos Aires	Argentina
262	Nueve de Julio	Buenos Aires	Argentina
264	Morteros	Cordoba	Argentina
266	Mendoza	Mendoza	Argentina
268	Machagai	Chaco	Argentina
269	Lincoln	Buenos Aires	Argentina
272	La Rioja	La Rioja	Argentina
273	La Falda	Cordoba	Argentina
274	La Calera	Cordoba	Argentina
275	Laboulaye	Cordoba	Argentina
279	Granadero Baigorria	Santa Fe	Argentina
281	General Roca	Rio Negro	Argentina
282	General Pinedo	Chaco	Argentina
283	General Pico	La Pampa	Argentina
284	General Enrique Mosconi	Salta	Argentina
286	Firmat	Santa Fe	Argentina
288	Esquel	Chubut	Argentina
289	Esperanza	Santa Fe	Argentina
291	Embalse	Cordoba	Argentina
293	Diamante	Entre Rios	Argentina
296	Cruz del Eje	Cordoba	Argentina
297	Crespo	Entre Rios	Argentina
300	Coronda	Santa Fe	Argentina
302	Comodoro Rivadavia	Chubut	Argentina
303	Cipolletti	Rio Negro	Argentina
304	Cinco Saltos	Rio Negro	Argentina
305	Chivilcoy	Buenos Aires	Argentina
306	Chimbas	San Juan	Argentina
307	Chilecito	La Rioja	Argentina
308	Charata	Chaco	Argentina
309	Chacabuco	Buenos Aires	Argentina
310	Centenario	Neuquen	Argentina
311	Caucete	San Juan	Argentina
312	Catriel	Rio Negro	Argentina
313	Castelli	Chaco	Argentina
314	Casilda	Santa Fe	Argentina
318	Caleta Olivia	Santa Cruz	Argentina
319	Bell Ville	Cordoba	Argentina
322	Arroyo Seco	Santa Fe	Argentina
323	Arroyito	Cordoba	Argentina
325	Alta Gracia	Cordoba	Argentina
326	Allen	Rio Negro	Argentina
330	Villa Santa Rita	Buenos Aires F.D.	Argentina
331	Villa Mercedes	San Luis	Argentina
332	San Carlos de Bariloche	Rio Negro	Argentina
334	Pago Pago	Eastern District	American Samoa
335	Wolfsberg	Carinthia	Austria
336	Wiener Neustadt	Lower Austria	Austria
337	Vienna	Vienna	Austria
338	Wels	Upper Austria	Austria
339	Weinzierl bei Krems	Lower Austria	Austria
340	Villach	Carinthia	Austria
341	Traun	Upper Austria	Austria
342	Traiskirchen	Lower Austria	Austria
343	Ternitz	Lower Austria	Austria
344	Steyr	Upper Austria	Austria
345	Spittal an der Drau	Carinthia	Austria
346	Schwechat	Lower Austria	Austria
348	Salzburg	Salzburg	Austria
349	Saalfelden am Steinernen Meer	Salzburg	Austria
351	Lustenau	Vorarlberg	Austria
352	Linz	Upper Austria	Austria
353	Leonding	Upper Austria	Austria
354	Leoben	Styria	Austria
355	Kufstein	Tyrol	Austria
356	Krems an der Donau	Lower Austria	Austria
357	Klosterneuburg	Lower Austria	Austria
359	Kapfenberg	Styria	Austria
360	Innsbruck	Tyrol	Austria
361	Hallein	Salzburg	Austria
362	Graz	Styria	Austria
363	Feldkirch	Vorarlberg	Austria
364	Dornbirn	Vorarlberg	Austria
365	Bregenz	Vorarlberg	Austria
366	Braunau am Inn	Upper Austria	Austria
367	Baden	Lower Austria	Austria
368	Amstetten	Lower Austria	Austria
369	Ansfelden	Salzburg	Austria
370	Whyalla	South Australia	Australia
371	Rockingham	Western Australia	Australia
372	Prospect	South Australia	Australia
373	Port Hedland	Western Australia	Australia
374	Perth	Western Australia	Australia
375	Murray Bridge	South Australia	Australia
376	Mount Isa	Queensland	Australia
377	Morphett Vale	South Australia	Australia
378	Mandurah	Western Australia	Australia
379	Kwinana	Western Australia	Australia
380	Kalgoorlie	Western Australia	Australia
381	Gosnells	Western Australia	Australia
382	Geraldton	Western Australia	Australia
383	Gawler	South Australia	Australia
384	Fremantle	Western Australia	Australia
385	Darwin	Northern Territory	Australia
386	Busselton	Western Australia	Australia
387	Bunbury	Western Australia	Australia
388	Armadale	Western Australia	Australia
389	Alice Springs	Northern Territory	Australia
390	Albany	Western Australia	Australia
391	Adelaide	South Australia	Australia
392	Woodridge	Queensland	Australia
393	Wodonga	Victoria	Australia
394	Werribee	Victoria	Australia
395	Warrnambool	Victoria	Australia
396	Wantirna South	Victoria	Australia
397	Wangaratta	Victoria	Australia
398	Wagga Wagga	New South Wales	Australia
399	Traralgon	Victoria	Australia
400	Townsville	Queensland	Australia
401	Toowoomba	Queensland	Australia
402	Thornbury	Victoria	Australia
403	Thomastown	Victoria	Australia
404	Tarneit	Victoria	Australia
405	Taree	New South Wales	Australia
406	Tamworth	New South Wales	Australia
407	Sydney	New South Wales	Australia
408	Surfers Paradise	Queensland	Australia
409	Sunnybank	Queensland	Australia
410	Sunbury	Victoria	Australia
411	Port Stephens	New South Wales	Australia
412	Springvale	Victoria	Australia
413	Southport	Queensland	Australia
414	South Grafton	New South Wales	Australia
415	Shepparton	Victoria	Australia
416	Seaford	Victoria	Australia
417	Saint Kilda	Victoria	Australia
418	Saint Albans	Victoria	Australia
419	Rowville	Victoria	Australia
420	Rockhampton	Queensland	Australia
421	Richmond	Victoria	Australia
422	Reservoir	Victoria	Australia
423	Queanbeyan	New South Wales	Australia
424	Quakers Hill	New South Wales	Australia
425	Preston	Victoria	Australia
426	Port Macquarie	New South Wales	Australia
427	Point Cook	Victoria	Australia
428	Pakenham South	Victoria	Australia
429	Orange	New South Wales	Australia
430	Nowra	New South Wales	Australia
431	Northcote	Victoria	Australia
432	Noble Park	Victoria	Australia
433	Newcastle	New South Wales	Australia
434	Nerang	Queensland	Australia
435	Narre Warren	Victoria	Australia
436	Narangba	Queensland	Australia
437	Mulgrave	Victoria	Australia
438	Mount Martha	Victoria	Australia
439	Mount Gambier	South Australia	Australia
440	Mount Eliza	Victoria	Australia
441	Mosman	New South Wales	Australia
442	Mornington	Victoria	Australia
443	Morayfield	Queensland	Australia
444	Moe	Victoria	Australia
445	Mill Park	Victoria	Australia
446	Mildura	Victoria	Australia
447	Melton	Victoria	Australia
448	Melbourne	Victoria	Australia
449	Maryborough	Queensland	Australia
450	Marrickville	New South Wales	Australia
451	Maroubra	New South Wales	Australia
452	Maitland	New South Wales	Australia
453	Mackay	Queensland	Australia
454	Liverpool	New South Wales	Australia
455	Lismore	New South Wales	Australia
456	Lilydale	Victoria	Australia
457	Launceston	Tasmania	Australia
458	Lara	Victoria	Australia
459	Langwarrin	Victoria	Australia
460	Lalor	Victoria	Australia
461	Keysborough	Victoria	Australia
462	Kew	Victoria	Australia
463	Katoomba	New South Wales	Australia
464	Hornsby	New South Wales	Australia
465	Hobart	Tasmania	Australia
466	Hawthorn South	Victoria	Australia
467	Hampton Park	Victoria	Australia
468	Griffith	New South Wales	Australia
469	Greensborough	Victoria	Australia
470	Granville	New South Wales	Australia
471	Goulburn	New South Wales	Australia
472	Gold Coast	Queensland	Australia
473	Glenroy	Victoria	Australia
474	Glenferrie	Victoria	Australia
475	Gladstone	Queensland	Australia
476	Geelong	Victoria	Australia
477	Frankston East	Victoria	Australia
478	Frankston	Victoria	Australia
479	Forster	New South Wales	Australia
480	Essendon	Victoria	Australia
481	Epping	Victoria	Australia
482	Epping	New South Wales	Australia
483	Engadine	New South Wales	Australia
484	Eltham	Victoria	Australia
485	Echuca	Victoria	Australia
486	Earlwood	New South Wales	Australia
487	Dubbo	New South Wales	Australia
488	Doncaster East	Victoria	Australia
489	Doncaster	Victoria	Australia
490	Devonport	Tasmania	Australia
491	Deer Park	Victoria	Australia
492	Deception Bay	Queensland	Australia
493	Dandenong	Victoria	Australia
494	Cronulla	New South Wales	Australia
495	Cranbourne	Victoria	Australia
496	Cranbourne	Victoria	Australia
497	Craigieburn	Victoria	Australia
498	Coffs Harbour	New South Wales	Australia
499	Coburg	Victoria	Australia
500	Clayton	Victoria	Australia
501	Wollongong	New South Wales	Australia
502	Cessnock	New South Wales	Australia
503	Castle Hill	New South Wales	Australia
504	Carrum Downs	Victoria	Australia
505	Carnegie	Victoria	Australia
506	Carlingford	New South Wales	Australia
507	Caringbah	New South Wales	Australia
508	Canberra	Australian Capital Territory	Australia
509	Camberwell	Victoria	Australia
510	Caloundra	Queensland	Australia
511	Cairns	Queensland	Australia
512	Caboolture	Queensland	Australia
513	Burnie	Tasmania	Australia
514	Bundaberg	Queensland	Australia
515	Buderim	Queensland	Australia
516	Brunswick	Victoria	Australia
517	Broken Hill	New South Wales	Australia
518	Brisbane	Queensland	Australia
519	Boronia	Victoria	Australia
520	Blacktown	New South Wales	Australia
521	Berwick	Victoria	Australia
522	Bendigo	Victoria	Australia
523	Baulkham Hills	New South Wales	Australia
524	Bathurst	New South Wales	Australia
525	Banora Point	New South Wales	Australia
526	Bankstown	New South Wales	Australia
527	Ballarat	Victoria	Australia
528	Auburn	New South Wales	Australia
529	Ashfield	New South Wales	Australia
530	Armidale	New South Wales	Australia
531	Albury	New South Wales	Australia
532	South Brisbane	Queensland	Australia
533	Cheltenham	Victoria	Australia
534	Randwick	New South Wales	Australia
535	Dee Why	New South Wales	Australia
536	Umina	New South Wales	Australia
537	Palmerston	Northern Territory	Australia
538	Bracken Ridge	Queensland	Australia
539	North Ryde	New South Wales	Australia
540	Hoppers Crossing	Victoria	Australia
541	Logan City	Queensland	Australia
542	Carindale	Queensland	Australia
543	Paramatta	New South Wales	Australia
544	Ferntree Gully	Victoria	Australia
545	City of Parramatta	New South Wales	Australia
546	Adelaide Hills	South Australia	Australia
547	Canning Vale	Western Australia	Australia
548	Glenmore Park	New South Wales	Australia
549	Glen Iris	Victoria	Australia
550	Balwyn North	Victoria	Australia
551	Carnegie	Victoria	Australia
552	Malvern East	Victoria	Australia
553	Brighton East	Victoria	Australia
554	Booval	Queensland	Australia
555	St Albans	Victoria	Australia
556	Endeavour Hills	Victoria	Australia
557	Clayton	Victoria	Australia
558	Taylors Lakes	Victoria	Australia
559	Roxburgh Park	Victoria	Australia
560	Wyndham Vale	Victoria	Australia
561	Willetton	Western Australia	Australia
562	Thornbury	Victoria	Australia
563	Thornlie	Western Australia	Australia
564	Hillside	Victoria	Australia
565	Bundoora	Victoria	Australia
566	Forest Lake	Queensland	Australia
567	Sunnybank Hills	Queensland	Australia
568	Narre Warren South	Victoria	Australia
569	Dandenong North	Victoria	Australia
570	Frankston South	Victoria	Australia
571	Sunshine West	Victoria	Australia
572	Altona Meadows	Victoria	Australia
573	West Pennant	New South Wales	Australia
574	Oranjestad	N/A	Aruba
575	Babijn	N/A	Aruba
576	Angochi	N/A	Aruba
577	Mariehamn	Mariehamns stad	Aland Islands
578	Xankandi	Xank?ndi	Azerbaijan
579	?hm?db?yli	Saatli	Azerbaijan
580	Shushi	Susa	Azerbaijan
581	Salyan	Salyan	Azerbaijan
582	Saatli	Saatli	Azerbaijan
584	Nakhchivan	Nakhichevan	Azerbaijan
585	Lankaran	L?nk?ran	Azerbaijan
586	Imishli	Imisli	Azerbaijan
588	Dzhalilabad	Jalilabad	Azerbaijan
589	Pushkino	Bil?suvar	Azerbaijan
590	Beylagan	Beyl?qan	Azerbaijan
591	Astara	Astara	Azerbaijan
592	Sirvan	Shirvan	Azerbaijan
593	Agdam	Agdam	Azerbaijan
594	Zaqatala	Zaqatala	Azerbaijan
595	Zabrat	Baki	Azerbaijan
596	Yevlakh	Yevlax City	Azerbaijan
597	Yelenendorf	Goygol Rayon	Azerbaijan
599	Ujar	Ucar	Azerbaijan
600	Terter	T?rt?r	Azerbaijan
601	Sumqayit	Sumqayit	Azerbaijan
603	Shamkhor	S?mkir	Azerbaijan
604	Shamakhi	Samaxi	Azerbaijan
605	Sheki	Shaki City	Azerbaijan
607	Sabirabad	Sabirabad	Azerbaijan
608	Qusar	Qusar	Azerbaijan
609	Quba	Quba	Azerbaijan
610	Haciqabul	Haciqabul	Azerbaijan
611	Qazax	Qazax	Azerbaijan
612	Haci Zeynalabdin	Sumqayit	Azerbaijan
613	Mingelchaur	Ming?cevir	Azerbaijan
614	Mastaga	Baki	Azerbaijan
615	Mardakan	Baki	Azerbaijan
618	Khirdalan	Abseron	Azerbaijan
619	Yeni Suraxani	Baki	Azerbaijan
622	Ganja	G?nc?	Azerbaijan
623	Divichibazar	Shabran	Azerbaijan
624	Buzovna	Baki	Azerbaijan
625	Biny Selo	Baki	Azerbaijan
626	Barda	B?rd?	Azerbaijan
627	Bilajari	Baki	Azerbaijan
628	Baku	Baki	Azerbaijan
629	Amirdzhan	Baki	Azerbaijan
630	Aghsu	Agsu	Azerbaijan
631	Agdas	Agdas	Azerbaijan
632	Agdzhabedy	Agcab?di	Azerbaijan
633	Bakixanov	Baki	Azerbaijan
634	Zenica	Federation of Bosnia and Herzegovina	Bosnia and Herzegovina
635	Visoko	Federation of Bosnia and Herzegovina	Bosnia and Herzegovina
637	Tuzla	Federation of Bosnia and Herzegovina	Bosnia and Herzegovina
638	Trebinje	Republika Srpska	Bosnia and Herzegovina
639	Travnik	Federation of Bosnia and Herzegovina	Bosnia and Herzegovina
640	Sarajevo	Federation of Bosnia and Herzegovina	Bosnia and Herzegovina
641	Prijedor	Republika Srpska	Bosnia and Herzegovina
642	Mostar	Federation of Bosnia and Herzegovina	Bosnia and Herzegovina
643	Gradacac	Federation of Bosnia and Herzegovina	Bosnia and Herzegovina
644	Gracanica	Federation of Bosnia and Herzegovina	Bosnia and Herzegovina
646	Doboj	Republika Srpska	Bosnia and Herzegovina
647	Cazin	Federation of Bosnia and Herzegovina	Bosnia and Herzegovina
648	Bugojno	Federation of Bosnia and Herzegovina	Bosnia and Herzegovina
649	Brcko	Brcko	Bosnia and Herzegovina
650	Bosanska Krupa	Federation of Bosnia and Herzegovina	Bosnia and Herzegovina
651	Bijeljina	Republika Srpska	Bosnia and Herzegovina
652	Bihac	Federation of Bosnia and Herzegovina	Bosnia and Herzegovina
653	Banja Luka	Republika Srpska	Bosnia and Herzegovina
654	Konjic	Federation of Bosnia and Herzegovina	Bosnia and Herzegovina
655	Bridgetown	Saint Michael	Barbados
656	Thakurgaon	Rangpur Division	Bangladesh
657	Teknaf	Chittagong	Bangladesh
658	Tungi	Dhaka	Bangladesh
659	Sylhet	Sylhet	Bangladesh
660	Dohar	Dhaka	Bangladesh
661	Jamalpur	Dhaka	Bangladesh
662	Shibganj	Rajshahi	Bangladesh
663	Satkhira	Khulna	Bangladesh
664	Sirajganj	Rajshahi	Bangladesh
665	Netrakona	Dhaka	Bangladesh
666	Narsingdi	Dhaka	Bangladesh
667	Sandwip	Chittagong	Bangladesh
668	Shahzadpur	Rajshahi	Bangladesh
669	Ramganj	Chittagong	Bangladesh
670	Rajshahi	Rajshahi	Bangladesh
671	Pirojpur	Barisal	Bangladesh
672	Panchagarh	Rangpur Division	Bangladesh
673	Patiya	Chittagong	Bangladesh
674	Parbatipur	Rangpur Division	Bangladesh
675	Narayanganj	Dhaka	Bangladesh
676	Nalchiti	Barisal	Bangladesh
677	Nagarpur	Dhaka	Bangladesh
678	Nageswari	Rangpur Division	Bangladesh
679	Mymensingh	Dhaka	Bangladesh
680	Muktagacha	Dhaka	Bangladesh
681	Mirzapur	Dhaka	Bangladesh
682	Maulavi Bazar	Sylhet	Bangladesh
683	Morrelgonj	Khulna	Bangladesh
684	Mehendiganj	Barisal	Bangladesh
685	Mathba	Barisal	Bangladesh
686	Lalmanirhat	Rangpur Division	Bangladesh
687	Laksham	Chittagong	Bangladesh
688	Comilla	Chittagong	Bangladesh
689	Rangpur	Rangpur Division	Bangladesh
690	Kushtia	Khulna	Bangladesh
691	Kaliganj	Khulna	Bangladesh
692	Jhingergacha	Khulna	Bangladesh
693	Joypur Hat	Rajshahi	Bangladesh
694	Ishurdi	Rajshahi	Bangladesh
695	Habiganj	Sylhet	Bangladesh
696	Gaurnadi	Barisal	Bangladesh
697	Gafargaon	Dhaka	Bangladesh
698	Feni	Chittagong	Bangladesh
699	Raipur	Chittagong	Bangladesh
700	Sarankhola	Khulna	Bangladesh
701	Dhaka	Dhaka	Bangladesh
702	Chilmari	Rangpur Division	Bangladesh
703	Chhagalnaiya	Chittagong	Bangladesh
704	Lalmohan	Barisal	Bangladesh
705	Khagrachhari	Chittagong	Bangladesh
706	Chhatak	Sylhet	Bangladesh
707	Bhatpara Abhaynagar	Khulna	Bangladesh
708	Bheramara	Khulna	Bangladesh
709	Bhairab Bazar	Dhaka	Bangladesh
710	Bandarban	Chittagong	Bangladesh
711	Kalia	Khulna	Bangladesh
712	Baniachang	Sylhet	Bangladesh
713	Bajitpur	Dhaka	Bangladesh
714	Badarganj	Rangpur Division	Bangladesh
715	Narail	Khulna	Bangladesh
716	Tungipara	Dhaka	Bangladesh
717	Sarishabari	Dhaka	Bangladesh
718	Sakhipur	Dhaka	Bangladesh
719	Raojan	Chittagong	Bangladesh
720	Phultala	Khulna	Bangladesh
721	Palang	Dhaka	Bangladesh
722	Par Naogaon	Rajshahi	Bangladesh
723	Nabinagar	Chittagong	Bangladesh
724	Lakshmipur	Chittagong	Bangladesh
725	Kesabpur	Khulna	Bangladesh
726	Hajiganj	Chittagong	Bangladesh
727	Faridpur	Dhaka	Bangladesh
728	Dinajpur	Rangpur Division	Bangladesh
729	Uttar Char Fasson	Khulna	Bangladesh
730	Chittagong	Chittagong	Bangladesh
731	Char Bhadrasan	Dhaka	Bangladesh
732	Bera	Rajshahi	Bangladesh
733	Burhanuddin	Barisal	Bangladesh
734	Satkania	Chittagong	Bangladesh
736	Khulna	Khulna	Bangladesh
737	Bhola	Barisal	Bangladesh
738	Barisal	Barisal	Bangladesh
739	Jessore	Khulna	Bangladesh
740	Pabna	Rajshahi	Bangladesh
741	Tangail	Dhaka	Bangladesh
742	Bogra	Rajshahi	Bangladesh
743	Pirgaaj	Rangpur Division	Bangladesh
744	Nawabganj	Rajshahi	Bangladesh
745	Madaripur	Dhaka	Bangladesh
746	Sherpur	Dhaka	Bangladesh
747	Kishorganj	Dhaka	Bangladesh
748	Manikchari	Chittagong	Bangladesh
749	Bhandaria	Barisal	Bangladesh
750	Fatikchari	Chittagong	Bangladesh
751	Saidpur	Rajshahi	Bangladesh
752	Azimpur	Dhaka	Bangladesh
753	Paltan	Dhaka	Bangladesh
754	Zwijndrecht	Flanders	Belgium
755	Zwevegem	Flanders	Belgium
756	Zottegem	Flanders	Belgium
757	Zonhoven	Flanders	Belgium
758	Zoersel	Flanders	Belgium
759	Zemst	Flanders	Belgium
760	Zele	Flanders	Belgium
761	Zedelgem	Flanders	Belgium
762	Zaventem	Flanders	Belgium
763	Wuustwezel	Flanders	Belgium
764	Willebroek	Flanders	Belgium
765	Wevelgem	Flanders	Belgium
766	Wetteren	Flanders	Belgium
767	Westerlo	Flanders	Belgium
768	Wervik	Flanders	Belgium
769	Wavre	Wallonia	Belgium
770	Waterloo	Wallonia	Belgium
771	Waregem	Flanders	Belgium
772	Walcourt	Wallonia	Belgium
774	Vilvoorde	Flanders	Belgium
775	Verviers	Wallonia	Belgium
776	Turnhout	Flanders	Belgium
777	Tubize	Wallonia	Belgium
778	Tournai	Wallonia	Belgium
779	Torhout	Flanders	Belgium
780	Tongeren	Flanders	Belgium
781	Tienen	Flanders	Belgium
782	Tielt	Flanders	Belgium
783	Tessenderlo	Flanders	Belgium
784	Tervuren	Flanders	Belgium
785	Temse	Flanders	Belgium
786	Stekene	Flanders	Belgium
787	Stabroek	Flanders	Belgium
788	Soumagne	Wallonia	Belgium
789	Soignies	Wallonia	Belgium
790	Sint-Truiden	Flanders	Belgium
791	Sint-Pieters-Leeuw	Flanders	Belgium
792	Sint-Niklaas	Flanders	Belgium
793	Sint-Kruis	Flanders	Belgium
794	Sint-Katelijne-Waver	Flanders	Belgium
795	Sint-Gillis-Waas	Flanders	Belgium
796	Sint-Genesius-Rode	Flanders	Belgium
797	Seraing	Wallonia	Belgium
798	Schoten	Flanders	Belgium
799	Schilde	Flanders	Belgium
800	Saint-Nicolas	Wallonia	Belgium
801	Saint-Ghislain	Wallonia	Belgium
802	Rotselaar	Flanders	Belgium
803	Ronse	Flanders	Belgium
804	Roeselare	Flanders	Belgium
805	Rixensart	Wallonia	Belgium
806	Riemst	Flanders	Belgium
807	Ranst	Flanders	Belgium
808	Quaregnon	Wallonia	Belgium
809	Puurs	Flanders	Belgium
810	Putte	Flanders	Belgium
811	Poperinge	Flanders	Belgium
814	Peer	Flanders	Belgium
815	Overijse	Flanders	Belgium
816	Oupeye	Wallonia	Belgium
817	Oudenaarde	Flanders	Belgium
818	Oostkamp	Flanders	Belgium
819	Ostend	Flanders	Belgium
820	Nivelles	Wallonia	Belgium
821	Ninove	Flanders	Belgium
822	Nijlen	Flanders	Belgium
823	Neerpelt	Flanders	Belgium
824	Namur	Wallonia	Belgium
825	Mouscron	Wallonia	Belgium
826	Mortsel	Flanders	Belgium
827	Morlanwelz-Mariemont	Wallonia	Belgium
828	Mons	Wallonia	Belgium
829	Mol	Flanders	Belgium
830	Middelkerke	Flanders	Belgium
831	Merelbeke	Flanders	Belgium
832	Menen	Flanders	Belgium
833	Meise	Flanders	Belgium
834	Mechelen	Flanders	Belgium
835	Marche-en-Famenne	Wallonia	Belgium
836	Manage	Wallonia	Belgium
837	Maldegem	Flanders	Belgium
838	Maasmechelen	Flanders	Belgium
839	Maaseik	Flanders	Belgium
840	Louvain-la-Neuve	Wallonia	Belgium
841	Londerzeel	Flanders	Belgium
842	Lommel	Flanders	Belgium
843	Lokeren	Flanders	Belgium
844	Lochristi	Flanders	Belgium
845	Lille	Flanders	Belgium
846	Lier	Flanders	Belgium
848	Leuven	Flanders	Belgium
849	Lessines	Wallonia	Belgium
850	Lede	Flanders	Belgium
851	Lebbeke	Flanders	Belgium
852	Lanaken	Flanders	Belgium
854	Kortrijk	Flanders	Belgium
855	Kortenberg	Flanders	Belgium
856	Kontich	Flanders	Belgium
857	Koksijde	Flanders	Belgium
858	Knokke-Heist	Flanders	Belgium
859	Kasterlee	Flanders	Belgium
860	Kapellen	Flanders	Belgium
861	Kalmthout	Flanders	Belgium
862	Izegem	Flanders	Belgium
863	Ieper	Flanders	Belgium
864	Huy	Wallonia	Belgium
865	Houthalen	Flanders	Belgium
866	Hoogstraten	Flanders	Belgium
867	Hoboken	Flanders	Belgium
868	Heusden	Flanders	Belgium
869	Herzele	Flanders	Belgium
870	Herve	Wallonia	Belgium
871	Herstal	Wallonia	Belgium
872	Herentals	Flanders	Belgium
873	Herent	Flanders	Belgium
874	Helchteren	Flanders	Belgium
875	Heist-op-den-Berg	Flanders	Belgium
876	Hasselt	Flanders	Belgium
877	Harelbeke	Flanders	Belgium
878	Hamme	Flanders	Belgium
879	Halle	Flanders	Belgium
880	Haaltert	Flanders	Belgium
881	Grimbergen	Flanders	Belgium
882	Geraardsbergen	Flanders	Belgium
883	Gent	Flanders	Belgium
884	Genk	Flanders	Belgium
885	Gembloux	Wallonia	Belgium
886	Geel	Flanders	Belgium
887	Frameries	Wallonia	Belgium
888	Fleurus	Wallonia	Belgium
891	Evergem	Flanders	Belgium
892	Eupen	Wallonia	Belgium
893	Essen	Flanders	Belgium
894	Eeklo	Flanders	Belgium
895	Edegem	Flanders	Belgium
896	Duffel	Flanders	Belgium
897	Dour	Wallonia	Belgium
898	Dilbeek	Flanders	Belgium
899	Diksmuide	Flanders	Belgium
900	Diest	Flanders	Belgium
901	Diepenbeek	Flanders	Belgium
902	Destelbergen	Flanders	Belgium
903	Dendermonde	Flanders	Belgium
904	Denderleeuw	Flanders	Belgium
905	Deinze	Flanders	Belgium
906	Courcelles	Wallonia	Belgium
907	Colfontaine	Wallonia	Belgium
908	Chaudfontaine	Wallonia	Belgium
910	Chasse Royale	Wallonia	Belgium
911	Charleroi	Wallonia	Belgium
912	Brussels	Brussels Capital	Belgium
913	Brugge	Flanders	Belgium
914	Brecht	Flanders	Belgium
915	Brasschaat	Flanders	Belgium
916	Braine-le-Comte	Wallonia	Belgium
917	Braine-lAlleud	Wallonia	Belgium
959	Fada Ngourma	Est	Burkina Faso
960	Dori	Sahel	Burkina Faso
961	Djibo	Sahel	Burkina Faso
962	Diapaga	Est	Burkina Faso
965	Boulsa	Centre-Nord	Burkina Faso
966	Bobo-Dioulasso	High-Basins	Burkina Faso
967	Banfora	Cascades	Burkina Faso
968	Gaoua	Southwest	Burkina Faso
969	Orodara	High-Basins	Burkina Faso
970	Yambol	Yambol	Bulgaria
971	Vratsa	Vratsa	Bulgaria
972	Vidin	Vidin	Bulgaria
973	Velingrad	Pazardzhik	Bulgaria
974	Veliko Turnovo	Veliko Turnovo	Bulgaria
975	Varna	Varna	Bulgaria
976	Targovishte	Turgovishte	Bulgaria
977	Troyan	Lovech	Bulgaria
978	Dobrich	Dobrich	Bulgaria
979	Svishtov	Veliko Turnovo	Bulgaria
980	Svilengrad	Khaskovo	Bulgaria
981	Stara Zagora	Stara Zagora	Bulgaria
982	Dupnitsa	Kyustendil	Bulgaria
983	Sofia	Sofia-Capital	Bulgaria
984	Smolyan	Smolyan	Bulgaria
985	Sliven	Sliven	Bulgaria
986	Silistra	Silistra	Bulgaria
987	Shumen	Shumen	Bulgaria
988	Sevlievo	Gabrovo	Bulgaria
989	Sandanski	Blagoevgrad	Bulgaria
990	Samokov	Sofiya	Bulgaria
991	Ruse	Ruse	Bulgaria
992	Razgrad	Razgrad	Bulgaria
993	Rakovski	Plovdiv	Bulgaria
994	Popovo	Turgovishte	Bulgaria
995	Plovdiv	Plovdiv	Bulgaria
996	Pleven	Pleven	Bulgaria
997	Petrich	Blagoevgrad	Bulgaria
998	Peshtera	Pazardzhik	Bulgaria
999	Pernik	Pernik	Bulgaria
1000	Pazardzhik	Pazardzhik	Bulgaria
1001	Panagyurishte	Pazardzhik	Bulgaria
1002	Nova Zagora	Sliven	Bulgaria
1003	Montana	Montana	Bulgaria
1004	Lovech	Lovech	Bulgaria
1005	Lom	Montana	Bulgaria
1006	Kyustendil	Kyustendil	Bulgaria
1007	Kardzhali	Kurdzhali	Bulgaria
1008	Haskovo	Khaskovo	Bulgaria
1009	Kharmanli	Khaskovo	Bulgaria
1010	Kazanluk	Stara Zagora	Bulgaria
1011	Karnobat	Burgas	Bulgaria
1012	Karlovo	Plovdiv	Bulgaria
1013	Gotse Delchev	Blagoevgrad	Bulgaria
1014	Gorna Oryakhovitsa	Veliko Turnovo	Bulgaria
1015	Gabrovo	Gabrovo	Bulgaria
1016	Dimitrovgrad	Khaskovo	Bulgaria
1017	Chirpan	Stara Zagora	Bulgaria
1018	Cherven Bryag	Pleven	Bulgaria
1019	Burgas	Burgas	Bulgaria
1020	Botevgrad	Sofiya	Bulgaria
1021	Blagoevgrad	Blagoevgrad	Bulgaria
1022	Berkovitsa	Montana	Bulgaria
1023	Aytos	Burgas	Bulgaria
1024	Asenovgrad	Plovdiv	Bulgaria
1025	Sitrah	Manama	Bahrain
1027	Jidd ?afs	Manama	Bahrain
1028	Madinat ?amad	Central Governorate	Bahrain
1029	Dar Kulayb	Southern Governorate	Bahrain
1030	Al Muharraq	Muharraq	Bahrain
1031	Manama	Manama	Bahrain
1033	Makamba	Makamba	Burundi
1034	Bururi	Bururi	Burundi
1035	Bujumbura	Bujumbura Mairie	Burundi
1036	Muramvya	Muramvya	Burundi
1037	Gitega	Gitega	Burundi
1038	Ruyigi	Ruyigi	Burundi
1039	Ngozi	Ngozi	Burundi
1040	Kayanza	Kayanza	Burundi
1041	Muyinga	Muyinga	Burundi
1042	Rutana	Rutana	Burundi
1043	Tchaourou	Borgou	Benin
1046	Savalou	Collines	Benin
1050	Parakou	Borgou	Benin
1051	Ouidah	Atlantique	Benin
1052	Nikki	Borgou	Benin
1053	Natitingou	Atakora	Benin
1054	Malanville	Atakora	Benin
1055	Lokossa	Mono	Benin
1057	Kandi	Alibori	Benin
1058	Dogbo	Kouffo	Benin
1059	Djougou	Donga	Benin
1062	Cotonou	Littoral	Benin
1064	Bohicon	Zou	Benin
1066	Bassila	Donga	Benin
1067	Banikoara	Alibori	Benin
1069	Allada	Atlantique	Benin
1070	Abomey-Calavi	Atlantique	Benin
1071	Abomey	Zou	Benin
1072	Gustavia	N/A	Saint Barthelemy
1073	Hamilton	Hamilton city	Bermuda
1074	Tutong	Tutong	Brunei
1075	Seria	Belait	Brunei
1076	Kuala Belait	Belait	Brunei
1077	Bandar Seri Begawan	Brunei and Muara	Brunei
1078	Yacuiba	Tarija	Bolivia
1079	Warnes	Santa Cruz	Bolivia
1082	Villamontes	Tarija	Bolivia
1084	Trinidad	El Beni	Bolivia
1085	Tarija	Tarija	Bolivia
1086	Sucre	Chuquisaca	Bolivia
1087	Santiago del Torno	Santa Cruz	Bolivia
1088	Santa Cruz de la Sierra	Santa Cruz	Bolivia
1089	San Ignacio de Velasco	Santa Cruz	Bolivia
1090	San Borja	El Beni	Bolivia
1091	Riberalta	El Beni	Bolivia
1092	Punata	Cochabamba	Bolivia
1094	Oruro	Oruro	Bolivia
1095	Montero	Santa Cruz	Bolivia
1096	Mizque	Cochabamba	Bolivia
1098	La Paz	La Paz	Bolivia
1099	Huanuni	Oruro	Bolivia
1101	Cotoca	Santa Cruz	Bolivia
1102	Cochabamba	Cochabamba	Bolivia
1103	Cobija	Pando	Bolivia
1104	Camiri	Santa Cruz	Bolivia
1105	Kralendijk	 Saint Eustatius and Saba "	"Bonaire
1123	Trindade	Pernambuco	Brazil
1125	Toritama	Pernambuco	Brazil
1134	Tabira	Pernambuco	Brazil
1135	Surubim	Pernambuco	Brazil
1142	Serra Talhada	Pernambuco	Brazil
1144	Satuba	Alagoas	Brazil
1165	Santana do Ipanema	Alagoas	Brazil
1169	Santa Cruz do Capibaribe	Pernambuco	Brazil
1170	Santa Cruz	Rio Grande do Norte	Brazil
1172	Salgueiro	Pernambuco	Brazil
1174	Rio Largo	Alagoas	Brazil
1175	Rio Formoso	Pernambuco	Brazil
1177	Recife	Pernambuco	Brazil
1182	Porto Calvo	Alagoas	Brazil
1184	Pombos	Pernambuco	Brazil
1190	Pilar	Alagoas	Brazil
1192	Petrolina	Pernambuco	Brazil
1194	Pesqueira	Pernambuco	Brazil
1199	Paulo Afonso	Bahia	Brazil
1200	Paulista	Pernambuco	Brazil
1202	Parnamirim	Rio Grande do Norte	Brazil
1204	Parintins	Amazonas	Brazil
1205	Parelhas	Rio Grande do Norte	Brazil
1209	Palmares	Pernambuco	Brazil
1212	Ouricuri	Pernambuco	Brazil
1215	Olinda	Pernambuco	Brazil
1219	Nova Cruz	Rio Grande do Norte	Brazil
1221	Natal	Rio Grande do Norte	Brazil
1222	Murici	Alagoas	Brazil
1223	Moreno	Pernambuco	Brazil
1232	Matriz de Camaragibe	Alagoas	Brazil
1234	Marechal Deodoro	Alagoas	Brazil
1235	Maragogi	Alagoas	Brazil
1240	Macau	Rio Grande do Norte	Brazil
1244	Limoeiro	Pernambuco	Brazil
1246	Lajedo	Pernambuco	Brazil
1248	Lagoa do Itaenga	Pernambuco	Brazil
1257	Itacoatiara	Amazonas	Brazil
1259	Itapissuma	Pernambuco	Brazil
1267	Ipubi	Pernambuco	Brazil
1269	Ipojuca	Pernambuco	Brazil
1274	Igarassu	Pernambuco	Brazil
1283	Goiana	Pernambuco	Brazil
1285	Garanhuns	Pernambuco	Brazil
1286	Gameleira	Pernambuco	Brazil
1289	Floresta	Pernambuco	Brazil
1291	Extremoz	Rio Grande do Norte	Brazil
1295	Escada	Pernambuco	Brazil
1298	Delmiro Gouveia	Alagoas	Brazil
1301	Currais Novos	Rio Grande do Norte	Brazil
1302	Cupira	Pernambuco	Brazil
1306	Condado	Pernambuco	Brazil
1317	Catende	Pernambuco	Brazil
1320	Caruaru	Pernambuco	Brazil
1321	Carpina	Pernambuco	Brazil
1326	Canguaretama	Rio Grande do Norte	Brazil
1329	Campo Alegre	Alagoas	Brazil
1333	Cajueiro	Alagoas	Brazil
1337	Cabo	Pernambuco	Brazil
1343	Brejo da Madre de Deus	Pernambuco	Brazil
1345	Bom Conselho	Pernambuco	Brazil
1347	Bezerros	Pernambuco	Brazil
1349	Belo Jardim	Pernambuco	Brazil
1355	Barreiros	Pernambuco	Brazil
1364	Atalaia	Alagoas	Brazil
1365	Areia Branca	Rio Grande do Norte	Brazil
1366	Arcoverde	Pernambuco	Brazil
1367	Araripina	Pernambuco	Brazil
1369	Arapiraca	Alagoas	Brazil
1373	Apodi	Rio Grande do Norte	Brazil
1375	Amaraji	Pernambuco	Brazil
1383	Afogados da Ingazeira	Pernambuco	Brazil
1387	Abreu e Lima	Pernambuco	Brazil
1389	Xique Xique	Bahia	Brazil
1393	Volta Redonda	Rio de Janeiro	Brazil
1396	Visconde do Rio Branco	Minas Gerais	Brazil
1400	Videira	Santa Catarina	Brazil
1404	Vespasiano	Minas Gerais	Brazil
1406	Vera Cruz	Bahia	Brazil
1409	Vazante	Minas Gerais	Brazil
1410	Vassouras	Rio de Janeiro	Brazil
1414	Varginha	Minas Gerais	Brazil
1420	Vacaria	Rio Grande do Sul	Brazil
1421	Uruguaiana	Rio Grande do Sul	Brazil
1426	Una	Bahia	Brazil
1429	Uberaba	Minas Gerais	Brazil
1432	Ubaitaba	Bahia	Brazil
1435	Tupaciguara	Minas Gerais	Brazil
1437	Tucano	Bahia	Brazil
1449	Torres	Rio Grande do Sul	Brazil
1451	Tobias Barreto	Sergipe	Brazil
1454	Tijucas	Santa Catarina	Brazil
1465	Taquari	Rio Grande do Sul	Brazil
1466	Taquara	Rio Grande do Sul	Brazil
1468	Tapes	Rio Grande do Sul	Brazil
1472	Taiobeiras	Minas Gerais	Brazil
1477	Soledade	Rio Grande do Sul	Brazil
1479	Sobradinho	Bahia	Brazil
1481	Silva Jardim	Rio de Janeiro	Brazil
1483	Sete Lagoas	Minas Gerais	Brazil
1485	Serrinha	Bahia	Brazil
1490	Senhor do Bonfim	Bahia	Brazil
1492	Seabra	Bahia	Brazil
1493	Schroeder	Santa Catarina	Brazil
1494	Saubara	Bahia	Brazil
1495	Sarzedo	Minas Gerais	Brazil
1496	Sarandi	Rio Grande do Sul	Brazil
1498	Saquarema	Rio de Janeiro	Brazil
1499	Sapucaia	Rio Grande do Sul	Brazil
1500	Sapiranga	Rio Grande do Sul	Brazil
1548	Santos Dumont	Minas Gerais	Brazil
1560	Santo Amaro da Imperatriz	Santa Catarina	Brazil
1561	Santo Amaro	Bahia	Brazil
1562	Santiago	Rio Grande do Sul	Brazil
1565	Santa Rosa	Rio Grande do Sul	Brazil
1569	Santana do Livramento	Rio Grande do Sul	Brazil
1572	Santa Maria	Rio Grande do Sul	Brazil
1573	Santa Luzia	Minas Gerais	Brazil
1574	Santaluz	Bahia	Brazil
1579	Santa Cruz do Sul	Rio Grande do Sul	Brazil
2462	LAssomption	Quebec	Canada
2463	Laval	Quebec	Canada
2464	Leduc	Alberta	Canada
2465	Lethbridge	Alberta	Canada
2466	Lloydminster	Saskatchewan	Canada
2467	London	Ontario	Canada
2468	Longueuil	Quebec	Canada
2469	Magog	Quebec	Canada
2470	Maple Ridge	British Columbia	Canada
2471	Markham	Ontario	Canada
2472	Mascouche	Quebec	Canada
2473	Medicine Hat	Alberta	Canada
2474	Midland	Ontario	Canada
2475	Milton	Ontario	Canada
2476	Mirabel	Quebec	Canada
2477	Miramichi	New Brunswick	Canada
2478	Mississauga	Ontario	Canada
2479	Moncton	New Brunswick	Canada
2481	Mont-Royal	Quebec	Canada
2482	Mont-Saint-Hilaire	Quebec	Canada
2483	Moose Jaw	Saskatchewan	Canada
2484	Mount Pearl	Newfoundland and Labrador	Canada
2485	Nanaimo	British Columbia	Canada
2486	New Glasgow	Nova Scotia	Canada
2487	Newmarket	Ontario	Canada
2488	New Westminster	British Columbia	Canada
2489	Niagara Falls	Ontario	Canada
2490	Norfolk County	Ontario	Canada
2491	North Battleford	Saskatchewan	Canada
2492	North Bay	Ontario	Canada
2493	North Cowichan	British Columbia	Canada
2494	North Vancouver	British Columbia	Canada
2495	North York	Ontario	Canada
2496	Oak Bay	British Columbia	Canada
2497	Oakville	Ontario	Canada
2498	Orangeville	Ontario	Canada
2499	Orillia	Ontario	Canada
2500	Oshawa	Ontario	Canada
2501	Ottawa	Ontario	Canada
2502	Owen Sound	Ontario	Canada
2503	Parksville	British Columbia	Canada
2504	Pembroke	Ontario	Canada
2505	Penticton	British Columbia	Canada
2506	Petawawa	Ontario	Canada
2507	Peterborough	Ontario	Canada
2508	Pickering	Ontario	Canada
2509	Pitt Meadows	British Columbia	Canada
2510	Pointe-Claire	Quebec	Canada
2511	Port Alberni	British Columbia	Canada
2512	Port Colborne	Ontario	Canada
2513	Port Moody	British Columbia	Canada
2514	Prince Albert	Saskatchewan	Canada
2515	Prince Edward	Ontario	Canada
2516	Prince George	British Columbia	Canada
2517	Quinte West	Ontario	Canada
2518	Rayside-Balfour	Ontario	Canada
2519	Red Deer	Alberta	Canada
2520	Regina	Saskatchewan	Canada
2521	Repentigny	Quebec	Canada
2522	Richmond	British Columbia	Canada
2523	Richmond Hill	Ontario	Canada
2524	Rouyn-Noranda	Quebec	Canada
2525	Saguenay	Quebec	Canada
2526	Saint-Basile-le-Grand	Quebec	Canada
2527	Saint-Bruno-de-Montarville	Quebec	Canada
2528	Saint-Constant	Quebec	Canada
2529	Sainte-Catherine	Quebec	Canada
2530	Sainte-Julie	Quebec	Canada
2532	Saint-Eustache	Quebec	Canada
2533	Saint-Hyacinthe	Quebec	Canada
2534	Saint-Jean-sur-Richelieu	Quebec	Canada
2536	Saint John	New Brunswick	Canada
2537	Saint-Laurent	Quebec	Canada
2538	Saint-Lazare	Quebec	Canada
2540	Salaberry-de-Valleyfield	Quebec	Canada
2541	Salmon Arm	British Columbia	Canada
2542	Sarnia	Ontario	Canada
2543	Saskatoon	Saskatchewan	Canada
2544	Sault Ste. Marie	Ontario	Canada
2546	Shawinigan	Quebec	Canada
2547	Sherbrooke	Quebec	Canada
2548	Sherwood Park	Alberta	Canada
2549	Sorel-Tracy	Quebec	Canada
2550	Spruce Grove	Alberta	Canada
2551	St. Albert	Alberta	Canada
2552	St. Catharines	Ontario	Canada
2553	Stratford	Ontario	Canada
2554	St. Thomas	Ontario	Canada
2555	Surrey	British Columbia	Canada
2556	Terrace	British Columbia	Canada
2557	Terrebonne	Quebec	Canada
2558	Thorold	Ontario	Canada
2559	Thunder Bay	Ontario	Canada
2560	Timmins	Ontario	Canada
2561	Toronto	Ontario	Canada
2563	Truro	Nova Scotia	Canada
2564	Val-dOr	Quebec	Canada
2584	St. Johns	Newfoundland and Labrador	Canada
2587	Rimouski	Quebec	Canada
2589	Sydney	Nova Scotia	Canada
2590	LAncienne-Lorette	Quebec	Canada
2819	Daloa	Haut-Sassandra	Ivory Coast
2820	Dabou	Lagunes	Ivory Coast
2821	Boundiali	Savanes	Ivory Coast
2822	Bouna	Zanzan	Ivory Coast
2826	Bongouanou	Lacs	Ivory Coast
2827	Bondoukou	Zanzan	Ivory Coast
2828	Bingerville	Lagunes	Ivory Coast
2829	Biankouma	Dix-Huit Montagnes	Ivory Coast
2831	Bangolo	Dix-Huit Montagnes	Ivory Coast
2832	Arrah	Lacs	Ivory Coast
2833	Anyama	Lagunes	Ivory Coast
2840	Abobo	Lagunes	Ivory Coast
2841	Abidjan	Lagunes	Ivory Coast
2845	Avarua	N/A	Cook Islands
2851	Vallenar	Atacama	Chile
2854	Tocopilla	Antofagasta	Chile
2857	Talca	Maule	Chile
2858	Talagante	Santiago Metropolitan	Chile
2859	San Vicente de Tagua Tagua	OHiggins	Chile
2860	San Vicente	OHiggins	Chile
2861	Santiago	Santiago Metropolitan	Chile
2862	Santa Cruz	OHiggins	Chile
2869	Rengo	OHiggins	Chile
2870	Rancagua	OHiggins	Chile
2899	Linares	Maule	Chile
2904	La Serena	Coquimbo	Chile
2905	Lampa	Santiago Metropolitan	Chile
2909	Illapel	Coquimbo	Chile
2911	Graneros	OHiggins	Chile
2924	Chimbarongo	OHiggins	Chile
2927	Chicureo Abajo	Santiago Metropolitan	Chile
2928	Cauquenes	Maule	Chile
2929	Castro	Los Lagos	Chile
2932	Calama	Antofagasta	Chile
2934	Buin	Santiago Metropolitan	Chile
2935	Arica	Arica y Parinacota	Chile
2937	Antofagasta	Antofagasta	Chile
2939	Ancud	Los Lagos	Chile
2940	Las Animas	Los Lagos	Chile
2941	La Pintana	Santiago Metropolitan	Chile
2942	Lo Prado	Santiago Metropolitan	Chile
2944	Yagoua	Far North	Cameroon
2945	Wum	North-West Province	Cameroon
2946	Tonga	West	Cameroon
2947	Tiko	South-West Province	Cameroon
2948	Tibati	Adamaoua	Cameroon
2951	Penja	Littoral	Cameroon
2952	Obala	Centre	Cameroon
2953	Nkoteng	Centre	Cameroon
2954	Nkongsamba	Littoral	Cameroon
2956	Nanga Eboko	Centre	Cameroon
2957	Muyuka	South-West Province	Cameroon
2958	Mutengene	South-West Province	Cameroon
2959	Mora	Far North	Cameroon
2960	Mokolo	Far North	Cameroon
2961	Melong	Littoral	Cameroon
2963	Mbouda	West	Cameroon
2964	Mbanga	Littoral	Cameroon
2965	Mbandjok	Centre	Cameroon
2966	Mbalmayo	Centre	Cameroon
2967	Maroua	Far North	Cameroon
2968	Manjo	Littoral	Cameroon
2969	Mamfe	South-West Province	Cameroon
2970	Loum	Littoral	Cameroon
2971	Lolodorf	South Province	Cameroon
2972	Limbe	South-West Province	Cameroon
2973	Lagdo	North Province	Cameroon
2974	Kumbo	North-West Province	Cameroon
2975	Kumba	South-West Province	Cameroon
2976	Kribi	South Province	Cameroon
2979	Guider	North Province	Cameroon
2981	Garoua	North Province	Cameroon
2982	Fundong	North-West Province	Cameroon
2983	Foumbot	West	Cameroon
2984	Foumban	West	Cameroon
2985	Fontem	South-West Province	Cameroon
2989	Dschang	West	Cameroon
2990	Douala	Littoral	Cameroon
2992	Buea	South-West Province	Cameroon
2993	Bogo	Far North	Cameroon
2994	Bertoua	East	Cameroon
2996	Batouri	East	Cameroon
2997	Banyo	Adamaoua	Cameroon
2999	Bamusso	South-West Province	Cameroon
3000	Bamenda	North-West Province	Cameroon
3001	Bali	North-West Province	Cameroon
3002	Bafoussam	West	Cameroon
3003	Bafia	Centre	Cameroon
3004	Bafang	West	Cameroon
3005	Akonolinga	Centre	Cameroon
3006	Idenao	South-West Province	Cameroon
3007	Rikaze	Tibet Autonomous Region	China
3008	Jiuquan	Gansu Sheng	China
3009	Shache	Xinjiang Uygur Zizhiqu	China
3010	Qamdo	Tibet Autonomous Region	China
3011	Nagqu	Tibet Autonomous Region	China
3012	Lhasa	Tibet Autonomous Region	China
3013	Laojunmiao	Gansu Sheng	China
3014	Kashgar	Xinjiang Uygur Zizhiqu	China
3015	Jiayuguan	Gansu Sheng	China
3016	Hotan	Xinjiang Uygur Zizhiqu	China
3019	Laochenglu	Xinjiang Uygur Zizhiqu	China
3020	Shihezi	Xinjiang Uygur Zizhiqu	China
3021	Kuche	Xinjiang Uygur Zizhiqu	China
3022	Sayibage	Xinjiang Uygur Zizhiqu	China
3023	Hoxtolgay	Xinjiang Uygur Zizhiqu	China
3024	Hami	Xinjiang Uygur Zizhiqu	China
3025	Changji	Xinjiang Uygur Zizhiqu	China
3026	Baijiantan	Xinjiang Uygur Zizhiqu	China
3027	Aral	Xinjiang Uygur Zizhiqu	China
3028	Altay	Xinjiang Uygur Zizhiqu	China
3029	Yingbazha	Xinjiang Uygur Zizhiqu	China
3030	Zunyi	Guizhou Sheng	China
3031	Zoucheng	Shandong Sheng	China
3032	Yanjiang	Sichuan	China
3033	Zigong	Sichuan	China
3034	Zhuzhou	Hunan	China
3035	Zhumadian	Henan Sheng	China
3036	Zhujiajiao	Shanghai Shi	China
3037	Shangqiu	Henan Sheng	China
3038	Zhuji	Zhejiang Sheng	China
3039	Mizhou	Shandong Sheng	China
3040	Zhuanghe	Liaoning	China
3041	Zhouzhuang	Jiangsu	China
3042	Zhoukou	Henan Sheng	China
3043	Zhoucun	Shandong Sheng	China
3044	Yuxi	Yunnan	China
3045	Zhongxing	Jiangsu	China
3046	Zhongshu	Yunnan	China
3047	Zhicheng	Zhejiang Sheng	China
3048	Zhicheng	Hubei	China
3049	Zhenzhou	Jiangsu	China
3050	Zhenjiang	Jiangsu	China
3051	Zhaobaoshan	Zhejiang Sheng	China
3052	Zhengzhou	Henan Sheng	China
3053	Xinghua	Jiangsu	China
3054	Zhaotong	Yunnan	China
3055	Zhaoqing	Guangdong	China
3056	Zhaogezhuang	Hebei	China
3057	Luofeng	Shandong Sheng	China
3058	Zhanjiang	Guangdong	China
3059	Zhangzhou	Fujian	China
3060	Zhangye	Gansu Sheng	China
3061	Zibo	Shandong Sheng	China
3062	Anyang	Henan Sheng	China
3063	Zaozhuang	Shandong Sheng	China
3064	Zaoyang	Hubei	China
3065	Yuyao	Zhejiang Sheng	China
3066	Yingchuan	Henan Sheng	China
3067	Yuxia	Shaanxi	China
3068	Kunshan	Jiangsu	China
3069	Yunyang	Henan Sheng	China
3070	Yunmeng Chengguanzhen	Hubei	China
3071	Jinghong	Yunnan	China
3072	Pizhou	Jiangsu	China
3073	Yunfu	Guangdong	China
3074	Yuncheng	Shanxi Sheng	China
3075	Yulin	Shaanxi	China
3076	Yulin	Guangxi Zhuangzu Zizhiqu	China
3077	Yudong	Chongqing Shi	China
3078	Yuci	Shanxi Sheng	China
3079	Yucheng	Shandong Sheng	China
3080	Yuanping	Shanxi Sheng	China
3081	Qianjiang	Hubei	China
3082	Heyuan	Guangdong	China
3083	Yongfeng	Hunan	China
3084	Yongchuan	Chongqing Shi	China
3085	Yishui	Shandong Sheng	China
3086	Zhongxiang	Hubei	China
3087	Yingshang Chengguanzhen	Anhui Sheng	China
3088	Chengzhong	Hubei	China
3089	Yinchuan	Ningxia Huizu Zizhiqu	China
3090	Yima	Henan Sheng	China
3091	Yigou	Henan Sheng	China
3092	Qingzhou	Shandong Sheng	China
3093	Yichun	Jiangxi Sheng	China
3094	Yicheng	Hubei	China
3095	Yicheng	Jiangsu	China
3096	Yichang	Hubei	China
3097	Yibin	Sichuan	China
3098	Yatou	Shandong Sheng	China
3099	Yashan	Guangxi Zhuangzu Zizhiqu	China
3100	Yanzhou	Shandong Sheng	China
3101	Yantai	Shandong Sheng	China
3102	Yanliang	Shaanxi	China
3103	Yangzhou	Jiangsu	China
3104	Yangshuo	Guangxi Zhuangzu Zizhiqu	China
3105	Zhangjiagang	Jiangsu	China
3106	Yangquan	Shanxi Sheng	China
3107	Yangliuqing	Tianjin Shi	China
3108	Yanggu	Shandong Sheng	China
3109	Yangcun	Tianjin Shi	China
3110	Yancheng	Jiangsu	China
3111	Tongshan	Jiangsu	China
3112	Xucheng	Guangdong	China
3113	Shangrao	Jiangxi Sheng	China
3114	Xunchang	Sichuan	China
3115	Jiangguanchi	Henan Sheng	China
3116	Xuanzhou	Anhui Sheng	China
3117	Xixiang	Henan Sheng	China
3118	Xiuying	Hainan	China
3119	Xiulin	Hubei	China
3120	Xiongzhou	Guangdong	China
3121	Guixi	Jiangxi Sheng	China
3122	Xinzhou	Shanxi Sheng	China
3123	Xinzhou	Hubei	China
3124	Xinzhi	Shanxi Sheng	China
3125	Xinyu	Jiangxi Sheng	China
3126	Hancheng	Henan Sheng	China
3127	Xinyang	Henan Sheng	China
3128	Nangandao	Henan Sheng	China
3129	Xintai	Shandong Sheng	China
3130	Xinshi	Hubei	China
3131	Xinpu	Jiangsu	China
3132	Xinji	Hebei	China
3133	Xining	Qinghai Sheng	China
3134	Shangmei	Hunan	China
3135	Xingtai	Hebei	China
3136	Ankang	Shaanxi	China
3137	Xindian	Shandong Sheng	China
3138	Xindi	Hubei	China
3139	Feicheng	Shandong Sheng	China
3140	Sanshui	Guangdong	China
3141	Ximei	Fujian	China
3142	Wacheng	Henan Sheng	China
3143	Xihe	Hubei	China
3144	Xichang	Sichuan	China
3145	Xiazhuang	Shandong Sheng	China
3146	Xiazhen	Shandong Sheng	China
3147	Xiashi	Zhejiang Sheng	China
3148	Zijinglu	Henan Sheng	China
3149	Xiaoweizhai	Guizhou Sheng	China
3150	Xiaoshan	Zhejiang Sheng	China
3151	Xiaolingwei	Jiangsu	China
3152	Xiaogan	Hubei	China
3153	Xianyang	Shaanxi	China
3154	Xiantao	Hubei	China
3155	Xianshuigu	Tianjin Shi	China
3157	Xianning	Hubei	China
3158	Xianju	Zhejiang Sheng	China
3159	Zhuhai	Guangdong	China
3160	Wenxing	Hunan	China
3161	Xiangxiang	Hunan	China
3162	Xiangtan	Hunan	China
3163	Xiangyang	Hubei	China
3164	Xiangcheng Chengguanzhen	Henan Sheng	China
3166	Xiamen	Fujian	China
3167	Wuzhou	Guangxi Zhuangzu Zizhiqu	China
3168	Wuyang	Anhui Sheng	China
3169	Wuxue	Hubei	China
3170	Wuxi	Jiangsu	China
3171	Dongyang	Zhejiang Sheng	China
3172	Changde	Hunan	China
3173	Wuhu	Anhui Sheng	China
3174	Wuhan	Hubei	China
3175	Wuhai	Inner Mongolia	China
3176	Wuda	Inner Mongolia	China
3177	Wucheng	Anhui Sheng	China
3178	Wenzhou	Zhejiang Sheng	China
3179	Wenshang	Shandong Sheng	China
3180	Wenling	Zhejiang Sheng	China
3181	Tianfu	Shandong Sheng	China
3182	Weinan	Shaanxi	China
3183	Weihai	Shandong Sheng	China
3184	Weifang	Shandong Sheng	China
3185	Wanxian	Chongqing Shi	China
3186	Wanning	Hainan	China
3187	Yinzhu	Shandong Sheng	China
3188	Wafangdian	Liaoning	China
3189	Huangshan	Anhui Sheng	China
3190	Loushanguan	Guizhou Sheng	China
3191	Tongzhou	Beijing	China
3192	Fuding	Fujian	China
3193	Tongren	Guizhou Sheng	China
3194	Wusong	Anhui Sheng	China
3195	Tongchuan	Sichuan	China
3196	Tianshui	Gansu Sheng	China
3197	Tianpeng	Sichuan	China
3198	Tianjin	Tianjin Shi	China
3199	Tengzhou	Shandong Sheng	China
3200	Taozhuang	Shandong Sheng	China
3201	Tantou	Fujian	China
3202	Tangzhai	Anhui Sheng	China
3203	Tangshan	Hebei	China
3204	Tangping	Guangdong	China
3205	Tangjiazhuang	Hebei	China
3206	Binhe	Henan Sheng	China
3207	Tanggu	Tianjin Shi	China
3208	Taizhou	Jiangsu	China
3209	Taiyuan	Shanxi Sheng	China
3210	Taixing	Jiangsu	China
3211	Taishan	Guangdong	China
3213	Suzhou	Anhui Sheng	China
3214	Suozhen	Shandong Sheng	China
3215	Suizhou	Hubei	China
3216	Suixi	Anhui Sheng	China
3217	Suicheng	Jiangsu	China
3218	Suining	Sichuan	China
3219	Songjiang	Shanghai Shi	China
3220	Sishui	Shandong Sheng	China
3221	Laixi	Shandong Sheng	China
3222	Shouguang	Shandong Sheng	China
3223	Shizuishan	Ningxia Huizu Zizhiqu	China
3224	Shizilu	Shandong Sheng	China
3225	Shiyan	Hubei	China
3226	Shiyan	Hubei	China
3227	Shiwan	Guangdong	China
3228	Shitanjing	Ningxia Huizu Zizhiqu	China
3229	Shiqiao	Guangdong	China
3230	Shiqi	Guangdong	China
3231	Shima	Fujian	China
3232	Shilong	Guangdong	China
3233	Tongchuan	Shaanxi	China
3234	Shijiazhuang	Hebei	China
3235	Shenzhen	Guangdong	China
3236	Yanta	Shandong Sheng	China
3237	Shenjiamen	Zhejiang Sheng	China
3238	Shashi	Hubei	China
3239	Shaping	Guangdong	China
3240	Shaoxing	Zhejiang Sheng	China
3241	Shaowu	Fujian	China
3242	Shaoguan	Guangdong	China
3243	Shancheng	Shandong Sheng	China
3244	Shanwei	Guangdong	China
3245	Shantou	Guangdong	China
3246	Shanting	Shandong Sheng	China
3247	Shanghai	Shanghai Shi	China
3248	Shahecheng	Hebei	China
3249	Sanya	Hainan	China
3250	Sanming	Fujian	China
3251	Runing	Henan Sheng	China
3252	Fuqing	Fujian	China
3253	Jieyang	Guangdong	China
3254	Rizhao	Shandong Sheng	China
3255	Renqiu	Hebei	China
3256	Quzhou	Zhejiang Sheng	China
3257	Qujing	Yunnan	China
3258	Qufu	Shandong Sheng	China
3259	Quanzhou	Fujian	China
3260	Wuxi	Hunan	China
3261	Zhuangyuan	Shandong Sheng	China
3262	Qiongshan	Hainan	China
3263	Qionghu	Hunan	China
3264	Qinzhou	Guangxi Zhuangzu Zizhiqu	China
3265	Qinnan	Jiangsu	China
3266	Qinhuangdao	Hebei	China
3267	Jinjiang	Fujian	China
3268	Qingquan	Hubei	China
3269	Huaian	Jiangsu	China
5364	Ali Sabieh	Ali Sabieh	Djibouti
5365	Viborg	Central Jutland	Denmark
5366	Vejle	South Denmark	Denmark
5368	Taastrup	Capital Region	Denmark
5369	Svendborg	South Denmark	Denmark
5372	Slagelse	Zealand	Denmark
5373	Skive	Central Jutland	Denmark
5374	Silkeborg	Central Jutland	Denmark
5375	Roskilde	Zealand	Denmark
5377	Ringsted	Zealand	Denmark
5378	Randers	Central Jutland	Denmark
5379	Odense	South Denmark	Denmark
5381	Nyborg	South Denmark	Denmark
5387	Copenhagen	Capital Region	Denmark
5388	Kolding	South Denmark	Denmark
5389	Kalundborg	Zealand	Denmark
5391	Hvidovre	Capital Region	Denmark
5392	Horsens	Central Jutland	Denmark
5394	Holstebro	Central Jutland	Denmark
5398	Herning	Central Jutland	Denmark
5400	Haderslev	South Denmark	Denmark
5401	Greve	Zealand	Denmark
5402	Glostrup	Capital Region	Denmark
5403	Frederikshavn	North Denmark	Denmark
5404	Frederiksberg	Capital Region	Denmark
5405	Fredericia	South Denmark	Denmark
5406	Farum	Capital Region	Denmark
5407	Esbjerg	South Denmark	Denmark
5408	Charlottenlund	Capital Region	Denmark
5410	Ballerup	Capital Region	Denmark
5412	Aalborg	North Denmark	Denmark
5413	Albertslund	Capital Region	Denmark
5414	Aabenraa	South Denmark	Denmark
5415	Roseau	Saint George	Dominica
5416	Villa Francisca	Nacional	Dominican Republic
5417	Villa Consuelo	Nacional	Dominican Republic
5420	Tamboril	Santiago	Dominican Republic
5421	Santo Domingo	Nacional	Dominican Republic
5422	Santiago de los Caballeros	Santiago	Dominican Republic
5424	Santa Cruz de Barahona	Barahona	Dominican Republic
5426	San Juan de la Maguana	San Juan	Dominican Republic
5429	San Fernando de Monte Cristi	Monte Cristi	Dominican Republic
5430	Puerto Plata	Puerto Plata	Dominican Republic
5432	Salcedo	Hermanas Mirabal	Dominican Republic
5437	Punta Cana	La Altagracia	Dominican Republic
5438	Neiba	Baoruco	Dominican Republic
5440	Monte Plata	Monte Plata	Dominican Republic
5441	Moca	Espaillat	Dominican Republic
5442	Mao	Valverde	Dominican Republic
5444	La Romana	La Romana	Dominican Republic
5445	Jarabacoa	La Vega	Dominican Republic
5446	Hato Mayor del Rey	Hato Mayor	Dominican Republic
5447	Esperanza	Valverde	Dominican Republic
5450	Constanza	La Vega	Dominican Republic
5452	Ciudad Nueva	Nacional	Dominican Republic
5454	Boca Chica	Santo Domingo	Dominican Republic
5456	Bella Vista	Nacional	Dominican Republic
5457	Bayaguana	Monte Plata	Dominican Republic
5460	Azua	Azua	Dominican Republic
5461	Santo Domingo Oeste	Santo Domingo	Dominican Republic
5462	Boumerdas	Boumerdes	Algeria
5463	Zeribet el Oued	Biskra	Algeria
5464	Zeralda	Tipaza	Algeria
5465	Zemoura	Relizane	Algeria
5466	Touggourt	Ouargla	Algeria
5467	Tolga	Biskra	Algeria
5468	Tlemcen	Tlemcen	Algeria
5469	Tizi Rached	Tizi Ouzou	Algeria
5470	Tizi Ouzou	Tizi Ouzou	Algeria
5471	Tizi-n-Tleta	Tizi Ouzou	Algeria
5472	Tizi Gheniff	Boumerdes	Algeria
5473	Tissemsilt	Tissemsilt	Algeria
5474	Tirmitine	Tizi Ouzou	Algeria
5475	Tipasa	Tipaza	Algeria
5476	Tindouf	Tindouf	Algeria
5477	Timizart	Tizi Ouzou	Algeria
5478	Timimoun	Adrar	Algeria
5480	Tiaret	Tiaret	Algeria
5482	Thenia	Boumerdes	Algeria
5483	Telerghma	Mila	Algeria
5485	Tebesbest	Ouargla	Algeria
5486	Tazoult-Lambese	Batna	Algeria
5487	Tamanrasset	Tamanghasset	Algeria
5488	Tamalous	Skikda	Algeria
5490	Sour el Ghozlane	Bouira	Algeria
5491	Souma	Blida	Algeria
5492	Lardjem	Tissemsilt	Algeria
5493	Souk Ahras	Souk Ahras	Algeria
5494	Sougueur	Tiaret	Algeria
5495	Skikda	Skikda	Algeria
5496	Sig	Mascara	Algeria
5497	Sidi Okba	Biskra	Algeria
5498	Sidi Moussa	Blida	Algeria
5500	Sidi Khaled	Biskra	Algeria
5501	Sidi ech Chahmi	Oran	Algeria
5503	Sidi Amrane	Ouargla	Algeria
5504	Sidi Akkacha	Chlef	Algeria
5539	Mostaganem	Mostaganem	Algeria
5540	Mila	Mila	Algeria
5542	Messaad	Djelfa	Algeria
5543	Meskiana	Oum el Bouaghi	Algeria
5544	Mers el Kebir	Oran	Algeria
5545	Merouana	Batna	Algeria
5547	Mekla	Tizi Ouzou	Algeria
5548	Mehdia	Tiaret	Algeria
5549	Megarine	Ouargla	Algeria
5550	Meftah	Blida	Algeria
5552	Mazouna	Relizane	Algeria
5553	Mascara	Mascara	Algeria
5556	Makouda	Boumerdes	Algeria
5559	Lakhdaria	Bouira	Algeria
5560	Laghouat	Laghouat	Algeria
5562	Ksar Chellala	Tiaret	Algeria
5563	Kolea	Tipaza	Algeria
5564	Khenchela	Khenchela	Algeria
5566	Khemis el Khechna	Boumerdes	Algeria
5567	Kerkera	Skikda	Algeria
5568	Jijel	Jijel	Algeria
5569	Djidiouia	Relizane	Algeria
5570	Isser	Boumerdes	Algeria
5571	I-n-Salah	Tamanghasset	Algeria
5572	Ighram	Tizi Ouzou	Algeria
5573	Hennaya	Tlemcen	Algeria
5575	Hassi Messaoud	Ouargla	Algeria
5578	Hamma Bouziane	Constantine	Algeria
5579	Hadjout	Tipaza	Algeria
5580	Guelma	Guelma	Algeria
5582	Frenda	Tiaret	Algeria
5583	Freha	Tizi Ouzou	Algeria
5585	Es Senia	Oran	Algeria
5586	El Tarf	El Tarf	Algeria
5587	El Oued	El Oued	Algeria
5590	El Khroub	Constantine	Algeria
5591	El Kala	El Tarf	Algeria
5592	El Idrissia	Djelfa	Algeria
5593	El Hadjira	Ouargla	Algeria
5594	El Hadjar	Annaba	Algeria
5596	El Bayadh	El Bayadh	Algeria
5598	Chlef	Chlef	Algeria
5599	El Aouinet	Oum el Bouaghi	Algeria
5601	El Affroun	Tipaza	Algeria
5603	El Abiodh Sidi Cheikh	El Bayadh	Algeria
5605	Ech Chettia	Chlef	Algeria
5606	Drean	Annaba	Algeria
5607	Draa el Mizan	Bouira	Algeria
5608	Draa Ben Khedda	Boumerdes	Algeria
5609	Douera	Tipaza	Algeria
5610	Djelfa	Djelfa	Algeria
5611	Djamaa	Ouargla	Algeria
5612	Didouche Mourad	Constantine	Algeria
5613	Dellys	Boumerdes	Algeria
5614	Debila	El Oued	Algeria
5616	Dar Chioukh	Djelfa	Algeria
5617	Constantine	Constantine	Algeria
5618	Chorfa	Bouira	Algeria
5619	Chiffa	Blida	Algeria
5620	Chetouane	Tlemcen	Algeria
5622	Cheraga	Tipaza	Algeria
5623	Chemini	Tizi Ouzou	Algeria
5625	Chebli	Blida	Algeria
5626	Charef	Djelfa	Algeria
5627	Chabet el Ameur	Boumerdes	Algeria
5628	Brezina	El Bayadh	Algeria
5629	Bou Tlelis	Oran	Algeria
5630	Boumahra Ahmed	Guelma	Algeria
5631	Boukadir	Chlef	Algeria
5634	Bouinan	Blida	Algeria
5635	Bou Hanifia el Hamamat	Mascara	Algeria
5636	Bougara	Blida	Algeria
5638	Boufarik	Blida	Algeria
5639	Boudouaou	Boumerdes	Algeria
5640	Boudjima	Tizi Ouzou	Algeria
5644	Bordj el Kiffan	Alger	Algeria
5646	Boghni	Tizi Ouzou	Algeria
5647	Blida	Blida	Algeria
5648	Biskra	Biskra	Algeria
5649	Birkhadem	Alger	Algeria
5650	Birine	Djelfa	Algeria
5651	Bir el Djir	Oran	Algeria
5653	Besbes	El Tarf	Algeria
5656	Berrahal	Annaba	Algeria
5657	Bensekrane	Tlemcen	Algeria
5658	Ben Mehidi	El Tarf	Algeria
5660	Beni Mester	Tlemcen	Algeria
5661	Beni Mered	Blida	Algeria
5662	Beni Douala	Tizi Ouzou	Algeria
5663	Beni Amrane	Boumerdes	Algeria
5666	Batna	Batna	Algeria
5667	Barika	Batna	Algeria
5669	Baraki	Tipaza	Algeria
5670	Bab Ezzouar	Alger	Algeria
5671	Azzaba	Skikda	Algeria
5672	Azazga	Tizi Ouzou	Algeria
5673	Arris	Batna	Algeria
5674	Arhribs	Tizi Ouzou	Algeria
5675	Arbatache	Boumerdes	Algeria
5676	Aoulef	Adrar	Algeria
5677	Annaba	Annaba	Algeria
5678	Ammi Moussa	Relizane	Algeria
5680	Algiers	Alger	Algeria
5705	Aflou	Laghouat	Algeria
5706	Adrar	Adrar	Algeria
5707	Abou el Hassan	Chlef	Algeria
5709	Zamora	Zamora-Chinchipe	Ecuador
5710	Yaguachi Nuevo	Guayas	Ecuador
5713	Velasco Ibarra	Guayas	Ecuador
5715	Tena	Napo	Ecuador
5718	Santa Rosa	El Oro	Ecuador
5719	Santa Elena	Santa Elena	Ecuador
5720	San Lorenzo de Esmeraldas	Esmeraldas	Ecuador
5721	San Gabriel	Carchi	Ecuador
5723	Salinas	Santa Elena	Ecuador
5724	Rosa Zarate	Esmeraldas	Ecuador
5725	Riobamba	Chimborazo	Ecuador
5726	Quito	Pichincha	Ecuador
5728	Puyo	Pastaza	Ecuador
5730	Puerto Francisco de Orellana	Orellana	Ecuador
5732	Playas	Guayas	Ecuador
5734	Pelileo	Tungurahua	Ecuador
5735	Pedro Carbo	Guayas	Ecuador
5736	Pasaje	El Oro	Ecuador
5737	Otavalo	Imbabura	Ecuador
5738	Naranjito	Guayas	Ecuador
5739	Naranjal	Guayas	Ecuador
5743	Machala	El Oro	Ecuador
5744	Machachi	Pichincha	Ecuador
5745	Macas	Morona-Santiago	Ecuador
5746	Loja	Loja	Ecuador
5748	Latacunga	Cotopaxi	Ecuador
5750	La Libertad	Guayas	Ecuador
5751	Nueva Loja	Sucumbios	Ecuador
5753	Ibarra	Imbabura	Ecuador
5754	Huaquillas	El Oro	Ecuador
5755	Guayaquil	Guayas	Ecuador
5757	Gualaceo	Azuay	Ecuador
5758	Esmeraldas	Esmeraldas	Ecuador
5759	El Triunfo	Guayas	Ecuador
5760	Eloy Alfaro	Guayas	Ecuador
5761	Cuenca	Azuay	Ecuador
5763	Cayambe	Pichincha	Ecuador
5764	Catamayo	Loja	Ecuador
5765	Cariamanga	Loja	Ecuador
5767	Boca Suno	Orellana	Ecuador
5768	Balzar	Guayas	Ecuador
5772	Atuntaqui	Imbabura	Ecuador
5773	Ambato	Tungurahua	Ecuador
5774	Tutamandahostel	Pichincha	Ecuador
5775	Viljandi	Viljandimaa	Estonia
5776	Tartu	Tartu	Estonia
5777	Tallinn	Harjumaa	Estonia
5781	Narva	Ida-Virumaa	Estonia
5782	Maardu	Harjumaa	Estonia
5790	Tahta	Suhaj	Egypt
5792	Sohag	Suhaj	Egypt
5793	Sidi Salim	Kafr ash Shaykh	Egypt
5798	Samalut	Al Minya	Egypt
5799	Rosetta	Al Bu?ayrah	Egypt
5800	Ras Gharib	Red Sea	Egypt
5803	Kousa	Qina	Egypt
5804	Qina	Qina	Egypt
5809	Matay	Al Minya	Egypt
5810	Mashtul as Suq	Eastern Province	Egypt
5812	Manfalut	Asyut	Egypt
5813	Mallawi	Al Minya	Egypt
5814	Madinat Sittah Uktubar	Al Jizah	Egypt
5815	Kawm Umbu	Aswan	Egypt
5816	Kawm ?amadah	Al Bu?ayrah	Egypt
5817	Kafr Saqr	Eastern Province	Egypt
5819	Kafr ash Shaykh	Kafr ash Shaykh	Egypt
5820	Kafr ad Dawwar	Al Bu?ayrah	Egypt
5821	Juhaynah	Suhaj	Egypt
5822	Jirja	Suhaj	Egypt
5825	Isna	Qina	Egypt
5826	Idku	Al Bu?ayrah	Egypt
5827	Idfu	Aswan	Egypt
5829	?alwan	Cairo Governorate	Egypt
5830	Hihya	Eastern Province	Egypt
5832	Fuwwah	Kafr ash Shaykh	Egypt
5833	Farshut	Qina	Egypt
5834	Faraskur	Dumyat	Egypt
5835	Faqus	Eastern Province	Egypt
5836	Damietta	Dumyat	Egypt
5837	Diyarb Najm	Eastern Province	Egypt
5838	Disuq	Kafr ash Shaykh	Egypt
5839	Dishna	Qina	Egypt
5841	Dayrut	Asyut	Egypt
5842	Dayr Mawas	Al Minya	Egypt
5843	Damanhur	Al Bu?ayrah	Egypt
5846	Bur Safajah	Red Sea	Egypt
5848	Bilbays	Eastern Province	Egypt
5851	Bani Mazar	Al Minya	Egypt
5853	Zagazig	Eastern Province	Egypt
5854	Awsim	Al Jizah	Egypt
5856	Asyut	Asyut	Egypt
5857	Aswan	Aswan	Egypt
5858	Suez	As Suways	Egypt
5859	As Saff	Al Jizah	Egypt
5863	Luxor	Luxor	Egypt
5864	Al Qusiyah	Asyut	Egypt
5865	Al Qusayr	Red Sea	Egypt
5866	Al Qurayn	Eastern Province	Egypt
5867	Al Qanayat	Eastern Province	Egypt
5869	Cairo	Cairo Governorate	Egypt
5870	Al Minya	Al Minya	Egypt
5874	Al Manshah	Suhaj	Egypt
5878	Al Jizah	Al Jizah	Egypt
5881	Alexandria	Alexandria	Egypt
5882	Al Ibrahimiyah	Eastern Province	Egypt
5883	Al ?awamidiyah	Al Jizah	Egypt
5884	Al ?amul	Kafr ash Shaykh	Egypt
5885	Hurghada	Red Sea	Egypt
5888	Al Bawiti	Al Jizah	Egypt
5889	Al Balyana	Suhaj	Egypt
5891	Al Badari	Asyut	Egypt
5893	Arish	Shamal Sina	Egypt
5910	Asmara	Maakel	Eritrea
5911	Assab	Debubawi Keyih Bahri	Eritrea
6059	LEliana	Valencia	Spain
6060	La Carolina	Andalusia	Spain
6061	Jumilla	Murcia	Spain
6062	Jerez de la Frontera	Andalusia	Spain
6063	Javea	Valencia	Spain
6066	Isla Cristina	Andalusia	Spain
6067	Ingenio	Canary Islands	Spain
6068	Inca	Balearic Islands	Spain
6069	Icod de los Vinos	Canary Islands	Spain
6070	Ibiza	Balearic Islands	Spain
6071	Ibi	Valencia	Spain
6073	Huelva	Andalusia	Spain
6077	Guardamar del Segura	Valencia	Spain
6078	Guadix	Andalusia	Spain
6079	Granadilla de Abona	Canary Islands	Spain
6080	Granada	Andalusia	Spain
6081	Gandia	Valencia	Spain
6083	Fuengirola	Andalusia	Spain
6084	Felanitx	Balearic Islands	Spain
6085	Estepona	Andalusia	Spain
6086	El Viso del Alcor	Andalusia	Spain
6088	El Ejido	Andalusia	Spain
6089	Elda	Valencia	Spain
6090	Elche	Valencia	Spain
6091	El Arahal	Andalusia	Spain
6093	Dos Hermanas	Andalusia	Spain
6094	Don Benito	Extremadura	Spain
6095	Denia	Valencia	Spain
6096	Daimiel	Castille-La Mancha	Spain
6097	Cullera	Valencia	Spain
6098	Quart de Poblet	Valencia	Spain
6099	Crevillente	Valencia	Spain
6102	Conil de la Frontera	Andalusia	Spain
6104	Ciudad Real	Castille-La Mancha	Spain
6105	Cieza	Murcia	Spain
6106	Xirivella	Valencia	Spain
6107	Chipiona	Andalusia	Spain
6108	Chiclana de la Frontera	Andalusia	Spain
6110	Catarroja	Valencia	Spain
6111	Castilleja de la Cuesta	Andalusia	Spain
6113	Cartaya	Andalusia	Spain
6115	Cartagena	Murcia	Spain
6116	Carmona	Andalusia	Spain
6117	Carlet	Valencia	Spain
6118	Carcaixent	Valencia	Spain
6119	Caravaca	Murcia	Spain
6120	Candelaria	Canary Islands	Spain
6121	Campo de Criptana	Castille-La Mancha	Spain
6123	el Campello	Valencia	Spain
6124	Camas	Andalusia	Spain
6126	Calp	Valencia	Spain
6127	Callosa de Segura	Valencia	Spain
6128	Cadiz	Andalusia	Spain
6130	Cabra	Andalusia	Spain
6131	Burriana	Valencia	Spain
6132	Burjassot	Valencia	Spain
6133	Bormujos	Andalusia	Spain
6135	Berja	Andalusia	Spain
6136	Benidorm	Valencia	Spain
6139	Baza	Andalusia	Spain
6140	Barbate de Franco	Andalusia	Spain
6142	Baeza	Andalusia	Spain
6143	Baena	Andalusia	Spain
6144	Badajoz	Extremadura	Spain
6145	Ayamonte	Andalusia	Spain
6146	Atarfe	Andalusia	Spain
6148	Aspe	Valencia	Spain
6149	Arucas	Canary Islands	Spain
6150	Arrecife	Canary Islands	Spain
6151	Arona	Canary Islands	Spain
6152	Armilla	Andalusia	Spain
6153	Arcos de la Frontera	Andalusia	Spain
6154	Archena	Murcia	Spain
6155	Antequera	Andalusia	Spain
6157	Altea	Valencia	Spain
6160	Almonte	Andalusia	Spain
6162	Almendralejo	Extremadura	Spain
6163	Almassora	Valencia	Spain
6164	Almansa	Castille-La Mancha	Spain
6165	Aljaraque	Andalusia	Spain
6166	Alicante	Valencia	Spain
6169	Alhama de Murcia	Murcia	Spain
6171	Algeciras	Andalusia	Spain
6172	Alfafar	Valencia	Spain
6173	Aldaia	Valencia	Spain
6175	Alcoy	Valencia	Spain
6176	Alzira	Valencia	Spain
6178	Alcantarilla	Murcia	Spain
6181	Alboraya	Valencia	Spain
6182	Albolote	Andalusia	Spain
6183	Albal	Valencia	Spain
6184	Albacete	Castille-La Mancha	Spain
6188	Adra	Andalusia	Spain
6189	Adeje	Canary Islands	Spain
6190	Groa de Murviedro	Valencia	Spain
6191	Zarautz	Basque Country	Spain
6192	Zaragoza	Aragon	Spain
6194	Viveiro	Galicia	Spain
6195	Gasteiz / Vitoria	Basque Country	Spain
6198	Villaverde	Madrid	Spain
6201	Villanueva del Pardillo	Madrid	Spain
6203	Vilalba	Galicia	Spain
6206	Vila-seca	Catalonia	Spain
6207	Vilaseca	Catalonia	Spain
6208	Viladecans	Catalonia	Spain
6209	Vigo	Galicia	Spain
6210	Vic	Catalonia	Spain
6212	El Vendrell	Catalonia	Spain
6213	Valls	Catalonia	Spain
6215	Valdemoro	Madrid	Spain
6216	Rivas-Vaciamadrid	Madrid	Spain
6217	Utebo	Aragon	Spain
6218	Tui	Galicia	Spain
6219	Tudela	Navarre	Spain
6220	Tortosa	Catalonia	Spain
6221	Torrelodones	Madrid	Spain
6222	Torrelavega	Cantabria	Spain
6224	Torredembarra	Catalonia	Spain
6225	Tordera	Catalonia	Spain
6226	Tolosa	Basque Country	Spain
6228	Teruel	Aragon	Spain
6229	Teo	Galicia	Spain
6231	Terrassa	Catalonia	Spain
6232	Tarragona	Catalonia	Spain
6235	Sitges	Catalonia	Spain
6236	Sestao	Basque Country	Spain
6241	Barakaldo	Basque Country	Spain
6242	Santurtzi	Basque Country	Spain
6243	Sant Just Desvern	Catalonia	Spain
6244	Santiago de Compostela	Galicia	Spain
6246	Santander	Cantabria	Spain
6248	Santa Coloma de Gramenet	Catalonia	Spain
6252	Sant Pere de Ribes	Catalonia	Spain
6254	San Lorenzo de El Escorial	Madrid	Spain
6255	Vilassar de Mar	Catalonia	Spain
6257	Sanxenxo	Galicia	Spain
6258	San Fernando de Henares	Madrid	Spain
6259	Sant Feliu de Llobregat	Catalonia	Spain
6262	Sant Celoni	Catalonia	Spain
6264	Sant Boi de Llobregat	Catalonia	Spain
6265	Sant Andreu de Palomar	Catalonia	Spain
6267	Sant Andreu de la Barca	Catalonia	Spain
6269	Sama	Asturias	Spain
6270	Salt	Catalonia	Spain
6271	Salou	Catalonia	Spain
6273	Sabadell	Catalonia	Spain
6275	Roses	Catalonia	Spain
6276	Ripollet	Catalonia	Spain
6277	Ribeira	Galicia	Spain
6278	Reus	Catalonia	Spain
6279	Errenteria	Basque Country	Spain
6280	Redondela	Galicia	Spain
6281	Puente de Vallecas	Madrid	Spain
6282	Ponteareas	Galicia	Spain
6285	Poio	Galicia	Spain
6286	Portugalete	Basque Country	Spain
6288	Pontevedra	Galicia	Spain
6290	Plasencia	Extremadura	Spain
6291	Pinto	Madrid	Spain
6292	Pineda de Mar	Catalonia	Spain
6293	Parla	Madrid	Spain
6295	Pamplona	Navarre	Spain
6298	Palafrugell	Catalonia	Spain
6299	Oviedo	Asturias	Spain
6300	Oria	Basque Country	Spain
6301	Ourense	Galicia	Spain
6302	Olot	Catalonia	Spain
6303	Olesa de Montserrat	Catalonia	Spain
6304	Oleiros	Galicia	Spain
6306	Navalcarnero	Madrid	Spain
6308	Mungia	Basque Country	Spain
6310	Moratalaz	Madrid	Spain
6313	Monforte de Lemos	Galicia	Spain
6315	Montcada i Reixac	Catalonia	Spain
6317	Molins de Rei	Catalonia	Spain
6320	Mieres	Asturias	Spain
6321	Mejorada del Campo	Madrid	Spain
6324	El Masnou	Catalonia	Spain
6325	Martorell	Catalonia	Spain
6327	Manresa	Catalonia	Spain
6328	Manlleu	Catalonia	Spain
6329	Malgrat de Mar	Catalonia	Spain
6330	Majadahonda	Madrid	Spain
6331	Madrid	Madrid	Spain
6332	Lugo	Galicia	Spain
6334	Lloret de Mar	Catalonia	Spain
6335	Laudio / Llodio	Basque Country	Spain
6336	Lleida	Catalonia	Spain
6338	Leioa	Basque Country	Spain
6340	Las Rozas de Madrid	Madrid	Spain
6341	Lasarte	Basque Country	Spain
6342	La Pineda	Catalonia	Spain
6345	A Estrada	Galicia	Spain
6347	Irun	Basque Country	Spain
6348	Illescas	Castille-La Mancha	Spain
6349	Igualada	Catalonia	Spain
6350	Humanes de Madrid	Madrid	Spain
6351	Huesca	Aragon	Spain
6352	LHospitalet de Llobregat	Catalonia	Spain
6463	Las Gabias	Andalusia	Spain
6464	Delicias	Aragon	Spain
6465	Almozara	Aragon	Spain
6466	Montecanal	Aragon	Spain
6467	Oliver-Valdefierro	Aragon	Spain
6468	Santutxu	Basque Country	Spain
6469	Los Realejos	Canary Islands	Spain
6470	Pasaia	Basque Country	Spain
6471	Basauri	Basque Country	Spain
6473	Corvera de Asturias	Asturias	Spain
6474	Tres Cantos	Madrid	Spain
6475	Iturrama	Navarre	Spain
6477	Primer Ensanche	Navarre	Spain
6478	Segundo Ensanche	Navarre	Spain
6479	Fuencarral-El Pardo	Madrid	Spain
6480	Villa de Vallecas	Madrid	Spain
6481	Natahoyo	Asturias	Spain
6482	Ziway	Oromiya	Ethiopia
6484	Yabelo	Oromiya	Ethiopia
6485	Werota	Amhara	Ethiopia
6486	Wenji	Oromiya	Ethiopia
6487	Tippi	"Southern Nations	Ethiopia
6488	Shashemene	Oromiya	Ethiopia
6489	Shambu	Oromiya	Ethiopia
6490	Shakiso	Oromiya	Ethiopia
6491	Sebeta	Oromiya	Ethiopia
6492	Robit	Amhara	Ethiopia
6493	Nejo	Oromiya	Ethiopia
6494	Nazret	Oromiya	Ethiopia
6495	Mojo	Oromiya	Ethiopia
6496	Metu	Oromiya	Ethiopia
6497	Metahara	Oromiya	Ethiopia
6498	Mendi	Oromiya	Ethiopia
6499	Mekele	Tigray	Ethiopia
6501	Korem	Tigray	Ethiopia
6503	Kibre Mengist	Oromiya	Ethiopia
6504	Kemise	Amhara	Ethiopia
6505	Kombolcha	Amhara	Ethiopia
6506	Jinka	"Southern Nations	Ethiopia
6507	Jima	Oromiya	Ethiopia
6508	Jijiga	Somali	Ethiopia
6509	Inda Silase	Tigray	Ethiopia
6510	Harar	Harari	Ethiopia
6511	Hagere Hiywet	Oromiya	Ethiopia
6512	Gondar	Amhara	Ethiopia
6513	Goba	Oromiya	Ethiopia
6514	Waliso	Oromiya	Ethiopia
6515	Ginir	Oromiya	Ethiopia
6516	Gimbi	Oromiya	Ethiopia
6517	Genet	Oromiya	Ethiopia
6518	Gelemso	Oromiya	Ethiopia
6519	Gebre Guracha	Oromiya	Ethiopia
6520	Gambela	Gambela	Ethiopia
6521	Finote Selam	Amhara	Ethiopia
6522	Fiche	Oromiya	Ethiopia
6523	Felege Neway	"Southern Nations	Ethiopia
6524	Dubti	Afar	Ethiopia
6525	Dodola	Oromiya	Ethiopia
6526	Dire Dawa	Dire Dawa	Ethiopia
6527	Dila	"Southern Nations	Ethiopia
6528	Dese	Amhara	Ethiopia
6529	Dembi Dolo	Oromiya	Ethiopia
6530	Bishoftu	Oromiya	Ethiopia
6531	Debre Tabor	Amhara	Ethiopia
6533	Debre Birhan	Amhara	Ethiopia
6535	Butajira	"Southern Nations	Ethiopia
6536	Bure	Amhara	Ethiopia
6537	Bonga	"Southern Nations	Ethiopia
6538	Boditi	"Southern Nations	Ethiopia
6539	Bichena	Amhara	Ethiopia
6540	Bedesa	Oromiya	Ethiopia
6541	Bedele	Oromiya	Ethiopia
6542	Bati	Amhara	Ethiopia
6543	Bako	"Southern Nations	Ethiopia
6544	Bahir Dar	Amhara	Ethiopia
6545	Hawassa	"Southern Nations	Ethiopia
6546	Asosa	Binshangul Gumuz	Ethiopia
6547	Asbe Teferi	Oromiya	Ethiopia
6548	Asaita	Afar	Ethiopia
6549	Asasa	Oromiya	Ethiopia
6550	Areka	"Southern Nations	Ethiopia
6552	Axum	Tigray	Ethiopia
6553	Hagere Maryam	Oromiya	Ethiopia
6554	Agaro	Oromiya	Ethiopia
6555	Adis Zemen	Amhara	Ethiopia
6556	Addis Ababa	Adis Abeba	Ethiopia
6557	Adigrat	Tigray	Ethiopia
6558	Addiet Canna	Amhara	Ethiopia
6559	Abomsa	Amhara	Ethiopia
6561	Vihti	Uusimaa	Finland
6562	Varkaus	Northern Savo	Finland
6563	Vantaa	Uusimaa	Finland
6564	Valkeakoski	Pirkanmaa	Finland
6565	Vaasa	Ostrobothnia	Finland
6566	Uusikaupunki	Southwest Finland	Finland
6567	Tuusula	Uusimaa	Finland
6568	Turku	Southwest Finland	Finland
6569	Tornio	Lapland	Finland
6570	Tampere	Pirkanmaa	Finland
6572	Sibbo	Uusimaa	Finland
6574	Savonlinna	Southern Savonia	Finland
6575	Salo	Southwest Finland	Finland
6576	Rovaniemi	Lapland	Finland
6578	Rauma	Satakunta	Finland
6579	Raisio	Southwest Finland	Finland
6580	Raahe	Northern Ostrobothnia	Finland
6581	Pori	Satakunta	Finland
6582	Pirkkala	Pirkanmaa	Finland
6583	Oulu	Northern Ostrobothnia	Finland
6585	Nokia	Pirkanmaa	Finland
6586	Mikkeli	Southern Savonia	Finland
6588	Lovisa	Uusimaa	Finland
6589	Lohja	Uusimaa	Finland
6590	Lieto	Southwest Finland	Finland
6592	Laukaa	Central Finland	Finland
6593	Lappeenranta	South Karelia	Finland
6595	Kirkkonummi	Uusimaa	Finland
6596	Kuusamo	Northern Ostrobothnia	Finland
6597	Kuopio	Northern Savo	Finland
6598	Kouvola	Kymenlaakso	Finland
6599	Kotka	Kymenlaakso	Finland
6600	Korsholm	Ostrobothnia	Finland
6601	Kokkola	Central Ostrobothnia	Finland
6602	Kerava	Uusimaa	Finland
6603	Kemi	Lapland	Finland
6604	Karhula	Kymenlaakso	Finland
6605	Kangasala	Pirkanmaa	Finland
6606	Kajaani	Kainuu	Finland
6607	Kaarina	Southwest Finland	Finland
6609	Joensuu	North Karelia	Finland
6613	Jakobstad	Ostrobothnia	Finland
6614	Imatra	South Karelia	Finland
6615	Iisalmi	Northern Savo	Finland
6616	Hyvinge	Uusimaa	Finland
6618	Helsinki	Uusimaa	Finland
6620	Haukipudas	Northern Ostrobothnia	Finland
6621	Hamina	Kymenlaakso	Finland
6624	Espoo	Uusimaa	Finland
6625	Porvoo	Uusimaa	Finland
6626	Anjala	Kymenlaakso	Finland
6628	Suva	Central	Fiji
6629	Nadi	Western	Fiji
6630	Lautoka	Western	Fiji
6631	Labasa	Northern	Fiji
6632	Stanley	N/A	Falkland Islands
6633	Palikir - National Government Center	Pohnpei	Micronesia
6636	Wittenheim	Alsace-Champagne-Ardenne-Lorraine	France
6637	Wattrelos	Nord-Pas-de-Calais-Picardie	France
6638	Wasquehal	Nord-Pas-de-Calais-Picardie	France
6653	Villeneuve-sur-Lot	Aquitaine-Limousin-Poitou-Charentes	France
6663	Vierzon	Centre	France
6667	Vertou	Pays de la Loire	France
6670	Vernon	Normandy	France
6672	Verdun	Alsace-Champagne-Ardenne-Lorraine	France
6680	Vannes	Brittany	France
6683	Valenciennes	Nord-Pas-de-Calais-Picardie	France
6685	Tulle	Aquitaine-Limousin-Poitou-Charentes	France
6686	Troyes	Alsace-Champagne-Ardenne-Lorraine	France
6689	Tours	Centre	France
6691	Tourlaville	Normandy	France
6692	Tourcoing	Nord-Pas-de-Calais-Picardie	France
6695	Toul	Alsace-Champagne-Ardenne-Lorraine	France
6698	Thionville	Alsace-Champagne-Ardenne-Lorraine	France
6700	Tergnier	Nord-Pas-de-Calais-Picardie	France
6704	Talence	Aquitaine-Limousin-Poitou-Charentes	France
6707	Strasbourg	Alsace-Champagne-Ardenne-Lorraine	France
6712	Soissons	Nord-Pas-de-Calais-Picardie	France
6714	Sin-le-Noble	Nord-Pas-de-Calais-Picardie	France
6720	Senlis	Nord-Pas-de-Calais-Picardie	France
6722	Sedan	Alsace-Champagne-Ardenne-Lorraine	France
6723	Schiltigheim	Alsace-Champagne-Ardenne-Lorraine	France
6727	Saumur	Pays de la Loire	France
6729	Sarreguemines	Alsace-Champagne-Ardenne-Lorraine	France
6731	Saran	Centre	France
6738	Saint-Quentin	Nord-Pas-de-Calais-Picardie	France
6740	Saint-Pol-sur-Mer	Nord-Pas-de-Calais-Picardie	France
6741	Saint-Pierre-des-Corps	Centre	France
6744	Saint-Omer	Nord-Pas-de-Calais-Picardie	France
6745	Saint-Nazaire	Pays de la Loire	France
6752	Saint-Malo	Brittany	France
6753	Saint-Louis	Alsace-Champagne-Ardenne-Lorraine	France
6758	Saint-Jean-de-la-Ruelle	Centre	France
6759	Saint-Jean-de-Braye	Centre	France
6760	Saint-Herblain	Pays de la Loire	France
6767	Saintes	Aquitaine-Limousin-Poitou-Charentes	France
6771	Saint-Dizier	Alsace-Champagne-Ardenne-Lorraine	France
6774	Saint-Cyr-sur-Loire	Centre	France
6778	Saint-Brieuc	Brittany	France
6779	Saint-Avold	Alsace-Champagne-Ardenne-Lorraine	France
6780	Saint-Avertin	Centre	France
6781	Saint-Amand-les-Eaux	Nord-Pas-de-Calais-Picardie	France
6783	Royan	Aquitaine-Limousin-Poitou-Charentes	France
6784	Rouen	Normandy	France
6785	Roubaix	Nord-Pas-de-Calais-Picardie	France
6787	Ronchin	Nord-Pas-de-Calais-Picardie	France
6788	Romorantin-Lanthenay	Centre	France
6793	Rochefort	Aquitaine-Limousin-Poitou-Charentes	France
6799	Rennes	Brittany	France
6800	Reims	Alsace-Champagne-Ardenne-Lorraine	France
6802	Quimper	Brittany	France
6806	Pontivy	Brittany	France
6809	Poitiers	Aquitaine-Limousin-Poitou-Charentes	France
6811	Ploemeur	Brittany	France
6815	Pessac	Aquitaine-Limousin-Poitou-Charentes	France
6819	Pau	Aquitaine-Limousin-Poitou-Charentes	France
6826	Outreau	Nord-Pas-de-Calais-Picardie	France
6829	Orvault	Pays de la Loire	France
6834	Olivet	Centre	France
6835	Octeville	Normandy	France
6836	Noyon	Nord-Pas-de-Calais-Picardie	France
6840	Nogent-sur-Oise	Nord-Pas-de-Calais-Picardie	France
6842	Niort	Aquitaine-Limousin-Poitou-Charentes	France
6850	Nantes	Pays de la Loire	France
6852	Nancy	Alsace-Champagne-Ardenne-Lorraine	France
6854	Mulhouse	Alsace-Champagne-Ardenne-Lorraine	France
6858	Morlaix	Brittany	France
6859	Mont-Saint-Aignan	Normandy	France
6865	Montivilliers	Normandy	France
6874	Mont-de-Marsan	Aquitaine-Limousin-Poitou-Charentes	France
6879	Montargis	Centre	France
6888	Metz	Alsace-Champagne-Ardenne-Lorraine	France
6893	Mayenne	Pays de la Loire	France
6896	Maubeuge	Nord-Pas-de-Calais-Picardie	France
6900	Marmande	Aquitaine-Limousin-Poitou-Charentes	France
6916	Louviers	Normandy	France
6918	Lormont	Aquitaine-Limousin-Poitou-Charentes	France
6919	Lorient	Brittany	France
6920	Loos	Nord-Pas-de-Calais-Picardie	France
6923	Lomme	Nord-Pas-de-Calais-Picardie	France
6927	Lisieux	Normandy	France
6928	Lingolsheim	Alsace-Champagne-Ardenne-Lorraine	France
6929	Limoges	Aquitaine-Limousin-Poitou-Charentes	France
6932	Lille	Nord-Pas-de-Calais-Picardie	France
6934	Libourne	Aquitaine-Limousin-Poitou-Charentes	France
6938	Les Sables-dOlonne	Pays de la Loire	France
6943	Les Herbiers	Pays de la Loire	France
6950	Le Petit-Quevilly	Normandy	France
6953	Lens	Nord-Pas-de-Calais-Picardie	France
6955	Le Mans	Pays de la Loire	France
6957	Le Havre	Normandy	France
6958	Le Grand-Quevilly	Normandy	France
6962	Le Bouscat	Aquitaine-Limousin-Poitou-Charentes	France
6964	Laxou	Alsace-Champagne-Ardenne-Lorraine	France
6966	Laval	Pays de la Loire	France
6968	La Teste-de-Buch	Aquitaine-Limousin-Poitou-Charentes	France
6970	La Roche-sur-Yon	Pays de la Loire	France
6971	La Rochelle	Aquitaine-Limousin-Poitou-Charentes	France
6972	Laon	Nord-Pas-de-Calais-Picardie	France
6973	Lannion	Brittany	France
6974	Lanester	Brittany	France
6975	Landerneau	Brittany	France
6976	Lambersart	Nord-Pas-de-Calais-Picardie	France
6977	La Madeleine	Nord-Pas-de-Calais-Picardie	France
6985	La Chapelle-sur-Erdre	Pays de la Loire	France
6994	Illzach	Alsace-Champagne-Ardenne-Lorraine	France
6995	Illkirch-Graffenstaden	Alsace-Champagne-Ardenne-Lorraine	France
7001	Hem	Nord-Pas-de-Calais-Picardie	France
7002	Hazebrouck	Nord-Pas-de-Calais-Picardie	France
7003	Hayange	Alsace-Champagne-Ardenne-Lorraine	France
7004	Hautmont	Nord-Pas-de-Calais-Picardie	France
7005	Yutz	Alsace-Champagne-Ardenne-Lorraine	France
7006	Haubourdin	Nord-Pas-de-Calais-Picardie	France
7007	Halluin	Nord-Pas-de-Calais-Picardie	France
7008	Haguenau	Alsace-Champagne-Ardenne-Lorraine	France
7010	Gujan-Mestras	Aquitaine-Limousin-Poitou-Charentes	France
7016	Grande-Synthe	Nord-Pas-de-Calais-Picardie	France
7017	Gradignan	Aquitaine-Limousin-Poitou-Charentes	France
7022	Gien	Centre	France
7036	Forbach	Alsace-Champagne-Ardenne-Lorraine	France
7038	Fontenay-le-Comte	Pays de la Loire	France
7042	Floirac	Aquitaine-Limousin-Poitou-Charentes	France
7043	Fleury-les-Aubrais	Centre	France
7044	Flers	Normandy	France
7047	Faches-Thumesnil	Nord-Pas-de-Calais-Picardie	France
7048	Eysines	Aquitaine-Limousin-Poitou-Charentes	France
7052	La Baule-Escoublac	Pays de la Loire	France
7059	Elbeuf	Normandy	France
7064	Dunkerque	Nord-Pas-de-Calais-Picardie	France
7065	Dreux	Centre	France
7069	Douarnenez	Brittany	France
7070	Douai	Nord-Pas-de-Calais-Picardie	France
7075	Dieppe	Normandy	France
7077	Denain	Nord-Pas-de-Calais-Picardie	France
7079	Dax	Aquitaine-Limousin-Poitou-Charentes	France
7082	Croix	Nord-Pas-de-Calais-Picardie	France
7085	Creil	Nord-Pas-de-Calais-Picardie	France
7091	Coudekerque-Branche	Nord-Pas-de-Calais-Picardie	France
7095	Concarneau	Brittany	France
7101	Colmar	Alsace-Champagne-Ardenne-Lorraine	France
7102	Cognac	Aquitaine-Limousin-Poitou-Charentes	France
7108	Cholet	Pays de la Loire	France
7112	Cherbourg-Octeville	Normandy	France
7117	Chaumont	Alsace-Champagne-Ardenne-Lorraine	France
7125	Chartres	Centre	France
7134	Challans	Pays de la Loire	France
7135	Cestas	Aquitaine-Limousin-Poitou-Charentes	France
7138	Cenon	Aquitaine-Limousin-Poitou-Charentes	France
7142	Carvin	Nord-Pas-de-Calais-Picardie	France
7144	Carquefou	Pays de la Loire	France
7147	Canteleu	Normandy	France
7149	Cambrai	Nord-Pas-de-Calais-Picardie	France
7151	Calais	Nord-Pas-de-Calais-Picardie	France
7154	Caen	Normandy	France
7160	Brive-la-Gaillarde	Aquitaine-Limousin-Poitou-Charentes	France
7164	Brest	Brittany	France
7165	Bressuire	Aquitaine-Limousin-Poitou-Charentes	France
7169	Bourges	Centre	France
7171	Boulogne-sur-Mer	Nord-Pas-de-Calais-Picardie	France
7173	Bouguenais	Pays de la Loire	France
7174	Bordeaux	Aquitaine-Limousin-Poitou-Charentes	France
7180	Blois	Centre	France
7181	Blanquefort	Aquitaine-Limousin-Poitou-Charentes	France
7183	Bischheim	Alsace-Champagne-Ardenne-Lorraine	France
7184	Biarritz	Aquitaine-Limousin-Poitou-Charentes	France
7189	Bergerac	Aquitaine-Limousin-Poitou-Charentes	France
7190	Berck	Nord-Pas-de-Calais-Picardie	France
7191	Berck-Plage	Nord-Pas-de-Calais-Picardie	France
7194	Beauvais	Nord-Pas-de-Calais-Picardie	France
7196	Bayonne	Aquitaine-Limousin-Poitou-Charentes	France
7197	Bayeux	Normandy	France
7198	Bastia	Corsica	France
7199	Bar-le-Duc	Alsace-Champagne-Ardenne-Lorraine	France
7205	Avion	Nord-Pas-de-Calais-Picardie	France
7217	Arras	Nord-Pas-de-Calais-Picardie	France
7221	Argentan	Normandy	France
7230	Anglet	Aquitaine-Limousin-Poitou-Charentes	France
7231	Angers	Pays de la Loire	France
7232	Amiens	Nord-Pas-de-Calais-Picardie	France
7239	Ajaccio	Corsica	France
7242	Agen	Aquitaine-Limousin-Poitou-Charentes	France
7245	Abbeville	Nord-Pas-de-Calais-Picardie	France
7246	Villeneuve-dAscq	Nord-Pas-de-Calais-Picardie	France
7268	Tchibanga	Nyanga	Gabon
7270	Oyem	Woleu-Ntem	Gabon
7273	Libreville	Estuaire	Gabon
7277	York	England	United Kingdom
7278	Yeovil	England	United Kingdom
7279	Yeadon	England	United Kingdom
7280	Yate	England	United Kingdom
7281	Wrexham	Wales	United Kingdom
7282	Worthing	England	United Kingdom
7283	Worksop	England	United Kingdom
7284	Workington	England	United Kingdom
7285	Worcester	England	United Kingdom
7286	Woodford Green	England	United Kingdom
7287	Wombwell	England	United Kingdom
7288	Wolverhampton	England	United Kingdom
7289	Wokingham	England	United Kingdom
7290	Woking	England	United Kingdom
7291	Witney	England	United Kingdom
7292	Witham	England	United Kingdom
7293	Wishaw	Scotland	United Kingdom
7294	Wisbech	England	United Kingdom
7295	Winsford	England	United Kingdom
7296	Windsor	England	United Kingdom
7297	Winchester	England	United Kingdom
7298	Wilmslow	England	United Kingdom
7299	Willenhall	England	United Kingdom
7300	Wigston Magna	England	United Kingdom
7301	Wigan	England	United Kingdom
7302	Widnes	England	United Kingdom
7303	Wickford	England	United Kingdom
7304	Whitstable	England	United Kingdom
7305	Whitley Bay	England	United Kingdom
7306	Whitehaven	England	United Kingdom
7307	Whitefield	England	United Kingdom
7308	Whickham	England	United Kingdom
7309	Weymouth	England	United Kingdom
7310	Weybridge	England	United Kingdom
7311	Weston-super-Mare	England	United Kingdom
7312	West Molesey	England	United Kingdom
7313	Westhoughton	England	United Kingdom
7314	West Bromwich	England	United Kingdom
7315	West Bridgford	England	United Kingdom
7316	Welwyn Garden City	England	United Kingdom
7317	Wellington	England	United Kingdom
7318	Wellingborough	England	United Kingdom
7319	Welling	England	United Kingdom
7320	Wednesfield	England	United Kingdom
7321	Wednesbury	England	United Kingdom
7322	Wath upon Dearne	England	United Kingdom
7323	Watford	England	United Kingdom
7324	Waterlooville	England	United Kingdom
7325	Washington	England	United Kingdom
7326	Warwick	England	United Kingdom
7327	Warrington	England	United Kingdom
7328	Warminster	England	United Kingdom
7329	Ware	England	United Kingdom
7330	Walton-on-Thames	England	United Kingdom
7331	Waltham Abbey	England	United Kingdom
7332	Walsall	England	United Kingdom
7333	Wallsend	England	United Kingdom
7334	Wallasey	England	United Kingdom
7335	Walkden	England	United Kingdom
7336	Wakefield	England	United Kingdom
7337	Urmston	England	United Kingdom
7338	Uckfield	England	United Kingdom
7339	Stowmarket	England	United Kingdom
7340	Stourport-on-Severn	England	United Kingdom
7341	Stourbridge	England	United Kingdom
7342	Stoke-on-Trent	England	United Kingdom
7343	Stockton-on-Tees	England	United Kingdom
7344	Stockport	England	United Kingdom
7345	Stirling	Scotland	United Kingdom
7346	Stevenage	England	United Kingdom
7347	Staveley	England	United Kingdom
7348	Stamford	England	United Kingdom
7349	Stalybridge	England	United Kingdom
7350	Staines	England	United Kingdom
7351	Stafford	England	United Kingdom
7352	Spennymoor	England	United Kingdom
7353	Spalding	England	United Kingdom
7354	South Shields	England	United Kingdom
7355	Southsea	England	United Kingdom
7356	Southport	England	United Kingdom
7357	South Ockendon	England	United Kingdom
7358	Southend-on-Sea	England	United Kingdom
7359	South Elmsall	England	United Kingdom
7360	South Benfleet	England	United Kingdom
7361	Southampton	England	United Kingdom
7362	Southall	England	United Kingdom
7363	Solihull	England	United Kingdom
7364	Slough	England	United Kingdom
7365	Sleaford	England	United Kingdom
7366	Skelmersdale	England	United Kingdom
7367	Skegness	England	United Kingdom
7368	Sittingbourne	England	United Kingdom
7369	Shrewsbury	England	United Kingdom
7370	Shoreham-by-Sea	England	United Kingdom
7371	Shoreham	England	United Kingdom
7372	Shipley	England	United Kingdom
7373	Sheffield	England	United Kingdom
7374	Sevenoaks	England	United Kingdom
7375	Selby	England	United Kingdom
7376	Seaham	England	United Kingdom
7377	Seaford	England	United Kingdom
7378	Scunthorpe	England	United Kingdom
7379	Scarborough	England	United Kingdom
7380	Sandown	England	United Kingdom
7381	Sandbach	England	United Kingdom
7382	Salisbury	England	United Kingdom
7383	Salford	England	United Kingdom
7384	Sale	England	United Kingdom
7385	Saint Neots	England	United Kingdom
7386	St Helens	England	United Kingdom
7387	St Austell	England	United Kingdom
7388	Saint Andrews	Scotland	United Kingdom
7389	St Albans	England	United Kingdom
7390	Ryton	England	United Kingdom
7391	Ryde	England	United Kingdom
7392	Rutherglen	Scotland	United Kingdom
7393	Rushden	England	United Kingdom
7394	Runcorn	England	United Kingdom
7395	Ruislip	England	United Kingdom
7396	Rugeley	England	United Kingdom
7397	Rugby	England	United Kingdom
7398	Royton	England	United Kingdom
7399	Royal Tunbridge Wells	England	United Kingdom
7400	Rottingdean	England	United Kingdom
7401	Rotherham	England	United Kingdom
7402	Romsey	England	United Kingdom
7403	Rochford	England	United Kingdom
7404	Rochester	England	United Kingdom
7405	Rochdale	England	United Kingdom
7406	Risca	Wales	United Kingdom
7407	Ripon	England	United Kingdom
7408	Ripley	England	United Kingdom
7409	Rhyl	Wales	United Kingdom
7410	Rhondda	Wales	United Kingdom
7411	Renfrew	Scotland	United Kingdom
7412	Reigate	England	United Kingdom
7413	Redhill	England	United Kingdom
7414	Redditch	England	United Kingdom
7415	Redcar	England	United Kingdom
7416	Reading	England	United Kingdom
7417	Rayleigh	England	United Kingdom
7418	Rawtenstall	England	United Kingdom
7419	Rawmarsh	England	United Kingdom
7420	Ramsgate	England	United Kingdom
7421	Ramsbottom	England	United Kingdom
7422	Purley	England	United Kingdom
7423	Pudsey	England	United Kingdom
7424	Prestwick	Scotland	United Kingdom
7425	Prestwich	England	United Kingdom
7426	Preston	England	United Kingdom
7427	Prestatyn	Wales	United Kingdom
7428	Prescot	England	United Kingdom
7429	Poulton le Fylde	England	United Kingdom
7430	Potters Bar	England	United Kingdom
7431	Portsmouth	England	United Kingdom
7432	Portslade	England	United Kingdom
7433	Portishead	England	United Kingdom
7434	Porthcawl	Wales	United Kingdom
7435	Port Glasgow	Scotland	United Kingdom
7436	Portadown	Northern Ireland	United Kingdom
7437	Poole	England	United Kingdom
7438	Pontypridd	Wales	United Kingdom
7439	Pontypool	Wales	United Kingdom
7440	Pontefract	England	United Kingdom
7441	Polmont	Scotland	United Kingdom
7442	Plymstock	England	United Kingdom
7443	Plymouth	England	United Kingdom
7444	Pitsea	England	United Kingdom
7445	Pinner	England	United Kingdom
7446	Peterlee	England	United Kingdom
7447	Peterhead	Scotland	United Kingdom
7448	Peterborough	England	United Kingdom
7449	Perth	Scotland	United Kingdom
7450	Penzance	England	United Kingdom
7451	Penicuik	Scotland	United Kingdom
7452	Penarth	Wales	United Kingdom
7453	Paisley	Scotland	United Kingdom
7454	Paignton	England	United Kingdom
7455	Oxford	England	United Kingdom
7456	Oswestry	England	United Kingdom
7457	Ossett	England	United Kingdom
7458	Orpington	England	United Kingdom
7459	Ormskirk	England	United Kingdom
7460	Omagh	Northern Ireland	United Kingdom
7461	Oldham	England	United Kingdom
7462	Oadby	England	United Kingdom
7463	Nuneaton	England	United Kingdom
7464	Nottingham	England	United Kingdom
7465	Norwich	England	United Kingdom
7466	Northwich	England	United Kingdom
7467	North Shields	England	United Kingdom
7468	Northolt	England	United Kingdom
7469	Lancing	England	United Kingdom
7470	Northampton	England	United Kingdom
7471	Northallerton	England	United Kingdom
7472	Newtownards	Northern Ireland	United Kingdom
7473	Newtownabbey	Northern Ireland	United Kingdom
7474	Newton Mearns	Scotland	United Kingdom
7475	Newton-le-Willows	England	United Kingdom
7476	Newton Aycliffe	England	United Kingdom
7477	Newton Abbot	England	United Kingdom
7478	Newry	Northern Ireland	United Kingdom
7479	Newquay	England	United Kingdom
7480	Newport Pagnell	England	United Kingdom
7481	Newport	Wales	United Kingdom
7482	Newport	England	United Kingdom
7483	New Milton	England	United Kingdom
7484	Newmarket	England	United Kingdom
7485	New Malden	England	United Kingdom
7486	Newcastle upon Tyne	England	United Kingdom
7487	Newcastle under Lyme	England	United Kingdom
7488	Newbury	England	United Kingdom
7489	Newburn	England	United Kingdom
7490	Newark on Trent	England	United Kingdom
7491	Nelson	England	United Kingdom
7492	Neath	Wales	United Kingdom
7493	Nailsea	England	United Kingdom
7494	Musselburgh	Scotland	United Kingdom
7495	Motherwell	Scotland	United Kingdom
7496	Morley	England	United Kingdom
7497	Moreton	England	United Kingdom
7498	Morecambe	England	United Kingdom
7499	Mitcham	England	United Kingdom
7500	Mirfield	England	United Kingdom
7501	Milton Keynes	England	United Kingdom
7502	Middleton	England	United Kingdom
7503	Middlesbrough	England	United Kingdom
7504	Mexborough	England	United Kingdom
7505	Merthyr Tydfil	Wales	United Kingdom
7506	Melton Mowbray	England	United Kingdom
7507	Marple	England	United Kingdom
7508	Marlow	England	United Kingdom
7509	Market Harborough	England	United Kingdom
7510	Margate	England	United Kingdom
7511	March	England	United Kingdom
7512	Mansfield Woodhouse	England	United Kingdom
7513	Mansfield	England	United Kingdom
7514	Mangotsfield	England	United Kingdom
7515	Manchester	England	United Kingdom
7516	Maltby	England	United Kingdom
7517	Maldon	England	United Kingdom
7518	Maidstone	England	United Kingdom
7519	Maidenhead	England	United Kingdom
7520	Maghull	England	United Kingdom
7521	Maesteg	Wales	United Kingdom
7522	Macclesfield	England	United Kingdom
7523	Luton	England	United Kingdom
7524	Lowestoft	England	United Kingdom
7525	Louth	England	United Kingdom
7526	Loughborough	England	United Kingdom
7527	Longfield	England	United Kingdom
7528	Long Eaton	England	United Kingdom
7529	Londonderry County Borough	Northern Ireland	United Kingdom
7530	Derry	Northern Ireland	United Kingdom
7531	City of London	England	United Kingdom
7532	London	England	United Kingdom
7533	Lofthouse	England	United Kingdom
7534	Llanelli	Wales	United Kingdom
7535	Llandudno	Wales	United Kingdom
7536	Livingston	Scotland	United Kingdom
7537	Liverpool	England	United Kingdom
7538	Littlehampton	England	United Kingdom
7539	Litherland	England	United Kingdom
7540	Lisburn	Northern Ireland	United Kingdom
7541	Lincoln	England	United Kingdom
7542	Lichfield	England	United Kingdom
7543	Leyland	England	United Kingdom
7544	Lewes	England	United Kingdom
7545	Letchworth	England	United Kingdom
7546	Leighton Buzzard	England	United Kingdom
7547	Leigh	England	United Kingdom
7548	Leicester	England	United Kingdom
7549	Leek	England	United Kingdom
7550	Leeds	England	United Kingdom
7551	Leatherhead	England	United Kingdom
7552	Royal Leamington Spa	England	United Kingdom
7553	Larne	Northern Ireland	United Kingdom
7554	Larkhall	Scotland	United Kingdom
7555	Lancaster	England	United Kingdom
7556	Kirkintilloch	Scotland	United Kingdom
7557	Kirkcaldy	Scotland	United Kingdom
7558	Kirkby in Ashfield	England	United Kingdom
7559	Kirkby	England	United Kingdom
7560	Kingswood	England	United Kingdom
7561	Kingswinford	England	United Kingdom
7562	Hull	England	United Kingdom
7563	Kings Lynn	England	United Kingdom
7564	Kilwinning	Scotland	United Kingdom
7565	Kilmarnock	Scotland	United Kingdom
7566	Kidsgrove	England	United Kingdom
7567	Kidlington	England	United Kingdom
7568	Kidderminster	England	United Kingdom
7569	Keynsham	England	United Kingdom
7570	Kettering	England	United Kingdom
7571	Kenilworth	England	United Kingdom
7572	Kendal	England	United Kingdom
7573	Kempston	England	United Kingdom
7574	Keighley	England	United Kingdom
7575	Johnstone	Scotland	United Kingdom
7576	Jarrow	England	United Kingdom
7577	Islington	England	United Kingdom
7578	Isleworth	England	United Kingdom
7579	Irvine	England	United Kingdom
7580	Coity	Wales	United Kingdom
7581	Cobham	England	United Kingdom
7582	Coatbridge	Scotland	United Kingdom
7583	Coalville	England	United Kingdom
7584	Clydebank	Scotland	United Kingdom
7585	Clydach	Wales	United Kingdom
7586	Clitheroe	England	United Kingdom
7587	Clevedon	England	United Kingdom
7588	Cleethorpes	England	United Kingdom
7589	Cleckheaton	England	United Kingdom
7590	Clacton-on-Sea	England	United Kingdom
7591	Cirencester	England	United Kingdom
7592	Christchurch	England	United Kingdom
7593	Chorley	England	United Kingdom
7594	Chislehurst	England	United Kingdom
7595	Chipping Sodbury	England	United Kingdom
7596	Chippenham	England	United Kingdom
7597	Chichester	England	United Kingdom
7598	Chester-le-Street	England	United Kingdom
7599	Chesterfield	England	United Kingdom
7600	Chester	England	United Kingdom
7601	Chessington	England	United Kingdom
7602	Cheshunt	England	United Kingdom
7603	Chesham	England	United Kingdom
7604	Cheltenham	England	United Kingdom
7605	Chelsea	England	United Kingdom
7606	Chelmsford	England	United Kingdom
7607	Cheadle Hulme	England	United Kingdom
7608	Chatham	England	United Kingdom
7609	Chapletown	England	United Kingdom
7610	Chalfont Saint Peter	England	United Kingdom
7611	Caterham	England	United Kingdom
7612	Castlereagh	Northern Ireland	United Kingdom
7613	Castleford	England	United Kingdom
7614	Carshalton	England	United Kingdom
7615	Carrickfergus	Northern Ireland	United Kingdom
7616	Carmarthen	Wales	United Kingdom
7617	Carlisle	England	United Kingdom
7618	Cardiff	Wales	United Kingdom
7619	Canterbury	England	United Kingdom
7620	Cannock	England	United Kingdom
7621	Cambridge	England	United Kingdom
7622	Camborne	England	United Kingdom
7623	Camberley	England	United Kingdom
7624	Caerphilly	Wales	United Kingdom
7625	Buxton	England	United Kingdom
7626	Bushey	England	United Kingdom
7627	Bury St Edmunds	England	United Kingdom
7628	Bury	England	United Kingdom
7629	Burton upon Trent	England	United Kingdom
7630	Burntwood	England	United Kingdom
7631	Burnley	England	United Kingdom
7632	Burnham-on-Sea	England	United Kingdom
7633	Burgess Hill	England	United Kingdom
7634	Buckley	Wales	United Kingdom
7635	Buckhaven	Scotland	United Kingdom
7636	Brymbo	Wales	United Kingdom
7637	Brownhills	England	United Kingdom
7638	Bromsgrove	England	United Kingdom
7639	Broadstairs	England	United Kingdom
7640	Brixham	England	United Kingdom
7641	Briton Ferry	Wales	United Kingdom
7642	Bristol	England	United Kingdom
7643	Brighton	England	United Kingdom
7644	Brighouse	England	United Kingdom
7645	Brierley Hill	England	United Kingdom
7646	Bridlington	England	United Kingdom
7647	Bridgwater	England	United Kingdom
7648	Bridgend	Wales	United Kingdom
7649	Brentwood	England	United Kingdom
7650	Bredbury	England	United Kingdom
7651	Bramhall	England	United Kingdom
7652	Braintree	England	United Kingdom
7653	Bradford	England	United Kingdom
7654	Bracknell	England	United Kingdom
7655	Bournemouth	England	United Kingdom
7656	Boston	England	United Kingdom
7657	Borehamwood	England	United Kingdom
7658	Bootle	England	United Kingdom
7659	Bolton	England	United Kingdom
7660	Bognor Regis	England	United Kingdom
7661	Blyth	England	United Kingdom
7662	Bloxwich	England	United Kingdom
7663	Bletchley	England	United Kingdom
7664	Blackpool	England	United Kingdom
7665	Blackburn	England	United Kingdom
7666	Bishopstoke	England	United Kingdom
7667	Bishops Stortford	England	United Kingdom
7668	Bishopbriggs	Scotland	United Kingdom
7669	Bishop Auckland	England	United Kingdom
7670	Birmingham	England	United Kingdom
7671	Birkenhead	England	United Kingdom
7672	Bingley	England	United Kingdom
7673	Billingham	England	United Kingdom
7674	Billericay	England	United Kingdom
7675	Biggleswade	England	United Kingdom
7676	Bideford	England	United Kingdom
7677	Biddulph	England	United Kingdom
7678	Bicester	England	United Kingdom
7679	Bexley	England	United Kingdom
7680	Bexhill-on-Sea	England	United Kingdom
7681	Beverley	England	United Kingdom
7682	Berwick-Upon-Tweed	England	United Kingdom
7683	Berkhamsted	England	United Kingdom
7684	Bentley	England	United Kingdom
7685	Belper	England	United Kingdom
7686	Bellshill	Scotland	United Kingdom
7687	Belfast	Northern Ireland	United Kingdom
7688	Bedworth	England	United Kingdom
7689	Bedlington	England	United Kingdom
7690	Bedford	England	United Kingdom
7691	Beckenham	England	United Kingdom
7692	Bebington	England	United Kingdom
7693	Bearsden	Scotland	United Kingdom
7694	Batley	England	United Kingdom
7695	Bathgate	Scotland	United Kingdom
7696	Bath	England	United Kingdom
7697	Basingstoke	England	United Kingdom
7698	Basildon	England	United Kingdom
7699	Barry	Wales	United Kingdom
7700	Barrow in Furness	England	United Kingdom
7701	Barrhead	Scotland	United Kingdom
7702	Barnstaple	England	United Kingdom
7703	Barnsley	England	United Kingdom
7704	Barnet	England	United Kingdom
7705	Barking	England	United Kingdom
7706	Banstead	England	United Kingdom
7707	Bangor	Northern Ireland	United Kingdom
7708	Bangor	Wales	United Kingdom
7709	Banbury	England	United Kingdom
7710	Banbridge	Northern Ireland	United Kingdom
7711	Ballymena	Northern Ireland	United Kingdom
7712	Baildon	England	United Kingdom
7713	Ayr	Scotland	United Kingdom
7714	Aylesbury	England	United Kingdom
7715	Atherton	England	United Kingdom
7716	Ashton-under-Lyne	England	United Kingdom
7717	Ashton in Makerfield	England	United Kingdom
7718	Ashford	England	United Kingdom
7719	Ascot	England	United Kingdom
7720	Arnold	England	United Kingdom
7721	Arbroath	Scotland	United Kingdom
7722	Antrim	Northern Ireland	United Kingdom
7723	Andover	England	United Kingdom
7724	Amersham	England	United Kingdom
7725	Altrincham	England	United Kingdom
7726	Alton	England	United Kingdom
7727	Alloa	Scotland	United Kingdom
7728	Alfreton	England	United Kingdom
7729	Aldridge	England	United Kingdom
7730	Aldershot	England	United Kingdom
7731	Airdrie	Scotland	United Kingdom
7732	Acton	England	United Kingdom
7733	Acocks Green	England	United Kingdom
7734	Accrington	England	United Kingdom
7735	Abingdon	England	United Kingdom
7736	Aberystwyth	Wales	United Kingdom
7737	Abergele	Wales	United Kingdom
7738	Aberdeen	Scotland	United Kingdom
7739	Aberdare	Wales	United Kingdom
7740	Crosby	England	United Kingdom
7741	Blackwood	Wales	United Kingdom
7742	Neston	England	United Kingdom
7743	Camden Town	England	United Kingdom
7744	Telford	England	United Kingdom
7745	Craigavon	Northern Ireland	United Kingdom
7746	Bayswater	England	United Kingdom
7747	Yateley	England	United Kingdom
7748	Bowthorpe	England	United Kingdom
7749	Hedge End	England	United Kingdom
7750	Erskine	Scotland	United Kingdom
7751	Hale	England	United Kingdom
7752	Amersham on the Hill	England	United Kingdom
7753	Battersea	England	United Kingdom
7754	South Croydon	England	United Kingdom
7755	Hornchurch	England	United Kingdom
7756	Surbiton	England	United Kingdom
7757	Ewell	England	United Kingdom
7758	Becontree	England	United Kingdom
7759	Brixton	England	United Kingdom
7760	Bethnal Green	England	United Kingdom
7761	Failsworth	England	United Kingdom
7762	Radcliffe	England	United Kingdom
7763	Heywood	England	United Kingdom
7764	Longsight	England	United Kingdom
7765	Heavitree	England	United Kingdom
7766	Ferndown	England	United Kingdom
7767	Canary Wharf	England	United Kingdom
7768	Lytham St Annes	England	United Kingdom
7769	Hadley Wood	England	United Kingdom
7770	Chapel Allerton	England	United Kingdom
7771	Blackheath	England	United Kingdom
7772	Kempston Hardwick	England	United Kingdom
7773	Mendip	England	United Kingdom
7774	Lower Earley	England	United Kingdom
7775	Bartley Green	England	United Kingdom
7776	Earlsfield	England	United Kingdom
7777	Letchworth Garden City	England	United Kingdom
7778	Shirley	England	United Kingdom
7779	Stanley	England	United Kingdom
7780	Rossendale	England	United Kingdom
7781	Thornton-Cleveleys	England	United Kingdom
7782	Deeside	Wales	United Kingdom
7783	High Peak	England	United Kingdom
7784	Hayling Island	England	United Kingdom
7785	Isle of Lewis	Scotland	United Kingdom
7786	Shetland	Scotland	United Kingdom
7787	Orkney	Scotland	United Kingdom
7788	Holloway	England	United Kingdom
7789	Harringay	England	United Kingdom
7790	Saint Georges	Saint George	Grenada
7791	Zugdidi	Samegrelo and Zemo Svaneti	Georgia
7794	Tqvarcheli	Abkhazia	Georgia
7795	Telavi	Kakheti	Georgia
7796	Tbilisi	Tbilisi	Georgia
7797	Sokhumi	Abkhazia	Georgia
7799	Samtredia	Imereti	Georgia
7802	Ozurgeti	Guria	Georgia
7804	Marneuli	Kvemo Kartli	Georgia
7805	Kutaisi	Imereti	Georgia
7806	Kobuleti	Ajaria	Georgia
7807	Khashuri	Shida Kartli	Georgia
7808	Gori	Shida Kartli	Georgia
7809	Batumi	Ajaria	Georgia
7810	Akhaltsikhe	Samtskhe-Javakheti	Georgia
7811	Stantsiya Novyy Afon	Abkhazia	Georgia
7812	Tsqaltubo	Imereti	Georgia
7813	Saint-Laurent-du-Maroni	Guyane	French Guiana
7815	Matoury	Guyane	French Guiana
7816	Kourou	Guyane	French Guiana
7817	Cayenne	Guyane	French Guiana
7818	Saint Peter Port	St Peter Port	Guernsey
7819	Yendi	Northern	Ghana
7820	Winneba	Central	Ghana
7821	Wenchi	Brong-Ahafo	Ghana
7822	Wa	Upper West	Ghana
7823	Teshi Old Town	Greater Accra	Ghana
7824	Tema	Greater Accra	Ghana
7825	Techiman	Brong-Ahafo	Ghana
7826	Tarkwa	Western	Ghana
7827	Tamale	Northern	Ghana
7828	Takoradi	Western	Ghana
7829	Tafo	Ashanti	Ghana
7830	Swedru	Central	Ghana
7831	Sunyani	Brong-Ahafo	Ghana
7832	Suhum	Eastern	Ghana
7833	Shama Junction	Western	Ghana
7834	Sekondi-Takoradi	Western	Ghana
7835	Savelugu	Northern	Ghana
7836	Saltpond	Central	Ghana
7837	Salaga	Northern	Ghana
7838	Prestea	Western	Ghana
7839	Kasoa	Central	Ghana
7840	Akim Oda	Eastern	Ghana
7841	Obuasi	Ashanti	Ghana
7842	Nungua	Greater Accra	Ghana
7843	Nsawam	Eastern	Ghana
7844	Nkawkaw	Eastern	Ghana
7845	Navrongo	Upper East	Ghana
7846	Mampong	Ashanti	Ghana
7847	Medina Estates	Greater Accra	Ghana
7848	Kumasi	Ashanti	Ghana
7849	Kpandu	Volta	Ghana
7850	Konongo	Ashanti	Ghana
7851	Koforidua	Eastern	Ghana
7852	Kintampo	Brong-Ahafo	Ghana
7853	Keta	Volta	Ghana
7854	Hohoe	Volta	Ghana
7855	Ho	Volta	Ghana
7856	Gbawe	Greater Accra	Ghana
7857	Foso	Central	Ghana
7858	Elmina	Central	Ghana
7859	Ejura	Ashanti	Ghana
7860	Dunkwa	Central	Ghana
7861	Dome	Greater Accra	Ghana
7862	Cape Coast	Central	Ghana
7863	Bolgatanga	Upper East	Ghana
7864	Bibiani	Western	Ghana
7865	Berekum	Brong-Ahafo	Ghana
7866	Begoro	Eastern	Ghana
7867	Bawku	Upper East	Ghana
7868	Axim	Western	Ghana
7869	Asamankese	Eastern	Ghana
7870	Apam	Central	Ghana
7871	Anloga	Volta	Ghana
7872	Akwatia	Eastern	Ghana
7873	Agogo	Ashanti	Ghana
7874	Achiaman	Greater Accra	Ghana
7875	Accra	Greater Accra	Ghana
7876	Aburi	Eastern	Ghana
7877	Gibraltar	N/A	Gibraltar
7878	Nuuk	Sermersooq	Greenland
7879	Sukuta	Western	Gambia
7880	Lamin	North Bank	Gambia
7881	Farafenni	North Bank	Gambia
7882	Brikama	Western	Gambia
7883	Banjul	Banjul	Gambia
7884	Bakau	Banjul	Gambia
7887	Siguiri	Kankan	Guinea
7888	Pita	Mamou	Guinea
7890	Mamou	Mamou	Guinea
7891	Macenta	Nzerekore	Guinea
7893	Kissidougou	Faranah	Guinea
7894	Kindia	Kindia	Guinea
7895	Kankan	Kankan	Guinea
7896	Kamsar	Boke	Guinea
7897	Gueckedou	Nzerekore	Guinea
7898	Fria	Boke	Guinea
7899	Coyah	Kindia	Guinea
7900	Conakry	Conakry	Guinea
7901	Camayenne	Conakry	Guinea
7903	Sainte-Rose	Guadeloupe	Guadeloupe
7904	Sainte-Anne	Guadeloupe	Guadeloupe
7906	Petit-Bourg	Guadeloupe	Guadeloupe
7907	Les Abymes	Guadeloupe	Guadeloupe
7908	Le Moule	Guadeloupe	Guadeloupe
7909	Le Gosier	Guadeloupe	Guadeloupe
7910	Capesterre-Belle-Eau	Guadeloupe	Guadeloupe
7911	Basse-Terre	Guadeloupe	Guadeloupe
7912	Baie-Mahault	Guadeloupe	Guadeloupe
7914	Malabo	Bioko Norte	Equatorial Guinea
7915	Bata	Litoral	Equatorial Guinea
7925	Rethymno	Crete	Greece
7928	Piraeus	Attica	Greece
7950	Kos	South Aegean	Greece
7955	Chios	North Aegean	Greece
7975	Agios Dimitrios	Attica	Greece
7978	Athens	Attica	Greece
7997	Ptolema?da	West Macedonia	Greece
8016	Corfu	Ionian Islands	Greece
8017	Vrilissia	Attica	Greece
8024	Agios Ioannis Rentis	Attica	Greece
8026	Grytviken	N/A	South Georgia and the South Sandwich Islands
8027	Zacapa	Zacapa	Guatemala
8028	Villa Nueva	Guatemala	Guatemala
8029	Villa Canales	Guatemala	Guatemala
8039	Santa Catarina Pinula	Guatemala	Guatemala
8041	San Pedro Ayampuc	Guatemala	Guatemala
8042	San Pablo Jocopilas	Suchitepeque	Guatemala
8043	San Marcos	San Marcos	Guatemala
8050	Sanarate	El Progreso	Guatemala
8053	Retalhuleu	Retalhuleu	Guatemala
8054	Quetzaltenango	Quetzaltenango	Guatemala
8056	Puerto Barrios	Izabal	Guatemala
8057	Tiquisate	Escuintla	Guatemala
8059	Petapa	Guatemala	Guatemala
8064	Palencia	Guatemala	Guatemala
8065	Ostuncalco	Quetzaltenango	Guatemala
8066	Nuevo San Carlos	Retalhuleu	Guatemala
8069	Morales	Izabal	Guatemala
8071	Mixco	Guatemala	Guatemala
8072	Mazatenango	Suchitepeque	Guatemala
8073	La Gomera	Escuintla	Guatemala
8074	La Esperanza	Quetzaltenango	Guatemala
8075	Jutiapa	Jutiapa	Guatemala
8077	Jalapa	Jalapa	Guatemala
8078	Jacaltenango	Huehuetenango	Guatemala
8079	Huehuetenango	Huehuetenango	Guatemala
8081	Fraijanes	Guatemala	Guatemala
8083	Esquipulas	Chiquimula	Guatemala
8084	Escuintla	Escuintla	Guatemala
8085	El Tejar	Chimaltenango	Guatemala
8086	El Palmar	Quetzaltenango	Guatemala
8087	El Estor	Izabal	Guatemala
8088	Cuilapa	Santa Rosa	Guatemala
8089	Comitancillo	San Marcos	Guatemala
8090	Comalapa	Chimaltenango	Guatemala
8091	Colomba	Quetzaltenango	Guatemala
8093	Coatepeque	Quetzaltenango	Guatemala
8095	Guatemala City	Guatemala	Guatemala
8096	Chisec	Alta Verapaz	Guatemala
8097	Chiquimula	Chiquimula	Guatemala
8098	Chinautla	Guatemala	Guatemala
8099	Chimaltenango	Chimaltenango	Guatemala
8101	Chicacao	Suchitepeque	Guatemala
8102	Cantel	Quetzaltenango	Guatemala
8103	Barberena	Santa Rosa	Guatemala
8108	Tamuning-Tumon-Harmon Village	Tamuning	Guam
8109	Yigo Village	Yigo	Guam
8110	Guam Government House	Hagatna	Guam
8111	Dededo Village	Dededo	Guam
8113	Mangilao Village	Mangilao	Guam
8114	Bissau	Bissau	Guinea-Bissau
8116	New Amsterdam	East Berbice-Corentyne	Guyana
8117	Linden	Upper Demerara-Berbice	Guyana
8118	Georgetown	Demerara-Mahaica	Guyana
8119	Tsuen Wan	Tsuen Wan	Hong Kong
8120	Yuen Long Kau Hui	Yuen Long	Hong Kong
8121	Tuen Mun	Tuen Mun	Hong Kong
8122	Tai Po	Tai Po	Hong Kong
8123	Sha Tin	Sha Tin	Hong Kong
8124	Kowloon	Kowloon City	Hong Kong
8125	Hong Kong	Central and Western	Hong Kong
8127	Yoro	Yoro	Honduras
8132	Siguatepeque	Comayagua	Honduras
8136	San Lorenzo	Valle	Honduras
8138	Olanchito	Yoro	Honduras
8139	La Paz	La Paz	Honduras
8142	Juticalpa	Olancho	Honduras
8143	El Progreso	Yoro	Honduras
8146	Comayagua	Comayagua	Honduras
8148	Ciudad Choluteca	Choluteca	Honduras
8151	Zagreb	Grad Zagreb	Croatia
8152	Zadar	Zadarska	Croatia
8153	Vukovar	Vukovarsko-Srijemska	Croatia
8154	Virovitica	Virovitick-Podravska	Croatia
8155	Vinkovci	Vukovarsko-Srijemska	Croatia
8156	Velika Gorica	Zagrebacka	Croatia
8158	Split	Splitsko-Dalmatinska	Croatia
8159	Solin	Splitsko-Dalmatinska	Croatia
8160	Slavonski Brod	Brodsko-Posavska	Croatia
8162	Sisak	Sisacko-Moslavacka	Croatia
8164	Sesvete	Grad Zagreb	Croatia
8165	Samobor	Zagrebacka	Croatia
8166	Rijeka	Primorsko-Goranska	Croatia
8167	Pula	Istarska	Croatia
8168	Osijek	Osjecko-Baranjska	Croatia
8170	Karlovac	Karlovacka	Croatia
8171	Dubrovnik	Dubrovacko-Neretvanska	Croatia
8172	Cakovec	Medimurska	Croatia
8173	Bjelovar	Bjelovarsko-Bilogorska	Croatia
8174	Zagreb- Stenjevec	Grad Zagreb	Croatia
8175	Zagreb - Centar	Grad Zagreb	Croatia
8176	Verrettes	Artibonite	Haiti
8177	Thomazeau	Ouest	Haiti
8179	Saint-Marc	Artibonite	Haiti
8180	Port-de-Paix	Nord-Ouest	Haiti
8181	Port-au-Prince	Ouest	Haiti
8182	Tigwav	Ouest	Haiti
8185	Lenbe	Nord	Haiti
8187	Kenscoff	Ouest	Haiti
8189	Jacmel	Sud-Est	Haiti
8190	Hinche	Centre	Haiti
8191	Gressier	Ouest	Haiti
8192	Grangwav	Ouest	Haiti
8193	Gonayiv	Artibonite	Haiti
8194	Fond Parisien	Ouest	Haiti
8196	Delmas 73	Ouest	Haiti
8197	Croix des Bouquets	Ouest	Haiti
8198	Les Cayes	Sud	Haiti
8199	Carrefour	Ouest	Haiti
8200	Okap	Nord	Haiti
8201	Ti Port-de-Paix	Nord-Ouest	Haiti
8207	Szarvas	Bekes	Hungary
8225	Gyula	Bekes	Hungary
8226	Gyomaendrod	Bekes	Hungary
8227	Eger	Heves	Hungary
8234	Abony	Pest	Hungary
8235	Zalaegerszeg	Zala	Hungary
8243	Szombathely	Vas	Hungary
8245	Szentendre	Pest	Hungary
8249	Sopron	Gyor-Moson-Sopron	Hungary
8256	Paks	Tolna	Hungary
8259	Nagykanizsa	Zala	Hungary
8261	Monor	Pest	Hungary
8268	Keszthely	Zala	Hungary
8273	Hatvan	Heves	Hungary
8274	Gyor	Gyor-Moson-Sopron	Hungary
8283	Dunakeszi	Pest	Hungary
8284	Dunaharaszti	Pest	Hungary
8286	Dabas	Pest	Hungary
8288	Budapest	Budapest	Hungary
8315	Tongging	North Sumatra	Indonesia
8316	Teluk Nibung	North Sumatra	Indonesia
8317	Tebingtinggi	North Sumatra	Indonesia
8318	Tanjungtiram	North Sumatra	Indonesia
8319	Tanjungbalai	North Sumatra	Indonesia
8320	Sunggal	North Sumatra	Indonesia
8321	Stabat	North Sumatra	Indonesia
8322	Singkil	Aceh	Indonesia
8323	Sigli	Aceh	Indonesia
8324	Sibolga	North Sumatra	Indonesia
8325	Sabang	Aceh	Indonesia
8326	Reuleuet	Aceh	Indonesia
8327	Rantauprapat	North Sumatra	Indonesia
8328	Percut	North Sumatra	Indonesia
8329	Perbaungan	North Sumatra	Indonesia
8330	Pematangsiantar	North Sumatra	Indonesia
8331	Pangkalan Brandan	North Sumatra	Indonesia
8332	Padangsidempuan	North Sumatra	Indonesia
8333	Meulaboh	Aceh	Indonesia
8334	Medan	North Sumatra	Indonesia
8335	Lhokseumawe	Aceh	Indonesia
8336	Langsa	Aceh	Indonesia
8337	Labuhan Deli	North Sumatra	Indonesia
8338	Kisaran	North Sumatra	Indonesia
8339	Kabanjahe	North Sumatra	Indonesia
8340	Deli Tua	North Sumatra	Indonesia
8341	Bireun	Aceh	Indonesia
8342	Binjai	North Sumatra	Indonesia
8343	Berastagi	North Sumatra	Indonesia
8344	Belawan	North Sumatra	Indonesia
8345	Bandar	North Sumatra	Indonesia
8346	Banda Aceh	Aceh	Indonesia
8347	Yogyakarta	Daerah Istimewa Yogyakarta	Indonesia
8348	Wonosobo	Central Java	Indonesia
8349	Wonopringgo	Central Java	Indonesia
8350	Wongsorejo	East Java	Indonesia
8351	Wiradesa	Central Java	Indonesia
8352	Weru	West Java	Indonesia
8353	Weleri	Central Java	Indonesia
8354	Welahan	Central Java	Indonesia
8355	Wedi	Central Java	Indonesia
8356	Watampone	South Sulawesi	Indonesia
8357	Wangon	Central Java	Indonesia
8358	Wanaraja	West Java	Indonesia
8359	Waingapu	East Nusa Tenggara	Indonesia
8360	Ungaran	Central Java	Indonesia
8361	Makassar	South Sulawesi	Indonesia
8362	Ubud	Bali	Indonesia
8363	Tulungagung	East Java	Indonesia
8364	Tulangan Utara	East Java	Indonesia
8365	Tuban	East Java	Indonesia
8366	Tual	Maluku	Indonesia
8367	Trucuk	Central Java	Indonesia
8368	Trenggalek	East Java	Indonesia
8369	Tondano	North Sulawesi	Indonesia
8370	Tomohon	North Sulawesi	Indonesia
8371	Ternate	Maluku Utara	Indonesia
8372	Terbanggi Besar	Lampung	Indonesia
8373	Tegal	Central Java	Indonesia
8374	Tayu	Central Java	Indonesia
8375	Tasikmalaya	West Java	Indonesia
8376	Tarub	Central Java	Indonesia
8377	Tarakan	North Kalimantan	Indonesia
8378	Tanjungpinang	Riau Islands	Indonesia
8380	Bandar Lampung	Lampung	Indonesia
8381	Tanjungagung	South Sumatra	Indonesia
8382	Tanggulangin	East Java	Indonesia
8383	Tangerang	Banten	Indonesia
8384	Tabanan	Bali	Indonesia
8385	Surakarta	Central Java	Indonesia
8386	Surabaya	East Java	Indonesia
8387	Sungai Raya	West Kalimantan	Indonesia
8388	Sungai Penuh	Jambi	Indonesia
8390	Sumenep	East Java	Indonesia
8391	Sumedang Utara	N/A	Indonesia
8392	Sumberpucung	East Java	Indonesia
8393	Sumber	West Java	Indonesia
8394	Sumbawa Besar	West Nusa Tenggara	Indonesia
8395	Sokaraja	Central Java	Indonesia
8396	Sukabumi	West Java	Indonesia
8397	Srono	East Java	Indonesia
8398	Srandakan	Daerah Istimewa Yogyakarta	Indonesia
8399	Sragen	Central Java	Indonesia
8400	Sorong	West Papua	Indonesia
8401	Soreang	West Java	Indonesia
8402	Solok	West Sumatra	Indonesia
8403	Soko	East Java	Indonesia
8404	Sofifi	Maluku Utara	Indonesia
8405	Soe	East Nusa Tenggara	Indonesia
8406	Sleman	Daerah Istimewa Yogyakarta	Indonesia
8407	Slawi	Central Java	Indonesia
8408	Situbondo	East Java	Indonesia
8409	Sinjai	South Sulawesi	Indonesia
8410	Singosari	East Java	Indonesia
8411	Singojuruh	East Java	Indonesia
8412	Singkawang	West Kalimantan	Indonesia
8413	Sengkang	South Sulawesi	Indonesia
8414	Singaraja	Bali	Indonesia
8415	Singaparna	West Java	Indonesia
8416	Simpang	Jambi	Indonesia
8417	Sijunjung	West Sumatra	Indonesia
8418	Sidoarjo	East Java	Indonesia
8419	Sidareja	Central Java	Indonesia
8420	Sewon	Daerah Istimewa Yogyakarta	Indonesia
8421	Serpong	West Java	Indonesia
8422	Serang	Banten	Indonesia
8423	Sepatan	West Java	Indonesia
8424	Semarang	Central Java	Indonesia
8425	Selogiri	Central Java	Indonesia
8426	Sawangan	West Java	Indonesia
8427	Sampit	Central Kalimantan	Indonesia
8428	Sampang	East Java	Indonesia
8429	Samarinda	East Kalimantan	Indonesia
8430	Salatiga	Central Java	Indonesia
8431	Ruteng	East Nusa Tenggara	Indonesia
8432	Rengasdengklok	West Java	Indonesia
8433	Rembangan	Central Java	Indonesia
8434	Rantepao	South Sulawesi	Indonesia
8435	Rangkasbitung	Banten	Indonesia
8436	Randudongkal	Central Java	Indonesia
8437	Rajapolah	West Java	Indonesia
8438	Purwokerto	Central Java	Indonesia
8439	Purwodadi	Central Java	Indonesia
8440	Purwakarta	West Java	Indonesia
8441	Purbalingga	Central Java	Indonesia
8442	Pundong	Daerah Istimewa Yogyakarta	Indonesia
8443	Probolinggo	East Java	Indonesia
8444	Prigen	East Java	Indonesia
8445	Praya	West Nusa Tenggara	Indonesia
8446	Candi Prambanan	Central Java	Indonesia
8447	Poso	Central Sulawesi	Indonesia
8448	Pontianak	West Kalimantan	Indonesia
8449	Ponorogo	East Java	Indonesia
8450	Polewali	Sulawesi Barat	Indonesia
8451	Plumbon	West Java	Indonesia
8452	Petarukan	Central Java	Indonesia
8453	Prabumulih	South Sumatra	Indonesia
8454	Pemangkat	West Kalimantan	Indonesia
8455	Pemalang	Central Java	Indonesia
8456	Pelabuhanratu	West Java	Indonesia
8457	Pekanbaru	Riau	Indonesia
8458	Pekalongan	Central Java	Indonesia
8459	Pecangaan	Central Java	Indonesia
8460	Payakumbuh	West Sumatra	Indonesia
8461	Pati	Central Java	Indonesia
8462	Pasuruan	East Java	Indonesia
8463	Paseh	West Java	Indonesia
8464	Pasarkemis	West Java	Indonesia
8465	Parung	West Java	Indonesia
8466	Pariaman	West Sumatra	Indonesia
8467	Parepare	South Sulawesi	Indonesia
8468	Pare	East Java	Indonesia
8469	Panji	East Java	Indonesia
8471	Pangkalanbuun	Central Kalimantan	Indonesia
8472	Pandeglang	Banten	Indonesia
8473	Pandaan	East Java	Indonesia
8474	Pandak	Daerah Istimewa Yogyakarta	Indonesia
8475	Panarukan	East Java	Indonesia
8476	Pamulang	West Java	Indonesia
8477	Pameungpeuk	West Java	Indonesia
8478	Pamekasan	East Java	Indonesia
8479	Pamanukan	West Java	Indonesia
8480	Palu	Central Sulawesi	Indonesia
8481	Palopo	South Sulawesi	Indonesia
8482	Palimanan	West Java	Indonesia
8483	Palembang	South Sumatra	Indonesia
8484	Palangkaraya	Central Kalimantan	Indonesia
8485	Pakisaji	East Java	Indonesia
8486	Pageralam	South Sumatra	Indonesia
8487	Padang	West Sumatra	Indonesia
8488	Paciran	East Java	Indonesia
8489	Ngunut	East Java	Indonesia
8490	Ngoro	East Java	Indonesia
8491	Ngawi	West Java	Indonesia
8492	Nganjuk	East Java	Indonesia
8493	Negara	Bali	Indonesia
8494	Nabire	Papua	Indonesia
8496	Muntilan	Central Java	Indonesia
8497	Muncar	East Java	Indonesia
8498	Mranggen	Central Java	Indonesia
8499	Mojokerto	East Java	Indonesia
8500	Mojoagung	East Java	Indonesia
8501	Mlonggo	Central Java	Indonesia
8502	Metro	Lampung	Indonesia
8503	Mertoyudan	Central Java	Indonesia
8504	Melati	Daerah Istimewa Yogyakarta	Indonesia
8505	Maumere	East Nusa Tenggara	Indonesia
8506	Mataram	West Nusa Tenggara	Indonesia
8507	Martapura	South Kalimantan	Indonesia
8508	Margasari	Central Java	Indonesia
8509	Margahayukencana	West Java	Indonesia
8510	Manokwari	West Papua	Indonesia
8511	Manismata	West Kalimantan	Indonesia
8513	Mendaha	Jambi	Indonesia
8514	Manado	North Sulawesi	Indonesia
8515	Malang	East Java	Indonesia
8516	Majene	Sulawesi Barat	Indonesia
8517	Majenang	Central Java	Indonesia
8518	Majalengka	West Java	Indonesia
8519	Magelang	Central Java	Indonesia
8520	Madiun	East Java	Indonesia
8521	Luwuk	Central Sulawesi	Indonesia
8522	Lumajang	East Java	Indonesia
8523	Lubuklinggau	South Sumatra	Indonesia
8524	Loa Janan	East Kalimantan	Indonesia
8525	Lembang	West Java	Indonesia
8526	Lebaksiu	Central Java	Indonesia
8527	Lawang	East Java	Indonesia
8528	Lasem	Central Java	Indonesia
8529	Lamongan	East Java	Indonesia
8530	Lahat	South Sumatra	Indonesia
8531	Labuan Bajo	East Nusa Tenggara	Indonesia
8532	Labuan	Banten	Indonesia
8533	Kutoarjo	Central Java	Indonesia
8534	Kuta	Bali	Indonesia
8535	Kuningan	West Java	Indonesia
8536	Kudus	Central Java	Indonesia
8537	Kuala Tungkal	Jambi	Indonesia
8538	Kualakapuas	Central Kalimantan	Indonesia
8539	Kroya	Central Java	Indonesia
8540	Krian	East Java	Indonesia
8541	Kresek	West Java	Indonesia
8542	Kraksaan	East Java	Indonesia
8543	Kotabumi	Lampung	Indonesia
8544	Klungkung	Bali	Indonesia
8545	Klaten	Central Java	Indonesia
8546	Klangenan	West Java	Indonesia
8547	Kijang	Riau Islands	Indonesia
8548	Ketanggungan	Central Java	Indonesia
8549	Kertosono	East Java	Indonesia
8550	Kepanjen	East Java	Indonesia
8551	Kendari	Sulawesi Tenggara	Indonesia
8552	Kencong	East Java	Indonesia
8553	Kefamenanu	East Nusa Tenggara	Indonesia
8554	Kedungwuni	Central Java	Indonesia
8555	Kedungwaru	East Java	Indonesia
8556	Kediri	East Java	Indonesia
8557	Kebonarun	Central Java	Indonesia
8558	Kebomas	East Java	Indonesia
8559	Kawalu	West Java	Indonesia
8560	Katabu	Sulawesi Tenggara	Indonesia
8561	Karangsembung	West Java	Indonesia
8562	Karangasem	Bali	Indonesia
8563	Karanganom	Central Java	Indonesia
8564	Karangampel	West Java	Indonesia
8565	Kamal	East Java	Indonesia
8566	Kalianget	East Java	Indonesia
8567	Juwana	Central Java	Indonesia
8568	Jombang	East Java	Indonesia
8569	Jogonalan	Central Java	Indonesia
8570	Jember	East Java	Indonesia
8571	Jekulo	Central Java	Indonesia
8572	Jatiwangi	West Java	Indonesia
8573	Jatiroto	Central Java	Indonesia
8574	Jatibarang	West Java	Indonesia
8575	Jaten	Central Java	Indonesia
8576	Jambi City	Jambi	Indonesia
8577	Jakarta	Jakarta Raya	Indonesia
8578	Indramayu	West Java	Indonesia
8579	Grogol	Central Java	Indonesia
8580	Gresik	East Java	Indonesia
8581	Gorontalo	Gorontalo	Indonesia
8582	Gongdanglegi Kulon	East Java	Indonesia
8583	Gombong	Central Java	Indonesia
8584	Godean	Daerah Istimewa Yogyakarta	Indonesia
8585	Genteng	East Java	Indonesia
8586	Gedangan	East Java	Indonesia
8587	Gebog	Central Java	Indonesia
8588	Gampengrejo	East Java	Indonesia
8589	Gambiran Satu	East Java	Indonesia
8590	Galesong	South Sulawesi	Indonesia
8591	Ende	East Nusa Tenggara	Indonesia
8592	Dumai	Riau	Indonesia
8593	Dukuhturi	Central Java	Indonesia
8594	Driyorejo	East Java	Indonesia
8595	Dompu	West Nusa Tenggara	Indonesia
8596	Diwek	East Java	Indonesia
8597	Depok	Daerah Istimewa Yogyakarta	Indonesia
8598	Depok	West Java	Indonesia
8599	Denpasar	Bali	Indonesia
8600	Demak	Central Java	Indonesia
8601	Delanggu	Central Java	Indonesia
8602	Dampit	East Java	Indonesia
8603	Curup	Bengkulu	Indonesia
8604	Curug	Banten	Indonesia
8605	Comal	Central Java	Indonesia
8606	Colomadu	Central Java	Indonesia
8607	Citeureup	West Java	Indonesia
8608	Cirebon	West Java	Indonesia
8609	Ciputat	West Java	Indonesia
8610	Cimahi	West Java	Indonesia
8611	Cileunyi	West Java	Indonesia
8612	Cileungsir	West Java	Indonesia
8613	Cikarang	West Java	Indonesia
8614	Cikampek	West Java	Indonesia
8615	Cicurug	West Java	Indonesia
8616	Cibinong	West Java	Indonesia
8617	Ciamis	West Java	Indonesia
8618	Cepu	Central Java	Indonesia
8619	Ceper	Central Java	Indonesia
8620	Caringin	West Java	Indonesia
8621	Ciampea	West Java	Indonesia
8622	Bulakamba	Central Java	Indonesia
8623	Bukittinggi	West Sumatra	Indonesia
8624	Buduran	East Java	Indonesia
8625	Buaran	Central Java	Indonesia
8626	Boyolangu	East Java	Indonesia
8627	Boyolali	Central Java	Indonesia
8628	Bontang	East Kalimantan	Indonesia
8629	Bondowoso	East Java	Indonesia
8630	Bojonegoro	East Java	Indonesia
8631	Bogor	West Java	Indonesia
8632	Blora	Central Java	Indonesia
8633	Blitar	East Java	Indonesia
8634	Bitung	North Sulawesi	Indonesia
8635	Bima	West Nusa Tenggara	Indonesia
8636	Besuki	East Java	Indonesia
8637	Bengkulu	Bengkulu	Indonesia
8638	Bekasi	West Java	Indonesia
8639	Baturaja	South Sumatra	Indonesia
8640	Baturaden	Central Java	Indonesia
8641	Batu	East Java	Indonesia
8642	Batang	Central Java	Indonesia
8643	Barabai	South Kalimantan	Indonesia
8644	Banyuwangi	East Java	Indonesia
8645	Banyumas	Central Java	Indonesia
8646	Bantul	Daerah Istimewa Yogyakarta	Indonesia
8647	Banjarmasin	South Kalimantan	Indonesia
8648	Banjaran	West Java	Indonesia
8649	Banjar	Bali	Indonesia
8650	Banjar	West Java	Indonesia
8651	Bangkalan	East Java	Indonesia
8652	Bangil	East Java	Indonesia
8653	Bandung	West Java	Indonesia
8654	Bambanglipuro	Daerah Istimewa Yogyakarta	Indonesia
8655	Balung	East Java	Indonesia
8656	Balikpapan	East Kalimantan	Indonesia
8657	Balapulang	Central Java	Indonesia
8658	Balaipungut	Riau	Indonesia
8659	Baki	Central Java	Indonesia
8660	Baekrajan	Central Java	Indonesia
8661	Babat	East Java	Indonesia
8662	Atambua	East Nusa Tenggara	Indonesia
8663	Astanajapura	West Java	Indonesia
8664	Arjawinangun	West Java	Indonesia
8665	Amuntai	South Kalimantan	Indonesia
8666	Ambon	Maluku	Indonesia
8667	Ambarawa	Central Java	Indonesia
8668	Amahai	Maluku	Indonesia
8669	Adiwerna	Central Java	Indonesia
8670	Padalarang	West Java	Indonesia
8671	Ciranjang-hilir	West Java	Indonesia
8672	Cikupa	West Java	Indonesia
8673	Teluknaga	West Java	Indonesia
8674	Wonosari	Daerah Istimewa Yogyakarta	Indonesia
8675	Gamping Lor	Daerah Istimewa Yogyakarta	Indonesia
8676	Kasihan	Daerah Istimewa Yogyakarta	Indonesia
8677	Ngemplak	Central Java	Indonesia
8678	Kartasura	Central Java	Indonesia
8679	Gatak	Central Java	Indonesia
8680	Kupang	East Nusa Tenggara	Indonesia
8681	Jayapura	Papua	Indonesia
8682	Abepura	Papua	Indonesia
8683	Seririt	Bali	Indonesia
8684	City of Balikpapan	East Kalimantan	Indonesia
8685	Pekan Bahapal	North Sumatra	Indonesia
8686	South Tangerang	Banten	Indonesia
8687	Loch Garman	Leinster	Ireland
8688	Waterford	Munster	Ireland
8689	Tralee	Munster	Ireland
8690	Tallaght	Leinster	Ireland
8691	Swords	Leinster	Ireland
8692	Sligo	Connaught	Ireland
8693	Droichead Nua	Leinster	Ireland
8694	Navan	Leinster	Ireland
8695	Naas	Leinster	Ireland
8696	An Muileann gCearr	Leinster	Ireland
8697	Malahide	Leinster	Ireland
8698	Lucan	Leinster	Ireland
8699	Luimneach	Munster	Ireland
8700	Letterkenny	Ulster	Ireland
8701	Leixlip	Leinster	Ireland
8702	Kilkenny	Leinster	Ireland
8703	Gaillimh	Connaught	Ireland
8704	Finglas	Leinster	Ireland
8705	Ennis	Munster	Ireland
8707	Dundalk	Leinster	Ireland
8708	Dublin	Leinster	Ireland
8709	Drogheda	Leinster	Ireland
8710	Cork	Munster	Ireland
8711	Cluain Meala	Munster	Ireland
8712	Celbridge	Leinster	Ireland
8713	Carlow	Leinster	Ireland
8714	Blanchardstown	Leinster	Ireland
8715	Balbriggan	Leinster	Ireland
8716	Athlone	Leinster	Ireland
8717	Sandyford	Leinster	Ireland
8718	Donaghmede	Leinster	Ireland
8719	Jerusalem	Jerusalem	Israel
8720	Safed	Northern District	Israel
8721	Yehud	Central District	Israel
8723	Yafo	Tel Aviv	Israel
8724	Umm el Fa?m	Haifa	Israel
8725	Tirat Karmel	Haifa	Israel
8726	Tiberias	Northern District	Israel
8727	Tel Aviv	Tel Aviv	Israel
8728	maalot Tarshiha	Northern District	Israel
8729	Tamra	Northern District	Israel
8730	Sederot	Southern District	Israel
8731	Sakhnin	Northern District	Israel
8733	Rishon Le?iyyon	Central District	Israel
8734	Ramla	Central District	Israel
8735	Ramat HaSharon	Tel Aviv	Israel
8736	Ramat Gan	Tel Aviv	Israel
8737	Raanana	Central District	Israel
8738	Qiryat Yam	Haifa	Israel
8739	Qiryat Shemona	Northern District	Israel
8740	Qiryat Mo?qin	Haifa	Israel
8741	Qiryat Gat	Southern District	Israel
8742	Qiryat Bialik	Haifa	Israel
8743	Qiryat Ata	Haifa	Israel
8744	Qalansuwa	Central District	Israel
8745	Peta? Tiqwa	Central District	Israel
8746	Or Yehuda	Tel Aviv	Israel
8747	Ofaqim	Southern District	Israel
8748	Netivot	Southern District	Israel
8749	Netanya	Central District	Israel
8750	Ness Ziona	Central District	Israel
8751	Nesher	Haifa	Israel
8752	Nazareth	Northern District	Israel
8753	Nahariya	Northern District	Israel
8755	Mevo Betar	Jerusalem	Israel
8756	Maghar	Northern District	Israel
8757	Lod	Central District	Israel
8758	Kfar Saba	Central District	Israel
8760	Kafr Qasim	Central District	Israel
8761	Kafr Manda	Northern District	Israel
8762	Kafr Kanna	Northern District	Israel
8763	Judeida Makr	Northern District	Israel
8764	H_olon	Tel Aviv	Israel
8765	Hod HaSharon	Central District	Israel
8766	Herzliyya	Tel Aviv	Israel
8767	Haifa	Haifa	Israel
8768	H_adera	Haifa	Israel
8771	Tirah	Central District	Israel
8772	E? ?aiyiba	Central District	Israel
8773	Er Reina	Northern District	Israel
8774	Eilat	Southern District	Israel
8775	Dimona	Southern District	Israel
8776	Daliyat el Karmil	Haifa	Israel
8777	Bet Shemesh	Jerusalem	Israel
8780	Beersheba	Southern District	Israel
8781	Bat Yam	Tel Aviv	Israel
8782	Ashqelon	Southern District	Israel
8783	Ashdod	Southern District	Israel
8787	Modiin	Central District	Israel
8788	West Jerusalem	Jerusalem	Israel
8789	Modiin Ilit	Jerusalem	Israel
8790	Ariel	Jerusalem	Israel
8791	Douglas	Douglas	Isle of Man
8792	Punch	Kashmir	India
8793	Keelakarai	Tamil Nadu	India
8794	Zunheboto	Nagaland	India
8795	Zamania	Uttar Pradesh	India
8796	Zaidpur	Uttar Pradesh	India
8797	Zahirabad	Telangana	India
8798	Yeola	Maharashtra	India
8799	Yellapur	Karnataka	India
8800	Yellandu	Telangana	India
8801	Yelahanka	Karnataka	India
8802	Yavatmal	Maharashtra	India
8803	Yaval	Maharashtra	India
8804	Yanam	Andhra Pradesh	India
8805	Yamunanagar	Haryana	India
8806	Yadgir	Karnataka	India
8807	Wokha	Nagaland	India
8808	Wer	Rajasthan	India
8809	Wellington	Tamil Nadu	India
8810	Wazirganj	Uttar Pradesh	India
8811	Washim	Maharashtra	India
8812	Warud	Maharashtra	India
8813	Warora	Maharashtra	India
8814	Waris Aliganj	Bihar	India
8815	Wardha	Maharashtra	India
8816	Waraseoni	Madhya Pradesh	India
8817	Warangal	Telangana	India
8818	Wanparti	Telangana	India
8819	Wankaner	Gujarat	India
8820	Wani	Maharashtra	India
8821	Walajapet	Tamil Nadu	India
8822	Wai	Maharashtra	India
8823	Wadi	Karnataka	India
8824	Vyara	Gujarat	India
8825	Vuyyuru	Andhra Pradesh	India
8826	Vrindavan	Uttar Pradesh	India
8827	Vriddhachalam	Tamil Nadu	India
8828	Vizianagaram	Andhra Pradesh	India
8829	Vite	Maharashtra	India
8830	Visnagar	Gujarat	India
8831	Visakhapatnam	Andhra Pradesh	India
8832	Visavadar	Gujarat	India
8833	Virudunagar	Tamil Nadu	India
8834	Viravanallur	Tamil Nadu	India
8835	Virarajendrapet	Karnataka	India
8836	Virar	Maharashtra	India
8837	Vinukonda	Andhra Pradesh	India
8838	Villupuram	Tamil Nadu	India
8839	Vikarabad	Telangana	India
8840	Vijayawada	Andhra Pradesh	India
8841	Vijapur	Gujarat	India
8842	Vidisha	Madhya Pradesh	India
8843	Vettur	Kerala	India
8844	Vettaikkaranpudur	Tamil Nadu	India
8845	Vetapalem	Andhra Pradesh	India
8846	Veraval	Gujarat	India
8847	Vepagunta	Andhra Pradesh	India
8848	Venkatagiri	Andhra Pradesh	India
8849	Vemalwada	Telangana	India
8850	Velur	Tamil Nadu	India
8851	Vellore	Tamil Nadu	India
8852	Vejalpur	Gujarat	India
8853	Vedaraniyam	Tamil Nadu	India
8854	Vayalar	Kerala	India
8855	Vattalkundu	Tamil Nadu	India
8856	Vasudevanallur	Tamil Nadu	India
8857	Vasind	Maharashtra	India
8858	Vasco Da Gama	Goa	India
8859	Vasa	Gujarat	India
8860	Varkala	Kerala	India
8861	Varangaon	Maharashtra	India
8862	Varanasi	Uttar Pradesh	India
8863	Vaniyambadi	Tamil Nadu	India
8864	Vandavasi	Tamil Nadu	India
8865	Valsad	Gujarat	India
8866	Valparai	Tamil Nadu	India
8867	Vallabh Vidyanagar	Gujarat	India
8868	Valabhipur	Gujarat	India
8869	Vaikam	Kerala	India
8870	Vaijapur	Maharashtra	India
8871	Vadodara	Gujarat	India
8872	Vadnagar	Gujarat	India
8873	Vadlapudi	Andhra Pradesh	India
8874	Vadippatti	Tamil Nadu	India
8875	Vadamadurai	Tamil Nadu	India
8876	Vadakku Valliyur	Tamil Nadu	India
8877	Vada	Maharashtra	India
8878	Uttiramerur	Tamil Nadu	India
8879	Uttarkashi	Uttarakhand	India
8880	Uttamapalaiyam	Tamil Nadu	India
8881	Utraula	Uttar Pradesh	India
8882	Usilampatti	Tamil Nadu	India
8883	Usehat	Uttar Pradesh	India
8884	Uravakonda	Andhra Pradesh	India
8885	Uran	Maharashtra	India
8886	Upleta	Gujarat	India
8887	Uppal Kalan	Telangana	India
8888	Unnao	Uttar Pradesh	India
8889	Unjha	Gujarat	India
8890	Unhel	Madhya Pradesh	India
8891	Una	Himachal Pradesh	India
8892	Una	Gujarat	India
8893	Un	Uttar Pradesh	India
8894	Un	Gujarat	India
8895	Umreth	Gujarat	India
8896	Umred	Maharashtra	India
8897	Umarkot	Chhattisgarh	India
8898	Umarkhed	Maharashtra	India
8899	Umaria	Madhya Pradesh	India
8900	Umarga	Maharashtra	India
8901	Ullal	Karnataka	India
8902	Ulhasnagar	Maharashtra	India
8903	Ujjain	Madhya Pradesh	India
8904	Ujhani	Uttar Pradesh	India
8905	Udumalaippettai	Tamil Nadu	India
8906	Udipi	Karnataka	India
8907	Udhampur	Kashmir	India
8908	Udgir	Maharashtra	India
8909	Udankudi	Tamil Nadu	India
8910	Udalguri	Assam	India
8911	Udaipura	Madhya Pradesh	India
8912	Udaipur	Rajasthan	India
8913	Udaipur	Rajasthan	India
8914	Udaipur	Tripura	India
8915	Ooty	Tamil Nadu	India
8916	Bara Uchana	Haryana	India
8917	Turaiyur	Tamil Nadu	India
8918	Tura	Meghalaya	India
8919	Tuni	Andhra Pradesh	India
8920	Tundla	Uttar Pradesh	India
8921	Tumsar	Maharashtra	India
8922	Tumkur	Karnataka	India
8923	Tulsipur	Uttar Pradesh	India
8924	Tuljapur	Maharashtra	India
8925	Tufanganj	West Bengal	India
8926	Tuensang	Nagaland	India
8927	Thiruvananthapuram	Kerala	India
8928	Trichur	Kerala	India
8929	Tonk	Rajasthan	India
8930	Tondi	Tamil Nadu	India
8931	Tohana	Haryana	India
8932	Todaraisingh	Rajasthan	India
8933	Todabhim	Rajasthan	India
8934	Titlagarh	Odisha	India
8935	Titagarh	West Bengal	India
8936	Tisaiyanvilai	Tamil Nadu	India
8937	Tiruvottiyur	Tamil Nadu	India
8938	Cheyyar	Tamil Nadu	India
8939	Tiruvannamalai	Tamil Nadu	India
8940	Tiruvallur	Tamil Nadu	India
8941	Tiruvalla	Kerala	India
8942	Thiruthani	Tamil Nadu	India
8943	Tiruttangal	Tamil Nadu	India
8944	Tirur	Kerala	India
8945	Tiruppuvanam	Tamil Nadu	India
8946	Tiruppur	Tamil Nadu	India
8947	Tirupparangunram	Tamil Nadu	India
8948	Tirupati	Andhra Pradesh	India
8949	Tirunelveli	Tamil Nadu	India
8950	Tirumala	Andhra Pradesh	India
8951	Tirukkoyilur	Tamil Nadu	India
8952	Tiruchengode	Tamil Nadu	India
8953	Tiruchirappalli	Tamil Nadu	India
8954	Tiruchchendur	Tamil Nadu	India
8955	Tirthahalli	Karnataka	India
8956	Tiptur	Karnataka	India
8957	Tinsukia	Assam	India
8958	Tinnanur	Tamil Nadu	India
8959	Tindivanam	Tamil Nadu	India
8960	Tilhar	Uttar Pradesh	India
8961	Tikamgarh	Madhya Pradesh	India
8962	Tijara	Rajasthan	India
8963	Thoubal	Manipur	India
8964	Thiruvarur	Tamil Nadu	India
8965	Thasra	Gujarat	India
8966	Tharad	Gujarat	India
8967	Thanjavur	Tamil Nadu	India
8968	Thanesar	Haryana	India
8969	Thane	Maharashtra	India
8970	Thana Bhawan	Uttar Pradesh	India
8971	Than	Gujarat	India
8972	Thakurganj	Bihar	India
8973	Thakurdwara	Uttar Pradesh	India
8974	Tezpur	Assam	India
8975	Terdal	Karnataka	India
8976	Teonthar	Madhya Pradesh	India
8977	Thenkasi	Tamil Nadu	India
8978	Teni	Tamil Nadu	India
8979	Tellicherry	Kerala	India
8980	Telhara	Maharashtra	India
8981	Tekkali	Andhra Pradesh	India
8982	Tekkalakote	Karnataka	India
8983	Tekari	Bihar	India
8984	Tehri	Uttarakhand	India
8985	Teghra	Bihar	India
8986	Tasgaon	Maharashtra	India
8987	Tarn Taran	Punjab	India
8988	Tarikere	Karnataka	India
8989	Tharangambadi	Tamil Nadu	India
8990	Taranagar	Rajasthan	India
8991	Tarana	Madhya Pradesh	India
8992	Taramangalam	Tamil Nadu	India
8993	Tarakeswar	West Bengal	India
8994	Taoru	Haryana	India
8995	Tanuku	Andhra Pradesh	India
8996	Tandur	Telangana	India
8997	Tanda	Uttar Pradesh	India
8998	Tanda	Uttar Pradesh	India
8999	Tanakpur	Uttarakhand	India
9000	Tamluk	West Bengal	India
9001	Talwara	Punjab	India
9002	Talwandi Bhai	Punjab	India
9003	Taloda	Maharashtra	India
9004	Talipparamba	Kerala	India
9005	Talikota	Karnataka	India
9006	Taleigao	Goa	India
9007	Talegaon Dabhade	Maharashtra	India
9008	Talcher	Odisha	India
9009	Talaja	Gujarat	India
9010	Taki	West Bengal	India
9011	Takhatpur	Chhattisgarh	India
9012	Takhatgarh	Rajasthan	India
9013	Tajpur	Uttar Pradesh	India
9014	Tadpatri	Andhra Pradesh	India
9015	Tadepallegudem	Andhra Pradesh	India
9016	Tadepalle	Andhra Pradesh	India
9017	Suriapet	Telangana	India
9018	Surianwan	Uttar Pradesh	India
9019	Surendranagar	Gujarat	India
9020	Suratgarh	Rajasthan	India
9021	Surat	Gujarat	India
9022	Surandai	Tamil Nadu	India
9023	Surajgarh	Rajasthan	India
9024	Supaul	Bihar	India
9025	Sunel	Rajasthan	India
9026	Sundarnagar	Himachal Pradesh	India
9027	Sundargarh	Odisha	India
9028	Sunam	Punjab	India
9029	Sulya	Karnataka	India
9030	Suluru	Andhra Pradesh	India
9031	Sulur	Tamil Nadu	India
9032	Sultanpur	Punjab	India
9033	Sultanpur	Uttar Pradesh	India
9034	Suket	Rajasthan	India
9035	Sujangarh	Rajasthan	India
9036	Suar	Uttar Pradesh	India
9037	Srivilliputhur	Tamil Nadu	India
9038	Srivardhan	Maharashtra	India
9039	Srivaikuntam	Tamil Nadu	India
9040	Srisailain	Andhra Pradesh	India
9041	Sriramnagar	Telangana	India
9042	Sriperumbudur	Tamil Nadu	India
9043	Srinivaspur	Karnataka	India
9044	Srinagar	Kashmir	India
9045	Srinagar	Uttarakhand	India
9046	Sri Madhopur	Rajasthan	India
9047	Karanpur	Rajasthan	India
9048	Chicacole	Andhra Pradesh	India
9049	Sri Dungargarh	Rajasthan	India
9050	Soygaon	Maharashtra	India
9051	Soron	Uttar Pradesh	India
9052	Soro	Odisha	India
9053	Sorada	Odisha	India
9054	Sopur	Kashmir	India
9055	Sonipat	Haryana	India
9056	Songadh	Gujarat	India
9057	Sonepur	Odisha	India
9058	Sonari	Assam	India
9059	Sonamukhi	West Bengal	India
9060	Sompeta	Andhra Pradesh	India
9061	Someshwar	Karnataka	India
9062	Solan	Himachal Pradesh	India
9063	Sojitra	Gujarat	India
9064	Sojat	Rajasthan	India
9065	Sohna	Haryana	India
9066	Sohagpur	Madhya Pradesh	India
9067	Siwana	Rajasthan	India
9068	Siwan	Bihar	India
9069	Sivakasi	Tamil Nadu	India
9070	Sivagiri	Tamil Nadu	India
9071	Sivagiri	Tamil Nadu	India
9072	Sivaganga	Tamil Nadu	India
9073	Siuri	West Bengal	India
9074	Sitarganj	Uttarakhand	India
9075	Sitapur	Uttar Pradesh	India
9076	Sitamarhi	Bihar	India
9077	Siswa Bazar	Uttar Pradesh	India
9078	Sisauli	Uttar Pradesh	India
9079	Sirur	Maharashtra	India
9080	Sirumugai	Tamil Nadu	India
9081	Siruguppa	Karnataka	India
9082	Sirsilla	Telangana	India
9083	Sirsi	Uttar Pradesh	India
9084	Sirsi	Karnataka	India
9085	Sirsaganj	Uttar Pradesh	India
9086	Sirsa	Haryana	India
9087	Sironj	Madhya Pradesh	India
9088	Sirohi	Rajasthan	India
9089	Sirkazhi	Tamil Nadu	India
9090	Sirhind	Punjab	India
9091	Sira	Karnataka	India
9092	Sinnar	Maharashtra	India
9093	Singur	West Bengal	India
9094	Singarayakonda	Andhra Pradesh	India
9095	Singanallur	Tamil Nadu	India
9096	Sindhnur	Karnataka	India
9097	Sindgi	Karnataka	India
9098	Shimla	Himachal Pradesh	India
9099	Simdega	Jharkhand	India
9100	Silvassa	Dadra and Nagar Haveli	India
9101	Sillod	Maharashtra	India
9102	Silchar	Assam	India
9103	Silao	Bihar	India
9104	Sikar	Rajasthan	India
9105	Sikandra Rao	Uttar Pradesh	India
9106	Sikandarpur	Uttar Pradesh	India
9107	Sikandarabad	Uttar Pradesh	India
9108	Sikka	Gujarat	India
9109	Sijua	Jharkhand	India
9110	Sihora	Madhya Pradesh	India
9111	Sihor	Gujarat	India
9112	Sidlaghatta	Karnataka	India
9113	Sidhi	Madhya Pradesh	India
9114	Sidhauli	Uttar Pradesh	India
9115	Siddipet	Telangana	India
9116	Siddhapur	Gujarat	India
9117	Sibsagar	Assam	India
9118	Shyamnagar	West Bengal	India
9119	Shujalpur	Madhya Pradesh	India
9120	Shrirangapattana	Karnataka	India
9121	Shrirampur	West Bengal	India
9122	Shrigonda	Maharashtra	India
9123	Shorapur	Karnataka	India
9124	Shoranur	Kerala	India
9125	Sholinghur	Tamil Nadu	India
9126	Solapur	Maharashtra	India
9127	Shivpuri	Madhya Pradesh	India
9128	Shishgarh	Uttar Pradesh	India
9129	Shirpur	Maharashtra	India
9130	Shirhatti	Karnataka	India
9131	Shirdi	Maharashtra	India
9132	Shimoga	Karnataka	India
9133	Shillong	Meghalaya	India
9134	Shiliguri	West Bengal	India
9135	Shikohabad	Uttar Pradesh	India
9136	Shikarpur	Uttar Pradesh	India
9137	Shikarpur	Karnataka	India
9138	Shiggaon	Karnataka	India
9139	Shertallai	Kerala	India
9140	Sherkot	Uttar Pradesh	India
9141	Sherghati	Bihar	India
9142	Sheopur	Madhya Pradesh	India
9143	Sheohar	Bihar	India
9144	Sheoganj	Rajasthan	India
9145	Shegaon	Maharashtra	India
9146	Shantipur	West Bengal	India
9147	Shamsabad	Uttar Pradesh	India
9148	Shamsabad	Uttar Pradesh	India
9149	Shamli	Uttar Pradesh	India
9150	Shamgarh	Madhya Pradesh	India
9151	Shajapur	Madhya Pradesh	India
9152	Sheikhpura	Bihar	India
9153	Shahpura	Rajasthan	India
9154	Shahpura	Rajasthan	India
9155	Shahpur	Uttar Pradesh	India
9156	Shahpur	Bihar	India
9157	Shahpur	Madhya Pradesh	India
9158	Shahpur	Karnataka	India
9159	Shahjanpur	Uttar Pradesh	India
9160	Shahi	Uttar Pradesh	India
9161	Shahganj	Uttar Pradesh	India
9162	Shahdol	Madhya Pradesh	India
9163	Shahada	Maharashtra	India
9164	Shahabad	Haryana	India
9165	Shahabad	Uttar Pradesh	India
9166	Shahabad	Uttar Pradesh	India
9167	Shahabad	Karnataka	India
9168	Serchhip	Mizoram	India
9169	Seram	Karnataka	India
9170	Seoni Malwa	Madhya Pradesh	India
9171	Seoni	Madhya Pradesh	India
9172	Seondha	Madhya Pradesh	India
9173	Seohara	Uttar Pradesh	India
9174	Sendhwa	Madhya Pradesh	India
9175	Sehore	Madhya Pradesh	India
9176	Secunderabad	Telangana	India
9177	Sayla	Gujarat	India
9178	Sawai Madhopur	Rajasthan	India
9179	Savda	Maharashtra	India
9180	Savanur	Karnataka	India
9181	Savantvadi	Maharashtra	India
9182	Sausar	Madhya Pradesh	India
9183	Saundatti	Karnataka	India
9184	Sathyamangalam	Tamil Nadu	India
9185	Sattur	Tamil Nadu	India
9186	Sattenapalle	Andhra Pradesh	India
9187	Satna	Madhya Pradesh	India
9188	Satara	Maharashtra	India
9189	Satana	Maharashtra	India
9190	Sasvad	Maharashtra	India
9191	Sarwar	Rajasthan	India
9192	Sarkhej	Gujarat	India
9193	Sardulgarh	Punjab	India
9194	Sardhana	Uttar Pradesh	India
9195	Sardarshahr	Rajasthan	India
9196	Sarauli	Uttar Pradesh	India
9197	Sarangpur	Madhya Pradesh	India
9198	Saraipali	Chhattisgarh	India
9199	Sarai Mir	Uttar Pradesh	India
9200	Sarai Akil	Uttar Pradesh	India
9201	Saoner	Maharashtra	India
9202	Sankrail	West Bengal	India
9203	Sankeshwar	Karnataka	India
9204	Sangrur	Punjab	India
9205	Sangola	Maharashtra	India
9206	Sangod	Rajasthan	India
9207	Sangli	Maharashtra	India
9208	Sangaria	Rajasthan	India
9209	Sangareddi	Telangana	India
9210	Sangamner	Maharashtra	India
9211	Sandur	Karnataka	India
9212	Sandila	Uttar Pradesh	India
9213	Sandi	Uttar Pradesh	India
9214	Sancoale	Goa	India
9215	Sanchor	Rajasthan	India
9216	Sanawad	Madhya Pradesh	India
9217	Sanaur	Punjab	India
9218	Sanand	Gujarat	India
9219	Samthar	Uttar Pradesh	India
9220	Samrala	Punjab	India
9221	Samdari	Rajasthan	India
9222	Sambhar	Rajasthan	India
9223	Sambhal	Uttar Pradesh	India
9224	Sambalpur	Odisha	India
9225	Samba	Kashmir	India
9226	Samastipur	Bihar	India
9227	Samalkot	Andhra Pradesh	India
9228	Samalkha	Haryana	India
9229	Salur	Andhra Pradesh	India
9230	Salumbar	Rajasthan	India
9231	Salem	Tamil Nadu	India
9232	Salaya	Gujarat	India
9233	Sakti	Chhattisgarh	India
9234	Sakleshpur	Karnataka	India
9235	Saint Thomas Mount	Tamil Nadu	India
9236	Sainthia	West Bengal	India
9237	Selu	Maharashtra	India
9238	Saiha	Mizoram	India
9239	Saidpur	Uttar Pradesh	India
9240	Sahibganj	Jharkhand	India
9241	Sahawar	Uttar Pradesh	India
9242	Sahaswan	Uttar Pradesh	India
9243	Sahaspur	Uttar Pradesh	India
9244	Saharsa	Bihar	India
9245	Saharanpur	Uttar Pradesh	India
9246	Sagauli	Bihar	India
9247	Saugor	Madhya Pradesh	India
9248	Sagar	Karnataka	India
9249	Safipur	Uttar Pradesh	India
9250	Safidon	Haryana	India
9251	Sadri	Rajasthan	India
9252	Sadaseopet	Telangana	India
9253	Sadalgi	Karnataka	India
9254	Sadabad	Uttar Pradesh	India
9255	Sabalgarh	Madhya Pradesh	India
9256	Rusera	Bihar	India
9257	Rura	Uttar Pradesh	India
9258	Ropar	Punjab	India
9259	Rudarpur	Uttar Pradesh	India
9260	Roorkee	Uttarakhand	India
9261	Ron	Karnataka	India
9262	Rohtak	Haryana	India
9263	Roha	Maharashtra	India
9264	Robertsonpet	Karnataka	India
9265	Robertsganj	Uttar Pradesh	India
9266	Risod	Maharashtra	India
9267	Rishra	West Bengal	India
9268	Rishikesh	Uttarakhand	India
9269	Ringas	Rajasthan	India
9270	Richha	Uttar Pradesh	India
9271	Rewari	Haryana	India
9272	Rewa	Madhya Pradesh	India
9273	Revelganj	Bihar	India
9274	Repalle	Andhra Pradesh	India
9275	Reoti	Uttar Pradesh	India
9276	Renukut	Uttar Pradesh	India
9277	Renigunta	Andhra Pradesh	India
9278	Remuna	Odisha	India
9279	Rehli	Madhya Pradesh	India
9280	Razam	Andhra Pradesh	India
9281	Raybag	Karnataka	India
9282	Rayadrug	Andhra Pradesh	India
9283	Rayachoti	Andhra Pradesh	India
9284	Raya	Uttar Pradesh	India
9285	Raxaul	Bihar	India
9286	Rawatsar	Rajasthan	India
9287	Rawatbhata	Rajasthan	India
9288	Raver	Maharashtra	India
9289	Ratnagiri	Maharashtra	India
9290	Ratlam	Madhya Pradesh	India
9291	Ratia	Haryana	India
9292	Rath	Uttar Pradesh	India
9293	Ratanpur	Chhattisgarh	India
9294	Ratangarh	Rajasthan	India
9295	Rasra	Uttar Pradesh	India
9296	Rasipuram	Tamil Nadu	India
9297	Rapar	Gujarat	India
9298	Ranipur	Uttar Pradesh	India
9299	Ranikhet	Uttarakhand	India
9300	Raniganj	West Bengal	India
9301	Ranibennur	Karnataka	India
9302	Rania	Haryana	India
9303	Rangia	Assam	India
9304	Rangapara	Assam	India
9305	Ranchi	Jharkhand	India
9306	Ranavav	Gujarat	India
9307	Ranaghat	West Bengal	India
9308	Ramtek	Maharashtra	India
9309	Rampur Hat	West Bengal	India
9310	Rampura	Punjab	India
9311	Rampura	Madhya Pradesh	India
9312	Rampur	Uttar Pradesh	India
9313	Rampur	Uttar Pradesh	India
9314	Ramnagar	Uttarakhand	India
9315	Ramnagar	Bihar	India
9316	Ramnagar	Uttar Pradesh	India
9317	Ramjibanpur	West Bengal	India
9318	Ramgundam	Telangana	India
9319	Ramgarh	Rajasthan	India
9320	Ramgarh	Jharkhand	India
9321	Ramganj Mandi	Rajasthan	India
9322	Rameswaram	Tamil Nadu	India
9323	Ramapuram	Andhra Pradesh	India
9324	Ramanathapuram	Tamil Nadu	India
9325	Ramanagaram	Karnataka	India
9326	Ramachandrapuram	Andhra Pradesh	India
9327	Rajura	Maharashtra	India
9328	Rajula	Gujarat	India
9329	Rajsamand	Rajasthan	India
9330	Rajpura	Punjab	India
9331	Rajpur	Madhya Pradesh	India
9332	Rajpur	Madhya Pradesh	India
9333	Rajpipla	Gujarat	India
9334	Raj-Nandgaon	Chhattisgarh	India
9335	Rajmahal	West Bengal	India
9336	Rajkot	Gujarat	India
9337	Rajgurunagar	Maharashtra	India
9338	Rajgir	Bihar	India
9339	Rajgarh	Rajasthan	India
9340	Rajgarh	Rajasthan	India
9341	Rajgarh	Madhya Pradesh	India
9342	Rajgarh	Madhya Pradesh	India
9343	Rajaori	Kashmir	India
9344	Rajapalaiyam	Tamil Nadu	India
9345	Rajampet	Andhra Pradesh	India
9346	Rajaldesar	Rajasthan	India
9347	Rajakhera	Rajasthan	India
9348	Rajahmundry	Andhra Pradesh	India
9349	Raisinghnagar	Rajasthan	India
9350	Raisen	Madhya Pradesh	India
9351	Raipur	Uttarakhand	India
9352	Raipur	Rajasthan	India
9353	Raipur	Chhattisgarh	India
9354	Raikot	Punjab	India
9355	Raigarh	Chhattisgarh	India
9356	Raiganj	West Bengal	India
9357	Raichur	Karnataka	India
9358	Rahuri	Maharashtra	India
9359	Rahimatpur	Maharashtra	India
9360	Rahatgarh	Madhya Pradesh	India
9361	Raghunathpur	West Bengal	India
9362	Raghogarh	Madhya Pradesh	India
9363	Rafiganj	Bihar	India
9364	Raebareli	Uttar Pradesh	India
9365	Radhanpur	Gujarat	India
9366	Rabkavi	Karnataka	India
9367	Kollam	Kerala	India
9368	Kasba	Bihar	India
9369	Qadian	Punjab	India
9370	Puttur	Andhra Pradesh	India
9371	Puttur	Karnataka	India
9372	Pushkar	Rajasthan	India
9373	Pusad	Maharashtra	India
9374	Purwa	Uttar Pradesh	India
9375	Puruliya	West Bengal	India
9376	Purnia	Bihar	India
9377	Purna	Maharashtra	India
9378	Puri	Odisha	India
9379	Puranpur	Uttar Pradesh	India
9380	Pupri	Bihar	India
9381	Punjai Puliyampatti	Tamil Nadu	India
9382	Punganuru	Andhra Pradesh	India
9383	Pune	Maharashtra	India
9384	Pundri	Haryana	India
9385	Punasa	Madhya Pradesh	India
9386	Punalur	Kerala	India
9387	Punahana	Haryana	India
9388	Pulwama	Kashmir	India
9389	Puliyangudi	Tamil Nadu	India
9390	Pulivendla	Andhra Pradesh	India
9391	Pulgaon	Maharashtra	India
9392	Pukhrayan	Uttar Pradesh	India
9393	Pudukkottai	Tamil Nadu	India
9394	Proddatur	Andhra Pradesh	India
9395	Pratapgarh	Rajasthan	India
9396	Port Blair	Andaman and Nicobar Islands	India
9397	Porsa	Madhya Pradesh	India
9398	Porbandar	Gujarat	India
9399	Poonamalle	Tamil Nadu	India
9400	Ponnuru	Andhra Pradesh	India
9401	Ponneri	Tamil Nadu	India
9402	Ponnani	Kerala	India
9403	Puducherry	Pondicherry	India
9404	Ponda	Goa	India
9405	Polur	Tamil Nadu	India
9406	Pollachi	Tamil Nadu	India
9407	Polavaram	Andhra Pradesh	India
9408	Polasara	Odisha	India
9409	Pokaran	Rajasthan	India
9410	Pithoragarh	Uttarakhand	India
9411	Pithapuram	Andhra Pradesh	India
9412	Piro	Bihar	India
9413	Piriyapatna	Karnataka	India
9414	Piravam	Kerala	India
9415	Pipri	Maharashtra	India
9416	Pipraich	Uttar Pradesh	India
9417	Pipili	Odisha	India
9418	Pipar	Rajasthan	India
9419	Pinjaur	Haryana	India
9420	Pindwara	Rajasthan	India
9421	Pinahat	Uttar Pradesh	India
9422	Pimpri	Maharashtra	India
9423	Pilkhua	Uttar Pradesh	India
9424	Pilibhit	Uttar Pradesh	India
9425	Pilibangan	Rajasthan	India
9426	Pilani	Rajasthan	India
9427	Pihani	Uttar Pradesh	India
9428	Phulpur	Uttar Pradesh	India
9429	Phulera	Rajasthan	India
9430	Phulabani	Odisha	India
9431	Phirangipuram	Andhra Pradesh	India
9432	Phillaur	Punjab	India
9433	Phek	Manipur	India
9434	Phaphund	Uttar Pradesh	India
9435	Phaltan	Maharashtra	India
9436	Phalodi	Rajasthan	India
9437	Phalauda	Uttar Pradesh	India
9438	Phagwara	Punjab	India
9439	Petlad	Gujarat	India
9440	Perundurai	Tamil Nadu	India
9441	Perumpavur	Kerala	India
9442	Periyanayakkanpalaiyam	Tamil Nadu	India
9443	Periyakulam	Tamil Nadu	India
9444	Peravurani	Tamil Nadu	India
9445	Peranampattu	Tamil Nadu	India
9446	Perambalur	Tamil Nadu	India
9447	Penukonda	Andhra Pradesh	India
9448	Penugonda	Andhra Pradesh	India
9449	Pennagaram	Tamil Nadu	India
9450	Pennadam	Tamil Nadu	India
9451	Pen	Maharashtra	India
9452	Pehowa	Haryana	India
9453	Peddapuram	Andhra Pradesh	India
9454	Peddapalli	Telangana	India
9455	Pedana	Andhra Pradesh	India
9456	Payyannur	Kerala	India
9457	Pawayan	Uttar Pradesh	India
9458	Pavugada	Karnataka	India
9459	Pauri	Uttarakhand	India
9460	Pawni	Maharashtra	India
9461	Patur	Maharashtra	India
9462	Pattukkottai	Tamil Nadu	India
9463	Patti	Punjab	India
9464	Patnagarh	Odisha	India
9465	Patna	Bihar	India
9466	Patiala	Punjab	India
9467	Pathri	Maharashtra	India
9468	Patharia	Madhya Pradesh	India
9469	Pathardih	Jharkhand	India
9470	Pathardi	Maharashtra	India
9471	Pathankot	Punjab	India
9472	Pathanamthitta	Kerala	India
9473	Pathalgaon	Chhattisgarh	India
9474	Pataudi	Haryana	India
9475	Patancheru	Telangana	India
9476	Patan	Gujarat	India
9477	Patamundai	Odisha	India
9478	Pasighat	Arunachal Pradesh	India
9479	Pasan	Chhattisgarh	India
9480	Parvatsar	Rajasthan	India
9481	Parvatipuram	Andhra Pradesh	India
9482	Partur	Maharashtra	India
9483	Parola	Maharashtra	India
9484	Parli Vaijnath	Maharashtra	India
9485	Parlakimidi	Andhra Pradesh	India
9486	Pariyapuram	Kerala	India
9487	Parichhatgarh	Uttar Pradesh	India
9488	Pardi	Gujarat	India
9489	Parbhani	Maharashtra	India
9490	Paravur	Kerala	India
9491	Parasia	Madhya Pradesh	India
9492	Paramagudi	Tamil Nadu	India
9493	Paradip Garh	Odisha	India
9494	Pappinissheri	Kerala	India
9495	Papanasam	Tamil Nadu	India
9496	Paonta Sahib	Himachal Pradesh	India
9497	Panvel	Maharashtra	India
9498	Panruti	Tamil Nadu	India
9499	Panna	Madhya Pradesh	India
9500	Panmana	Kerala	India
9501	Panipat	Haryana	India
9502	Panihati	West Bengal	India
9503	Pandua	West Bengal	India
9504	Pandhurna	Madhya Pradesh	India
9505	Pandharpur	Maharashtra	India
9506	French Rocks	Karnataka	India
9507	Panaji	Goa	India
9508	Panagar	Madhya Pradesh	India
9509	Palwal	Haryana	India
9510	Paloncha	Telangana	India
9511	Palani	Tamil Nadu	India
9512	Palmaner	Andhra Pradesh	India
9513	Pallippatti	Tamil Nadu	India
9514	Pallikondai	Tamil Nadu	India
9515	Pallavaram	Tamil Nadu	India
9516	Pallappatti	Tamil Nadu	India
9517	Palladam	Tamil Nadu	India
9518	Palkonda	Andhra Pradesh	India
9519	Palitana	Gujarat	India
9520	Palia Kalan	Uttar Pradesh	India
9521	Pali	Rajasthan	India
9522	Pali	Madhya Pradesh	India
9523	Palakkad	Kerala	India
9524	Palghar	Maharashtra	India
9525	Palera	Madhya Pradesh	India
9526	Palasa	Andhra Pradesh	India
9527	Palanpur	Gujarat	India
9528	Palakollu	Andhra Pradesh	India
9529	Palakkodu	Tamil Nadu	India
9530	Pakaur	Jharkhand	India
9531	Pakala	Andhra Pradesh	India
9532	Paithan	Maharashtra	India
9533	Pahasu	Uttar Pradesh	India
9534	Padrauna	Uttar Pradesh	India
9535	Padra	Gujarat	India
9536	Padmanabhapuram	Tamil Nadu	India
9537	Padampur	Rajasthan	India
9538	Padampur	Odisha	India
9539	Padam	Kashmir	India
9540	Pachperwa	Uttar Pradesh	India
9541	Pachora	Maharashtra	India
9542	Ottappalam	Kerala	India
9543	Osmanabad	Maharashtra	India
9544	Orai	Uttar Pradesh	India
9545	Ongole	Andhra Pradesh	India
9546	Okha	Gujarat	India
9547	Ozar	Maharashtra	India
9548	Obra	Uttar Pradesh	India
9549	Nuzvid	Andhra Pradesh	India
9550	Nurpur	Uttar Pradesh	India
9551	Nowrangapur	Odisha	India
9552	North Lakhimpur	Assam	India
9553	North Guwahati	Assam	India
9554	Nongstoin	Meghalaya	India
9555	Nokha	Rajasthan	India
9556	Nohar	Rajasthan	India
9557	Noamundi	Jharkhand	India
9558	Nizamabad	Telangana	India
9559	Nirmali	Bihar	India
9560	Nirmal	Telangana	India
9561	Nipani	Maharashtra	India
9562	Neem ka Thana	Rajasthan	India
9563	Nimbahera	Rajasthan	India
9564	Nimaparha	Odisha	India
9565	Nimaj	Rajasthan	India
9566	Nilokheri	Haryana	India
9567	Nileshwar	Kerala	India
9568	Nilanga	Maharashtra	India
9569	Nilakottai	Tamil Nadu	India
9570	Nilgiri	Odisha	India
9571	Nihtaur	Uttar Pradesh	India
9572	Nidadavole	Andhra Pradesh	India
9573	Nichlaul	Uttar Pradesh	India
9574	Neyyattinkara	Kerala	India
9575	New Delhi	NCT	India
9576	Neral	Maharashtra	India
9577	Nepanagar	Madhya Pradesh	India
9578	Nellore	Andhra Pradesh	India
9579	Nellikkuppam	Tamil Nadu	India
9580	Nelamangala	Karnataka	India
9581	Nedumangad	Kerala	India
9582	Nayudupeta	Andhra Pradesh	India
9583	Nayagarh	Odisha	India
9584	Nawashahr	Punjab	India
9585	Nawalgarh	Rajasthan	India
9586	Niwai	Rajasthan	India
9587	Nawada	Bihar	India
9588	Nawabganj	Uttar Pradesh	India
9589	Nawabganj	Uttar Pradesh	India
9590	Nawabganj	Uttar Pradesh	India
9591	Nawa	Rajasthan	India
9592	Navalgund	Karnataka	India
9593	Navadwip	West Bengal	India
9594	Nautanwa	Uttar Pradesh	India
9595	Naugachhia	Bihar	India
9596	Nattam	Tamil Nadu	India
9597	Nathdwara	Rajasthan	India
9598	Nasrullahganj	Madhya Pradesh	India
9599	Nasriganj	Bihar	India
9600	Naspur	Telangana	India
9601	Nasirabad	Rajasthan	India
9602	Nashik	Maharashtra	India
9603	Narwar	Madhya Pradesh	India
9604	Narwana	Haryana	India
9605	Narsipatnam	Andhra Pradesh	India
9606	Narsinghgarh	Madhya Pradesh	India
9607	Narsimhapur	Madhya Pradesh	India
9608	Narnaund	Haryana	India
9609	Narnaul	Haryana	India
9610	Nargund	Karnataka	India
9611	Naregal	Karnataka	India
9612	Narayanpet	Telangana	India
9613	Narayangarh	Haryana	India
9614	Naravarikuppam	Tamil Nadu	India
9615	Naraura	Uttar Pradesh	India
9616	Narauli	Uttar Pradesh	India
9617	Narasaraopet	Andhra Pradesh	India
9618	Narasapur	Andhra Pradesh	India
9619	Narasannapeta	Andhra Pradesh	India
9620	Naraini	Madhya Pradesh	India
9621	Naraina	Rajasthan	India
9622	Napasar	Rajasthan	India
9623	Nanpara	Uttar Pradesh	India
9624	Nanjangud	Karnataka	India
9625	Nangloi Jat	NCT	India
9626	Nangal Township	Punjab	India
9627	Nandyal	Andhra Pradesh	India
9628	Nandurbar	Maharashtra	India
9629	Nandura Buzurg	Maharashtra	India
9630	Nandikotkur	Andhra Pradesh	India
9631	Nandigama	Andhra Pradesh	India
9632	Nandgaon	Maharashtra	India
9633	Nanded	Maharashtra	India
9634	Nanauta	Uttar Pradesh	India
9635	Namrup	Assam	India
9636	Nambiyur	Tamil Nadu	India
9637	Namakkal	Tamil Nadu	India
9638	Namagiripettai	Tamil Nadu	India
9639	Nalhati	West Bengal	India
9640	Nalgonda	Telangana	India
9641	Naldurg	Maharashtra	India
9642	Nakur	Uttar Pradesh	India
9643	Naksalbari	West Bengal	India
9644	Nakodar	Punjab	India
9645	Najibabad	Uttar Pradesh	India
9646	Nainwa	Rajasthan	India
9647	Nainpur	Madhya Pradesh	India
9648	Naini Tal	Uttarakhand	India
9649	Naihati	West Bengal	India
9650	Nahorkatiya	Assam	India
9651	Nahan	Himachal Pradesh	India
9652	Nagpur	Maharashtra	India
9653	Nagod	Madhya Pradesh	India
9654	Nagina	Uttar Pradesh	India
9655	Nagercoil	Tamil Nadu	India
9656	Nagda	Madhya Pradesh	India
9657	Nagaur	Rajasthan	India
9658	Nagar Karnul	Telangana	India
9659	Nagari	Andhra Pradesh	India
9660	Nagar	Rajasthan	India
9661	Nagappattinam	Tamil Nadu	India
9662	Nagamangala	Karnataka	India
9663	Naduvannur	Kerala	India
9664	Nadiad	Gujarat	India
9665	Nadbai	Rajasthan	India
9666	Nadapuram	Kerala	India
9667	Nabinagar	Bihar	India
9668	Nabha	Punjab	India
9669	Mysore	Karnataka	India
9670	Muzaffarpur	Bihar	India
9671	Muzaffarnagar	Uttar Pradesh	India
9672	Muvattupula	Kerala	India
9673	Muttupet	Tamil Nadu	India
9674	Mussoorie	Uttarakhand	India
9675	Musiri	Tamil Nadu	India
9676	Mushabani	Jharkhand	India
9677	Murwara	Madhya Pradesh	India
9678	Murtajapur	Maharashtra	India
9679	Murshidabad	West Bengal	India
9680	Murliganj	Bihar	India
9681	Morinda	Punjab	India
9682	Murbad	Maharashtra	India
9683	Muradnagar	Uttar Pradesh	India
9684	Munnar	Kerala	India
9685	Monghyr	Bihar	India
9686	Mungeli	Chhattisgarh	India
9687	Mungaoli	Madhya Pradesh	India
9688	Mundwa	Rajasthan	India
9689	Mundra	Gujarat	India
9690	Mundgod	Karnataka	India
9691	Mundargi	Karnataka	India
9692	Multai	Madhya Pradesh	India
9693	Mulki	Karnataka	India
9694	Mulgund	Karnataka	India
9695	Mulbagal	Karnataka	India
9696	Muluppilagadu	Kerala	India
9697	Mul	Maharashtra	India
9698	Muktsar	Punjab	India
9699	Mukher	Maharashtra	India
9700	Mukerian	Punjab	India
9701	Muhammadabad	Uttar Pradesh	India
9702	Muhammadabad	Uttar Pradesh	India
9703	Muhammadabad	Uttar Pradesh	India
9704	Mughal Sarai	Uttar Pradesh	India
9705	Mudkhed	Maharashtra	India
9706	Mudhol	Karnataka	India
9707	Mudgal	Karnataka	India
9708	Muddebihal	Karnataka	India
9709	Mudbidri	Karnataka	India
9710	Mubarakpur	Uttar Pradesh	India
9711	Mothihari	Bihar	India
9712	Morwa	Gujarat	India
9713	Morsi	Maharashtra	India
9714	Morena	Madhya Pradesh	India
9715	Morbi	Gujarat	India
9716	Morar	Madhya Pradesh	India
9717	Moram	Maharashtra	India
9718	Moradabad	Uttar Pradesh	India
9719	Mon	Nagaland	India
9720	Mokokchung	Nagaland	India
9721	Mokameh	Bihar	India
9722	Moirang	Manipur	India
9723	Moga	Punjab	India
9724	Modasa	Gujarat	India
9725	Misrikh	Uttar Pradesh	India
9726	Mirzapur	Uttar Pradesh	India
9727	Mirialguda	Telangana	India
9728	Mirganj	Uttar Pradesh	India
9729	Miranpur Katra	Uttar Pradesh	India
9730	Miranpur	Uttar Pradesh	India
9731	Minjur	Tamil Nadu	India
9732	Milak	Uttar Pradesh	India
9733	Mihona	Madhya Pradesh	India
9734	Mhasvad	Maharashtra	India
9735	Mettur	Tamil Nadu	India
9736	Mettupalayam	Tamil Nadu	India
9737	Merta	Rajasthan	India
9738	Mendarda	Gujarat	India
9739	Memari	West Bengal	India
9740	Melur	Tamil Nadu	India
9741	Mehndawal	Uttar Pradesh	India
9742	Mehekar	Maharashtra	India
9743	Meerut	Uttar Pradesh	India
9744	Medinipur	West Bengal	India
9745	Medak	Telangana	India
9746	Mayiladuthurai	Tamil Nadu	India
9747	Mayang Imphal	Manipur	India
9748	Mawana	Uttar Pradesh	India
9749	Mavoor	Kerala	India
9750	Mavelikara	Kerala	India
9751	Maur	Punjab	India
9752	Mauganj	Madhya Pradesh	India
9753	Maudaha	Uttar Pradesh	India
9754	Mau Aimma	Uttar Pradesh	India
9755	Mau	Madhya Pradesh	India
9756	Mau	Uttar Pradesh	India
9757	Mattanur	Kerala	India
9758	Mathura	Uttar Pradesh	India
9759	Matabhanga	West Bengal	India
9760	Masaurhi Buzurg	Bihar	India
9761	Marmagao	Goa	India
9762	Markapur	Andhra Pradesh	India
9763	Mariani	Assam	India
9764	Mariahu	Uttar Pradesh	India
9765	Marhaura	Bihar	India
9766	Margherita	Arunachal Pradesh	India
9767	Marakkanam	Tamil Nadu	India
9768	Marahra	Uttar Pradesh	India
9769	Mapuca	Goa	India
9770	Manwat	Maharashtra	India
9771	Manvi	Karnataka	India
9772	Manthani	Telangana	India
9773	Mansa	Punjab	India
9774	Mansa	Gujarat	India
9775	Manoharpur	Rajasthan	India
9776	Mannargudi	Tamil Nadu	India
9777	Mannarakkat	Kerala	India
9778	Manmad	Maharashtra	India
9779	Mankachar	Meghalaya	India
9780	Majalgaon	Maharashtra	India
9781	Manjhanpur	Uttar Pradesh	India
9782	Manjeri	Kerala	India
9783	Manihari	Bihar	India
9784	Maniar	Uttar Pradesh	India
9785	Mangrul Pir	Maharashtra	India
9786	Mangrol	Rajasthan	India
9787	Mangrol	Gujarat	India
9788	Manglaur	Uttarakhand	India
9789	Mangalore	Karnataka	India
9790	Mangaldai	Assam	India
9791	Mangalagiri	Andhra Pradesh	India
9792	Maner	Bihar	India
9793	Mandya	Karnataka	India
9794	Mandvi	Gujarat	India
9795	Mandvi	Gujarat	India
9796	Mandu	Madhya Pradesh	India
9797	Mandsaur	Madhya Pradesh	India
9798	Mandla	Madhya Pradesh	India
9799	Mandi	Himachal Pradesh	India
9800	Mandawar	Uttar Pradesh	India
9801	Mandapeta	Andhra Pradesh	India
9802	Mandapam	Tamil Nadu	India
9803	Mandalgarh	Rajasthan	India
9804	Mandal	Rajasthan	India
9805	Mancheral	Telangana	India
9806	Manawar	Madhya Pradesh	India
9807	Manavadar	Gujarat	India
9808	Manasa	Madhya Pradesh	India
9809	Manapparai	Tamil Nadu	India
9810	Manamadurai	Tamil Nadu	India
9811	Manali	Tamil Nadu	India
9812	Malvan	Maharashtra	India
9813	Malur	Karnataka	India
9814	Malpura	Rajasthan	India
9815	Malpe	Karnataka	India
9816	Mallasamudram	Tamil Nadu	India
9817	Malkapur	Maharashtra	India
9818	Malakanagiri	Odisha	India
9819	Malihabad	Uttar Pradesh	India
9820	Maler Kotla	Punjab	India
9821	Malegaon	Maharashtra	India
9822	Malavalli	Karnataka	India
9823	Malaut	Punjab	India
9824	Malappuram	Kerala	India
9825	Makum	Assam	India
9826	Maksi	Madhya Pradesh	India
9827	Makrana	Rajasthan	India
9828	Mairwa	Bihar	India
9829	Mainpuri	Uttar Pradesh	India
9830	Mainaguri	West Bengal	India
9831	Maihar	Madhya Pradesh	India
9832	Mahwah	Rajasthan	India
9833	Mahudha	Gujarat	India
9834	Maholi	Uttar Pradesh	India
9835	Mahoba	Uttar Pradesh	India
9836	Mahmudabad	Uttar Pradesh	India
9837	Mahishadal	West Bengal	India
9838	Mahgawan	Madhya Pradesh	India
9839	Maheshwar	Madhya Pradesh	India
9840	Mahendragarh	Haryana	India
9841	Mahemdavad	Gujarat	India
9842	Mahe	Kerala	India
9843	Mahbubnagar	Telangana	India
9844	Mahbubabad	Telangana	India
9845	Mahasamund	Chhattisgarh	India
9846	Maharaganj	Uttar Pradesh	India
9847	Maharajgani	Bihar	India
9848	Maham	Haryana	India
9849	Mahalingpur	Karnataka	India
9850	Mahad	Maharashtra	India
9851	Maghar	Uttar Pradesh	India
9852	Magadi	Karnataka	India
9853	Madurantakam	Tamil Nadu	India
9854	Madurai	Tamil Nadu	India
9855	Madukkur	Tamil Nadu	India
9856	Madukkarai	Tamil Nadu	India
9857	Chennai	Tamil Nadu	India
9858	Madikeri	Karnataka	India
9859	Madhyamgram	West Bengal	India
9860	Madhupur	Jharkhand	India
9861	Maddagiri	Karnataka	India
9862	Madhubani	Bihar	India
9863	Madhipura	Bihar	India
9864	Madgaon	Goa	India
9865	Maddur	Karnataka	India
9866	Madanapalle	Andhra Pradesh	India
9867	Machilipatnam	Andhra Pradesh	India
9868	Machhlishahr	Uttar Pradesh	India
9869	Machhiwara	Punjab	India
9870	Macherla	Andhra Pradesh	India
9871	Lunglei	Mizoram	India
9872	Lunavada	Gujarat	India
9873	Ludhiana	Punjab	India
9874	Lucknow	Uttar Pradesh	India
9875	Luckeesarai	Bihar	India
9876	Losal	Rajasthan	India
9877	Loni	Uttar Pradesh	India
9878	Lonavla	Maharashtra	India
9879	Lonar	Maharashtra	India
9880	Lohardaga	Jharkhand	India
9881	Lingsugur	Karnataka	India
9882	Limbdi	Gujarat	India
9883	Leteri	Madhya Pradesh	India
9884	Leh	Kashmir	India
9885	Lawar Khas	Uttar Pradesh	India
9886	Laungowal	Punjab	India
9887	Latur	Maharashtra	India
9888	Lathi	Gujarat	India
9889	Latehar	Jharkhand	India
9890	Lar	Uttar Pradesh	India
9891	Lalsot	Rajasthan	India
9892	Lalpur	Gujarat	India
9893	Lalitpur	Uttar Pradesh	India
9894	Lalgudi	Tamil Nadu	India
9895	Lalgola	West Bengal	India
9896	Lalganj	Uttar Pradesh	India
9897	Lalganj	Bihar	India
9898	Lakshmeshwar	Karnataka	India
9899	Laksar	Uttarakhand	India
9900	Lakhyabad	West Bengal	India
9901	Lakhnadon	Madhya Pradesh	India
9902	Lakhimpur	Uttar Pradesh	India
9903	Lakheri	Rajasthan	India
9904	Laharpur	Uttar Pradesh	India
9905	Lahar	Madhya Pradesh	India
9906	Ladwa	Haryana	India
9907	Ladnun	Rajasthan	India
9908	Lachhmangarh Sikar	Rajasthan	India
9909	Kuzhithurai	Tamil Nadu	India
9910	Koothanallur	Tamil Nadu	India
9911	Kuttampuzha	Kerala	India
9912	Kutiyana	Gujarat	India
9913	Kutiatodu	Kerala	India
9914	Kushtagi	Karnataka	India
9915	Kurinjippadi	Tamil Nadu	India
9916	Kurduvadi	Maharashtra	India
9917	Kurandvad	Maharashtra	India
9918	Kuppam	Andhra Pradesh	India
9919	Kunnamkulam	Kerala	India
9920	Kunnamangalam	Kerala	India
9921	Kunigal	Karnataka	India
9922	Kundla	Gujarat	India
9923	Kundgol	Karnataka	India
9924	Kundarkhi	Uttar Pradesh	India
9925	Kunda	Uttar Pradesh	India
9926	Kumta	Karnataka	India
9927	Kumher	Rajasthan	India
9928	Kumhari	Chhattisgarh	India
9929	Kumbhraj	Madhya Pradesh	India
9930	Kumbakonam	Tamil Nadu	India
9931	Kulu	Himachal Pradesh	India
9932	Kulti	West Bengal	India
9933	Kulpahar	Uttar Pradesh	India
9934	Kulittalai	Tamil Nadu	India
9935	Kulgam	Kashmir	India
9936	Kukshi	Madhya Pradesh	India
9937	Kukatpalli	Telangana	India
9938	Kuju	Jharkhand	India
9939	Kudligi	Karnataka	India
9940	Kudachi	Karnataka	India
9941	Kuchera	Rajasthan	India
9942	Kuchaman	Rajasthan	India
9943	Kuchaiburi	Odisha	India
9944	Krishnarajpet	Karnataka	India
9945	Krishnanagar	West Bengal	India
9946	Krishnagiri	Tamil Nadu	India
9947	Kozhikode	Kerala	India
9948	Koynanagar	Maharashtra	India
9949	Kovvur	Andhra Pradesh	India
9950	Kovur	Andhra Pradesh	India
9951	Kovilpatti	Tamil Nadu	India
9952	Kotturu	Karnataka	India
9953	Kottayam	Kerala	India
9954	Kottagudem	Telangana	India
9955	Kotputli	Rajasthan	India
9956	Kotma	Madhya Pradesh	India
9957	Kotdwara	Uttarakhand	India
9958	Kotaparh	Chhattisgarh	India
9959	Kotamangalam	Kerala	India
9960	Kotagiri	Tamil Nadu	India
9961	Kota	Rajasthan	India
9962	Kota	Chhattisgarh	India
9963	Kosigi	Andhra Pradesh	India
9964	Kosi	Uttar Pradesh	India
9965	Kosamba	Gujarat	India
9966	Korwai	Madhya Pradesh	India
9967	Koregaon	Maharashtra	India
9968	Korba	Chhattisgarh	India
9969	Koratla	Telangana	India
9970	Koraput	Odisha	India
9971	Koppal	Karnataka	India
9972	Kopargaon	Maharashtra	India
9973	Kopaganj	Uttar Pradesh	India
9974	Konnur	Karnataka	India
9975	Konnagar	West Bengal	India
9976	Kondapalle	Andhra Pradesh	India
9977	Kondagaon	Chhattisgarh	India
9978	Konch	Uttar Pradesh	India
9979	Konarka	Odisha	India
9980	Kolasib	Mizoram	India
9981	Kollegal	Karnataka	India
9982	Kolhapur	Maharashtra	India
9983	Kolaras	Madhya Pradesh	India
9984	Kolar	Karnataka	India
9985	Colachel	Tamil Nadu	India
9986	Kokrajhar	Assam	India
9987	Kohima	Nagaland	India
9988	Koelwar	Bihar	India
9989	Kodungallur	Kerala	India
9990	Kodoli	Maharashtra	India
9991	Kodinar	Gujarat	India
9992	Kodarma	Jharkhand	India
9993	Kodar	Telangana	India
9994	Kodaikanal	Tamil Nadu	India
9995	Koch Bihar	West Bengal	India
9996	Koath	Bihar	India
9997	Kizhake Chalakudi	Kerala	India
9998	Kithor	Uttar Pradesh	India
9999	Kishtwar	Kashmir	India
10000	Kishangarh	Rajasthan	India
10001	Kishanganj	Bihar	India
10002	Kiratpur	Uttar Pradesh	India
10003	Kiraoli	Uttar Pradesh	India
10004	Kinwat	Maharashtra	India
10005	Kichha	Uttarakhand	India
10006	Khutar	Uttar Pradesh	India
10007	Khurja	Uttar Pradesh	India
10008	Khurda	Odisha	India
10009	Khurai	Madhya Pradesh	India
10010	Khunti	Jharkhand	India
10011	Khuldabad	Maharashtra	India
10012	Khowai	Tripura	India
10013	Khopoli	Maharashtra	India
10014	Khirkiyan	Madhya Pradesh	India
10015	Khilchipur	Madhya Pradesh	India
10016	Khetri	Rajasthan	India
10017	Khetia	Maharashtra	India
10018	Kheri	Uttar Pradesh	India
10019	Kheralu	Gujarat	India
10020	Khekra	Uttar Pradesh	India
10021	Khed Brahma	Gujarat	India
10022	Kheda	Gujarat	India
10023	Khatra	West Bengal	India
10024	Khatima	Uttarakhand	India
10025	Khategaon	Madhya Pradesh	India
10026	Khatauli	Uttar Pradesh	India
10027	Kharupatia	Assam	India
10028	Kharsia	Chhattisgarh	India
10029	Kharkhauda	Haryana	India
10030	Khargone	Madhya Pradesh	India
10031	Khardah	West Bengal	India
10032	Kharar	Punjab	India
10033	Kharakvasla	Maharashtra	India
10034	Kharagpur	Bihar	India
10035	Kharagpur	West Bengal	India
10036	Khapa	Maharashtra	India
10037	Khanna	Punjab	India
10038	Khandwa	Madhya Pradesh	India
10039	Khandela	Rajasthan	India
10040	Khanapur	Karnataka	India
10041	Khammam	Telangana	India
10042	Khamgaon	Maharashtra	India
10043	Khambhat	Gujarat	India
10044	Khambhaliya	Gujarat	India
10045	Khamaria	Madhya Pradesh	India
10046	Khalilabad	Uttar Pradesh	India
10047	Khajuraho	Madhya Pradesh	India
10048	Khairagarh	Chhattisgarh	India
10049	Khairagarh	Chhattisgarh	India
10050	Khairabad	Uttar Pradesh	India
10051	Khair	Uttar Pradesh	India
10052	Khagaul	Bihar	India
10053	Khagaria	Bihar	India
10054	Khadki	Maharashtra	India
10055	Khada	Uttar Pradesh	India
10056	Khachrod	Madhya Pradesh	India
10057	Kesinga	Odisha	India
10058	Keshorai Patan	Rajasthan	India
10059	Keshod	Gujarat	India
10060	Kerur	Karnataka	India
10061	Kendraparha	Odisha	India
10062	Kenda	West Bengal	India
10063	Kemri	Uttar Pradesh	India
10064	Kekri	Rajasthan	India
10065	Kayankulam	Kerala	India
10066	Kayalpattinam	Tamil Nadu	India
10067	Kawardha	Chhattisgarh	India
10068	Kavali	Andhra Pradesh	India
10069	Kattivakkam	Tamil Nadu	India
10070	Kattanam	Kerala	India
10071	Katras	Jharkhand	India
10072	Katpadi	Tamil Nadu	India
10073	Katoya	West Bengal	India
10074	Katol	Maharashtra	India
10075	Katihar	Bihar	India
10076	Kathua	Kashmir	India
10077	Kathor	Gujarat	India
10078	Katghora	Chhattisgarh	India
10079	Katangi	Madhya Pradesh	India
10080	Katangi	Madhya Pradesh	India
10081	Kasrawad	Madhya Pradesh	India
10082	Kashipur	Uttarakhand	India
10083	Kasganj	Uttar Pradesh	India
10084	Kasaragod	Kerala	India
10085	Karwar	Karnataka	India
10086	Karur	Tamil Nadu	India
10087	Kartarpur	Punjab	India
10088	Karsiyang	West Bengal	India
10089	Karol Bagh	NCT	India
10090	Karnal	Haryana	India
10091	Karmala	Maharashtra	India
10092	Karkala	Karnataka	India
10093	Karjat	Maharashtra	India
10094	Karimnagar	Telangana	India
10095	Karimganj	Assam	India
10096	Karhal	Uttar Pradesh	India
10097	Karera	Madhya Pradesh	India
10098	Kareli	Madhya Pradesh	India
10099	Karauli	Rajasthan	India
10100	Karanja	Maharashtra	India
10101	Karamsad	Gujarat	India
10102	Karamadai	Tamil Nadu	India
10103	Karaikkudi	Tamil Nadu	India
10104	Karaikal	Pondicherry	India
10105	Karad	Maharashtra	India
10106	Kapurthala	Punjab	India
10107	Kapren	Rajasthan	India
10108	Kapadvanj	Gujarat	India
10109	Kanth	Uttar Pradesh	India
10110	Kantabanji	Odisha	India
10111	Kant	Uttar Pradesh	India
10112	Kanpur	Uttar Pradesh	India
10113	Kannod	Madhya Pradesh	India
10114	Kanniyakumari	Tamil Nadu	India
10115	Kannauj	Uttar Pradesh	India
10116	Kannangad	Kerala	India
10117	Kannad	Maharashtra	India
10118	Kanker	Chhattisgarh	India
10119	Kanke	Jharkhand	India
10120	Kankauli	Maharashtra	India
10121	Kanigiri	Andhra Pradesh	India
10122	Kangayam	Tamil Nadu	India
10123	Kandukur	Andhra Pradesh	India
10124	Kandla	Gujarat	India
10125	Kandi	West Bengal	India
10126	Kandhla	Uttar Pradesh	India
10127	Kanchipuram	Tamil Nadu	India
10128	Kanakapura	Karnataka	India
10129	Kamthi	Maharashtra	India
10130	Kampli	Karnataka	India
10131	Cumbum	Tamil Nadu	India
10132	Kamarhati	West Bengal	India
10133	Kamareddi	Telangana	India
10134	Kaman	Rajasthan	India
10135	Kamalganj	Uttar Pradesh	India
10136	Kamakhyanagar	Odisha	India
10137	Kalyani	West Bengal	India
10138	Kalyan	Maharashtra	India
10139	Kalugumalai	Tamil Nadu	India
10140	Kalpi	Uttar Pradesh	India
10141	Kalpetta	Kerala	India
10142	Kalol	Gujarat	India
10143	Kalna	West Bengal	India
10144	Kalmeshwar	Maharashtra	India
10145	Kallidaikurichchi	Tamil Nadu	India
10146	Kallakkurichchi	Tamil Nadu	India
10147	Kalka	Himachal Pradesh	India
10148	Kaliyaganj	West Bengal	India
10149	Kalimpong	West Bengal	India
10150	Kalghatgi	Karnataka	India
10151	Kalavad	Gujarat	India
10152	Kalanwali	Haryana	India
10153	Kalanaur	Haryana	India
10154	Kalamnuri	Maharashtra	India
10155	Kalamb	Maharashtra	India
10156	Kalakkadu	Tamil Nadu	India
10157	Kakrala	Uttar Pradesh	India
10158	Kakori	Uttar Pradesh	India
10159	Kakinada	Andhra Pradesh	India
10160	Kakching	Manipur	India
10161	Kaithal	Haryana	India
10162	Kairana	Uttar Pradesh	India
10163	Kaimori	Madhya Pradesh	India
10164	Kaimganj	Uttar Pradesh	India
10165	Kailashahar	Tripura	India
10166	Kailaras	Madhya Pradesh	India
10167	Kaikalur	Andhra Pradesh	India
10168	Kagal	Maharashtra	India
10169	Kadur	Karnataka	India
10170	Kadod	Gujarat	India
10171	Kadiri	Andhra Pradesh	India
10172	Kadi	Gujarat	India
10173	Kadayanallur	Tamil Nadu	India
10174	Kanchrapara	West Bengal	India
10175	Kachhwa	Uttar Pradesh	India
10176	Kabrai	Uttar Pradesh	India
10177	Junnar	Maharashtra	India
10178	Junagarh	Chhattisgarh	India
10179	Junagadh	Gujarat	India
10180	Jumri Tilaiya	Jharkhand	India
10181	Jalandhar	Punjab	India
10182	Jugsalai	Jharkhand	India
10183	Jorhat	Assam	India
10184	Jora	Madhya Pradesh	India
10185	Jolarpettai	Tamil Nadu	India
10186	Jogbani	Bihar	India
10187	Jodiya Bandar	Gujarat	India
10188	Jodhpur	Rajasthan	India
10189	Jodhpur	Gujarat	India
10190	Jintur	Maharashtra	India
10191	Jind	Haryana	India
10192	Jhusi	Uttar Pradesh	India
10193	Jhunjhunun	Rajasthan	India
10194	Jhinjhana	Uttar Pradesh	India
10195	Jhinjhak	Uttar Pradesh	India
10196	Jharsuguda	Odisha	India
10197	Jharia	Jharkhand	India
10198	Jhargram	West Bengal	India
10199	Jhansi	Uttar Pradesh	India
10200	Jhanjharpur	Bihar	India
10201	Jhalu	Uttar Pradesh	India
10202	Jhalrapatan	Rajasthan	India
10203	Jhalida	West Bengal	India
10204	Jhalawar	Rajasthan	India
10205	Jhajjar	Haryana	India
10206	Jha Jha	Bihar	India
10207	Jhabua	Madhya Pradesh	India
10208	Jewar	Uttar Pradesh	India
10209	Jevargi	Karnataka	India
10210	Jetpur	Gujarat	India
10211	Jeypore	Odisha	India
10212	Jaynagar	Bihar	India
10213	Jaynagar-Majilpur	West Bengal	India
10214	Jayamkondacholapuram	Tamil Nadu	India
10215	Jawad	Madhya Pradesh	India
10216	Jaunpur	Uttar Pradesh	India
10217	Jatara	Madhya Pradesh	India
10218	Jatani	Odisha	India
10219	Jaswantnagar	Uttar Pradesh	India
10220	Jaspur	Uttarakhand	India
10221	Jasidih	Jharkhand	India
10222	Jashpurnagar	Chhattisgarh	India
10223	Jasdan	Gujarat	India
10224	Jarwal	Uttar Pradesh	India
10225	Jaora	Madhya Pradesh	India
10226	Jansath	Uttar Pradesh	India
10227	Janjgir	Chhattisgarh	India
10228	Jangipur	West Bengal	India
10229	Jangaon	Telangana	India
10230	Jandiala	Punjab	India
10231	Jamuria	West Bengal	India
10232	Jamui	Bihar	India
10233	Jamtara	Jharkhand	India
10234	Jamshedpur	Jharkhand	India
10235	Jamnagar	Gujarat	India
10236	Jammu	Kashmir	India
10237	Jammalamadugu	Andhra Pradesh	India
10238	Jamkhandi	Karnataka	India
10239	Jambusar	Gujarat	India
10240	Jamalpur	Bihar	India
10241	Jamai	Madhya Pradesh	India
10242	Jamadoba	Jharkhand	India
10243	Jalpaiguri	West Bengal	India
10244	Jalor	Rajasthan	India
10245	Jalna	Maharashtra	India
10246	Jalgaon Jamod	Maharashtra	India
10247	Jalgaon	Maharashtra	India
10248	Jaleshwar	Odisha	India
10249	Jalesar	Uttar Pradesh	India
10250	Jalaun	Uttar Pradesh	India
10251	Jalalpur	Uttar Pradesh	India
10252	Jalalpur	Gujarat	India
10253	Jalali	Uttar Pradesh	India
10254	Jalalabad	Punjab	India
10255	Jalalabad	Uttar Pradesh	India
10256	Jalalabad	Uttar Pradesh	India
10257	Jajpur	Odisha	India
10258	Jaito	Punjab	India
10259	Jaitaran	Rajasthan	India
10260	Jaisingpur	Maharashtra	India
10261	Jaisalmer	Rajasthan	India
10262	Jais	Uttar Pradesh	India
10263	Jaipur	Rajasthan	India
10264	Jahazpur	Rajasthan	India
10265	Jahangirabad	Uttar Pradesh	India
10266	Jahanabad	Bihar	India
10267	Jagtial	Telangana	India
10268	Jagraon	Punjab	India
10269	Jaggayyapeta	Andhra Pradesh	India
10270	Jagdispur	Bihar	India
10271	Jagdishpur	Uttar Pradesh	India
10272	Jagdalpur	Chhattisgarh	India
10273	Jagatsinghapur	Odisha	India
10274	Jagalur	Karnataka	India
10275	Jagadhri	Haryana	India
10276	Jabalpur	Madhya Pradesh	India
10277	Itimadpur	Uttar Pradesh	India
10278	Itarsi	Madhya Pradesh	India
10279	Itanagar	Arunachal Pradesh	India
10280	Islampur	West Bengal	India
10281	Islampur	Bihar	India
10282	Islamnagar	Uttar Pradesh	India
10283	Irugur	Tamil Nadu	India
10284	Irinjalakuda	Kerala	India
10285	Iringal	Kerala	India
10286	Ingraj Bazar	West Bengal	India
10287	Indri	Haryana	India
10288	Indore	Madhya Pradesh	India
10289	Indi	Karnataka	India
10290	Indergarh	Uttar Pradesh	India
10291	Indapur	Maharashtra	India
10292	Imphal	Manipur	India
10293	Ilkal	Karnataka	India
10294	Igatpuri	Maharashtra	India
10295	Idappadi	Tamil Nadu	India
10296	Ichchapuram	Andhra Pradesh	India
10297	Ichalkaranji	Maharashtra	India
10298	Hyderabad	Telangana	India
10299	Hadagalli	Karnataka	India
10300	Husainabad	Jharkhand	India
10301	Hunsur	Karnataka	India
10302	Hungund	Karnataka	India
10303	Hukeri	Karnataka	India
10304	Hugli	West Bengal	India
10305	Hubli	Karnataka	India
10306	Howli	Assam	India
10307	Hosur	Tamil Nadu	India
10308	Hospet	Karnataka	India
10309	Hoskote	Karnataka	India
10310	Hoshangabad	Madhya Pradesh	India
10311	Hosdurga	Karnataka	India
10312	Honnali	Karnataka	India
10313	Honavar	Karnataka	India
10314	Homnabad	Karnataka	India
10315	Hole Narsipur	Karnataka	India
10316	Holalkere	Karnataka	India
10317	Hojai	Assam	India
10318	Hodal	Haryana	India
10319	Hisua	Bihar	India
10320	Hisar	Haryana	India
10321	Hiriyur	Karnataka	India
10322	Hirekerur	Karnataka	India
10323	Hirakud	Odisha	India
10324	Hinjilikatu	Odisha	India
10325	Hingoli	Maharashtra	India
10326	Hinganghat	Maharashtra	India
10327	Hindupur	Andhra Pradesh	India
10328	Hindoria	Madhya Pradesh	India
10329	Hindaun	Rajasthan	India
10330	Himatnagar	Gujarat	India
10331	Hilsa	Bihar	India
10332	Hazaribag	Jharkhand	India
10333	Haveri	Karnataka	India
10334	Hatta	Madhya Pradesh	India
10335	Hathras	Uttar Pradesh	India
10336	Hastinapur	Uttar Pradesh	India
10337	Hassan	Karnataka	India
10338	Hasimara	West Bengal	India
10339	Hasanpur	Uttar Pradesh	India
10340	Harur	Tamil Nadu	India
10341	Harsud	Madhya Pradesh	India
10342	Harpanahalli	Karnataka	India
10343	Harpalpur	Madhya Pradesh	India
10344	Harij	Gujarat	India
10345	Harihar	Karnataka	India
10346	Haridwar	Uttarakhand	India
10347	Hardoi	Uttar Pradesh	India
10348	Harda Khas	Madhya Pradesh	India
10349	Hapur	Uttar Pradesh	India
10350	Haora	West Bengal	India
10351	Hanumangarh	Rajasthan	India
10352	Hansi	Haryana	India
10353	Hangal	Karnataka	India
10354	Handia	Uttar Pradesh	India
10355	Hamirpur	Himachal Pradesh	India
10356	Hamirpur	Uttar Pradesh	India
10357	Halvad	Gujarat	India
10358	Halol	Gujarat	India
10359	Haliyal	Karnataka	India
10360	Halisahar	West Bengal	India
10361	Haldwani	Uttarakhand	India
10362	Haldaur	Uttar Pradesh	India
10363	Hajo	Assam	India
10364	Hajipur	Bihar	India
10365	Hailakandi	Assam	India
10366	Haflong	Assam	India
10367	Hadgaon	Maharashtra	India
10368	Habra	West Bengal	India
10369	Gwalior	Madhya Pradesh	India
10370	Guskhara	West Bengal	India
10371	Guruvayur	Kerala	India
10372	Guru Har Sahai	Punjab	India
10373	Gursarai	Uttar Pradesh	India
10374	Gursahaiganj	Uttar Pradesh	India
10375	Gurmatkal	Karnataka	India
10376	Gurgaon	Haryana	India
10377	Gunupur	Odisha	India
10378	Guntur	Andhra Pradesh	India
10379	Guntakal Junction	Andhra Pradesh	India
10380	Gunnaur	Uttar Pradesh	India
10381	Gundlupet	Karnataka	India
10382	Guna	Madhya Pradesh	India
10383	Gummidipundi	Tamil Nadu	India
10384	Gumla	Chhattisgarh	India
10385	Gumia	Jharkhand	India
10386	Guledagudda	Karnataka	India
10387	Gulbarga	Karnataka	India
10388	Gulaothi	Uttar Pradesh	India
10389	Gulabpura	Rajasthan	India
10390	Guduvancheri	Tamil Nadu	India
10391	Gudur	Andhra Pradesh	India
10392	Gudiyatham	Tamil Nadu	India
10393	Gudivada	Andhra Pradesh	India
10394	Gudalur	Tamil Nadu	India
10395	Gubbi	Karnataka	India
10396	Goyerkata	West Bengal	India
10397	Govardhan	Uttar Pradesh	India
10398	Gosaba	West Bengal	India
10399	Gorakhpur	Haryana	India
10400	Gorakhpur	Uttar Pradesh	India
10401	Gobichettipalayam	Tamil Nadu	India
10402	Gopalganj	Bihar	India
10403	Gondia	Maharashtra	India
10404	Gondal	Gujarat	India
10405	Gonda City	Uttar Pradesh	India
10406	Gomoh	Jharkhand	India
10407	Gola Gokarannath	Uttar Pradesh	India
10408	Golaghat	Assam	India
10409	Gokarna	Karnataka	India
10410	Gokak	Karnataka	India
10411	Gohana	Haryana	India
10412	Gohadi	Madhya Pradesh	India
10413	Godhra	Gujarat	India
10414	Godda	Jharkhand	India
10415	Gobindpur	Jharkhand	India
10416	Gobardanga	West Bengal	India
10417	Goalpara	Assam	India
10418	Giridih	Jharkhand	India
10419	Gingee	Tamil Nadu	India
10420	Giddarbaha	Punjab	India
10421	Giddalur	Andhra Pradesh	India
10422	Ghugus	Maharashtra	India
10423	Ghoti Budrukh	Maharashtra	India
10424	Ghosi	Uttar Pradesh	India
10425	Ghazipur	Uttar Pradesh	India
10426	Ghaziabad	Uttar Pradesh	India
10427	Ghatsila	Jharkhand	India
10428	Ghatanji	Maharashtra	India
10429	Ghatampur	Uttar Pradesh	India
10430	Ghatal	West Bengal	India
10431	Gharaunda	Haryana	India
10432	Gevrai	Maharashtra	India
10433	Gaya	Bihar	India
10434	Gauripur	Assam	India
10435	Goribidnur	Karnataka	India
10436	Guwahati	Assam	India
10437	Garhwa	Jharkhand	India
10438	Garui	West Bengal	India
10439	Gariadhar	Gujarat	India
10440	Garhshankar	Punjab	India
10441	Garhmuktesar	Uttar Pradesh	India
10442	Garhakota	Madhya Pradesh	India
10443	Gannavaram	Andhra Pradesh	India
10444	Gangtok	Sikkim	India
10445	Gangolli	Karnataka	India
10446	Gangoh	Uttar Pradesh	India
10447	Gangawati	Karnataka	India
10448	Gangarampur	West Bengal	India
10449	Gangapur	Rajasthan	India
10450	Gangapur	Rajasthan	India
10451	Gangapur	Maharashtra	India
10452	Ganganagar	Rajasthan	India
10453	Gangakher	Maharashtra	India
10454	Ghandinagar	Gujarat	India
10455	Gandhidham	Gujarat	India
10456	Gandevi	Gujarat	India
10457	Gandarbal	Kashmir	India
10458	Gajraula	Uttar Pradesh	India
10459	Gajendragarh	Karnataka	India
10460	Gadwal	Telangana	India
10461	Gadhinglaj	Maharashtra	India
10462	Gadhada	Gujarat	India
10463	Gadarwara	Madhya Pradesh	India
10464	Gadag	Karnataka	India
10465	Fort Gloster	West Bengal	India
10466	Forbesganj	Bihar	India
10467	Firozpur Jhirka	Haryana	India
10468	Ferozepore	Punjab	India
10469	Firozabad	Uttar Pradesh	India
10470	Ferokh	Kerala	India
10471	Fazilka	Punjab	India
10472	Fatwa	Bihar	India
10473	Fatehpur Sikri	Uttar Pradesh	India
10474	Fatehpur	Rajasthan	India
10475	Fatehpur	Uttar Pradesh	India
10476	Fatehpur	Uttar Pradesh	India
10477	Fatehgarh Churian	Punjab	India
10478	Fatehganj West	Uttar Pradesh	India
10479	Fatehabad	Haryana	India
10480	Fatehabad	Uttar Pradesh	India
10481	Farrukhnagar	Telangana	India
10482	Farrukhabad	Uttar Pradesh	India
10483	Faridpur	Uttar Pradesh	India
10484	Faridkot	Punjab	India
10485	Faridabad	Haryana	India
10486	Farakka	West Bengal	India
10487	Falakata	West Bengal	India
10488	Faizpur	Maharashtra	India
10489	Fyzabad	Uttar Pradesh	India
10490	Etawah	Uttar Pradesh	India
10491	Erraguntla	Andhra Pradesh	India
10492	Erode	Tamil Nadu	India
10493	Erattupetta	Kerala	India
10494	Erandol	Maharashtra	India
10495	Emmiganur	Andhra Pradesh	India
10496	Ellore	Andhra Pradesh	India
10497	Elur	Kerala	India
10498	Ellenabad	Haryana	India
10499	Elamanchili	Andhra Pradesh	India
10500	Egra	West Bengal	India
10501	Dwarka	Gujarat	India
10502	Durgapur	West Bengal	India
10503	Durgapur	Maharashtra	India
10504	Durg	Chhattisgarh	India
10505	Dungarpur	Rajasthan	India
10506	Ganj Dundwara	Uttar Pradesh	India
10507	Dumraon	Bihar	India
10508	Dumra	Bihar	India
10509	Dumka	Jharkhand	India
10510	Dum Duma	Assam	India
10511	Dam Dam	West Bengal	India
10512	Duliagaon	Assam	India
10513	Dugda	Jharkhand	India
10514	Dubrajpur	West Bengal	India
10515	Dornakal	Telangana	India
10516	Doraha	Punjab	India
10517	Dongargarh	Chhattisgarh	India
10518	Dondaicha	Maharashtra	India
10519	Dombivli	Maharashtra	India
10520	Dod Ballapur	Karnataka	India
10521	Doda	Kashmir	India
10522	Diu	Daman and Diu	India
10523	Disa	Gujarat	India
10524	Diphu	Assam	India
10525	Dinhata	West Bengal	India
10526	Dindori	Madhya Pradesh	India
10527	Dindigul	Tamil Nadu	India
10528	Dinanagar	Punjab	India
10529	Dimapur	Nagaland	India
10530	Digras	Maharashtra	India
10531	Diglur	Maharashtra	India
10532	Dighwara	Bihar	India
10533	Digboi	Assam	India
10534	Dig	Rajasthan	India
10535	Didwana	Rajasthan	India
10536	Dicholi	Goa	India
10537	Dibrugarh	Assam	India
10538	Dibai	Uttar Pradesh	India
10539	Diamond Harbour	West Bengal	India
10540	Dhuri	Punjab	India
10541	Dhupgari	West Bengal	India
10542	Dhulian	West Bengal	India
10543	Dhulia	Maharashtra	India
10544	Dhuburi	Assam	India
10545	Dhrol	Gujarat	India
10546	Dhrangadhra	Gujarat	India
10547	Dhoraji	Gujarat	India
10548	Dhone	Andhra Pradesh	India
10549	Dholka	Gujarat	India
10550	Dhing	Assam	India
10551	Dhenkanal	Odisha	India
10552	Dhekiajuli	Assam	India
10553	Dhaurahra	Uttar Pradesh	India
10554	Dhaulpur	Rajasthan	India
10555	Dharur	Maharashtra	India
10556	Dharuhera	Haryana	India
10557	Dharmsala	Himachal Pradesh	India
10558	Dharmavaram	Andhra Pradesh	India
10559	Dharmapuri	Tamil Nadu	India
10560	Dharmanagar	Tripura	India
10561	Dharmadam	Kerala	India
10562	Dharmabad	Maharashtra	India
10563	Dhariwal	Punjab	India
10564	Dhari	Gujarat	India
10565	Dharapuram	Tamil Nadu	India
10566	Dharangaon	Maharashtra	India
10567	Dharampur	Gujarat	India
10568	Dhar	Madhya Pradesh	India
10569	Dhanera	Gujarat	India
10570	Dhandhuka	Gujarat	India
10571	Dhanbad	Jharkhand	India
10572	Dhanaura	Uttar Pradesh	India
10573	Dhanaula	Punjab	India
10574	Dhamtari	Chhattisgarh	India
10575	Dhampur	Uttar Pradesh	India
10576	Dhamnod	Madhya Pradesh	India
10577	Dhaka	Bihar	India
10578	Dewas	Madhya Pradesh	India
10579	Deoli	Rajasthan	India
10580	Devgarh	Rajasthan	India
10581	Devgadh Bariya	Gujarat	India
10582	Devarkonda	Telangana	India
10583	Devanhalli	Karnataka	India
10584	Devakottai	Tamil Nadu	India
10585	Deulgaon Raja	Maharashtra	India
10586	Deshnoke	Rajasthan	India
10587	Depalpur	Madhya Pradesh	India
10588	Deori Khas	Madhya Pradesh	India
10589	Deoria	Uttar Pradesh	India
10590	Deoranian	Uttar Pradesh	India
10591	Deoli	Maharashtra	India
10592	Deolali	Maharashtra	India
10593	Deogarh	Odisha	India
10594	Deoband	Uttar Pradesh	India
10595	Denkanikota	Tamil Nadu	India
10596	Delhi	NCT	India
10597	Dehri	Bihar	India
10598	Dehra Dun	Uttarakhand	India
10599	Dausa	Rajasthan	India
10600	Daund	Maharashtra	India
10601	Daudnagar	Bihar	India
10602	Dattapur	Maharashtra	India
10603	Datia	Madhya Pradesh	India
10604	Dataganj	Uttar Pradesh	India
10605	Dasuya	Punjab	India
10606	Dasna	Uttar Pradesh	India
10607	Daryapur	Maharashtra	India
10608	Darwha	Maharashtra	India
10609	Darjiling	West Bengal	India
10610	Darbhanga	Bihar	India
10611	Dandeli	Karnataka	India
10612	Dinapore	Bihar	India
10613	Damoh	Madhya Pradesh	India
10614	Damnagar	Gujarat	India
10615	Daman	Daman and Diu	India
10616	Daltonganj	Jharkhand	India
10617	Dalsingh Sarai	Bihar	India
10618	Dalkola	West Bengal	India
10619	Dakor	Gujarat	India
10620	Dohad	Gujarat	India
10621	Dahegam	Gujarat	India
10622	Dahanu	Maharashtra	India
10623	Dadri	Uttar Pradesh	India
10624	Dabwali	Haryana	India
10625	Dabra	Madhya Pradesh	India
10626	Daboh	Madhya Pradesh	India
10627	Dabhoi	Gujarat	India
10628	Cuttack	Odisha	India
10629	Curchorem	Goa	India
10630	Cuncolim	Goa	India
10631	Cumbum	Andhra Pradesh	India
10632	Cuddapah	Andhra Pradesh	India
10633	Cuddalore	Tamil Nadu	India
10634	Coondapoor	Karnataka	India
10635	Colonelganj	Uttar Pradesh	India
10636	Colgong	Bihar	India
10637	Calangute	Goa	India
10638	Coimbatore	Tamil Nadu	India
10639	Cochin	Kerala	India
10640	Clement Town	Uttarakhand	India
10641	Churu	Rajasthan	India
10642	Churachandpur	Manipur	India
10643	Chunar	Uttar Pradesh	India
10644	Chotila	Gujarat	India
10645	Chopda	Maharashtra	India
10646	Chodavaram	Andhra Pradesh	India
10647	Rampachodavaram	Andhra Pradesh	India
10648	Chittur	Kerala	India
10649	Chittaurgarh	Rajasthan	India
10650	Chittaranjan	West Bengal	India
10651	Chitradurga	Karnataka	India
10652	Chitapur	Karnataka	India
10653	Chidawa	Rajasthan	India
10654	Chirala	Andhra Pradesh	India
10655	Chipurupalle	Andhra Pradesh	India
10656	Chiplun	Maharashtra	India
10657	Chintamani	Karnataka	India
10658	Chinna Salem	Tamil Nadu	India
10659	Chinnamanur	Tamil Nadu	India
10660	Chincholi	Karnataka	India
10661	Chillupar	Uttar Pradesh	India
10662	Chilakalurupet	Andhra Pradesh	India
10663	Chikodi	Karnataka	India
10664	Chiknayakanhalli	Karnataka	India
10665	Chikmagalur	Karnataka	India
10666	Chikhli	Maharashtra	India
10667	Chik Ballapur	Karnataka	India
10668	Chidambaram	Tamil Nadu	India
10669	Chicholi	Maharashtra	India
10670	Chhoti Sadri	Rajasthan	India
10671	Chhota Udepur	Gujarat	India
10672	Chhindwara	Madhya Pradesh	India
10673	Chhibramau	Uttar Pradesh	India
10674	Chhatarpur	Madhya Pradesh	India
10675	Chhatapur	Bihar	India
10676	Chhata	Uttar Pradesh	India
10677	Chharra	Uttar Pradesh	India
10678	Chhaprauli	Uttar Pradesh	India
10679	Chapra	Bihar	India
10680	Chhapar	Rajasthan	India
10681	Chhala	Gujarat	India
10682	Chhabra	Rajasthan	India
10683	Chettipalaiyam	Tamil Nadu	India
10684	Chetput	Tamil Nadu	India
10685	Chennimalai	Tamil Nadu	India
10686	Chengannur	Kerala	India
10687	Chengam	Tamil Nadu	India
10688	Chengalpattu	Tamil Nadu	India
10689	Chavakkad	Kerala	India
10690	Chaksu	Rajasthan	India
10691	Chatrapur	Odisha	India
10692	Chatra	Jharkhand	India
10693	Chas	Jharkhand	India
10694	Charthawal	Uttar Pradesh	India
10695	Charkhi Dadri	Haryana	India
10696	Charkhari	Uttar Pradesh	India
10697	Chapar	Assam	India
10698	Channarayapatna	Karnataka	India
10699	Channapatna	Karnataka	India
10700	Channagiri	Karnataka	India
10701	Changanacheri	Kerala	India
10702	Chandor	Maharashtra	India
10703	Chandur Bazar	Maharashtra	India
10704	Chandur	Maharashtra	India
10705	Chandur	Maharashtra	India
10706	Chanda	Maharashtra	India
10707	Chandrakona	West Bengal	India
10708	Chandpur	Uttar Pradesh	India
10709	Chandigarh	Chandigarh	India
10710	Chanderi	Madhya Pradesh	India
10711	Chanduasi	Uttar Pradesh	India
10712	Chandauli	Uttar Pradesh	India
10713	Chandannagar	West Bengal	India
10714	Chanasma	Gujarat	India
10715	Chamrajnagar	Karnataka	India
10716	Champa	Chhattisgarh	India
10717	Chamba	Himachal Pradesh	India
10718	Challapalle	Andhra Pradesh	India
10719	Challakere	Karnataka	India
10720	Chalisgaon	Maharashtra	India
10721	Chalala	Gujarat	India
10722	Chakradharpur	Jharkhand	India
10723	Chaklasi	Gujarat	India
10724	Chakia	Bihar	India
10725	Chakan	Maharashtra	India
10726	Chaibasa	Jharkhand	India
10727	Canning	West Bengal	India
10728	Cannanore	Kerala	India
10729	Kolkata	West Bengal	India
10730	Byadgi	Karnataka	India
10731	Buxar	Bihar	India
10732	Burla	Odisha	India
10733	Burhar	Madhya Pradesh	India
10734	Burhanpur	Madhya Pradesh	India
10735	Bundu	Jharkhand	India
10736	Bundi	Rajasthan	India
10737	Buldana	Maharashtra	India
10738	Bulandshahr	Uttar Pradesh	India
10739	Budhlada	Punjab	India
10740	Budhana	Uttar Pradesh	India
10741	Budaun	Uttar Pradesh	India
10742	Brajarajnagar	Odisha	India
10743	Brahmapur	Odisha	India
10744	Botad	Gujarat	India
10745	Borsad	Gujarat	India
10746	Borivli	Maharashtra	India
10747	Bongaigaon	Assam	India
10748	Mumbai	Maharashtra	India
10749	Bolpur	West Bengal	India
10750	Bokaro	Jharkhand	India
10751	Bokajan	Assam	India
10752	Boisar	Maharashtra	India
10753	Bodinayakkanur	Tamil Nadu	India
10754	Buddh Gaya	Bihar	India
10755	Bodhan	Telangana	India
10756	Bobbili	Andhra Pradesh	India
10757	Biswan	Uttar Pradesh	India
10758	Bissau	Rajasthan	India
10759	Bishnupur	West Bengal	India
10760	Bisauli	Uttar Pradesh	India
10761	Bisalpur	Uttar Pradesh	India
10762	Birur	Karnataka	India
10763	Birpur	Bihar	India
10764	Birmitrapur	Odisha	India
10765	Binka	Odisha	India
10766	Bindki	Uttar Pradesh	India
10767	Etawa	Madhya Pradesh	India
10768	Bilthra	Uttar Pradesh	India
10769	Bilsi	Uttar Pradesh	India
10770	Bilsanda	Uttar Pradesh	India
10771	Bilimora	Gujarat	India
10772	Bilhaur	Uttar Pradesh	India
10773	Bilgram	Uttar Pradesh	India
10774	Bilgi	Karnataka	India
10775	Bilaspur	Uttar Pradesh	India
10776	Bilaspur	Chhattisgarh	India
10777	Bilasipara	Assam	India
10778	Bilari	Uttar Pradesh	India
10779	Bilara	Rajasthan	India
10780	Bikramganj	Bihar	India
10781	Bikaner	Rajasthan	India
10782	Bijnor	Uttar Pradesh	India
10783	Bijbiara	Kashmir	India
10784	Bijawar	Madhya Pradesh	India
10785	Bijapur	Karnataka	India
10786	Bihar	Bihar	India
10787	Bihariganj	Bihar	India
10788	Bidhuna	Uttar Pradesh	India
10789	Bidar	Karnataka	India
10790	Biaora	Madhya Pradesh	India
10791	Bhuvanagiri	Tamil Nadu	India
10792	Bhusaval	Maharashtra	India
10793	Bhum	Maharashtra	India
10794	Bhuj	Gujarat	India
10795	Bhudgaon	Maharashtra	India
10796	Bhubaneshwar	Odisha	India
10797	Bhuban	Odisha	India
10798	Bhor	Maharashtra	India
10799	Bhopal	Madhya Pradesh	India
10800	Bhongir	Telangana	India
10801	Bhongaon	Uttar Pradesh	India
10802	Bhogpur	Punjab	India
10803	Bhiwani	Haryana	India
10804	Bhiwandi	Maharashtra	India
10805	Bhitarwar	Madhya Pradesh	India
10806	Bhinmal	Rajasthan	India
10807	Bhinga	Uttar Pradesh	India
10808	Bhindar	Rajasthan	India
10809	Bhind	Madhya Pradesh	India
10810	Bhimunipatnam	Andhra Pradesh	India
10811	Bhimavaram	Andhra Pradesh	India
10812	Bhilwara	Rajasthan	India
10813	Bhilai	Chhattisgarh	India
10814	Bhikhi	Punjab	India
10815	Bhikangaon	Madhya Pradesh	India
10816	Bhayavadar	Gujarat	India
10817	Bhayandar	Maharashtra	India
10818	Bhawanipatna	Odisha	India
10819	Bhawanigarh	Punjab	India
10820	Bhawaniganj	Madhya Pradesh	India
10821	Bhavnagar	Gujarat	India
10822	Bhavani	Tamil Nadu	India
10823	Bhattiprolu	Andhra Pradesh	India
10824	Bhatpara	West Bengal	India
10825	Bhatkal	Karnataka	India
10826	Bhatinda	Punjab	India
10827	Bhatapara	Chhattisgarh	India
10828	Bhasawar	Rajasthan	India
10829	Bharwari	Uttar Pradesh	India
10830	Bharuch	Gujarat	India
10831	Bharthana	Uttar Pradesh	India
10832	Bharatpur	Rajasthan	India
10833	Bhanvad	Gujarat	India
10834	Bhanpuri	Chhattisgarh	India
10835	Bhanpura	Madhya Pradesh	India
10836	Bhanjanagar	Odisha	India
10837	Bhander	Madhya Pradesh	India
10838	Bhandara	Maharashtra	India
10839	Bhalki	Karnataka	India
10840	Bhaisa	Telangana	India
10841	Bhainsdehi	Madhya Pradesh	India
10842	Bhagalpur	Bihar	India
10843	Bhadreswar	West Bengal	India
10844	Bhadravati	Karnataka	India
10845	Bhadrakh	Odisha	India
10846	Bhadrachalam	Telangana	India
10847	Bhadra	Rajasthan	India
10848	Bhadohi	Uttar Pradesh	India
10849	Bhadaur	Punjab	India
10850	Bhadasar	Rajasthan	India
10851	Bhachau	Gujarat	India
10852	Bhabhua	Bihar	India
10853	Beypore	Kerala	India
10854	Bewar	Uttar Pradesh	India
10855	Betul	Madhya Pradesh	India
10856	Bettiah	Bihar	India
10857	Betamcherla	Andhra Pradesh	India
10858	Beri Khas	Haryana	India
10859	Berasia	Madhya Pradesh	India
10860	Beohari	Madhya Pradesh	India
10861	Bemetara	Chhattisgarh	India
10862	Belur	Karnataka	India
10863	Belsand	Bihar	India
10864	Belonia	Tripura	India
10865	Bellary	Karnataka	India
10866	Belgaum	Karnataka	India
10867	Beldanga	West Bengal	India
10868	Bela	Uttar Pradesh	India
10869	Behror	Rajasthan	India
10870	Behat	Uttar Pradesh	India
10871	Begusarai	Bihar	India
10872	Begun	Rajasthan	India
10873	Begamganj	Madhya Pradesh	India
10874	Bedi	Gujarat	India
10875	Beawar	Rajasthan	India
10876	Bazpur	Uttarakhand	India
10877	Bayana	Rajasthan	India
10878	Bawana	NCT	India
10879	Bauda	Odisha	India
10880	Batala	Punjab	India
10881	Baswa	Rajasthan	India
10882	Basudebpur	Odisha	India
10883	Basti	Uttar Pradesh	India
10884	Basoda	Madhya Pradesh	India
10885	Basni	Rajasthan	India
10886	Basmat	Maharashtra	India
10887	Basi	Punjab	India
10888	Basi	Punjab	India
10889	Basi	Rajasthan	India
10890	Basavana Bagevadi	Karnataka	India
10891	Basavakalyan	Karnataka	India
10892	Barwani	Madhya Pradesh	India
10893	Barwala	Haryana	India
10894	Baruni	Bihar	India
10895	Baruipur	West Bengal	India
10896	Barsi	Maharashtra	India
10897	Barpeta	Assam	India
10898	Barpali	Odisha	India
10899	Barnala	Punjab	India
10900	Barmer	Rajasthan	India
10901	Barki Saria	Jharkhand	India
10902	Barka Kana	Jharkhand	India
10903	Barjala	Tripura	India
10904	Bari Sadri	Rajasthan	India
10905	Bari	Rajasthan	India
10906	Barhiya	Bihar	India
10907	Barh	Bihar	India
10908	Bargi	Madhya Pradesh	India
10909	Bargarh	Odisha	India
10910	Bareilly	Uttar Pradesh	India
10911	Bardoli	Gujarat	India
10912	Barddhaman	West Bengal	India
10913	Bar Bigha	Bihar	India
10914	Baraut	Uttar Pradesh	India
10915	Barauli	Bihar	India
10916	Barasat	West Bengal	India
10917	Barasat	West Bengal	India
10918	Baranagar	West Bengal	India
10919	Baran	Rajasthan	India
10920	Baramula	Kashmir	India
10921	Baramati	Maharashtra	India
10922	Barakpur	West Bengal	India
10923	Bapatla	Andhra Pradesh	India
10924	Banur	Punjab	India
10925	Bantval	Karnataka	India
10926	Bantva	Gujarat	India
10927	Banswara	Rajasthan	India
10928	Banswada	Telangana	India
10929	Bansi	Uttar Pradesh	India
10930	Bansdih	Uttar Pradesh	India
10931	Bansbaria	West Bengal	India
10932	Bannur	Karnataka	India
10933	Banmankhi	Bihar	India
10934	Bankura	West Bengal	India
10935	Banki	Odisha	India
10936	Banka	Bihar	India
10937	Bangarmau	Uttar Pradesh	India
10938	Bangarapet	Karnataka	India
10939	Bangaon	Bihar	India
10940	Bangaon	West Bengal	India
10941	Banganapalle	Andhra Pradesh	India
10942	Bengaluru	Karnataka	India
10943	Banga	Punjab	India
10944	Bandipura	Kashmir	India
10945	Bandikui	Rajasthan	India
10946	Banda	Uttar Pradesh	India
10947	Banda	Madhya Pradesh	India
10948	Banat	Uttar Pradesh	India
10949	Banapur	Odisha	India
10950	Bamor Kalan	Madhya Pradesh	India
10951	Balurghat	West Bengal	India
10952	Balugaon	Odisha	India
10953	Balrampur	Uttar Pradesh	India
10954	Balotra	Rajasthan	India
10955	Baloda Bazar	Chhattisgarh	India
10956	Balod	Chhattisgarh	India
10957	Bali	West Bengal	India
10958	Ballalpur	Maharashtra	India
10959	Bali	Rajasthan	India
10960	Balasore	Odisha	India
10961	Balarampur	West Bengal	India
10962	Balapur	Maharashtra	India
10963	Balangir	Odisha	India
10964	Balaghat	Madhya Pradesh	India
10965	Balachor	Punjab	India
10966	Bakhtiyarpur	Bihar	India
10967	Baj Baj	West Bengal	India
10968	Bairagnia	Bihar	India
10969	Byndoor	Karnataka	India
10970	Bail-Hongal	Karnataka	India
10971	Baihar	Madhya Pradesh	India
10972	Baidyabati	West Bengal	India
10973	Bahraigh	Uttar Pradesh	India
10974	Bahjoi	Uttar Pradesh	India
10975	Baheri	Uttar Pradesh	India
10976	Baharampur	West Bengal	India
10977	Bahadurgarh	Haryana	India
10978	Bahadurganj	Bihar	India
10979	Bah	Uttar Pradesh	India
10980	Bagula	West Bengal	India
10981	Baghpat	Uttar Pradesh	India
10982	Baghdogra	West Bengal	India
10983	Bagha Purana	Punjab	India
10984	Bagepalli	Karnataka	India
10985	Bagasra	Gujarat	India
10986	Bagar	Rajasthan	India
10987	Bagalkot	Karnataka	India
10988	Bagaha	Bihar	India
10989	Bagaha	Bihar	India
10990	Badvel	Andhra Pradesh	India
10991	Baduria	West Bengal	India
10992	Badnawar	Madhya Pradesh	India
10993	Badlapur	Maharashtra	India
10994	Badami	Karnataka	India
10995	Badagara	Kerala	India
10996	Bada Barabil	Odisha	India
10997	Bachhraon	Uttar Pradesh	India
10998	Babrala	Uttar Pradesh	India
10999	Babra	Gujarat	India
11000	Babina	Uttar Pradesh	India
11001	Baberu	Uttar Pradesh	India
11002	Babai	Madhya Pradesh	India
11003	Azamgarh	Uttar Pradesh	India
11004	Ajodhya	Uttar Pradesh	India
11005	Ayakudi	Tamil Nadu	India
11006	Avanigadda	Andhra Pradesh	India
11007	Avinashi	Tamil Nadu	India
11008	Avadi	Tamil Nadu	India
11009	Ausa	Maharashtra	India
11010	Aurangabad	Bihar	India
11011	Aurangabad	Maharashtra	India
11012	Auraiya	Uttar Pradesh	India
11013	Aurad	Karnataka	India
11014	Attur	Tamil Nadu	India
11015	Attingal	Kerala	India
11016	Attili	Andhra Pradesh	India
11017	Atrauli	Uttar Pradesh	India
11018	Atmakur	Andhra Pradesh	India
11019	Adirampattinam	Tamil Nadu	India
11020	Athni	Karnataka	India
11021	Athagarh	Odisha	India
11022	Atarra	Uttar Pradesh	India
11023	Asind	Rajasthan	India
11024	Asika	Odisha	India
11025	Asifabad	Telangana	India
11026	Ashta	Madhya Pradesh	India
11027	Ashta	Maharashtra	India
11028	Ashoknagar	Madhya Pradesh	India
11029	Asansol	West Bengal	India
11030	Asandh	Haryana	India
11031	Arvi	Maharashtra	India
11032	Aruppukkottai	Tamil Nadu	India
11033	Arumuganeri	Tamil Nadu	India
11034	Arukutti	Kerala	India
11035	Arsikere	Karnataka	India
11036	Aron	Madhya Pradesh	India
11037	Arkalgud	Karnataka	India
11038	Ariyalur	Tamil Nadu	India
11039	Arcot	Tamil Nadu	India
11040	Araria	Bihar	India
11041	Arantangi	Tamil Nadu	India
11042	Arani	Tamil Nadu	India
11043	Arangaon	Maharashtra	India
11044	Arang	Chhattisgarh	India
11045	Arambagh	West Bengal	India
11046	Arakkonam	Tamil Nadu	India
11047	Arrah	Bihar	India
11048	Aonla	Uttar Pradesh	India
11049	Anupshahr	Uttar Pradesh	India
11050	Anuppur	Madhya Pradesh	India
11051	Anupgarh	Rajasthan	India
11052	Anta	Rajasthan	India
11053	Anshing	Maharashtra	India
11054	Annur	Tamil Nadu	India
11055	Annigeri	Karnataka	India
11056	Ankleshwar	Gujarat	India
11057	Anjar	Gujarat	India
11058	Anjangaon	Maharashtra	India
11059	Anjad	Madhya Pradesh	India
11060	Angul	Odisha	India
11061	Angamali	Kerala	India
11062	Anekal	Karnataka	India
11063	Andol	Telangana	India
11064	Anthiyur	Tamil Nadu	India
11065	Andippatti	Tamil Nadu	India
11066	Anantnag	Kashmir	India
11067	Anantapur	Andhra Pradesh	India
11068	Anandpur	Punjab	India
11069	Anand	Gujarat	India
11070	Anakapalle	Andhra Pradesh	India
11071	Anaimalai	Tamil Nadu	India
11072	Amudalavalasa	Andhra Pradesh	India
11073	Amta	West Bengal	India
11074	Amroli	Gujarat	India
11075	Amroha	Uttar Pradesh	India
11076	Amritsar	Punjab	India
11077	Amreli	Gujarat	India
11078	Amravati	Maharashtra	India
11079	Amod	Gujarat	India
11080	Amli	Dadra and Nagar Haveli	India
11081	Amlagora	West Bengal	India
11082	Amla	Madhya Pradesh	India
11083	Amet	Rajasthan	India
11084	Ambur	Tamil Nadu	India
11085	Ambikapur	Chhattisgarh	India
11086	Ambattur	Tamil Nadu	India
11087	Ambasamudram	Tamil Nadu	India
11088	Ambala	Haryana	India
11089	Ambajogai	Maharashtra	India
11090	Ambah	Madhya Pradesh	India
11091	Ambad	Maharashtra	India
11092	Amarpur	Bihar	India
11093	Amarpatan	Madhya Pradesh	India
11094	Amarnath	Maharashtra	India
11095	Amalner	Maharashtra	India
11096	Amalapuram	Andhra Pradesh	India
11097	Aluva	Kerala	India
11098	Alwar	Rajasthan	India
11099	Alot	Madhya Pradesh	India
11100	Along	Arunachal Pradesh	India
11101	Alnavar	Karnataka	India
11102	Almora	Uttarakhand	India
11103	Alleppey	Kerala	India
11104	Allahabad	Uttar Pradesh	India
11105	Alipur	NCT	India
11106	Aligarh	Uttar Pradesh	India
11107	Aliganj	Uttar Pradesh	India
11108	Alibag	Maharashtra	India
11109	Alangulam	Tamil Nadu	India
11110	Alangayam	Tamil Nadu	India
11111	Alandur	Tamil Nadu	India
11112	Alandi	Maharashtra	India
11113	Aland	Karnataka	India
11114	Akot	Maharashtra	India
11115	Akola	Maharashtra	India
11116	Aklera	Rajasthan	India
11117	Akividu	Andhra Pradesh	India
11118	Akbarpur	Uttar Pradesh	India
11119	Akbarpur	Uttar Pradesh	India
11120	Akaltara	Chhattisgarh	India
11121	Akalkot	Maharashtra	India
11122	Ajra	Maharashtra	India
11123	Ajnala	Punjab	India
11124	Ajmer	Rajasthan	India
11125	Aizawl	Mizoram	India
11126	Ahraura	Uttar Pradesh	India
11127	Ahmadpur	Maharashtra	India
11128	Ahmadnagar	Maharashtra	India
11129	Ahmedabad	Gujarat	India
11130	Agra	Uttar Pradesh	India
11131	Agartala	Tripura	India
11132	Agar	Madhya Pradesh	India
11133	Afzalpur	Karnataka	India
11134	Afzalgarh	Uttar Pradesh	India
11135	Adur	Kerala	India
11136	Adra	West Bengal	India
11137	Adoni	Andhra Pradesh	India
11138	Adilabad	Telangana	India
11139	Addanki	Andhra Pradesh	India
11140	Achhnera	Uttar Pradesh	India
11141	Achalpur	Maharashtra	India
11142	Abu Road	Rajasthan	India
11143	Abu	Rajasthan	India
11144	Abohar	Punjab	India
11145	Abhayapuri	Assam	India
11146	Contai	West Bengal	India
11147	Haldia	West Bengal	India
11148	Srirampur	West Bengal	India
11149	Dumjor	West Bengal	India
11150	Bankra	West Bengal	India
11151	Chakapara	West Bengal	India
11152	Mahiari	West Bengal	India
11153	Dhulagari	West Bengal	India
11154	Panchla	West Bengal	India
11155	Nangi	West Bengal	India
11156	Pujali	West Bengal	India
11157	Monoharpur	West Bengal	India
11158	Nabagram	West Bengal	India
11159	Soyibug	Kashmir	India
11160	Singapur	Telangana	India
11161	Ghatkesar	Telangana	India
11162	Vijayapura	Karnataka	India
11163	Adampur	Punjab	India
11164	Porur	Tamil Nadu	India
11165	Madipakkam	Tamil Nadu	India
11166	Perungudi	Tamil Nadu	India
11167	Madambakkam	Tamil Nadu	India
11168	Powai	Maharashtra	India
11169	Navi Mumbai	Maharashtra	India
11170	Murudeshwara	Karnataka	India
11171	Shivaji Nagar	Maharashtra	India
11172	Greater Noida	Uttar Pradesh	India
11173	Mohali	Punjab	India
11174	Pithampur	Madhya Pradesh	India
11175	Barbil	Odisha	India
11176	Airoli	Maharashtra	India
11177	Aluva	Kerala	India
11178	Kotkapura	Punjab	India
11179	Muvattupuzha	Kerala	India
11180	Perumbavoor	Kerala	India
11181	Vapi	Gujarat	India
11182	Baddi	Himachal Pradesh	India
11183	Noida	Uttar Pradesh	India
11184	Bhiwadi	Rajasthan	India
11185	Mandideep	Madhya Pradesh	India
11186	Singrauli	Madhya Pradesh	India
11187	Birpara	West Bengal	India
11188	Jaigaon	West Bengal	India
11189	Akkarampalle	Andhra Pradesh	India
11190	Bellampalli	Telangana	India
11191	Chemmumiahpet	Andhra Pradesh	India
11192	Gaddi Annaram	Telangana	India
11193	Dasnapur	Telangana	India
11194	Kanuru	Andhra Pradesh	India
11195	Lal Bahadur Nagar	Telangana	India
11196	Malkajgiri	Telangana	India
11197	Mandamarri	Telangana	India
11198	Chinnachowk	Andhra Pradesh	India
11199	Kyathampalle	Telangana	India
11200	Gajuwaka	Andhra Pradesh	India
11201	Manuguru	Telangana	India
11202	Kalyandurg	Andhra Pradesh	India
11203	Ponnur	Andhra Pradesh	India
11204	Quthbullapur	Telangana	India
11205	Ramanayyapeta	Andhra Pradesh	India
11206	Palwancha	Telangana	India
11207	Barpeta Road	Assam	India
11208	Sathupalli	Telangana	India
11209	Yanamalakuduru	Andhra Pradesh	India
11210	Marigaon	Assam	India
11211	Naharlagun	Arunachal Pradesh	India
11212	Serilingampalle	Telangana	India
11213	Silapathar	Assam	India
11214	Lumding Railway Colony	Assam	India
11215	Aistala	West Bengal	India
11216	Ashoknagar Kalyangarh	West Bengal	India
11217	Bahula	West Bengal	India
11218	Bhawanipur	Bihar	India
11219	Zira	Punjab	India
11220	Ramagundam	Telangana	India
11221	Cherpulassery	Kerala	India
11222	Kirandul	Chhattisgarh	India
11223	Shiraguppi	Maharashtra	India
11224	V.S.K.Valasai (Dindigul-Dist.)	Tamil Nadu	India
11225	Neelankarai	Tamil Nadu	India
11226	Injambakkam	Tamil Nadu	India
11227	Kultali	West Bengal	India
11228	Shahbazpur	Bihar	India
11229	Kumbalam	Kerala	India
11230	Aroor	Kerala	India
11231	Kadakkavoor	Kerala	India
11232	Kalavoor	Kerala	India
11233	Kalamassery	Kerala	India
11234	Cherthala	Kerala	India
11235	Zaxo	Dahuk	Iraq
11236	Umm Qasr	Basra Governorate	Iraq
11237	Tozkhurmato	Salah ad Din Governorate	Iraq
11238	Tikrit	Salah ad Din Governorate	Iraq
11240	Sinah	Dahuk	Iraq
11242	Na?iyat Saddat al Hindiyah	Babil	Iraq
11243	Ruwandiz	Arbil	Iraq
11244	Rawah	Anbar	Iraq
11247	Koysinceq	Arbil	Iraq
11249	Kirkuk	At Tamim	Iraq
11250	Karbala	Karbala	Iraq
11251	Erbil	Arbil	Iraq
11252	Hit	Anbar	Iraq
11253	?alabjah	As Sulaymaniyah	Iraq
11254	?adithah	Anbar	Iraq
11255	Dihok	Dahuk	Iraq
11256	Jamjamal	As Sulaymaniyah	Iraq
11257	Bayji	Salah ad Din Governorate	Iraq
11259	Baynjiwayn	As Sulaymaniyah	Iraq
11260	Balad	Salah ad Din Governorate	Iraq
11261	Baghdad	Mayorality of Baghdad	Iraq
11262	Az Zubayr	Basra Governorate	Iraq
11263	As Suwayrah	Wasit	Iraq
11264	As Sulaymaniyah	As Sulaymaniyah	Iraq
11266	Na?iyat ash Shinafiyah	Al Qadisiyah	Iraq
11267	Ash Shatrah	Dhi Qar	Iraq
11268	Ash Shamiyah	Al Qadisiyah	Iraq
11269	Ar Rutbah	Anbar	Iraq
11271	Ramadi	Anbar	Iraq
11273	An Nasiriyah	Dhi Qar	Iraq
11274	Najaf	An Najaf	Iraq
11276	Imam Qasim	Babil	Iraq
11277	Al Musayyib	Babil	Iraq
11278	Al Mishkhab	An Najaf	Iraq
11282	Al Kut	Wasit	Iraq
11283	Kufa	An Najaf	Iraq
11286	Al Hindiyah	Karbala	Iraq
11287	Al ?illah	Babil	Iraq
11288	Al ?ayy	Wasit	Iraq
11289	Al Harithah	Basra Governorate	Iraq
11290	Nahiyat Ghammas	Al Qadisiyah	Iraq
11291	Na?iyat al Fuhud	Dhi Qar	Iraq
11292	Al Faw	Basra Governorate	Iraq
11293	Al Fallujah	Anbar	Iraq
11294	Basrah	Basra Governorate	Iraq
11298	Ad Dujayl	Salah ad Din Governorate	Iraq
11299	Ad Diwaniyah	Al Qadisiyah	Iraq
11300	Abu Ghurayb	Mayorality of Baghdad	Iraq
11301	Al Basrah al Qadimah	Basra Governorate	Iraq
11303	Azadshahr	Hamadan	Iran
11304	Kahriz	Kermanshah	Iran
11305	Nurabad	Lorestan	Iran
11306	Istgah-e Rah Ahan-e Garmsar	Semnan	Iran
11307	Qarchak	Tehran	Iran
11308	Shahre Jadide Andisheh	Tehran	Iran
11309	Khorramdarreh	Zanjan	Iran
11310	Yasuj	Kohgiluyeh va Buyer A?mad	Iran
11311	Azadshahr	Golestan	Iran
11312	Zarand	Kerman	Iran
11313	Zanjan	Zanjan	Iran
11314	Yazd	Yazd	Iran
11315	Varamin	Tehran	Iran
11316	Torbat-e ?eydariyeh	Razavi Khorasan	Iran
11317	Tonekabon	Mazandaran	Iran
11318	Tehran	Tehran	Iran
11319	Hashtpar	Gilan	Iran
11320	Takestan	Qazvin	Iran
11322	Taft	Yazd	Iran
11323	Tabriz	East Azerbaijan	Iran
11324	Tabas	Yazd	Iran
11325	Sonqor	Kermanshah	Iran
11326	Sirjan	Kerman	Iran
11327	Shushtar	Khuzestan	Iran
11328	Shush	Khuzestan	Iran
11329	Shirvan	Khorasan-e Shomali	Iran
11330	Shiraz	Fars	Iran
11331	Shahr-e Kord	Chahar Ma?all va Bakhtiari	Iran
11332	Shahr-e Babak	Kerman	Iran
11333	Shadegan	Khuzestan	Iran
11334	Semnan	Semnan	Iran
11335	Semirom	Isfahan	Iran
11336	Saveh	Markazi	Iran
11337	Sari	Mazandaran	Iran
11338	Saqqez	Kordestan	Iran
11339	Sanandaj	Kordestan	Iran
11342	Sabzevar	Razavi Khorasan	Iran
11343	Rudsar	Gilan	Iran
11344	Robat Karim	Tehran	Iran
11345	Ravar	Kerman	Iran
11346	Rasht	Gilan	Iran
11347	Ramshir	Khuzestan	Iran
11348	Ramhormoz	Khuzestan	Iran
11349	Rafsanjan	Kerman	Iran
11350	Quchan	Razavi Khorasan	Iran
11351	Qorveh	Kordestan	Iran
11352	Qom	Qom	Iran
11353	Qeshm	Hormozgan	Iran
11354	Qazvin	Qazvin	Iran
11356	Farrokh Shahr	Chahar Ma?all va Bakhtiari	Iran
11359	Pishva	Tehran	Iran
11361	Paveh	Kermanshah	Iran
11362	Parsabad	Ardabil	Iran
11365	Omidiyeh	Khuzestan	Iran
11366	Nurabad	Fars	Iran
11367	Nowshahr	Mazandaran	Iran
11368	Nishabur	Razavi Khorasan	Iran
11369	Neyriz	Fars	Iran
11370	Neka	Mazandaran	Iran
11373	Nahavand	Hamadan	Iran
11374	Minab	Hormozgan	Iran
11376	Meybod	Yazd	Iran
11377	Mahriz	Yazd	Iran
11378	Masjed Soleyman	Khuzestan	Iran
11379	Bardsir	Kerman	Iran
11380	Mashhad	Razavi Khorasan	Iran
11381	Marand	East Azerbaijan	Iran
11382	Malayer	Hamadan	Iran
11383	Malard	Tehran	Iran
11385	Langarud	Gilan	Iran
11386	Kuhdasht	Lorestan	Iran
11387	Kish	Hormozgan	Iran
11389	Khvansar	Isfahan	Iran
11390	Khorramshahr	Khuzestan	Iran
11391	Khorramabad	Lorestan	Iran
11392	Khomeyn	Markazi	Iran
11393	Khalkhal	Ardabil	Iran
11394	Kermanshah	Kermanshah	Iran
11395	Kerman	Kerman	Iran
11396	Kazerun	Fars	Iran
11397	Kashmar	Razavi Khorasan	Iran
11398	Kashan	Isfahan	Iran
11399	Karaj	Alborz	Iran
11400	Kangavar	Kermanshah	Iran
11401	Kamyaran	Kordestan	Iran
11402	Kalaleh	Golestan	Iran
11403	Juybar	Mazandaran	Iran
11404	Javanrud	Kermanshah	Iran
11405	Ilam	Ilam	Iran
11406	Harsin	Kermanshah	Iran
11407	Hamadan	Hamadan	Iran
11408	Gorgan	Golestan	Iran
11409	Gonbad-e Kavus	Golestan	Iran
11410	Gonabad	Razavi Khorasan	Iran
11411	Golpayegan	Isfahan	Iran
11412	Gerash	Fars	Iran
11413	Bandar-e Ganaveh	Bushehr	Iran
11414	Fuman	Gilan	Iran
11415	Firuzabad	Fars	Iran
11416	Fereydunkenar	Mazandaran	Iran
11417	Fasa	Fars	Iran
11418	Farsan	Chahar Ma?all va Bakhtiari	Iran
11419	Esfarayen	Khorasan-e Shomali	Iran
11420	Shahrud	Semnan	Iran
11421	Dogonbadan	Kohgiluyeh va Buyer A?mad	Iran
11422	Delijan	Markazi	Iran
11423	Dehloran	Ilam	Iran
11424	Dehdasht	Kohgiluyeh va Buyer A?mad	Iran
11425	Susangerd	Khuzestan	Iran
11426	Darreh Shahr	Ilam	Iran
11427	Darab	Fars	Iran
11428	Damghan	Semnan	Iran
11429	Damavand	Tehran	Iran
11430	Chenaran	Razavi Khorasan	Iran
11431	Chalus	Mazandaran	Iran
11432	Bandar-e Bushehr	Bushehr	Iran
11434	Borujerd	Lorestan	Iran
11435	Borujen	Chahar Ma?all va Bakhtiari	Iran
11436	Borazjan	Bushehr	Iran
11437	Bojnurd	Khorasan-e Shomali	Iran
11438	Birjand	Khorasan-e Jonubi	Iran
11439	Bijar	Kordestan	Iran
11440	Bonab	East Azerbaijan	Iran
11441	Behshahr	Mazandaran	Iran
11442	Behbahan	Khuzestan	Iran
11443	Baneh	Kordestan	Iran
11444	Bandar-e Lengeh	Hormozgan	Iran
11445	Bandar-e Anzali	Gilan	Iran
11447	Bam	Kerman	Iran
11448	Bahar	Hamadan	Iran
11449	Bafq	Yazd	Iran
11450	Babolsar	Mazandaran	Iran
11451	Babol	Mazandaran	Iran
11452	Azna	Lorestan	Iran
11453	Hashtrud	East Azerbaijan	Iran
11454	Astara	Gilan	Iran
11455	Astaneh-ye Ashrafiyeh	Gilan	Iran
11456	Asadabad	Hamadan	Iran
11457	Ardestan	Isfahan	Iran
11458	Ardakan	Yazd	Iran
11459	Ardabil	Ardabil	Iran
11460	Arak	Markazi	Iran
11461	Amol	Mazandaran	Iran
11462	Alvand	Zanjan	Iran
11463	Shahriar	Tehran	Iran
11464	Aligudarz	Lorestan	Iran
11465	Aleshtar	Lorestan	Iran
11466	Akbarabad	Fars	Iran
11468	Ahvaz	Khuzestan	Iran
11469	Ahar	East Azerbaijan	Iran
11470	Aghajari	Khuzestan	Iran
11471	Abyek	Markazi	Iran
11472	Abhar	Zanjan	Iran
11473	Abdanan	Ilam	Iran
11474	Abadeh	Fars	Iran
11475	Abadan	Khuzestan	Iran
11476	Eqbaliyeh	Tehran	Iran
11477	Shahre?a	Isfahan	Iran
11478	Rehnan	Isfahan	Iran
11479	Qahderijan	Isfahan	Iran
11480	Najafabad	Isfahan	Iran
11481	Khomeyni Shahr	Isfahan	Iran
11482	Kelishad va Sudarjan	Isfahan	Iran
11483	Falavarjan	Isfahan	Iran
11484	Isfahan	Isfahan	Iran
11485	Dowlatabad	Isfahan	Iran
11486	Dorcheh Piaz	Isfahan	Iran
11487	Zabol	Sistan and Baluchestan	Iran
11488	Zahedan	Sistan and Baluchestan	Iran
11489	Torbat-e Jam	Razavi Khorasan	Iran
11490	Taybad	Razavi Khorasan	Iran
11491	Sarakhs	Razavi Khorasan	Iran
11492	Qasr-e Qand	Sistan and Baluchestan	Iran
11493	Khash	Sistan and Baluchestan	Iran
11494	Iranshahr	Sistan and Baluchestan	Iran
11495	Chabahar	Sistan and Baluchestan	Iran
11496	Mahdishahr	Semnan	Iran
11497	Pasragad Branch	Hamadan	Iran
11498	Akureyri	Northeast	Iceland
11502	Vittoria	Sicily	Italy
11503	Villabate	Sicily	Italy
11504	Vibo Valentia	Calabria	Italy
11505	Trapani	Sicily	Italy
11506	Termini Imerese	Sicily	Italy
11507	Siracusa	Sicily	Italy
11508	Sinnai	Sardinia	Italy
11509	Siderno	Calabria	Italy
11510	Sestu	Sardinia	Italy
11511	Selargius	Sardinia	Italy
11512	Scordia	Sicily	Italy
11513	Scicli	Sicily	Italy
11514	Sciacca	Sicily	Italy
11515	San Giovanni la Punta	Sicily	Italy
11516	San Giovanni in Fiore	Calabria	Italy
11517	San Cataldo	Sicily	Italy
11518	Rossano Stazione	Calabria	Italy
11519	Rosolini	Sicily	Italy
11520	Ribera	Sicily	Italy
11521	Reggio Calabria	Calabria	Italy
11522	Ragusa	Sicily	Italy
11523	Quattromiglia	Calabria	Italy
11524	Quartu SantElena	Sardinia	Italy
11525	Pozzallo	Sicily	Italy
11526	Porto Empedocle	Sicily	Italy
11527	Piazza Armerina	Sicily	Italy
11529	Partinico	Sicily	Italy
11530	Palmi	Calabria	Italy
11531	Palma di Montechiaro	Sicily	Italy
11532	Palermo	Sicily	Italy
11533	Palagonia	Sicily	Italy
11534	Pachino	Sicily	Italy
11535	Oristano	Sardinia	Italy
11536	Noto	Sicily	Italy
11537	Niscemi	Sicily	Italy
11538	Nicastro-Sambiase	Calabria	Italy
11539	Monserrato	Sardinia	Italy
11540	Monreale	Sicily	Italy
11541	Modica	Sicily	Italy
11542	Misterbianco	Sicily	Italy
11543	Misilmeri	Sicily	Italy
11544	Milazzo	Sicily	Italy
11545	Messina	Sicily	Italy
11546	Mazara del Vallo	Sicily	Italy
11547	Mascalucia	Sicily	Italy
11548	Marsala	Sicily	Italy
11549	Licata	Sicily	Italy
11550	Lentini	Sicily	Italy
11551	Iglesias	Sardinia	Italy
11552	Gioia Tauro	Calabria	Italy
11553	Giarre	Sicily	Italy
11554	Gela	Sicily	Italy
11555	Floridia	Sicily	Italy
11556	Favara	Sicily	Italy
11557	Enna	Sicily	Italy
11558	Crotone	Calabria	Italy
11559	Cosenza	Calabria	Italy
11560	Comiso	Sicily	Italy
11561	Catanzaro	Calabria	Italy
11562	Catania	Sicily	Italy
11563	Castrovillari	Calabria	Italy
11564	Castelvetrano	Sicily	Italy
11565	Casarano	Apulia	Italy
11566	Carini	Sicily	Italy
11567	Carbonia	Sardinia	Italy
11569	Caltanissetta	Sicily	Italy
11570	Caltagirone	Sicily	Italy
11571	Cagliari	Sardinia	Italy
11572	Bronte	Sicily	Italy
11573	Biancavilla	Sicily	Italy
11574	Belpasso	Sicily	Italy
11575	Barcellona Pozzo di Gotto	Sicily	Italy
11576	Bagheria	Sicily	Italy
11577	Avola	Sicily	Italy
11578	Augusta	Sicily	Italy
11579	Assemini	Sardinia	Italy
11580	Amato	Calabria	Italy
11581	Alcamo	Sicily	Italy
11582	Agrigento	Sicily	Italy
11583	Adrano	Sicily	Italy
11584	Acireale	Sicily	Italy
11585	Aci Catena	Sicily	Italy
11586	Aci Castello	Sicily	Italy
11587	Zola Predosa	Emilia-Romagna	Italy
11588	Voghera	Lombardy	Italy
11589	Vittorio Veneto	Veneto	Italy
11590	Viterbo	Latium	Italy
11591	Vimodrone	Lombardy	Italy
11592	Vimercate	Lombardy	Italy
11593	Lancenigo-Villorba	Veneto	Italy
11594	Villaricca	Campania	Italy
11595	Villafranca di Verona	Veneto	Italy
11596	Vignola	Emilia-Romagna	Italy
11597	Vigevano	Lombardy	Italy
11598	Vicenza	Veneto	Italy
11599	Viareggio	Tuscany	Italy
11600	Verona	Veneto	Italy
11601	Vercelli	Piedmont	Italy
11602	Ventimiglia	Liguria	Italy
11603	Venice	Veneto	Italy
11604	Venaria Reale	Piedmont	Italy
11605	Velletri	Latium	Italy
11606	Vasto	Abruzzo	Italy
11607	Varese	Lombardy	Italy
11608	Valenzano	Apulia	Italy
11609	Valenza	Piedmont	Italy
11610	Valdagno	Veneto	Italy
11611	Udine	Friuli Venezia Giulia	Italy
11612	Triggiano	Apulia	Italy
11613	Trieste	Friuli Venezia Giulia	Italy
11614	Trezzano sul Naviglio	Lombardy	Italy
11615	Treviso	Veneto	Italy
11616	Treviglio	Lombardy	Italy
11617	Trentola-Ducenta	Campania	Italy
11618	Trento	Trentino-Alto Adige	Italy
11619	Trecate	Piedmont	Italy
11620	Trani	Apulia	Italy
11621	Tradate	Lombardy	Italy
11622	Tortona	Piedmont	Italy
11623	Torremaggiore	Apulia	Italy
11624	Torre del Greco	Campania	Italy
11625	Torre Annunziata	Campania	Italy
11626	Turin	Piedmont	Italy
11627	Tolentino	The Marches	Italy
11628	Tivoli	Latium	Italy
11629	Thiene	Veneto	Italy
11630	Terzigno	Campania	Italy
11631	Terracina	Latium	Italy
11632	Terni	Umbria	Italy
11633	Termoli	Molise	Italy
11634	Terlizzi	Apulia	Italy
11635	Teramo	Abruzzo	Italy
11636	Taranto	Apulia	Italy
11637	Suzzara	Lombardy	Italy
11638	Sulmona	Abruzzo	Italy
11639	Spoleto	Umbria	Italy
11640	Sora	Latium	Italy
11641	Sondrio	Lombardy	Italy
11642	Somma Vesuviana	Campania	Italy
11643	Siena	Tuscany	Italy
11644	Sezze	Latium	Italy
11645	Seveso	Lombardy	Italy
11646	Settimo Torinese	Piedmont	Italy
11647	Sestri Levante	Liguria	Italy
11648	Sesto San Giovanni	Lombardy	Italy
11649	Sesto Fiorentino	Tuscany	Italy
11650	Seriate	Lombardy	Italy
11651	Seregno	Lombardy	Italy
11652	Senigallia	The Marches	Italy
11653	Senago	Lombardy	Italy
11654	Segrate	Lombardy	Italy
11655	Schio	Veneto	Italy
11656	Scandicci	Tuscany	Italy
11657	Scafati	Campania	Italy
11658	Savona	Liguria	Italy
11659	Savigliano	Piedmont	Italy
11660	Sava	Apulia	Italy
11661	Sassuolo	Emilia-Romagna	Italy
11662	Sassari	Sardinia	Italy
11663	Sarzana	Liguria	Italy
11664	Saronno	Lombardy	Italy
11665	Sarno	Campania	Italy
11666	San Vito dei Normanni	Apulia	Italy
11667	Santeramo in Colle	Apulia	Italy
11668	SantAntonio Abate	Campania	Italy
11669	SantAntimo	Campania	Italy
11670	SantAnastasia	Campania	Italy
11671	Santa Maria Capua Vetere	Campania	Italy
11672	San Severo	Apulia	Italy
11673	San Sebastiano	Lombardy	Italy
11674	San Salvo	Abruzzo	Italy
11675	San Remo	Liguria	Italy
11676	Sannicandro Garganico	Apulia	Italy
11677	San Miniato	Tuscany	Italy
11678	San Miniato Basso	Tuscany	Italy
11679	San Mauro Torinese	Piedmont	Italy
11680	San Lazzaro	Emilia-Romagna	Italy
11681	San Giuseppe Vesuviano	Campania	Italy
11682	San Giuliano Milanese	Lombardy	Italy
11683	San Giovanni Valdarno	Tuscany	Italy
11684	San Giovanni Rotondo	Apulia	Italy
11685	San Giovanni Lupatoto	Veneto	Italy
11686	San Giovanni in Persiceto	Emilia-Romagna	Italy
11687	San Giorgio a Cremano	Campania	Italy
11688	San Donato Milanese	Lombardy	Italy
11690	San Bonifacio	Veneto	Italy
11691	San Benedetto del Tronto	The Marches	Italy
11692	Salsomaggiore Terme	Emilia-Romagna	Italy
11693	Salerno	Campania	Italy
11694	Sacile	Friuli Venezia Giulia	Italy
11695	Ruvo di Puglia	Apulia	Italy
11696	Rutigliano	Apulia	Italy
11697	Rozzano	Lombardy	Italy
11698	Rovigo	Veneto	Italy
11699	Rovereto	Trentino-Alto Adige	Italy
11700	Rosignano Solvay-Castiglioncello	Tuscany	Italy
11701	Roseto degli Abruzzi	Abruzzo	Italy
11702	Romano di Lombardia	Lombardy	Italy
11703	Rome	Latium	Italy
11704	Rocca di Papa	Latium	Italy
11705	Rivoli	Piedmont	Italy
11706	Rimini	Emilia-Romagna	Italy
11707	Rieti	Latium	Italy
11708	Riccione	Emilia-Romagna	Italy
11709	Rho	Lombardy	Italy
11710	Reggio nellEmilia	Emilia-Romagna	Italy
11711	Ravenna	Emilia-Romagna	Italy
11712	Rapallo	Liguria	Italy
11713	Qualiano	Campania	Italy
11714	Putignano	Apulia	Italy
11715	Prato	Tuscany	Italy
11716	Pozzuoli	Campania	Italy
11717	Potenza	Basilicate	Italy
11718	Porto Torres	Sardinia	Italy
11719	Porto SantElpidio	The Marches	Italy
11720	Porto San Giorgio	The Marches	Italy
11721	Portogruaro	Veneto	Italy
11722	Civitanova Marche	The Marches	Italy
11723	Portici	Campania	Italy
11724	Pordenone	Friuli Venezia Giulia	Italy
11725	Pontedera	Tuscany	Italy
11726	Pompei	Campania	Italy
11727	Pomigliano dArco	Campania	Italy
11728	Pomezia	Latium	Italy
11729	Poggiomarino	Campania	Italy
11730	Poggibonsi	Tuscany	Italy
11731	Pistoia	Tuscany	Italy
11732	Pisa	Tuscany	Italy
11733	Piossasco	Piedmont	Italy
11734	Piombino	Tuscany	Italy
11735	Pioltello	Lombardy	Italy
11736	Pinerolo	Piedmont	Italy
11737	Pietrasanta	Tuscany	Italy
11738	Piacenza	Emilia-Romagna	Italy
11739	Pescara	Abruzzo	Italy
11740	Pesaro	The Marches	Italy
11741	Perugia	Umbria	Italy
11742	Pavia	Lombardy	Italy
11743	Parma	Emilia-Romagna	Italy
11744	Parabiago	Lombardy	Italy
11745	Palo del Colle	Apulia	Italy
11746	Palazzolo sullOglio	Lombardy	Italy
11747	Palagiano	Apulia	Italy
11748	Pagani	Campania	Italy
11749	Padova	Veneto	Italy
11750	Paderno Dugnano	Lombardy	Italy
11751	Ottaviano	Campania	Italy
11752	Ostuni	Apulia	Italy
11753	Osimo	The Marches	Italy
11754	Orta Nova	Apulia	Italy
11755	Orbassano	Piedmont	Italy
11756	Olbia	Sardinia	Italy
11757	Oderzo	Veneto	Italy
11758	Nuoro	Sardinia	Italy
11759	Novi Ligure	Piedmont	Italy
11760	Novate Milanese	Lombardy	Italy
11761	Novara	Piedmont	Italy
11762	Nova Milanese	Lombardy	Italy
11763	Nola	Campania	Italy
11764	Noicattaro	Apulia	Italy
11765	Noci	Apulia	Italy
11766	Nocera Superiore	Campania	Italy
11767	Nocera Inferiore	Campania	Italy
11768	Nichelino	Piedmont	Italy
11769	Nettuno	Latium	Italy
11770	Nerviano	Lombardy	Italy
11772	Napoli	Campania	Italy
11773	Mugnano di Napoli	Campania	Italy
11775	Monza	Lombardy	Italy
11776	Montichiari	Lombardy	Italy
11777	Montevarchi	Tuscany	Italy
11778	Montesilvano Marina	Abruzzo	Italy
11779	Monterotondo	Latium	Italy
11780	Montemurlo	Tuscany	Italy
11781	Montecchio Maggiore-Alte Ceccato	Veneto	Italy
11782	Montecatini-Terme	Tuscany	Italy
11783	Montebelluna	Veneto	Italy
11784	Monopoli	Apulia	Italy
11785	Monfalcone	Friuli Venezia Giulia	Italy
11786	Mondragone	Campania	Italy
11788	Moncalieri	Piedmont	Italy
11789	Molfetta	Apulia	Italy
11790	Mola di Bari	Apulia	Italy
11791	Mogliano Veneto	Veneto	Italy
11792	Modugno	Apulia	Italy
11793	Modena	Emilia-Romagna	Italy
11794	Mirano	Veneto	Italy
11795	Mirandola	Emilia-Romagna	Italy
11796	Mira Taglio	Veneto	Italy
11797	Minturno	Latium	Italy
11798	Milano	Lombardy	Italy
11799	Mestre	Veneto	Italy
11800	Mesagne	Apulia	Italy
11801	Merano	Trentino-Alto Adige	Italy
11802	Mentana	Latium	Italy
11803	Melzo	Lombardy	Italy
11804	Melito di Napoli	Campania	Italy
11805	Melegnano	Lombardy	Italy
11806	Meda	Lombardy	Italy
11807	Matera	Basilicate	Italy
11808	Massafra	Apulia	Italy
11809	Massa	Tuscany	Italy
11810	Martina Franca	Apulia	Italy
11811	Marino	Latium	Italy
11812	Marina di Carrara	Tuscany	Italy
11813	Marigliano	Campania	Italy
11814	Mariano Comense	Lombardy	Italy
11815	Marcianise	Campania	Italy
11816	Marano di Napoli	Campania	Italy
11817	Mantova	Lombardy	Italy
11818	Manfredonia	Apulia	Italy
11819	Manduria	Apulia	Italy
11820	Malnate	Lombardy	Italy
11821	Magenta	Lombardy	Italy
11822	Maddaloni	Campania	Italy
11823	Macerata	The Marches	Italy
11824	Lugo	Emilia-Romagna	Italy
11825	Lucera	Apulia	Italy
11826	Lucca	Tuscany	Italy
11827	Lodi	Lombardy	Italy
11828	Livorno	Tuscany	Italy
11829	Lissone	Lombardy	Italy
11830	Limbiate	Lombardy	Italy
11831	Lido di Ostia	Latium	Italy
11832	Lido	Veneto	Italy
11833	Legnano	Lombardy	Italy
11834	Legnago	Veneto	Italy
11835	Lecco	Lombardy	Italy
11836	Lecce	Apulia	Italy
11837	Latina	Latium	Italy
11838	La Spezia	Liguria	Italy
11839	LAquila	Abruzzo	Italy
11840	Lanciano	Abruzzo	Italy
11841	Lainate	Lombardy	Italy
11842	Ladispoli	Latium	Italy
11843	Ivrea	Piedmont	Italy
11844	Isernia	Molise	Italy
11845	Ischia Porto	Campania	Italy
11846	Ischia	Campania	Italy
11847	Pallanza-Intra-Suna	Piedmont	Italy
11848	Imperia	Liguria	Italy
11849	Imola	Emilia-Romagna	Italy
11850	Jesi	The Marches	Italy
11851	Guidonia	Latium	Italy
11852	Grumo Nevano	Campania	Italy
11853	Grugliasco	Piedmont	Italy
11854	Grottaglie	Apulia	Italy
11855	Grottaferrata	Latium	Italy
11856	Grosseto	Tuscany	Italy
11857	Gravina in Puglia	Apulia	Italy
11858	Gragnano	Campania	Italy
11859	Gorizia	Friuli Venezia Giulia	Italy
11860	Gorgonzola	Lombardy	Italy
11861	Giussano	Lombardy	Italy
11862	Giulianova	Abruzzo	Italy
11863	Giugliano in Campania	Campania	Italy
11864	Giovinazzo	Apulia	Italy
11865	Gioia del Colle	Apulia	Italy
11866	Ginosa	Apulia	Italy
11867	Ghedi	Lombardy	Italy
11868	Genzano di Roma	Latium	Italy
11869	Genoa	Liguria	Italy
11870	Garbagnate Milanese	Lombardy	Italy
11871	Gallipoli	Apulia	Italy
11872	Gallarate	Lombardy	Italy
11873	Galatina	Apulia	Italy
11874	Gaeta	Latium	Italy
11875	Frosinone	Latium	Italy
11876	Frattaminore	Campania	Italy
11877	Frattamaggiore	Campania	Italy
11878	Frascati	Latium	Italy
11879	Francavilla Fontana	Apulia	Italy
11880	Francavilla al Mare	Abruzzo	Italy
11881	Fossano	Piedmont	Italy
11882	Fornacelle	Tuscany	Italy
11883	Formigine	Emilia-Romagna	Italy
11884	Formia	Latium	Italy
11886	Forio	Campania	Italy
11887	Fondi	Latium	Italy
11888	Follonica	Tuscany	Italy
11889	Foligno	Umbria	Italy
11890	Foggia	Apulia	Italy
11891	Fiumicino-Isola Sacra	Latium	Italy
11892	Florence	Tuscany	Italy
11893	Fiorano	Emilia-Romagna	Italy
11894	Fidenza	Emilia-Romagna	Italy
11895	Ferrara	Emilia-Romagna	Italy
11896	Fermo	The Marches	Italy
11897	Fasano	Apulia	Italy
11898	Fano	The Marches	Italy
11899	Falconara Marittima	The Marches	Italy
11900	Faenza	Emilia-Romagna	Italy
11901	Fabriano	The Marches	Italy
11902	Ercolano	Campania	Italy
11903	Erba	Lombardy	Italy
11904	Empoli	Tuscany	Italy
11905	Eboli	Campania	Italy
11906	Domodossola	Piedmont	Italy
11907	Desio	Lombardy	Italy
11908	Desenzano del Garda	Lombardy	Italy
11909	Dalmine	Lombardy	Italy
11910	Cusano Milanino	Lombardy	Italy
11911	Cuneo	Piedmont	Italy
11912	Cremona	Lombardy	Italy
11913	Crema	Lombardy	Italy
11914	Corsico	Lombardy	Italy
11915	Correggio	Emilia-Romagna	Italy
11916	Cornaredo	Lombardy	Italy
11917	Cormano	Lombardy	Italy
11918	Cordenons	Friuli Venezia Giulia	Italy
11919	Corato	Apulia	Italy
11920	Copertino	Apulia	Italy
11921	Conversano	Apulia	Italy
11922	Conegliano	Veneto	Italy
11923	Como	Lombardy	Italy
11924	Cologno Monzese	Lombardy	Italy
11925	Collegno	Piedmont	Italy
11926	Colleferro	Latium	Italy
11927	Colle di Val dElsa	Tuscany	Italy
11928	Civitavecchia	Latium	Italy
11930	Cisterna di Latina	Latium	Italy
11932	Cinisello Balsamo	Lombardy	Italy
11933	Ciampino	Latium	Italy
11934	Chivasso	Piedmont	Italy
11935	Chioggia	Veneto	Italy
11936	Chieti	Abruzzo	Italy
11937	Chieri	Piedmont	Italy
11938	Chiavari	Liguria	Italy
11939	Chiari	Lombardy	Italy
11940	Cesenatico	Emilia-Romagna	Italy
11941	Cesena	Emilia-Romagna	Italy
11942	Cesano Maderno	Lombardy	Italy
11943	Cervia	Emilia-Romagna	Italy
11944	Cerveteri	Latium	Italy
11945	Cernusco sul Naviglio	Lombardy	Italy
11946	Cerignola	Apulia	Italy
11947	Cercola	Campania	Italy
11948	Cento	Emilia-Romagna	Italy
11949	Ceglie Messapica	Apulia	Italy
11950	Cecina	Tuscany	Italy
11952	Cattolica	Emilia-Romagna	Italy
11953	Castiglione delle Stiviere	Lombardy	Italy
11954	Castel Volturno	Campania	Italy
11955	Castel Maggiore	Emilia-Romagna	Italy
11956	Castellammare di Stabia	Campania	Italy
11957	Castelfranco Veneto	Veneto	Italy
11958	Castelfranco Emilia	Emilia-Romagna	Italy
11959	Cassino	Latium	Italy
11960	Cassano dAdda	Lombardy	Italy
11961	Casoria	Campania	Italy
11962	Caserta	Campania	Italy
11963	Cascina	Tuscany	Italy
11964	Casamassima	Apulia	Italy
11965	Casalnuovo di Napoli	Campania	Italy
11966	Casale Monferrato	Piedmont	Italy
11967	Casalecchio di Reno	Emilia-Romagna	Italy
11968	Casal di Principe	Campania	Italy
11969	Carrara	Tuscany	Italy
11970	Carpi Centro	Emilia-Romagna	Italy
11971	Carmagnola	Piedmont	Italy
11972	Cardito	Campania	Italy
11973	Carate Brianza	Lombardy	Italy
11974	Capua	Campania	Italy
11975	Capannori	Tuscany	Italy
11977	Canosa di Puglia	Apulia	Italy
11978	Campobasso	Molise	Italy
11979	Campi Bisenzio	Tuscany	Italy
11980	Camaiore	Tuscany	Italy
11981	Caivano	Campania	Italy
11982	Busto Arsizio	Lombardy	Italy
11983	Bussolengo	Veneto	Italy
11984	Brusciano	Campania	Italy
11985	Brugherio	Lombardy	Italy
11986	Brindisi	Apulia	Italy
11987	Bresso	Lombardy	Italy
11988	Bressanone	Trentino-Alto Adige	Italy
11989	Brescia	Lombardy	Italy
11990	Bra	Piedmont	Italy
11991	Bovisio-Masciago	Lombardy	Italy
11992	Boscoreale	Campania	Italy
11993	Borgomanero	Piedmont	Italy
11994	Bolzano	Trentino-Alto Adige	Italy
11995	Bologna	Emilia-Romagna	Italy
11996	Bollate	Lombardy	Italy
11997	Bitonto	Apulia	Italy
11998	Bisceglie	Apulia	Italy
11999	Biella	Piedmont	Italy
12000	Bergamo	Lombardy	Italy
12001	Benevento	Campania	Italy
12002	Belluno	Veneto	Italy
12003	Battipaglia	Campania	Italy
12004	Bastia umbra	Umbria	Italy
12005	Bassano del Grappa	Veneto	Italy
12006	Barletta	Apulia	Italy
12007	Bari	Apulia	Italy
12008	Bareggio	Lombardy	Italy
12009	Bagnoli	Campania	Italy
12010	Bacoli	Campania	Italy
12011	Avezzano	Abruzzo	Italy
12012	Aversa	Campania	Italy
12013	Avellino	Campania	Italy
12014	Asti	Piedmont	Italy
12015	Ascoli Piceno	The Marches	Italy
12016	Arzignano	Veneto	Italy
12017	Arzano	Campania	Italy
12018	Ariccia	Latium	Italy
12019	Arezzo	Tuscany	Italy
12020	Arese	Lombardy	Italy
12021	Ardea	Latium	Italy
12022	Arcore	Lombardy	Italy
12023	Aprilia	Latium	Italy
12024	Aosta	Aosta Valley	Italy
12025	Anzio	Latium	Italy
12026	Angri	Campania	Italy
12027	Andria	Apulia	Italy
12028	Ancona	The Marches	Italy
12029	Altamura	Apulia	Italy
12030	Alpignano	Piedmont	Italy
12031	Alghero	Sardinia	Italy
12032	Alessandria	Piedmont	Italy
12033	Albignasego	Veneto	Italy
12034	Albenga	Liguria	Italy
12035	Albano Laziale	Latium	Italy
12036	Alba	Piedmont	Italy
12037	Agropoli	Campania	Italy
12038	Afragola	Campania	Italy
12039	Adelfia	Apulia	Italy
12040	Acqui Terme	Piedmont	Italy
12041	Acquaviva delle Fonti	Apulia	Italy
12042	Acilia-Castel Fusano-Ostia Antica	Latium	Italy
12043	Acerra	Campania	Italy
12044	Abbiategrasso	Lombardy	Italy
12045	Abano Terme	Veneto	Italy
12046	Spinea-Orgnano	Veneto	Italy
12047	Verbania	Piedmont	Italy
12048	Lumezzane	Lombardy	Italy
12049	Guidonia Montecelio	Latium	Italy
12050	Lamezia Terme	Calabria	Italy
12051	Caronno Pertusella	Lombardy	Italy
12052	Cassano Magnago	Lombardy	Italy
12053	San Felice A Cancello	Campania	Italy
12054	San Nicola la Strada	Campania	Italy
12055	Quarto	Campania	Italy
12056	Orta di Atella	Campania	Italy
12057	Casavatore	Campania	Italy
12058	Volla	Campania	Italy
12059	Gravina di Catania	Sicily	Italy
12060	Cesano Boscone	Lombardy	Italy
12061	Tor Lupara	Latium	Italy
12062	Torvaianica	Latium	Italy
12063	Bellaria-Igea Marina	Emilia-Romagna	Italy
12064	Villanova	Latium	Italy
12065	Marina di Ardea-Tor San Lorenzo	Latium	Italy
12066	San Paolo	Apulia	Italy
12067	Monterusciello	Campania	Italy
12068	Romano Banco	Lombardy	Italy
12069	Casa Santa	Sicily	Italy
12070	Arpino	Campania	Italy
12071	Paolo VI	Apulia	Italy
12072	Corigliano Scalo	Calabria	Italy
12073	Saint Helier	St Helier	Jersey
12074	Spanish Town	Saint Catherine	Jamaica
12075	Savanna-la-Mar	Westmoreland	Jamaica
12076	Portmore	Saint Catherine	Jamaica
12077	Old Harbour	Saint Catherine	Jamaica
12078	New Kingston	Saint Andrew	Jamaica
12079	Montego Bay	Saint James	Jamaica
12080	May Pen	Clarendon	Jamaica
12081	Mandeville	Manchester	Jamaica
12082	Linstead	Saint Catherine	Jamaica
12083	Kingston	Kingston	Jamaica
12084	Half Way Tree	Saint Andrew	Jamaica
12085	Wadi as Sir	Amman	Jordan
12086	Umm as Summaq	Amman	Jordan
12087	Sa?ab	Amman	Jordan
12088	Madaba	Madaba	Jordan
12090	Kurayyimah	Irbid	Jordan
12091	Judita	Irbid	Jordan
12092	Jarash	Jerash	Jordan
12094	Irbid	Irbid	Jordan
12095	Zarqa	Zarqa	Jordan
12096	Aydun	Irbid	Jordan
12097	At Tafilah	Tafielah	Jordan
12098	As Salt	Balqa	Jordan
12099	Safi	Karak	Jordan
12100	Ar Ramtha	Irbid	Jordan
12102	Amman	Amman	Jordan
12103	Al Quwaysimah	Amman	Jordan
12104	Mafraq	Mafraq	Jordan
12106	Al Jubayhah	Amman	Jordan
12107	Aqaba	Aqaba	Jordan
12109	Karak City	Karak	Jordan
12110	Russeifa	Zarqa	Jordan
12111	Shingu	Wakayama	Japan
12112	Atsugi	Kanagawa	Japan
12113	Akashi	Hyogo	Japan
12114	Zushi	Kanagawa	Japan
12115	Zama	Kanagawa	Japan
12116	Yuza	Yamagata	Japan
12117	Gero	Gifu	Japan
12118	Yukuhashi	Fukuoka	Japan
12119	Yuki	Ibaraki	Japan
12120	Yugawara	Kanagawa	Japan
12121	Yoshikawa	Saitama	Japan
12122	Yoshii	Gunma	Japan
12123	Yoshida-kasugacho	Niigata	Japan
12124	Yorii	Saitama	Japan
12125	Yono	Saitama	Japan
12126	Yonago	Tottori	Japan
12127	Yokosuka	Kanagawa	Japan
12128	Yokohama	Kanagawa	Japan
12129	Yokkaichi	Mie	Japan
12130	Youkaichi	Shiga Prefecture	Japan
12131	Yawata	Kyoto	Japan
12132	Yatsushiro	Kumamoto	Japan
12133	Yatsuomachi-higashikumisaka	Toyama	Japan
12134	Yasugicho	Shimane	Japan
12135	Yashiro	Hyogo	Japan
12136	Yashio-shi	Saitama	Japan
12137	Yao	Osaka	Japan
12138	Yanai	Yamaguchi	Japan
12139	Yanagawa	Fukuoka	Japan
12140	Yamazakicho-nakabirose	Hyogo	Japan
12141	Yamaguchi	Yamaguchi	Japan
12142	Yamaga	Kumamoto	Japan
12143	Yaizu	Shizuoka	Japan
12144	Yaita	Tochigi	Japan
12145	Wakimachi	Tokushima	Japan
12146	Utsunomiya	Tochigi	Japan
12147	Uto	Kumamoto	Japan
12148	Usuki	Oita	Japan
12149	Ushibuka	Kumamoto	Japan
12150	Ureshinomachi-shimojuku	Saga Prefecture	Japan
12151	Urayasu	Tokyo	Japan
12152	Uozu	Toyama	Japan
12153	Umi	Fukuoka	Japan
12154	Ujiie	Tochigi	Japan
12155	Uji	Kyoto	Japan
12156	Uenohara	Yamanashi	Japan
12157	Ueno-ebisumachi	Mie	Japan
12158	Ueki	Kumamoto	Japan
12159	Ueda	Nagano	Japan
12160	Ube	Yamaguchi	Japan
12161	Tsuyama	Okayama	Japan
12162	Tsushima	Aichi	Japan
12163	Tsurusaki	Oita	Japan
12164	Tsuruoka	Yamagata	Japan
12165	Tsurugi-asahimachi	Ishikawa	Japan
12166	Tsuruga	Fukui	Japan
12167	Tsuma	Miyazaki	Japan
12168	Tsukumiura	Oita	Japan
12169	Tsukawaki	Oita	Japan
12170	Tsubata	Ishikawa	Japan
12171	Tsubame	Niigata	Japan
12172	Tsu	Mie	Japan
12173	Toyota	Aichi	Japan
12174	Toyoshina	Nagano	Japan
12175	Toyooka	Hyogo	Japan
12176	Toyonaka	Osaka	Japan
12177	Toyokawa	Aichi	Japan
12178	Toyohashi	Aichi	Japan
12179	Toyohama	Aichi	Japan
12180	Toyama	Toyama	Japan
12181	Tottori	Tottori	Japan
12182	Tosu	Saga Prefecture	Japan
12183	Tonosho	Kagawa	Japan
12184	Tondabayashicho	Osaka	Japan
12185	Tomioka	Gunma	Japan
12186	Tomigusuku	Okinawa	Japan
12187	Tokyo	Tokyo	Japan
12188	Tokuyama	Yamaguchi	Japan
12189	Tokushima	Tokushima	Japan
12190	Tokorozawa	Saitama	Japan
12191	Tokoname	Aichi	Japan
12192	Toki	Gifu	Japan
12193	Tokamachi	Niigata	Japan
12194	Togitsu	Nagasaki	Japan
12195	Tochio-honcho	Niigata	Japan
12196	Tochigi	Tochigi	Japan
12197	Toba	Mie	Japan
12198	Tenri	Nara	Japan
12199	Tenno	Akita	Japan
12200	Tawaramoto	Nara	Japan
12201	Tatsuno	Nagano	Japan
12202	Tatsunocho-tominaga	Hyogo	Japan
12203	Tateyama	Chiba	Japan
12204	Tatebayashi	Gunma	Japan
12205	Tarumizu	Kagoshima	Japan
12206	Tarui	Gifu	Japan
12207	Tanushimarumachi-toyoki	Fukuoka	Japan
12208	Tanuma	Tochigi	Japan
12209	Nishi-Tokyo-shi	Tokyo	Japan
12210	Tanashicho	Tokyo	Japan
12211	Tanabe	Kyoto	Japan
12212	Tanabe	Wakayama	Japan
12213	Tamano	Okayama	Japan
12214	Tamana	Kumamoto	Japan
12215	Tamamura	Gunma	Japan
12216	Taketoyo	Aichi	Japan
12217	Takeocho-takeo	Saga Prefecture	Japan
12218	Takehara	Hiroshima	Japan
12219	Takefu	Fukui	Japan
12220	Takedamachi	Oita	Japan
12221	Takayama	Gifu	Japan
12222	Takatsuki	Osaka	Japan
12223	Takasaki	Gunma	Japan
12224	Takarazuka	Hyogo	Japan
12225	Takaoka	Toyama	Japan
12226	Takanabe	Miyazaki	Japan
12227	Takamatsu	Kagawa	Japan
12228	Takaishi	Osaka	Japan
12229	Takahashi	Okayama	Japan
12230	Takahama	Aichi	Japan
12231	Bungo-Takada-shi	Oita	Japan
12232	Tajimi	Gifu	Japan
12233	Tahara	Aichi	Japan
12234	Tagawa	Fukuoka	Japan
12235	Tadotsu	Kagawa	Japan
12236	Suzuka	Mie	Japan
12237	Suzaka	Nagano	Japan
12238	Suwa	Nagano	Japan
12239	Susaki	Kochi	Japan
12240	Sumoto	Hyogo	Japan
12241	Sukumo	Kochi	Japan
12242	Suita	Osaka	Japan
12243	Suibara	Niigata	Japan
12244	Sugito	Saitama	Japan
12245	Sueyoshicho-ninokata	Kagoshima	Japan
12246	Soka	Saitama	Japan
12247	Soja	Okayama	Japan
12248	Sobue	Aichi	Japan
12249	Shobu	Saitama	Japan
12250	Shobara	Hiroshima	Japan
12251	Shizuoka	Shizuoka	Japan
12252	Shirone	Niigata	Japan
12253	Shiraoka	Saitama	Japan
12254	Shirahamacho-usazakiminami	Hyogo	Japan
12255	Shiozawa	Niigata	Japan
12256	Shiojiri	Nagano	Japan
12257	Shinshiro	Aichi	Japan
12259	Shingu	Fukuoka	Japan
12260	Shimonoseki	Yamaguchi	Japan
12261	Shimodate	Ibaraki	Japan
12262	Shimoda	Shizuoka	Japan
12263	Minato	Wakayama	Japan
12264	Nishishinminato	Toyama	Japan
12265	Shimada	Shizuoka	Japan
12266	Shimabara	Nagasaki	Japan
12267	Shiki	Saitama	Japan
12268	Shido	Kagawa	Japan
12269	Shibushi	Kagoshima	Japan
12270	Shibukawa	Gunma	Japan
12271	Shibata	Niigata	Japan
12272	Seto	Aichi	Japan
12273	Setakamachi-takayanagi	Fukuoka	Japan
12274	Satsumasendai	Kagoshima	Japan
12275	Satte	Saitama	Japan
12276	Sasebo	Nagasaki	Japan
12277	Sasayama	Hyogo	Japan
12278	Sasaguri	Fukuoka	Japan
12279	Sano	Tochigi	Japan
12280	Sanjo	Niigata	Japan
12281	Sandacho	Hyogo	Japan
12282	Sakurai	Nara	Japan
12283	Saku	Nagano	Japan
12284	Sakata	Yamagata	Japan
12285	Sakaiminato	Shimane	Japan
12286	Sakaidecho	Kagawa	Japan
12287	Sakai-nakajima	Gunma	Japan
12288	Sakai	Ibaraki	Japan
12289	Sakai	Osaka	Japan
12290	Sakado	Saitama	Japan
12291	Saiki	Oita	Japan
12292	Sagara	Shizuoka	Japan
12293	Saga	Saga Prefecture	Japan
12294	Sabae	Fukui	Japan
12295	Ryuo	Yamanashi	Japan
12296	Ryotsu-minato	Niigata	Japan
12297	Ozu	Kumamoto	Japan
12298	Oyama	Tochigi	Japan
12299	Oyama	Shizuoka	Japan
12300	Owase	Mie	Japan
12301	Otsuki	Yamanashi	Japan
12302	Otsu	Shiga Prefecture	Japan
12303	Otake	Yamaguchi	Japan
12304	Ota	Gunma	Japan
12305	Osaka	Osaka	Japan
12306	Onomichi	Hiroshima	Japan
12307	Onoda	Yamaguchi	Japan
12308	Ono	Fukui	Japan
12309	Ono	Hyogo	Japan
12310	Ono-hara	Hiroshima	Japan
12311	Omuta	Fukuoka	Japan
12312	Omura	Nagasaki	Japan
12313	Ome	Tokyo	Japan
12314	Omamacho-omama	Gunma	Japan
12315	Omachi	Nagano	Japan
12316	Okuchi-shinohara	Kagoshima	Japan
12317	Okegawa	Saitama	Japan
12318	Okazaki	Aichi	Japan
12319	Okayama	Okayama	Japan
12320	Okaya	Nagano	Japan
12321	Okawa	Saga Prefecture	Japan
12322	Ojiya	Niigata	Japan
12323	Oita	Oita	Japan
12324	Oiso	Kanagawa	Japan
12325	Oi	Saitama	Japan
12326	Ogori-shimogo	Yamaguchi	Japan
12327	Ogawa	Saitama	Japan
12328	Ogaki	Gifu	Japan
12329	Odawara	Kanagawa	Japan
12330	Odacho-oda	Shimane	Japan
12331	Obu	Aichi	Japan
12332	Obita	Nagasaki	Japan
12333	Obama	Fukui	Japan
12334	Nyuzen	Toyama	Japan
12335	Numazu	Shizuoka	Japan
12336	Numata	Gunma	Japan
12337	Nonoichi	Ishikawa	Japan
12338	Nogata	Fukuoka	Japan
12339	Noda	Chiba	Japan
12340	Nobeoka	Miyazaki	Japan
12341	Nishiwaki	Hyogo	Japan
12342	Nishio	Aichi	Japan
12343	Nishinoomote	Kagoshima	Japan
12344	Nishinomiya-hama	Hyogo	Japan
12345	Nirasaki	Yamanashi	Japan
12346	Ninomiya	Kanagawa	Japan
12347	Nikko	Tochigi	Japan
12348	Niitsu-honcho	Niigata	Japan
12349	Niimi	Okayama	Japan
12350	Niihama	Ehime	Japan
12351	Niigata	Niigata	Japan
12352	Nichinan	Miyazaki	Japan
12353	Naze	Kagoshima	Japan
12354	Narutocho-mitsuishi	Tokushima	Japan
12355	Nara-shi	Nara	Japan
12356	Nanao	Ishikawa	Japan
12357	Namerikawa	Toyama	Japan
12358	Nakatsugawa	Gifu	Japan
12359	Nakatsu	Fukuoka	Japan
12360	Nakanojomachi	Gunma	Japan
12361	Nakano	Nagano	Japan
12362	Nakamura	Kochi	Japan
12363	Nakama	Fukuoka	Japan
12364	Naha	Okinawa	Japan
12365	Nagoya	Aichi	Japan
12366	Nago	Okinawa	Japan
12367	Nagasaki	Nagasaki	Japan
12368	Nagareyama	Chiba	Japan
12369	Nagaoka	Niigata	Japan
12370	Nagano	Nagano	Japan
12371	Nagahama	Shiga Prefecture	Japan
12372	Nabari	Mie	Japan
12373	Musashino	Tokyo	Japan
12374	Muroto-misakicho	Kochi	Japan
12375	Muramatsu	Niigata	Japan
12376	Murakami	Niigata	Japan
12377	Muko	Kyoto	Japan
12378	Muikamachi	Niigata	Japan
12379	Morohongo	Saitama	Japan
12380	Moriyama	Shiga Prefecture	Japan
12381	Moriguchi	Osaka	Japan
12382	Mori	Shizuoka	Japan
12383	Mizunami	Gifu	Japan
12384	Miyoshi	Hiroshima	Japan
12385	Miyazu	Kyoto	Japan
12386	Miyazaki	Miyazaki	Japan
12387	Miyakonojo	Miyazaki	Japan
12388	Miyata	Fukuoka	Japan
12389	Mitsuke	Niigata	Japan
12390	Mitsukaido	Ibaraki	Japan
12391	Mitake	Gifu	Japan
12392	Mitaka-shi	Tokyo	Japan
12393	Mishima	Shizuoka	Japan
12394	Mino	Osaka	Japan
12395	Mino	Gifu	Japan
12396	Minamirinkan	Kanagawa	Japan
12397	Minamata	Kumamoto	Japan
12398	Minakuchicho-matoba	Shiga Prefecture	Japan
12399	Mikuni	Fukui	Japan
12400	Miki	Hyogo	Japan
12401	Mihara	Hiroshima	Japan
12402	Mibu	Tochigi	Japan
12403	Menuma	Saitama	Japan
12404	Matsuto	Ishikawa	Japan
12405	Matsumoto	Nagano	Japan
12406	Matsue	Shimane	Japan
12407	Matsudo	Chiba	Japan
12408	Matsubase	Kumamoto	Japan
12409	Matsubara	Osaka	Japan
12410	Masuda	Shimane	Japan
12411	Maruoka	Fukui	Japan
12412	Kamimaruko	Nagano	Japan
12413	Marugame	Kagawa	Japan
12414	Makurazaki	Kagoshima	Japan
12415	Maki	Niigata	Japan
12416	Maizuru	Kyoto	Japan
12417	Maebashi	Gunma	Japan
12418	Maebaru-chuo	Fukuoka	Japan
12419	Machida	Tokyo	Japan
12420	Kyoto	Kyoto	Japan
12421	Kushikino	Kagoshima	Japan
12422	Kusatsu	Shiga Prefecture	Japan
12423	Kurume	Fukuoka	Japan
12424	Kuroda	Aichi	Japan
12425	Kurihashi	Saitama	Japan
12426	Kure	Hiroshima	Japan
12427	Kurayoshi	Tottori	Japan
12428	Kurashiki	Okayama	Japan
12429	Kumamoto	Kumamoto	Japan
12430	Kumagaya	Saitama	Japan
12431	Kukichuo	Saitama	Japan
12432	Kudamatsu	Yamaguchi	Japan
12433	Kozakai-cho	Aichi	Japan
12434	Koshigaya	Saitama	Japan
12435	Kosai-shi	Shizuoka	Japan
12436	Konosu	Saitama	Japan
12437	Konan	Aichi	Japan
12438	Komoro	Nagano	Japan
12439	Komono	Mie	Japan
12440	Komatsushimacho	Tokushima	Japan
12441	Komatsu	Ishikawa	Japan
12442	Komaki	Aichi	Japan
12443	Kokubunji	Tokyo	Japan
12444	Kokubu-matsuki	Kagoshima	Japan
12445	Koga	Ibaraki	Japan
12446	Koga	Fukuoka	Japan
12447	Kofu	Yamanashi	Japan
12448	Kodamacho-kodamaminami	Saitama	Japan
12449	Kochi	Kochi	Japan
12450	Kobe	Hyogo	Japan
12451	Kobayashi	Miyazaki	Japan
12452	Kitsuki	Oita	Japan
12453	Kitakyushu	Fukuoka	Japan
12454	Kitakata	Fukushima	Japan
12455	Kitahama	Shiga Prefecture	Japan
12456	Kishiwada	Osaka	Japan
12457	Kisarazu	Chiba	Japan
12458	Kisai	Saitama	Japan
12459	Kiryu	Gunma	Japan
12460	Kikuchi	Kumamoto	Japan
12461	Kazo	Saitama	Japan
12462	Kawasaki	Kanagawa	Japan
12463	Kawasaki	Fukuoka	Japan
12464	Kawanishi	Hyogo	Japan
12465	Kawaguchi	Saitama	Japan
12466	Kawagoe	Saitama	Japan
12467	Katsuyama	Fukui	Japan
12468	Kasukabe	Saitama	Japan
12469	Kasugai	Aichi	Japan
12470	Kashiwazaki	Niigata	Japan
12471	Kashiwa	Chiba	Japan
12472	Kashima	Saga Prefecture	Japan
12473	Kashihara-shi	Nara	Japan
12474	Kashihara	Osaka	Japan
12475	Kaseda-shirakame	Kagoshima	Japan
12476	Kasaoka	Okayama	Japan
12477	Kasamatsucho	Gifu	Japan
12478	Kariya	Aichi	Japan
12479	Karatsu	Saga Prefecture	Japan
12480	Kanzakimachi-kanzaki	Saga Prefecture	Japan
12481	Kanuma	Tochigi	Japan
12482	Kanoya	Kagoshima	Japan
12484	Kannabecho-yahiro	Hiroshima	Japan
12485	Kanie	Aichi	Japan
12486	Kanekomachi	Gunma	Japan
12487	Kanda	Fukuoka	Japan
12488	Kanazawa	Ishikawa	Japan
12489	Kanaya	Shizuoka	Japan
12490	Kamojimacho-jogejima	Tokushima	Japan
12491	Kamogatacho-kamogata	Okayama	Japan
12492	Kamo	Niigata	Japan
12493	Kamirenjaku	Tokyo	Japan
12494	Kaminokawa	Tochigi	Japan
12495	Kamiichi	Toyama	Japan
12496	Kameyama	Mie	Japan
12497	Kameoka	Kyoto	Japan
12498	Kameda-honcho	Niigata	Japan
12499	Kamakura	Kanagawa	Japan
12500	Kakogawacho-honmachi	Hyogo	Japan
12501	Kakegawa	Shizuoka	Japan
12502	Kakamigahara	Gifu	Japan
12503	Kashima-shi	Ibaraki	Japan
12504	Kajiki	Kagoshima	Japan
12505	Kaizuka	Osaka	Japan
12506	Kainan	Wakayama	Japan
12507	Kagoshima	Kagoshima	Japan
12508	Kadoma	Osaka	Japan
12509	Izumo	Shimane	Japan
12510	Izumiotsu	Osaka	Japan
12511	Izumi	Osaka	Japan
12512	Izumi	Kagoshima	Japan
12513	Iwatsuki	Saitama	Japan
12514	Iwata	Shizuoka	Japan
12515	Iwakura	Aichi	Japan
12516	Iwakuni	Yamaguchi	Japan
12517	Iwai	Ibaraki	Japan
12518	Iwade	Wakayama	Japan
12519	Itsukaichi	Tokyo	Japan
12520	Itoman	Okinawa	Japan
12521	Itoigawa	Niigata	Japan
12522	Ito	Shizuoka	Japan
12523	Itami	Hyogo	Japan
12524	Ishiki	Aichi	Japan
12525	Ishikawa	Okinawa	Japan
12526	Ishii	Tokushima	Japan
12527	Ishige	Ibaraki	Japan
12528	Ishigaki	Okinawa	Japan
12529	Isesaki	Gunma	Japan
12530	Isehara	Kanagawa	Japan
12531	Ise	Mie	Japan
12532	Isawa	Yamanashi	Japan
12533	Isahaya	Nagasaki	Japan
12534	Inuyama	Gifu	Japan
12535	Ino	Kochi	Japan
12536	Innoshima	Hiroshima	Japan
12537	Inazawa	Aichi	Japan
12538	Ina	Nagano	Japan
12539	Imaricho-ko	Saga Prefecture	Japan
12540	Imaichi	Tochigi	Japan
12541	Ikoma	Nara	Japan
12542	Ikeda	Osaka	Japan
12543	Ikedacho	Tokushima	Japan
12544	Ijuin	Kagoshima	Japan
12545	Iizuka	Fukuoka	Japan
12546	Iiyama	Nagano	Japan
12547	Iida	Nagano	Japan
12548	Ichinomiya	Aichi	Japan
12549	Ibusuki	Kagoshima	Japan
12550	Ibaraki	Osaka	Japan
12551	Ibara	Okayama	Japan
12552	Hotaka	Nagano	Japan
12553	Honjo	Saitama	Japan
12554	Hondo	Kumamoto	Japan
12555	Hofu	Yamaguchi	Japan
12556	Hitoyoshi	Kumamoto	Japan
12557	Hita	Oita	Japan
12558	Hisai-motomachi	Mie	Japan
12559	Hiroshima	Hiroshima	Japan
12560	Hiratsuka	Kanagawa	Japan
12561	Hiratacho	Shimane	Japan
12562	Hirara	Okinawa	Japan
12563	Hirakata	Osaka	Japan
12564	Hirado	Nagasaki	Japan
12565	Hino	Tokyo	Japan
12566	Hino	Shiga Prefecture	Japan
12567	Himimachi	Toyama	Japan
12568	Himeji	Hyogo	Japan
12569	Hikone	Shiga Prefecture	Japan
12570	Hiji	Oita	Japan
12571	Hekinan	Aichi	Japan
12572	Hayama	Kanagawa	Japan
12573	Hatsukaichi	Hiroshima	Japan
12574	Hatogaya-honcho	Saitama	Japan
12575	Hashimoto	Wakayama	Japan
12576	Hanyu	Saitama	Japan
12577	Hanno	Saitama	Japan
12578	Handa	Aichi	Japan
12579	Hamanoichi	Kagoshima	Japan
12580	Hamamatsu	Shizuoka	Japan
12581	Hamakita	Shizuoka	Japan
12582	Hamada	Shimane	Japan
12583	Hakui	Ishikawa	Japan
12584	Haibara-akanedai	Nara	Japan
12585	Hagi	Yamaguchi	Japan
12586	Katsuren-haebaru	Okinawa	Japan
12587	Hadano	Kanagawa	Japan
12588	Hachioji	Tokyo	Japan
12589	Omihachiman	Shiga Prefecture	Japan
12590	Gyoda	Saitama	Japan
12591	Gushikawa	Okinawa	Japan
12592	Gotsucho	Shimane	Japan
12593	Gotenba	Shizuoka	Japan
12594	Gosen	Niigata	Japan
12595	Gose	Nara	Japan
12596	Gojo	Nara	Japan
12597	Godo	Gifu	Japan
12598	Gobo	Wakayama	Japan
12599	Ginowan	Okinawa	Japan
12600	Gifu-shi	Gifu	Japan
12601	Gamagori	Aichi	Japan
12602	Futtsu	Chiba	Japan
12603	Honcho	Chiba	Japan
12604	Fukuyama	Hiroshima	Japan
12605	Fukuroi	Shizuoka	Japan
12606	Fukura	Hyogo	Japan
12607	Fukuoka	Fukuoka	Japan
12608	Fukumitsu	Toyama	Japan
12609	Nishifukuma	Fukuoka	Japan
12610	Fukui-shi	Fukui	Japan
12611	Fukuecho	Nagasaki	Japan
12612	Fukuchiyama	Kyoto	Japan
12613	Fukiage-fujimi	Saitama	Japan
12614	Fukayacho	Saitama	Japan
12615	Fujisawa	Kanagawa	Japan
12616	Fujioka	Tochigi	Japan
12617	Fujioka	Gunma	Japan
12618	Fujinomiya	Shizuoka	Japan
12619	Fujieda	Shizuoka	Japan
12620	Fuji	Shizuoka	Japan
12621	Fuchucho	Hiroshima	Japan
12622	Enzan	Yamanashi	Japan
12623	Daitocho	Osaka	Japan
12624	Chofugaoka	Tokyo	Japan
12625	Chiryu	Aichi	Japan
12626	Chino	Nagano	Japan
12627	Chikushino-shi	Fukuoka	Japan
12628	Chigasaki	Kanagawa	Japan
12629	Chichibu	Saitama	Japan
12630	Chatan	Okinawa	Japan
12631	Beppu	Oita	Japan
12632	Ayabe	Kyoto	Japan
12633	Atami	Shizuoka	Japan
12634	Ashiya	Hyogo	Japan
12635	Ashikaga	Tochigi	Japan
12636	Arai	Niigata	Japan
12637	Annaka	Gunma	Japan
12638	Anjo	Aichi	Japan
12639	Anan	Tokushima	Japan
12640	Amagi	Fukuoka	Japan
12641	Amagasaki	Hyogo	Japan
12642	Akune	Kagoshima	Japan
12643	Kariya	Hyogo	Japan
12644	Aki	Kochi	Japan
12645	Aioi	Hyogo	Japan
12646	Ageoshimo	Saitama	Japan
12647	Okinawa	Okinawa	Japan
12648	Kushima	Miyazaki	Japan
12649	Hikari	Yamaguchi	Japan
12650	Nagato	Yamaguchi	Japan
12651	Hasuda	Saitama	Japan
12652	Kamifukuoka	Saitama	Japan
12653	Sayama	Saitama	Japan
12654	Fussa	Tokyo	Japan
12655	Asaka	Saitama	Japan
12656	Wako	Saitama	Japan
12657	Shimotoda	Saitama	Japan
12658	Kimitsu	Chiba	Japan
12659	Miura	Kanagawa	Japan
12660	Wakayama	Wakayama	Japan
12661	Iyo	Ehime	Japan
12662	Uwajima	Ehime	Japan
12663	Saijo	Ehime	Japan
12664	Ozu	Ehime	Japan
12665	Matsuyama	Ehime	Japan
12666	Masaki-cho	Ehime	Japan
12667	Kawanoecho	Ehime	Japan
12668	Hojo	Ehime	Japan
12669	Yuzawa	Akita	Japan
12670	Yotsukaido	Chiba	Japan
12671	Yonezawa	Yamagata	Japan
12672	Yokotemachi	Akita	Japan
12673	Yokaichiba	Chiba	Japan
12674	Yanagawamachi-saiwaicho	Fukushima	Japan
12675	Yamoto	Miyagi	Japan
12676	Yamagata	Yamagata	Japan
12677	Yamada	Iwate	Japan
12678	Yachimata	Chiba	Japan
12679	Watari	Miyagi	Japan
12680	Wakuya	Miyagi	Japan
12681	Ushiku	Ibaraki	Japan
12682	Tsukuba	Ibaraki	Japan
12683	Toride	Ibaraki	Japan
12684	Tono	Iwate	Japan
12685	Tomobe	Ibaraki	Japan
12686	Tomiya	Miyagi	Japan
12687	Togane	Chiba	Japan
12688	Tendo	Yamagata	Japan
12689	Takahata	Yamagata	Japan
12690	Takahagi	Ibaraki	Japan
12691	Sukagawa	Fukushima	Japan
12692	Shizukuishi	Iwate	Japan
12693	Shisui	Chiba	Japan
12694	Shiroishi	Miyagi	Japan
12695	Shiroi	Chiba	Japan
12696	Shiogama	Miyagi	Japan
12697	Shinjo	Yamagata	Japan
12698	Sendai	Miyagi	Japan
12699	Sawara	Chiba	Japan
12700	Sakura	Chiba	Japan
12701	Sagae	Yamagata	Japan
12702	Ryugasaki	Ibaraki	Japan
12703	Rifu	Miyagi	Japan
12704	Otsuchi	Iwate	Japan
12705	Otawara	Tochigi	Japan
12706	Omiya	Ibaraki	Japan
12707	Omigawa	Chiba	Japan
12708	Omagari	Akita	Japan
12709	Okunoya	Ibaraki	Japan
12710	Okawara	Miyagi	Japan
12711	Ohara	Chiba	Japan
12712	Ofunato	Iwate	Japan
12713	Obanazawa	Yamagata	Japan
12714	Oarai	Ibaraki	Japan
12715	Oami	Chiba	Japan
12716	Nihommatsu	Fukushima	Japan
12717	Naruto	Chiba	Japan
12718	Narita	Chiba	Japan
12719	Namie	Fukushima	Japan
12720	Naka	Ibaraki	Japan
12721	Nagai	Yamagata	Japan
12722	Motomiya	Fukushima	Japan
12723	Motegi	Tochigi	Japan
12724	Moriya	Ibaraki	Japan
12725	Morioka	Iwate	Japan
12726	Mooka	Tochigi	Japan
12727	Mobara	Chiba	Japan
12728	Mizusawa	Iwate	Japan
12729	Miyako	Iwate	Japan
12730	Mito	Ibaraki	Japan
12731	Miharu	Fukushima	Japan
12732	Matsushima	Miyagi	Japan
12733	Mashiko	Tochigi	Japan
12734	Marumori	Miyagi	Japan
12735	Makabe	Ibaraki	Japan
12736	Kuroiso	Tochigi	Japan
12737	Koriyama	Fukushima	Japan
12738	Kogota	Miyagi	Japan
12739	Kitakami	Iwate	Japan
12740	Kitaibaraki	Ibaraki	Japan
12741	Kamogawa	Chiba	Japan
12742	Katsuura	Chiba	Japan
12743	Katsuta	Ibaraki	Japan
12744	Katori-shi	Chiba	Japan
12745	Kasama	Ibaraki	Japan
12746	Karasuyama	Tochigi	Japan
12747	Kaminoyama	Yamagata	Japan
12748	Kamaishi	Iwate	Japan
12749	Kakuda	Miyagi	Japan
12750	Iwase	Ibaraki	Japan
12751	Iwanuma	Miyagi	Japan
12752	Iwaki	Fukushima	Japan
12753	Itako	Ibaraki	Japan
12754	Ishioka	Ibaraki	Japan
12755	Ishinomaki	Miyagi	Japan
12756	Ishikawa	Fukushima	Japan
12757	Inawashiro	Fukushima	Japan
12758	Ichinoseki	Iwate	Japan
12759	Ichihara	Chiba	Japan
12760	Hobaramachi	Fukushima	Japan
12761	Hitachi	Ibaraki	Japan
12762	Higashine	Yamagata	Japan
12763	Hasaki	Chiba	Japan
12764	Hanamaki	Iwate	Japan
12765	Furukawa	Miyagi	Japan
12766	Funehikimachi-funehiki	Fukushima	Japan
12767	Funaishikawa	Ibaraki	Japan
12768	Fukushima	Fukushima	Japan
12769	Fujishiro	Ibaraki	Japan
12770	Edosaki	Ibaraki	Japan
12771	Daigo	Ibaraki	Japan
12772	Chiba	Chiba	Japan
12773	Asahi	Chiba	Japan
12774	Ami	Ibaraki	Japan
12775	Akita	Akita	Japan
12776	Abiko	Chiba	Japan
12777	Akitashi	Akita	Japan
12778	Bihoro	Hokkaido	Japan
12779	Wakkanai	Hokkaido	Japan
12780	Tomakomai	Hokkaido	Japan
12781	Tobetsu	Hokkaido	Japan
12782	Mutsu	Aomori	Japan
12783	Takikawa	Hokkaido	Japan
12784	Takanosu	Akita	Japan
12785	Sunagawa	Hokkaido	Japan
12786	Shizunai-furukawacho	Hokkaido	Japan
12787	Shiraoi	Hokkaido	Japan
12788	Shimo-furano	Hokkaido	Japan
12789	Shibetsu	Hokkaido	Japan
12790	Sapporo	Hokkaido	Japan
12791	Rumoi	Hokkaido	Japan
12792	Otofuke	Hokkaido	Japan
12793	Otaru	Hokkaido	Japan
12794	Odate	Akita	Japan
12795	Obihiro	Hokkaido	Japan
12796	Noshiro	Akita	Japan
12797	Nemuro	Hokkaido	Japan
12798	Nayoro	Hokkaido	Japan
12799	Nanae	Hokkaido	Japan
12800	Namioka	Aomori	Japan
12801	Muroran	Hokkaido	Japan
12802	Mombetsu	Hokkaido	Japan
12803	Misawa	Aomori	Japan
12804	Yoichi	Hokkaido	Japan
12805	Makubetsu	Hokkaido	Japan
12806	Kushiro	Hokkaido	Japan
12807	Kuroishi	Aomori	Japan
12808	Shimokizukuri	Aomori	Japan
12809	Kitami	Hokkaido	Japan
12810	Kamiiso	Hokkaido	Japan
12811	Iwanai	Hokkaido	Japan
12812	Iwamizawa	Hokkaido	Japan
12813	Ishikari	Hokkaido	Japan
12814	Ichinohe	Iwate	Japan
12815	Kitahiroshima	Hokkaido	Japan
12816	Hirosaki	Aomori	Japan
12817	Hanawa	Akita	Japan
12818	Hakodate	Hokkaido	Japan
12819	Hachinohe	Aomori	Japan
12820	Fukagawa	Hokkaido	Japan
12821	Ebetsu	Hokkaido	Japan
12822	Date	Hokkaido	Japan
12823	Chitose	Hokkaido	Japan
12824	Bibai	Hokkaido	Japan
12825	Ashibetsu	Hokkaido	Japan
12826	Asahikawa	Hokkaido	Japan
12827	Aomorishi	Aomori	Japan
12828	Abashiri	Hokkaido	Japan
12829	Goshogawara	Aomori	Japan
12830	Aso	Kumamoto	Japan
12831	Nanto-shi	Toyama	Japan
12832	Kawage	Mie	Japan
12833	Neyagawa	Osaka	Japan
12834	Hitachi-Naka	Ibaraki	Japan
12835	Inashiki	Ibaraki	Japan
12836	Onojo	Fukuoka	Japan
12837	Minokamo	Gifu	Japan
12838	Gujo	Gifu	Japan
12839	Joetsu	Niigata	Japan
12840	Saitama	Saitama	Japan
12841	Higashimurayama-shi	Tokyo	Japan
12842	Fujikawaguchiko	Yamanashi	Japan
12843	Dazaifu	Fukuoka	Japan
12844	Kamigyo-ku	Kyoto	Japan
12845	Buzen	Fukuoka	Japan
12846	Sendai	Miyagi	Japan
12847	Webuye	Bungoma	Kenya
12848	Wajir	Wajir	Kenya
12849	Voi	Taita Taveta	Kenya
12850	Thika	Nairobi Area	Kenya
12851	Rongai	Nakuru	Kenya
12852	Pumwani	Nairobi Area	Kenya
12853	Nyeri	Nyeri	Kenya
12854	Nyahururu	Laikipia	Kenya
12855	Narok	Narok	Kenya
12856	Nanyuki	Laikipia	Kenya
12857	Nakuru	Nakuru	Kenya
12858	Naivasha	Nakuru	Kenya
12859	Nairobi	Nairobi Area	Kenya
12860	Mumias	Kakamega	Kenya
12861	Muhoroni	Kisumu	Kenya
12862	Moyale	Marsabit	Kenya
12863	Mombasa	Mombasa	Kenya
12864	Molo	Nakuru	Kenya
12865	Migori	Migori	Kenya
12866	Meru	Meru	Kenya
12867	Mbale	Vihiga	Kenya
12868	Marsabit	Marsabit	Kenya
12869	Maralal	Samburu	Kenya
12870	Mandera	Mandera	Kenya
12871	Malindi	Kilifi	Kenya
12872	Makueni	Makueni	Kenya
12873	Machakos	Machakos	Kenya
12874	Lugulu	Busia	Kenya
12875	Lodwar	Turkana	Kenya
12876	Lamu	Lamu	Kenya
12877	Kitui	Kitui	Kenya
12878	Kitale	Trans Nzoia	Kenya
12879	Kisumu	Kisumu	Kenya
12880	Kisii	Kisii	Kenya
12881	Kilifi	Kilifi	Kenya
12882	Kiambu	Kiambu	Kenya
12883	Keruguya	Kirinyaga	Kenya
12884	Kericho	Kericho	Kenya
12885	Karuri	MurangA	Kenya
12886	Kapenguria	West Pokot	Kenya
12887	Kakamega	Kakamega	Kenya
12888	Kabarnet	Baringo	Kenya
12889	Isiolo	Isiolo	Kenya
12890	Homa Bay	Homa Bay	Kenya
12891	Garissa	Garissa	Kenya
12892	Embu	Embu	Kenya
12893	Eldoret	Uasin Gishu	Kenya
12894	Busia	Busia	Kenya
12895	Bungoma	Bungoma	Kenya
12896	Athi River	Machakos	Kenya
12897	Siaya	Siaya	Kenya
12898	Ol Kalou	Nyandarua	Kenya
12899	Suluktu	Batken	Kyrgyzstan
12900	Isfana	Batken	Kyrgyzstan
12903	Tash-Kumyr	Jalal-Abad	Kyrgyzstan
12904	Talas	Talas	Kyrgyzstan
12906	Uzgen	Osh	Kyrgyzstan
12907	Osh	Osh	Kyrgyzstan
12908	Naryn	Naryn	Kyrgyzstan
12909	Kyzyl-Kyya	Batken	Kyrgyzstan
12910	Kara Suu	Osh	Kyrgyzstan
12914	Jalal-Abad	Jalal-Abad	Kyrgyzstan
12915	Iradan	Batken	Kyrgyzstan
12917	Bishkek	Bishkek	Kyrgyzstan
12918	Bazar-Korgon	Jalal-Abad	Kyrgyzstan
12919	At-Bashi	Naryn	Kyrgyzstan
12920	Toktogul	Jalal-Abad	Kyrgyzstan
12921	Osh City	Osh City	Kyrgyzstan
12922	Phnom Penh	Phnom Penh	Cambodia
12923	Ta Khmau	Kandal	Cambodia
12924	Takeo	Takeo	Cambodia
12925	Svay Rieng	Svay Rieng	Cambodia
12926	Stung Treng	Stung Treng	Cambodia
12927	Sisophon	Banteay Meanchey	Cambodia
12928	Siem Reap	Siem Reap	Cambodia
12929	Prey Veng	Prey Veng	Cambodia
12930	Pursat	Pursat	Cambodia
12935	Pailin	Pailin	Cambodia
12936	Lumphat	Ratanakiri	Cambodia
12937	Koh Kong	Koh Kong	Cambodia
12939	Kampot	Kampot	Cambodia
12940	Kampong Thom	Kampong Thom	Cambodia
12941	Kampong Speu	Kampong Speu	Cambodia
12942	Sihanoukville	Preah Sihanouk	Cambodia
12943	Kampong Chhnang	Kampong Chhnang	Cambodia
12944	Kampong Cham	Kampong Cham	Cambodia
12945	Ban Lung	Ratanakiri	Cambodia
12946	Battambang	Battambang	Cambodia
12947	Smach Mean Chey	Koh Kong	Cambodia
12948	Tarawa	Gilbert Islands	Kiribati
12949	Moutsamoudou	Anjouan	Comoros
12950	Moroni	Grande Comore	Comoros
12951	Basseterre	Saint George Basseterre	Saint Kitts and Nevis
12952	Yonan-up	Hwanghae-namdo	North Korea
12953	Wonsan	Kangwon-do	North Korea
12955	Sungho 1-tong	Pyongyang	North Korea
12956	Sunan	Pyongyang	North Korea
12957	Songnim	Hwanghae-bukto	North Korea
12958	Sil-li	Pyongan-namdo	North Korea
12959	Sinmak	Hwanghae-bukto	North Korea
12960	Sinanju	Pyongan-namdo	North Korea
12961	Sariwon	Hwanghae-bukto	North Korea
12962	Samho-rodongjagu	Hamgyong-namdo	North Korea
12963	Pyongyang	Pyongyang	North Korea
12965	Ongjin	Hwanghae-namdo	North Korea
12967	Kusong	Pyongan-bukto	North Korea
12968	Kujang-up	Pyongan-bukto	North Korea
12969	Kowon-up	Hamgyong-namdo	North Korea
12970	Kosan	Kangwon-do	North Korea
12971	Kangdong-up	Pyongyang	North Korea
12972	Kaesong	Hwanghae-namdo	North Korea
12973	Hwangju-up	Hwanghae-bukto	North Korea
12974	Hungnam	Hamgyong-namdo	North Korea
12975	Hukkyo-ri	Hwanghae-bukto	North Korea
12976	Hoeyang	Kangwon-do	North Korea
12977	Hamhung	Hamgyong-namdo	North Korea
12978	Haeju	Hwanghae-namdo	North Korea
12979	Chunghwa	Pyongyang	North Korea
12980	Chongju	Pyongan-bukto	North Korea
12981	Changyon	Hwanghae-namdo	North Korea
12982	Chaeryong-up	Hwanghae-namdo	North Korea
12983	Ayang-ni	Hwanghae-namdo	North Korea
12984	Anju	Pyongan-namdo	North Korea
12985	Anbyon-up	Kangwon-do	North Korea
12986	Anak	Hwanghae-bukto	North Korea
12987	Yuktae-dong	Hamgyong-namdo	North Korea
12988	Uiju	Pyongan-bukto	North Korea
12989	Sonbong	Rason	North Korea
12990	Sinuiju	Pyongan-bukto	North Korea
12991	Sakchu-up	Pyongan-bukto	North Korea
12992	Yonggwang-up	Hamgyong-namdo	North Korea
12993	Onsong	Hamgyong-bukto	North Korea
12994	Nanam	Hamgyong-bukto	North Korea
12995	Namyang-dong	Hamgyong-bukto	North Korea
12996	Najin	Rason	North Korea
12997	Musan-up	Hamgyong-bukto	North Korea
12998	Kyongsong	Hamgyong-bukto	North Korea
12999	Kilju	Hamgyong-bukto	North Korea
13000	Kapsan-up	Yanggang-do	North Korea
13001	Kanggye-si	Chagang-do	North Korea
13002	Iwon-up	Hamgyong-namdo	North Korea
13003	Hyesan-dong	Yanggang-do	North Korea
13004	Hyesan-si	Yanggang-do	North Korea
13005	Hongwon	Hamgyong-namdo	North Korea
13006	Hoeryong	Hamgyong-bukto	North Korea
13007	Chongjin	Hamgyong-bukto	North Korea
13008	Aoji-ri	Hamgyong-bukto	North Korea
13009	Heung-hai	Gyeongsangbuk-do	South Korea
13010	Enjitsu	Gyeongsangbuk-do	South Korea
13011	Neietsu	Gangwon-do	South Korea
13012	Eisen	Gyeongsangbuk-do	South Korea
13013	Reiko	Jeollanam-do	South Korea
13014	Yong-dong	Chungcheongbuk-do	South Korea
13015	Eisen	Gyeongsangbuk-do	South Korea
13016	Yeoju	Gyeonggi-do	South Korea
13017	Yesan	Chungcheongnam-do	South Korea
13018	Yangsan	Gyeongsangnam-do	South Korea
13019	Yangpyong	Gyeonggi-do	South Korea
13020	Yangju	Gyeonggi-do	South Korea
13021	Yanggu	Gangwon-do	South Korea
13022	Wonju	Gangwon-do	South Korea
13023	Wanju	Jeollabuk-do	South Korea
13024	Waegwan	Gyeongsangbuk-do	South Korea
13025	Ulsan	Ulsan	South Korea
13026	Uijeongbu-si	Gyeonggi-do	South Korea
13027	Tangjin	Chungcheongnam-do	South Korea
13028	Taesal-li	Chungcheongnam-do	South Korea
13029	Daejeon	Daejeon	South Korea
13030	Daegu	Daegu	South Korea
13031	Taisen-ri	Chungcheongnam-do	South Korea
13033	Suwon-si	Gyeonggi-do	South Korea
13034	Suncheon	Jeollanam-do	South Korea
13035	Seoul	Seoul	South Korea
13036	Suisan	Chungcheongnam-do	South Korea
13037	Jenzan	Gyeongsangbuk-do	South Korea
13038	Seonghwan	Chungcheongnam-do	South Korea
13039	Sokcho	Gangwon-do	South Korea
13040	Sangju	Gyeongsangbuk-do	South Korea
13041	Santyoku	Gangwon-do	South Korea
13042	Fuyo	Chungcheongnam-do	South Korea
13043	Busan	Busan	South Korea
13044	Bucheon-si	Gyeonggi-do	South Korea
13045	Puan	Jeollabuk-do	South Korea
13046	Beolgyo	Jeollanam-do	South Korea
13047	Pohang	Gyeongsangbuk-do	South Korea
13048	Osan	Gyeonggi-do	South Korea
13049	Asan	Chungcheongnam-do	South Korea
13050	Okcheon	Chungcheongbuk-do	South Korea
13051	Kosong	Gangwon-do	South Korea
13052	Nonsan	Chungcheongnam-do	South Korea
13053	Nangen	Jeollabuk-do	South Korea
13054	Naju	Jeollanam-do	South Korea
13055	Munsan	Gyeonggi-do	South Korea
13056	Mungyeong	Gyeongsangbuk-do	South Korea
13057	Muan	Jeollanam-do	South Korea
13058	Moppo	Jeollanam-do	South Korea
13059	Miryang	Gyeongsangnam-do	South Korea
13060	Gyeongsan-si	Gyeongsangbuk-do	South Korea
13061	Kyonju	Gyeongsangbuk-do	South Korea
13062	Kwangyang	Jeollanam-do	South Korea
13063	Gwangju	Gyeonggi-do	South Korea
13064	Gwangju	Gwangju	South Korea
13065	Kurye	Jeollanam-do	South Korea
13066	Guri-si	Gyeonggi-do	South Korea
13067	Kunwi	Gyeongsangbuk-do	South Korea
13068	Kunsan	Jeollabuk-do	South Korea
13069	Kinzan	Chungcheongnam-do	South Korea
13070	Gumi	Gyeongsangbuk-do	South Korea
13071	Goyang-si	Gyeonggi-do	South Korea
13072	Goseong	Gyeongsangnam-do	South Korea
13073	Gongju	Chungcheongnam-do	South Korea
13074	Kyosai	Gyeongsangnam-do	South Korea
13075	Koesan	Chungcheongbuk-do	South Korea
13076	Kochang	Jeollabuk-do	South Korea
13077	Kimje	Jeollabuk-do	South Korea
13078	Kimhae	Gyeongsangnam-do	South Korea
13079	Gimcheon	Gyeongsangbuk-do	South Korea
13080	Gijang	Busan	South Korea
13081	Gapyeong	Gyeonggi-do	South Korea
13082	Kang-neung	Gangwon-do	South Korea
13083	Ganghwa-gun	Incheon	South Korea
13084	Iksan	Jeollabuk-do	South Korea
13085	Incheon	Incheon	South Korea
13086	Imsil	Jeollabuk-do	South Korea
13087	Icheon-si	Gyeonggi-do	South Korea
13088	Hwasun	Jeollanam-do	South Korea
13089	Hwaseong-si	Gyeonggi-do	South Korea
13090	Hwacheon	Gangwon-do	South Korea
13091	Hongsung	Chungcheongnam-do	South Korea
13093	Hayang	Gyeongsangbuk-do	South Korea
13094	Haenam	Jeollanam-do	South Korea
13095	Chuncheon	Gangwon-do	South Korea
13096	Jeonju	Jeollabuk-do	South Korea
13097	Cheongsong gun	Gyeongsangbuk-do	South Korea
13098	Cheongju-si	Chungcheongbuk-do	South Korea
13099	Cheonan	Chungcheongnam-do	South Korea
13100	Chinju	Gyeongsangnam-do	South Korea
13101	Chinchon	Chungcheongbuk-do	South Korea
13102	Jinan-gun	Jeollabuk-do	South Korea
13103	Jeju City	Jeju-do	South Korea
13104	Changwon	Gyeongsangnam-do	South Korea
13105	Changsu	Jeollabuk-do	South Korea
13106	Anyang-si	Gyeonggi-do	South Korea
13107	Anseong	Gyeonggi-do	South Korea
13108	Ansan-si	Gyeonggi-do	South Korea
13109	Andong	Gyeongsangbuk-do	South Korea
13110	Gaigeturi	Jeju-do	South Korea
13111	Sinhyeon	Gyeongsangnam-do	South Korea
13112	Yeosu	Jeollanam-do	South Korea
13113	Yonmu	Chungcheongnam-do	South Korea
13114	Tonghae	Gangwon-do	South Korea
13115	Pubal	Gyeonggi-do	South Korea
13116	Seongnam-si	Gyeonggi-do	South Korea
13117	Hanam	Gyeonggi-do	South Korea
13118	Hwado	Gyeonggi-do	South Korea
13119	Namyangju	Gyeonggi-do	South Korea
13120	Ungsang	Gyeongsangnam-do	South Korea
13121	Wabu	Gyeonggi-do	South Korea
13122	Naeso	Gyeongsangnam-do	South Korea
13123	Hwawon	Daegu	South Korea
13124	Kwangmyong	Gyeonggi-do	South Korea
13125	Sinan	Jeollanam-do	South Korea
13126	Seogwipo	Jeju-do	South Korea
13127	Changnyeong	Gyeongsangnam-do	South Korea
13128	Janub as Surrah	Al Farwaniyah	Kuwait
13130	Bayan	N/A	Kuwait
13133	Ar Riqqah	Al A?madi	Kuwait
13134	Al Manqaf	Al A?madi	Kuwait
13135	Al Mahbulah	Al A?madi	Kuwait
13136	Kuwait City	Al Asimah	Kuwait
13138	Al Fa?a?il	Al A?madi	Kuwait
13139	Al Fintas	Al A?madi	Kuwait
13140	Al Farwaniyah	Al Farwaniyah	Kuwait
13141	Al A?madi	Al A?madi	Kuwait
13142	Ad Dasmah	Al Asimah	Kuwait
13144	Ar Rabiyah	Al Asimah	Kuwait
13145	Saba? as Salim	Mubarak al Kabir	Kuwait
13146	George Town	George Town	Cayman Islands
13147	Zhanaozen	Mangghystau	Kazakhstan
13149	Shalkar	Atyrau	Kazakhstan
13150	Oral	Batys Qazaqstan	Kazakhstan
13152	Qulsary	Atyrau	Kazakhstan
13154	Karagandy	Qaraghandy	Kazakhstan
13156	Balyqshy	Atyrau	Kazakhstan
13157	Atyrau	Atyrau	Kazakhstan
13159	Aktau	Mangghystau	Kazakhstan
13160	Aqsay	Batys Qazaqstan	Kazakhstan
13161	Zyryanovsk	East Kazakhstan	Kazakhstan
13162	Zhosaly	Qyzylorda	Kazakhstan
13163	Zhezqazghan	Qaraghandy	Kazakhstan
13164	Dzhetygara	Qostanay	Kazakhstan
13165	Zhangatas	Zhambyl	Kazakhstan
13166	Ayteke Bi	Qyzylorda	Kazakhstan
13167	Taraz	Zhambyl	Kazakhstan
13168	Zaysan	East Kazakhstan	Kazakhstan
13169	Yanykurgan	Qyzylorda	Kazakhstan
13171	Ush-Tyube	Almaty Oblysy	Kazakhstan
13173	Temirtau	Qaraghandy	Kazakhstan
13174	Tekeli	Almaty Oblysy	Kazakhstan
13176	Talghar	Almaty Oblysy	Kazakhstan
13177	Taldykorgan	Almaty Oblysy	Kazakhstan
13178	Taldyqorghan	Almaty Oblysy	Kazakhstan
13180	Chu	Zhambyl	Kazakhstan
13181	Shemonaikha	East Kazakhstan	Kazakhstan
13183	Semey	East Kazakhstan	Kazakhstan
13185	Sarkand	Almaty Oblysy	Kazakhstan
13186	Sorang	Qaraghandy	Kazakhstan
13187	Rudnyy	Qostanay	Kazakhstan
13188	Kyzylorda	Qyzylorda	Kazakhstan
13189	Kostanay	Qostanay	Kazakhstan
13190	Karatau	Zhambyl	Kazakhstan
13191	Kapshagay	Almaty Oblysy	Kazakhstan
13193	Pavlodar	Pavlodar	Kazakhstan
13194	Zharkent	Almaty Oblysy	Kazakhstan
13195	Ust-Kamenogorsk	East Kazakhstan	Kazakhstan
13196	Sarykemer	Zhambyl	Kazakhstan
13197	Merke	Zhambyl	Kazakhstan
13198	Makinsk	Aqmola	Kazakhstan
13199	Lisakovsk	Qostanay	Kazakhstan
13200	Baykonyr	Bayqongyr Qalasy	Kazakhstan
13201	Ridder	East Kazakhstan	Kazakhstan
13203	Kokshetau	Aqmola	Kazakhstan
13205	Esik	Almaty Oblysy	Kazakhstan
13206	Georgievka	East Kazakhstan	Kazakhstan
13207	Aksu	Pavlodar	Kazakhstan
13208	Otegen Batyra	Almaty Oblysy	Kazakhstan
13209	Ekibastuz	Pavlodar	Kazakhstan
13210	Shieli	Qyzylorda	Kazakhstan
13212	Burunday	Almaty Oblysy	Kazakhstan
13214	Balqash	Qaraghandy	Kazakhstan
13215	Ayagoz	East Kazakhstan	Kazakhstan
13216	Atbasar	Aqmola	Kazakhstan
13218	Arkalyk	Qostanay	Kazakhstan
13219	Aral	Qyzylorda	Kazakhstan
13220	Astana	Astana Qalasy	Kazakhstan
13221	Almaty	Almaty Qalasy	Kazakhstan
13223	Abay	Qaraghandy	Kazakhstan
13224	Stepnogorsk	Aqmola	Kazakhstan
13225	Kyzyl-Orda	Qyzylorda	Kazakhstan
13226	Vientiane	Vientiane	Laos
13227	Xam Nua	Houaphan	Laos
13231	Vangviang	Vientiane Province	Laos
13233	Muang Pakxan	Bolikhamsai Province	Laos
13235	Luang Prabang	Louangphabang	Laos
13236	Ban Houakhoua	Bokeo Province	Laos
13237	Phonsavan	Xiangkhoang	Laos
13239	Tripoli	Liban-Nord	Lebanon
13240	Tyre	Liban-Sud	Lebanon
13241	Sidon	Liban-Sud	Lebanon
13243	Djounie	Mont-Liban	Lebanon
13247	Beirut	Beyrouth	Lebanon
13248	Baalbek	Baalbek-Hermel	Lebanon
13251	Castries	Castries Quarter	Saint Lucia
13252	Vaduz	Vaduz	Liechtenstein
13253	Welisara	Western	Sri Lanka
13254	Weligama	Southern	Sri Lanka
13255	Wattala	Western	Sri Lanka
13256	Vavuniya	Northern Province	Sri Lanka
13257	Valvedditturai	Northern Province	Sri Lanka
13258	Trincomalee	Eastern Province	Sri Lanka
13259	Ratnapura	Sabaragamuwa	Sri Lanka
13260	Puttalam	North Western	Sri Lanka
13261	Point Pedro	Northern Province	Sri Lanka
13262	Pita Kotte	Western	Sri Lanka
13263	Peliyagoda	Western	Sri Lanka
13264	Panadura	Western	Sri Lanka
13265	Nuwara Eliya	Central	Sri Lanka
13266	Negombo	Western	Sri Lanka
13267	Mulleriyawa	Western	Sri Lanka
13268	Dehiwala-Mount Lavinia	Western	Sri Lanka
13269	Moratuwa	Western	Sri Lanka
13270	Matara	Southern	Sri Lanka
13271	Maharagama	Western	Sri Lanka
13272	Kurunegala	North Western	Sri Lanka
13273	Sri Jayewardenepura Kotte	Western	Sri Lanka
13274	Kotikawatta	Western	Sri Lanka
13275	Kolonnawa	Western	Sri Lanka
13276	Kelaniya	Western	Sri Lanka
13277	Katunayaka	Western	Sri Lanka
13278	Kandy	Central	Sri Lanka
13279	Kandana	Western	Sri Lanka
13280	Kalutara	Western	Sri Lanka
13281	Kalmunai	Eastern Province	Sri Lanka
13282	Jaffna	Northern Province	Sri Lanka
13283	Ja Ela	Western	Sri Lanka
13284	Homagama	Western	Sri Lanka
13285	Hendala	Western	Sri Lanka
13286	Hatton	Central	Sri Lanka
13287	Hanwella Ihala	Western	Sri Lanka
13288	Gampola	Central	Sri Lanka
13289	Galle	Southern	Sri Lanka
13290	Galkissa	Western	Sri Lanka
13291	Eravur Town	Eastern Province	Sri Lanka
13292	Dambulla	Central	Sri Lanka
13293	Colombo	Western	Sri Lanka
13294	Chilaw	North Western	Sri Lanka
13295	Beruwala	Western	Sri Lanka
13296	Bentota	Southern	Sri Lanka
13297	Batticaloa	Eastern Province	Sri Lanka
13298	Battaramulla South	Western	Sri Lanka
13299	Badulla	Uva	Sri Lanka
13300	Anuradhapura	North Central	Sri Lanka
13301	Ampara	Eastern Province	Sri Lanka
13302	Ambalangoda	Southern	Sri Lanka
13303	Shanjeev Home	Eastern Province	Sri Lanka
13304	Mount Lavinia	Western	Sri Lanka
13305	Zwedru	Grand Gedeh	Liberia
13306	New Yekepa	Nimba	Liberia
13307	Voinjama	Lofa	Liberia
13308	Monrovia	Montserrado	Liberia
13309	Kakata	Margibi	Liberia
13310	Harper	Maryland	Liberia
13311	Greenville	Sinoe	Liberia
13312	Gbarnga	Bong	Liberia
13313	Buchanan	Grand Bassa	Liberia
13314	Bensonville	Montserrado	Liberia
13315	Quthing	Quthing	Lesotho
13318	Maseru	Maseru	Lesotho
13319	Maputsoe	Leribe	Lesotho
13320	Mafeteng	Mafeteng	Lesotho
13321	Leribe	Leribe	Lesotho
13322	Butha-Buthe	Butha-Buthe	Lesotho
13323	Visaginas	Utenos apskritis	Lithuania
13324	Vilnius	Vilnius County	Lithuania
13325	Utena	Utenos apskritis	Lithuania
13326	Ukmerge	Vilnius County	Lithuania
13328	Taurage	Taurages apskritis	Lithuania
13329	Silute	Klaipedos apskritis	Lithuania
13335	Palanga	Klaipedos apskritis	Lithuania
13338	Marijampole	Marijampoles apskritis	Lithuania
13339	Kretinga	Klaipedos apskritis	Lithuania
13340	Klaipeda	Klaipedos apskritis	Lithuania
13341	Kedainiai	Kauno apskritis	Lithuania
13342	Kaunas	Kauno apskritis	Lithuania
13343	Jonava	Kauno apskritis	Lithuania
13345	Druskininkai	Alytaus apskritis	Lithuania
13346	Alytus	Alytaus apskritis	Lithuania
13347	Aleksotas	Kauno apskritis	Lithuania
13348	Dainava (Kaunas)	Kauno apskritis	Lithuania
13350	Eiguliai	Kauno apskritis	Lithuania
13352	Pilaite	Vilnius County	Lithuania
13355	Lazdynai	Vilnius County	Lithuania
13356	Vilkpede	Vilnius County	Lithuania
13357	Naujamiestis	Vilnius County	Lithuania
13358	Luxembourg	Luxembourg	Luxembourg
13359	Esch-sur-Alzette	Luxembourg	Luxembourg
13360	Dudelange	Luxembourg	Luxembourg
13361	Valmiera	Valmieras Rajons	Latvia
13362	Ventspils	Ventspils	Latvia
13363	Vec-Liepaja	Liepaja	Latvia
13364	Tukums	Tukuma Rajons	Latvia
13365	Salaspils	Salaspils	Latvia
13366	Riga	Riga	Latvia
13367	Rezekne	Rezekne	Latvia
13368	Ogre	Ogre	Latvia
13369	Liepaja	Liepaja	Latvia
13370	Jurmala	Jurmala	Latvia
13371	Jelgava	Jelgava	Latvia
13372	Jekabpils	Jekabpils Municipality	Latvia
13373	Daugavpils	Daugavpils municipality	Latvia
13374	Cesis	Cesu Rajons	Latvia
13376	Suluq	Banghazi	Libya
13377	Darnah	Darnah	Libya
13378	Benghazi	Banghazi	Libya
13380	At Taj	Al Kufrah	Libya
13381	Tukrah	Al Marj	Libya
13382	Al Qubbah	Darnah	Libya
13383	Al Marj	Al Marj	Libya
13384	Al Jawf	Al Kufrah	Libya
13386	Al Abyar	Al Marj	Libya
13388	Zuwarah	An Nuqat al Khams	Libya
13389	Zliten	Misratah	Libya
13390	Zaltan	An Nuqat al Khams	Libya
13392	Waddan	Al Jufrah	Libya
13393	Tarhuna	Al Marqab	Libya
13394	Tripoli	Tripoli	Libya
13395	Tagiura	Tripoli	Libya
13396	Sirte	Surt	Libya
13397	Surman	Az Zawiyah	Libya
13398	Sabratah	Az Zawiyah	Libya
13399	Sabha	Sabha	Libya
13401	Murzuq	Murzuq	Libya
13403	Misratah	Misratah	Libya
13404	Masallatah	Al Marqab	Libya
13405	Hun	Al Jufrah	Libya
13406	Zawiya	Az Zawiyah	Libya
13409	Brak	Ash Shati	Libya
13410	Bani Walid	Misratah	Libya
13412	Az Zawiyah	Az Zawiyah	Libya
13414	Al Khums	Al Marqab	Libya
13415	Al Jadid	Sabha	Libya
13418	Youssoufia	Doukkala-Abda	Morocco
13424	Taza	Taza-Al Hoceima-Taounate	Morocco
13426	Taourirt	Oriental	Morocco
13427	Taounate	Taza-Al Hoceima-Taounate	Morocco
13428	Tan-Tan	Guelmim-Es Smara	Morocco
13430	Tahla	Taza-Al Hoceima-Taounate	Morocco
13432	Sidi Yahia El Gharb	Gharb-Chrarda-Beni Hssen	Morocco
13433	Sidi Slimane	Gharb-Chrarda-Beni Hssen	Morocco
13434	Sidi Qacem	Gharb-Chrarda-Beni Hssen	Morocco
13436	Sidi Bennour	Doukkala-Abda	Morocco
13437	Settat	Chaouia-Ouardigha	Morocco
13440	Safi	Doukkala-Abda	Morocco
13443	Oujda	Oriental	Morocco
13444	Oued Zem	Chaouia-Ouardigha	Morocco
13445	Ouezzane	Gharb-Chrarda-Beni Hssen	Morocco
13447	Nador	Oriental	Morocco
13448	Mohammedia	Grand Casablanca	Morocco
13451	Mechraa Bel Ksiri	Gharb-Chrarda-Beni Hssen	Morocco
13453	Marrakesh	Marrakech-Tensift-Al Haouz	Morocco
13456	Khouribga	Chaouia-Ouardigha	Morocco
13458	Kenitra	Gharb-Chrarda-Beni Hssen	Morocco
13459	Kasba Tadla	Tadla-Azilal	Morocco
13460	Jerada	Oriental	Morocco
13462	Guercif	Taza-Al Hoceima-Taounate	Morocco
13463	Guelmim	Guelmim-Es Smara	Morocco
13464	Fkih Ben Salah	Tadla-Azilal	Morocco
13467	Essaouira	Marrakech-Tensift-Al Haouz	Morocco
13468	El Jadida	Doukkala-Abda	Morocco
13472	Casablanca	Grand Casablanca	Morocco
13473	Bouznika	Chaouia-Ouardigha	Morocco
13474	Berkane	Oriental	Morocco
13475	Beni Mellal	Tadla-Azilal	Morocco
13476	Berrechid	Chaouia-Ouardigha	Morocco
13478	Azemmour	Doukkala-Abda	Morocco
13482	Ahfir	Oriental	Morocco
13485	Boujniba	Chaouia-Ouardigha	Morocco
13486	Dakhla	Oued ed Dahab-Lagouira	Morocco
13487	Monte-Carlo		Monaco
13488	Monaco		Monaco
13489	Edinet	Raionul Edinet	Moldova
13490	Ungheni	Ungheni	Moldova
13492	Straseni	Stra?eni	Moldova
13494	Soroca	Raionul Soroca	Moldova
13497	Orhei	Orhei	Moldova
13499	Causeni	Causeni	Moldova
13500	Floresti	Floresti	Moldova
13501	Dubasari	Telenesti	Moldova
13502	Drochia	Drochia	Moldova
13503	Comrat	Gagauzia	Moldova
13504	Chisinau	Chisinau	Moldova
13506	Cahul	Cahul	Moldova
13507	Bender	Bender	Moldova
13508	Balti	Balti	Moldova
13509	Podgorica	Podgorica	Montenegro
13510	Pljevlja	Pljevlja	Montenegro
13512	Herceg-Novi	Herceg Novi	Montenegro
13513	Cetinje	Cetinje	Montenegro
13514	Budva	Budva	Montenegro
13515	Bijelo Polje	Bijelo Polje	Montenegro
13516	Bar	Bar	Montenegro
13517	Marigot	N/A	Saint Martin
13518	Toamasina	Atsinanana	Madagascar
13519	Vondrozo	Atsimo-Atsinanana	Madagascar
13520	Vohipaho	Atsimo-Atsinanana	Madagascar
13521	Vohibinany	Atsinanana	Madagascar
13522	Vavatenina	Analanjirofo	Madagascar
13523	Vangaindrano	Atsimo-Atsinanana	Madagascar
13524	Tsiroanomandidy	Bongolava	Madagascar
13525	Tsiombe	Androy	Madagascar
13526	Tsaratanana	Betsiboka	Madagascar
13527	Toliara	Atsimo-Andrefana	Madagascar
13528	Fort Dauphin	Anosy	Madagascar
13529	Soavinandriana	Itasy	Madagascar
13530	Soanindrariny	Vakinankaratra	Madagascar
13531	Soanierana Ivongo	Analanjirofo	Madagascar
13532	Sitampiky	Boeny	Madagascar
13533	Sambava	Sava	Madagascar
13534	Sakaraha	Atsimo-Andrefana	Madagascar
13535	Sahavato	Vatovavy Fitovinany	Madagascar
13536	Sadabe	Analamanga	Madagascar
13537	Nosy Varika	Vatovavy Fitovinany	Madagascar
13538	Morondava	Menabe	Madagascar
13539	Moramanga	Alaotra Mangoro	Madagascar
13540	Miandrivazo	Menabe	Madagascar
13541	Miandrarivo	Vakinankaratra	Madagascar
13542	Marovoay	Boeny	Madagascar
13543	Marolambo	Atsinanana	Madagascar
13544	Maroantsetra	Analanjirofo	Madagascar
13545	Manjakandriana	Analamanga	Madagascar
13546	Mananjary	Vatovavy Fitovinany	Madagascar
13547	Mananara	Analanjirofo	Madagascar
13548	Manakara	Vatovavy Fitovinany	Madagascar
13549	Maintirano	Melaky	Madagascar
13550	Mahanoro	Atsinanana	Madagascar
13551	Mahajanga	Boeny	Madagascar
13552	Maevatanana	Betsiboka	Madagascar
13553	Ikongo	Vatovavy Fitovinany	Madagascar
13554	Ikalamavony	Upper Matsiatra	Madagascar
13555	Ihosy	Ihorombe	Madagascar
13556	Ifanadiana	Vatovavy Fitovinany	Madagascar
13557	Fianarantsoa	Upper Matsiatra	Madagascar
13558	Fenoarivo Be	Bongolava	Madagascar
13559	Fenoarivo Atsinanana	Analanjirofo	Madagascar
13560	Faratsiho	Vakinankaratra	Madagascar
13561	Farafangana	Atsimo-Atsinanana	Madagascar
13562	Fandriana	Amoroni Mania	Madagascar
13563	Betioky	Atsimo-Andrefana	Madagascar
13564	Betafo	Vakinankaratra	Madagascar
13565	Beroroha	Atsimo-Andrefana	Madagascar
13566	Belo sur Tsiribihina	Menabe	Madagascar
13567	Beloha	Androy	Madagascar
13568	Bealanana	Sofia	Madagascar
13569	Arivonimamo	Itasy	Madagascar
13570	Antsohimbondrona	Diana	Madagascar
13571	Antsohihy	Sofia	Madagascar
13572	Antsiranana	Diana	Madagascar
13573	Antsirabe	Vakinankaratra	Madagascar
13574	Antanifotsy	Vakinankaratra	Madagascar
13575	Antananarivo	Analamanga	Madagascar
13576	Antalaha	Sava	Madagascar
13577	Ankazondandy	Analamanga	Madagascar
13578	Ankazobe	Analamanga	Madagascar
13579	Ankazoabo	Atsimo-Andrefana	Madagascar
13580	Anjozorobe	Analamanga	Madagascar
13581	Hell-Ville	Diana	Madagascar
13582	Andilamena	Alaotra Mangoro	Madagascar
13583	Andapa	Sava	Madagascar
13584	Ampasimanolotra	Atsinanana	Madagascar
13585	Amparafaravola	Alaotra Mangoro	Madagascar
13586	Ampanihy	Atsimo-Andrefana	Madagascar
13587	Ampahana	Sava	Madagascar
13588	Ambovombe	Androy	Madagascar
13589	Ambositra	Amoroni Mania	Madagascar
13590	Ambohitrolomahitsy	Analamanga	Madagascar
13591	Amboasary	Anosy	Madagascar
13592	Amboanjo	Vatovavy Fitovinany	Madagascar
13593	Ambilobe	Diana	Madagascar
13594	Ambatondrazaka	Alaotra Mangoro	Madagascar
13595	Ambatolampy	Vakinankaratra	Madagascar
13596	Ambatofinandrahana	Amoroni Mania	Madagascar
13597	Ambato Boeny	Boeny	Madagascar
13598	Ambarakaraka	Diana	Madagascar
13599	Ambanja	Diana	Madagascar
13600	Ambalavao	Upper Matsiatra	Madagascar
13601	Alarobia	Analamanga	Madagascar
13602	Majuro	Majuro Atoll	Marshall Islands
13603	RMI Capitol	Majuro Atoll	Marshall Islands
13605	Vinica	Vinica	Macedonia
13606	Veles	Veles	Macedonia
13607	Tetovo	Tetovo	Macedonia
13608	??????	Tearce	Macedonia
13609	???????????	Studenicani	Macedonia
13610	Strumica	Strumica	Macedonia
13611	Struga	Struga	Macedonia
13614	?????	Saraj	Macedonia
13615	?????	Resen	Macedonia
13617	Prilep	Prilep	Macedonia
13618	Ohrid	Ohrid	Macedonia
13620	Negotino	Negotino	Macedonia
13621	???????	Opstina Lipkovo	Macedonia
13622	Kumanovo	Kumanovo	Macedonia
13623	????? ???????	Kriva Palanka	Macedonia
13624	Kochani	Kocani	Macedonia
13625	Kicevo	Kicevo	Macedonia
13626	Kavadarci	Kavadarci	Macedonia
13627	Kamenjane	Bogovinje	Macedonia
13628	Gostivar	Gostivar	Macedonia
13629	Gevgelija	Gevgelija	Macedonia
13630	Delcevo	Delcevo	Macedonia
13631	Debar	Debar	Macedonia
13632	Brvenica	Brvenica	Macedonia
13633	Bogovinje	Bogovinje	Macedonia
13634	Bitola	Bitola	Macedonia
13636	Butel	Butel	Macedonia
13637	Cair	Cair	Macedonia
13638	Ilinden	Ilinden	Macedonia
13639	Kisela Voda	Kisela Voda	Macedonia
13641	Yorosso	Sikasso	Mali
13642	Timbuktu	Tombouctou	Mali
13643	Sikasso	Sikasso	Mali
13646	Sagalo	Kayes	Mali
13647	Mopti	Mopti	Mali
13649	Koutiala	Sikasso	Mali
13650	Koulikoro	Koulikoro	Mali
13651	Kolokani	Koulikoro	Mali
13652	Kayes	Kayes	Mali
13653	Kati	Koulikoro	Mali
13654	Kangaba	Koulikoro	Mali
13655	Gao	Gao	Mali
13657	Bougouni	Sikasso	Mali
13658	Banamba	Koulikoro	Mali
13659	Bamako	Bamako	Mali
13661	Yenangyaung	Magway	Myanmar
13662	Nyaungdon	Ayeyarwady	Myanmar
13663	Yamethin	Mandalay	Myanmar
13664	Wakema	Ayeyarwady	Myanmar
13665	Twante	Yangon	Myanmar
13666	Taungoo	Bago	Myanmar
13667	Thongwa	Yangon	Myanmar
13668	Thayetmyo	Magway	Myanmar
13669	Thaton	Mon	Myanmar
13670	Tharyarwady	Bago	Myanmar
13671	Thanatpin	Bago	Myanmar
13672	Thanatpin	Bago	Myanmar
13673	Dawei	Tanintharyi	Myanmar
13674	Taunggyi	Shan	Myanmar
13675	Taungdwingyi	Magway	Myanmar
13676	Syriam	Yangon	Myanmar
13677	Sittwe	Rakhine	Myanmar
13678	Shwebo	Sagain	Myanmar
13679	Sagaing	Sagain	Myanmar
13680	Yangon	Yangon	Myanmar
13681	Pyu	Bago	Myanmar
13682	Pyinmana	Mandalay	Myanmar
13683	Pyay	Bago	Myanmar
13684	Pyapon	Ayeyarwady	Myanmar
13685	Bago	Bago	Myanmar
13686	Paungde	Bago	Myanmar
13687	Pakokku	Magway	Myanmar
13688	Hpa-an	Kayin	Myanmar
13689	Nyaunglebin	Bago	Myanmar
13690	Myitkyina	Kachin	Myanmar
13691	Myingyan	Mandalay	Myanmar
13692	Myawadi	Kayin	Myanmar
13693	Myanaung	Ayeyarwady	Myanmar
13694	Mudon	Mon	Myanmar
13695	Mawlamyinegyunn	Ayeyarwady	Myanmar
13696	Mawlamyine	Mon	Myanmar
13697	Monywa	Sagain	Myanmar
13698	Mogok	Mandalay	Myanmar
13699	Minbu	Magway	Myanmar
13700	Myeik	Tanintharyi	Myanmar
13701	Meiktila	Mandalay	Myanmar
13702	Pyin Oo Lwin	Mandalay	Myanmar
13703	Mawlaik	Sagain	Myanmar
13704	Maubin	Ayeyarwady	Myanmar
13705	Martaban	Mon	Myanmar
13706	Mandalay	Mandalay	Myanmar
13707	Magway	Magway	Myanmar
13708	Loikaw	Kayah	Myanmar
13709	Letpandan	Bago	Myanmar
13710	Lashio	Shan	Myanmar
13711	Kyaukse	Mandalay	Myanmar
13712	Kyaikto	Mon	Myanmar
13713	Kyaiklat	Ayeyarwady	Myanmar
13714	Kyaikkami	Mon	Myanmar
13715	Kayan	Yangon	Myanmar
13716	Kanbe	Yangon	Myanmar
13717	Hinthada	Ayeyarwady	Myanmar
13718	Hakha	Chin	Myanmar
13719	Chauk	Magway	Myanmar
13720	Bogale	Ayeyarwady	Myanmar
13721	Bhamo	Kachin	Myanmar
13722	Pathein	Ayeyarwady	Myanmar
13723	Myaydo	Magway	Myanmar
13724	Nay Pyi Taw	Mandalay	Myanmar
13725	Uliastay	Dzabkhan	Mongolia
13726	Ulaangom	Uvs	Mongolia
13728	Khovd	Hovd	Mongolia
13729	Altai	Govi-Altay	Mongolia
13730	Ulan Bator	Ulaanbaatar	Mongolia
13733	Mandalgovi	Middle Govi	Mongolia
13735	Erdenet	Orhon	Mongolia
13737	Darhan	Darhan Uul	Mongolia
13739	Saynshand	East Gobi Aymag	Mongolia
13740	Bulgan	Bulgan	Mongolia
13741	Bayanhongor	Bayanhongor	Mongolia
13742	Bayanhongor	Bayanhongor	Mongolia
13745	???????	Central Aimak	Mongolia
13746	Macau	Macau	Macao
13747	Saipan	Saipan	Northern Mariana Islands
13748	Saint-Joseph	Martinique	Martinique
13749	Sainte-Marie	Martinique	Martinique
13751	Le Robert	Martinique	Martinique
13752	Le Lamentin	Martinique	Martinique
13755	Fort-de-France	Martinique	Martinique
13756	Ducos	Martinique	Martinique
13757	Zouerate	Tiris Zemmour	Mauritania
13760	Rosso	Trarza	Mauritania
13761	Nouakchott	Nouakchott	Mauritania
13764	Kiffa	Assaba	Mauritania
13766	Atar	Adrar	Mauritania
13767	Aleg	Brakna	Mauritania
13768	Plymouth	Saint Anthony	Montserrat
13769	Brades	Saint Peter	Montserrat
13770	Zabbar	Haz-Zabbar	Malta
13771	Valletta	Il-Belt Valletta	Malta
13772	Qormi	Qormi	Malta
13773	Mosta	Il-Mosta	Malta
13774	Birkirkara	Birkirkara	Malta
13775	Vacoas	Plaines Wilhems	Mauritius
13776	Triolet	Pamplemousses	Mauritius
13777	Saint Pierre	Moka	Mauritius
13778	Quatre Bornes	Plaines Wilhems	Mauritius
13779	Port Louis	Port Louis	Mauritius
13782	Curepipe	Plaines Wilhems	Mauritius
13783	Centre de Flacq	Flacq	Mauritius
13785	Le Hochet	Pamplemousses	Mauritius
13786	Male	Kaafu Atoll	Maldives
13787	Karonga	Northern Region	Malawi
13788	Zomba	Southern Region	Malawi
13789	Salima	Central Region	Malawi
13790	Rumphi	Northern Region	Malawi
13791	Nsanje	Southern Region	Malawi
13792	Nkhotakota	Central Region	Malawi
13793	Mzuzu	Northern Region	Malawi
13794	Mzimba	Northern Region	Malawi
13795	Mulanje	Southern Region	Malawi
13796	Mchinji	Central Region	Malawi
13797	Mangochi	Southern Region	Malawi
13798	Liwonde	Southern Region	Malawi
13799	Lilongwe	Central Region	Malawi
13800	Kasungu	Central Region	Malawi
13801	Dedza	Central Region	Malawi
13802	Blantyre	Southern Region	Malawi
13803	Balaka	Southern Region	Malawi
13804	Gustavo A. Madero	Tamaulipas	Mexico
13805	San Fernando	Tamaulipas	Mexico
13810	Zacatepec	Morelos	Mexico
13811	Yecapixtla	Morelos	Mexico
13812	Yautepec	Morelos	Mexico
13813	Xoxocotla	Morelos	Mexico
13815	Xochitepec	Morelos	Mexico
13816	Xochimilco	Mexico City	Mexico
13818	Xico	Veracruz	Mexico
13821	Villahermosa	Tabasco	Mexico
13822	Gustavo A. Madero	Mexico City	Mexico
13824	Veracruz	Veracruz	Mexico
13825	Venustiano Carranza	Chiapas	Mexico
13826	Valle Hermoso	Tamaulipas	Mexico
13833	Tulancingo	Hidalgo	Mexico
13834	Tula de Allende	Hidalgo	Mexico
13836	Tlazcalancingo	Puebla	Mexico
13837	Tlaquiltenango	Morelos	Mexico
14239	Ixtapa	Jalisco	Mexico
13838	Tlapa de Comonfort	Guerrero	Mexico
13839	Tlapacoyan	Veracruz	Mexico
13840	Tlalpan	Mexico City	Mexico
13842	Tlahuac	Mexico City	Mexico
13844	Tizayuca	Morelos	Mexico
13845	Tixtla de Guerrero	Guerrero	Mexico
13848	Tezontepec de Aldama	Hidalgo	Mexico
13849	Teziutlan	Puebla	Mexico
13856	Tepeji de Ocampo	Hidalgo	Mexico
13857	Tepeaca	Puebla	Mexico
13858	Tepatlaxco de Hidalgo	Puebla	Mexico
13861	Tenango de Arista	Morelos	Mexico
13862	Temixco	Morelos	Mexico
13863	Temapache	Veracruz	Mexico
13864	Teloloapan	Guerrero	Mexico
13867	Tecamachalco	Puebla	Mexico
13868	Teapa	Tabasco	Mexico
13870	Tapachula	Chiapas	Mexico
13871	Tantoyuca	Veracruz	Mexico
13872	Tampico	Tamaulipas	Mexico
13874	Santo Domingo Tehuantepec	Oaxaca	Mexico
13875	Santiago Tuxtla	Veracruz	Mexico
13876	Santiago Pinotepa Nacional	Oaxaca	Mexico
13877	Santiago Tulantepec	Hidalgo	Mexico
13878	Moyotzingo	Puebla	Mexico
13881	Tecamac de Felipe Villanueva	Morelos	Mexico
13882	Chiautempan	Tlaxcala	Mexico
13883	San Salvador El Seco	Puebla	Mexico
13886	San Pablo Autopan	Morelos	Mexico
13889	San Mateo Atenco	Morelos	Mexico
13890	San Martin Texmelucan de Labastida	Puebla	Mexico
13891	Teolocholco	Tlaxcala	Mexico
13894	Tuxtepec	Oaxaca	Mexico
13896	Sanctorum	Puebla	Mexico
13898	San Andres Tuxtla	Veracruz	Mexico
13899	Salina Cruz	Oaxaca	Mexico
13903	Reynosa	Tamaulipas	Mexico
13904	Puerto Escondido	Oaxaca	Mexico
13905	Puente de Ixtla	Morelos	Mexico
13906	Puebla	Puebla	Mexico
13907	Progreso de Alvaro Obregon	Hidalgo	Mexico
13909	Poza Rica de Hidalgo	Veracruz	Mexico
13910	Polanco	Mexico City	Mexico
13911	Playa del Carmen	Quintana Roo	Mexico
13912	Pijijiapan	Chiapas	Mexico
13914	Perote	Veracruz	Mexico
13915	Paraiso	Tabasco	Mexico
13916	Papantla de Olarte	Veracruz	Mexico
13919	Palenque	Chiapas	Mexico
13920	Pachuca de Soto	Hidalgo	Mexico
13923	Orizaba	Veracruz	Mexico
13924	Ometepec	Guerrero	Mexico
13925	Ocozocoautla de Espinosa	Chiapas	Mexico
13926	Ocoyoacac	Morelos	Mexico
13927	Ocosingo	Chiapas	Mexico
13929	Nuevo Laredo	Tamaulipas	Mexico
13930	Nogales	Veracruz	Mexico
13933	Naranjos	Veracruz	Mexico
13934	Villa Nanchital	Veracruz	Mexico
13936	Motozintla	Chiapas	Mexico
13938	Santiago Momoxpan	Puebla	Mexico
13939	Mixquiahuala de Juarez	Hidalgo	Mexico
13940	Misantla	Veracruz	Mexico
13941	Miramar	Tamaulipas	Mexico
13942	Minatitlan	Veracruz	Mexico
13943	Milpa Alta	Mexico City	Mexico
13945	Metepec	Morelos	Mexico
13948	Heroica Matamoros	Tamaulipas	Mexico
13950	Mapastepec	Chiapas	Mexico
13951	Malinaltepec	Guerrero	Mexico
13952	Magdalena Contreras	Mexico City	Mexico
13953	Macuspana	Tabasco	Mexico
13954	Reyes Acozac	Morelos	Mexico
13957	Lerma de Villada	Morelos	Mexico
13958	Lerdo de Tejada	Veracruz	Mexico
13959	Las Margaritas	Chiapas	Mexico
13960	Las Choapas	Veracruz	Mexico
13961	La Isla	Veracruz	Mexico
13964	Jojutla	Morelos	Mexico
13965	Jiutepec	Morelos	Mexico
13972	Iztapalapa	Mexico City	Mexico
13974	Iztacalco	Mexico City	Mexico
13975	Ixmiquilpan	Hidalgo	Mexico
13976	Iguala de la Independencia	Guerrero	Mexico
13978	Huixtla	Chiapas	Mexico
13979	Huitzuco de los Figueroa	Guerrero	Mexico
13980	Huimanguillo	Tabasco	Mexico
13981	Huejutla de Reyes	Hidalgo	Mexico
13982	Huejotzingo	Puebla	Mexico
13983	Huauchinango	Puebla	Mexico
13984	Huatusco de Chicuellar	Veracruz	Mexico
13986	Frontera Comalapa	Chiapas	Mexico
13987	Frontera	Tabasco	Mexico
13989	Felipe Carrillo Puerto	Quintana Roo	Mexico
13991	Emiliano Zapata	Morelos	Mexico
13992	Emiliano Zapata	Chiapas	Mexico
13993	Ciudad Mante	Tamaulipas	Mexico
13996	Cuernavaca	Morelos	Mexico
13997	Cuautlancingo	Puebla	Mexico
13998	Cuautla Morelos	Morelos	Mexico
14000	Cuautepec de Hinojosa	Hidalgo	Mexico
14001	Cuajimalpa	Mexico City	Mexico
14002	San Miguel de Cozumel	Quintana Roo	Mexico
14003	Coyotepec	Morelos	Mexico
14005	Cosoleacaque	Veracruz	Mexico
14006	Cosamaloapan de Carpio	Veracruz	Mexico
14008	San Bernardino Contla	Tlaxcala	Mexico
14010	Comalcalco	Tabasco	Mexico
14011	Coatzintla	Veracruz	Mexico
14012	Coatzacoalcos	Veracruz	Mexico
14013	Coatepec	Veracruz	Mexico
14015	Ciudad Victoria	Tamaulipas	Mexico
14018	Ciudad Sahagun	Hidalgo	Mexico
14021	Ciudad Mendoza	Veracruz	Mexico
14022	Ciudad Madero	Tamaulipas	Mexico
14024	Mexico City	Mexico City	Mexico
14025	Ciudad del Carmen	Campeche	Mexico
14026	Cintalapa de Figueroa	Chiapas	Mexico
14027	Cholula	Puebla	Mexico
14028	Chilpancingo de los Bravos	Guerrero	Mexico
14029	Chilapa de Alvarez	Guerrero	Mexico
14030	Chignahuapan	Puebla	Mexico
14035	Chiapa de Corzo	Chiapas	Mexico
14036	Chetumal	Quintana Roo	Mexico
14039	Cerro Azul	Veracruz	Mexico
14040	Catemaco	Veracruz	Mexico
14041	Carlos A. Carrillo	Veracruz	Mexico
14044	Capulhuac	Morelos	Mexico
14046	Campeche	Campeche	Mexico
14047	Calpulalpan	Hidalgo	Mexico
14050	Banderilla	Veracruz	Mexico
14051	Azcapotzalco	Mexico City	Mexico
14052	Axochiapan	Morelos	Mexico
14053	Atlixco	Puebla	Mexico
14056	Apizaco	Tlaxcala	Mexico
14057	Apan	Hidalgo	Mexico
14058	Amozoc de Mota	Puebla	Mexico
14060	Heroica Alvarado	Veracruz	Mexico
14061	Altotonga	Veracruz	Mexico
14062	Altepexi	Puebla	Mexico
14063	Altamira	Tamaulipas	Mexico
14064	Allende	Veracruz	Mexico
14066	Ajalpan	Puebla	Mexico
14067	Agua Dulce	Veracruz	Mexico
14068	Actopan	Hidalgo	Mexico
14069	Acayucan	Veracruz	Mexico
14070	Acatzingo de Hidalgo	Puebla	Mexico
14073	Acajete	Puebla	Mexico
14074	San Antonio de la Cal	Oaxaca	Mexico
14077	Huamantla	Tlaxcala	Mexico
14078	Zacatelco	Tlaxcala	Mexico
14079	Tlaxcala de Xicohtencatl	Tlaxcala	Mexico
14080	Papalotla	Tlaxcala	Mexico
14081	Vicente Guerrero	Tlaxcala	Mexico
14083	Arriaga	Chiapas	Mexico
14085	Tampico	Tamaulipas	Mexico
14086	Alto Lucero	Veracruz	Mexico
14087	San Mateo Otzacatipan	Morelos	Mexico
14089	San Lorenzo Acopilco	Mexico City	Mexico
14090	Benito Juarez	Mexico City	Mexico
14091	Venustiano Carranza	Mexico City	Mexico
14092	Miguel Hidalgo	Mexico City	Mexico
14101	Leyva Solano	Sinaloa	Mexico
14103	Guadalupe Victoria	Baja California	Mexico
14104	Ixtapa-Zihuatanejo	Guerrero	Mexico
14105	Zapotlanejo	Jalisco	Mexico
14106	Zapotiltic	Jalisco	Mexico
14107	Zapopan	Jalisco	Mexico
14109	Zacoalco de Torres	Jalisco	Mexico
14110	Zacatecas	Zacatecas	Mexico
14112	Yuriria	Guanajuato	Mexico
14115	Ciudad Frontera	Coahuila	Mexico
14118	Valle de Santiago	Guanajuato	Mexico
14121	Uriangato	Guanajuato	Mexico
14122	Tuxpan	Jalisco	Mexico
14123	Torreon	Coahuila	Mexico
14125	Tlaquepaque	Jalisco	Mexico
14127	Tijuana	Baja California	Mexico
14129	Tequila	Jalisco	Mexico
14130	Tepic	Nayarit	Mexico
14133	Teocaltiche	Jalisco	Mexico
14135	Tecoman	Colima	Mexico
14136	Tecate	Baja California	Mexico
14138	Tamazula de Gordiano	Jalisco	Mexico
14139	Tala	Jalisco	Mexico
14141	Sombrerete	Zacatecas	Mexico
14143	Silao	Guanajuato	Mexico
14144	Sayula	Jalisco	Mexico
14145	Santiago Papasquiaro	Durango	Mexico
14146	Santiago Ixcuintla	Nayarit	Mexico
14150	Santa Anita	Jalisco	Mexico
14152	San Pedro	Coahuila	Mexico
14154	San Miguel el Alto	Jalisco	Mexico
14155	San Miguel de Papasquiaro	Durango	Mexico
14156	San Miguel de Allende	Guanajuato	Mexico
14159	San Luis de la Paz	Guanajuato	Mexico
14160	San Luis de la Paz	Guerrero	Mexico
14161	Cabo San Lucas	Baja California Sur	Mexico
14162	San Juan de los Lagos	Jalisco	Mexico
14166	San Felipe	Baja California	Mexico
14167	San Felipe	Guanajuato	Mexico
14168	San Buenaventura	Coahuila	Mexico
14170	Salvatierra	Guanajuato	Mexico
14171	Saltillo	Coahuila	Mexico
14172	Salamanca	Guanajuato	Mexico
14175	Ciudad Sabinas	Coahuila	Mexico
14176	Rosarito	Baja California	Mexico
14177	Romita	Guanajuato	Mexico
14180	Ramos Arizpe	Coahuila	Mexico
14183	Puerto Vallarta	Jalisco	Mexico
14185	Piedras Negras	Coahuila	Mexico
14189	Parras de la Fuente	Coahuila	Mexico
14191	Palau	Coahuila	Mexico
14192	Ojinaga	Chihuahua	Mexico
14195	Nuevo Casas Grandes	Chihuahua	Mexico
14196	Nueva Rosita	Coahuila	Mexico
14199	Navolato	Sinaloa	Mexico
14200	Navojoa	Sonora	Mexico
14201	Nava	Coahuila	Mexico
14205	Monclova	Coahuila	Mexico
14206	Mexicali	Baja California	Mexico
14207	Pedro Meoqui	Chihuahua	Mexico
14209	Medina	Guanajuato	Mexico
14212	Matamoros	Coahuila	Mexico
14213	Marfil	Guanajuato	Mexico
14215	Manzanillo	Colima	Mexico
14217	Magdalena de Kino	Sonora	Mexico
14218	San Pedro Madera	Chihuahua	Mexico
14219	Los Mochis	Sinaloa	Mexico
14220	Loreto	Zacatecas	Mexico
14222	Las Pintas de Arriba	Jalisco	Mexico
14224	La Paz	Baja California Sur	Mexico
14226	Lagos de Moreno	Jalisco	Mexico
14227	La Cruz	Sinaloa	Mexico
14228	La Barca	Jalisco	Mexico
14229	Santa Cruz de Juventino Rosas	Guanajuato	Mexico
14230	Jocotepec	Jalisco	Mexico
14235	Jaral del Progreso	Guanajuato	Mexico
14236	Jamay	Jalisco	Mexico
14240	Irapuato	Guanajuato	Mexico
14242	Huatabampo	Sonora	Mexico
14243	Hidalgo del Parral	Chihuahua	Mexico
14245	Nogales	Sonora	Mexico
14246	Heroica Caborca	Sonora	Mexico
14247	Hermosillo	Sonora	Mexico
14248	Heroica Guaymas	Sonora	Mexico
14249	Guasave	Sinaloa	Mexico
14250	Guanajuato	Guanajuato	Mexico
14253	Guadalupe	Zacatecas	Mexico
14254	Guadalajara	Jalisco	Mexico
14255	Gomez Palacio	Durango	Mexico
14256	Juan Jose Rios	Sinaloa	Mexico
14259	Fresnillo	Zacatecas	Mexico
14260	Escuinapa de Hidalgo	Sinaloa	Mexico
14261	Ensenada	Baja California	Mexico
14263	Empalme	Sonora	Mexico
14264	Pueblo Nuevo	Durango	Mexico
14265	El Salto	Jalisco	Mexico
14267	El Grullo	Jalisco	Mexico
14268	Victoria de Durango	Durango	Mexico
14271	Villa de Costa Rica	Sinaloa	Mexico
14272	Cortazar	Guanajuato	Mexico
14273	Compostela	Nayarit	Mexico
14274	Comonfort	Guanajuato	Mexico
14275	Colima	Colima	Mexico
14277	Ciudad Lerdo	Coahuila	Mexico
14281	Ciudad Delicias	Chihuahua	Mexico
14283	Ciudad Camargo	Chihuahua	Mexico
14285	Ciudad Altamirano	Guerrero	Mexico
14287	Chihuahua	Chihuahua	Mexico
14288	Chapala	Jalisco	Mexico
14289	Celaya	Guanajuato	Mexico
14291	Cananea	Sonora	Mexico
14293	Calvillo	Aguascalientes	Mexico
14297	Atotonilco el Alto	Jalisco	Mexico
14298	Armeria	Colima	Mexico
14299	Arcelia	Guerrero	Mexico
14300	Arandas	Jalisco	Mexico
14303	Apaseo el Grande	Guanajuato	Mexico
14304	Apaseo el Alto	Guanajuato	Mexico
14305	Ameca	Jalisco	Mexico
14306	Allende	Coahuila	Mexico
14308	Aguascalientes	Aguascalientes	Mexico
14309	Agua Prieta	Sonora	Mexico
14310	Acaponeta	Nayarit	Mexico
14312	Abasolo	Guanajuato	Mexico
14314	Dolores Hidalgo Cuna de la Independencia Nacional	Guanajuato	Mexico
14317	Colonia del Valle	Mexico City	Mexico
14319	Colonia Nativitas	Mexico City	Mexico
14320	Las Delicias	Baja California	Mexico
14323	Manzanillo	Colima	Mexico
14325	Hacienda Santa Fe	Jalisco	Mexico
14336	Centro Familiar la Soledad	Guanajuato	Mexico
14338	Las Pintitas	Jalisco	Mexico
14345	Manuel Ojinaga	Chihuahua	Mexico
14346	Terrazas del Valle	Baja California	Mexico
14347	La Ermita	Guanajuato	Mexico
14348	Lomas del Sur	Jalisco	Mexico
14352	Tres de Mayo	Morelos	Mexico
14353	Don Antonio	Hidalgo	Mexico
14354	Heroica Ciudad de Tlaxiaco	Oaxaca	Mexico
14355	Ciudad de Huitzuco	Guerrero	Mexico
14356	Casa Blanca	Puebla	Mexico
14357	La Providencia Siglo XXI	Hidalgo	Mexico
14359	Fraccionamiento Ciudad Olmeca	Veracruz	Mexico
14360	San Rafael Tlanalapan	Puebla	Mexico
14364	Crucecita	Oaxaca	Mexico
14365	Padang Mat Sirat	Kedah	Malaysia
14366	Kuah	Kedah	Malaysia
14367	Jerantut	Pahang	Malaysia
14368	Raub	Pahang	Malaysia
14369	Batu Pahat	Johor	Malaysia
14370	Parit Raja	Johor	Malaysia
14371	Pekan Nenas	Johor	Malaysia
14372	Pontian Kechil	Johor	Malaysia
14373	Kampung Pasir Gudang Baru	Johor	Malaysia
14374	Kota Tinggi	Johor	Malaysia
14375	Taman Senai	Johor	Malaysia
14376	Kulai	Johor	Malaysia
14377	Skudai	Johor	Malaysia
14378	Johor Bahru	Johor	Malaysia
14379	Kluang	Johor	Malaysia
14380	Yong Peng	Johor	Malaysia
14381	Mersing	Johor	Malaysia
14382	Segamat	Johor	Malaysia
14383	Tangkak	Johor	Malaysia
14384	Muar	Johor	Malaysia
14385	Bakri	Johor	Malaysia
14386	Labis	Johor	Malaysia
14387	Kuala Selangor	Selangor	Malaysia
14388	Batang Berjuntai	Selangor	Malaysia
14389	Batu Arang	Selangor	Malaysia
14390	Shah Alam	Selangor	Malaysia
14391	Klang	Selangor	Malaysia
14392	Cukai	Terengganu	Malaysia
14393	Kuala Lipis	Pahang	Malaysia
14394	Papar	Sabah	Malaysia
14395	Kota Kinabalu	Sabah	Malaysia
14396	Donggongon	Sabah	Malaysia
14397	Putatan	Sabah	Malaysia
14398	Kinarut	Sabah	Malaysia
14399	Ranau	Sabah	Malaysia
14400	Semporna	Sabah	Malaysia
14401	Victoria	Labuan	Malaysia
14402	Beaufort	Sabah	Malaysia
14403	Lahad Datu	Sabah	Malaysia
14404	Sandakan	Sabah	Malaysia
14405	Keningau	Sabah	Malaysia
14406	Tawau	Sabah	Malaysia
14407	Paka	Terengganu	Malaysia
14408	Kertih	Terengganu	Malaysia
14409	Kulim	Kedah	Malaysia
14410	Bagan Serai	Perak	Malaysia
14411	Bedong	Kedah	Malaysia
14412	Simpang Empat	Perak	Malaysia
14413	Taiping	Perak	Malaysia
14414	Kuala Kangsar	Perak	Malaysia
14415	Ipoh	Perak	Malaysia
14416	Gua Musang	Kelantan	Malaysia
14417	Kuala Terengganu	Terengganu	Malaysia
14418	Marang	Terengganu	Malaysia
14419	Tampin	Negeri Sembilan	Malaysia
14420	Alor Gajah	Melaka	Malaysia
14421	Kampung Ayer Keroh	Melaka	Malaysia
14422	Sungai Udang	Melaka	Malaysia
14423	Malacca	Melaka	Malaysia
14424	Banting	Selangor	Malaysia
14425	Jenjarum	Selangor	Malaysia
14426	Semenyih	Selangor	Malaysia
14427	Seremban	Negeri Sembilan	Malaysia
14428	Port Dickson	Negeri Sembilan	Malaysia
14429	Sepang	Selangor	Malaysia
14430	Bahau	Negeri Sembilan	Malaysia
14431	Kuala Pilah	Negeri Sembilan	Malaysia
14432	Pekan	Pahang	Malaysia
14433	Mentekab	Pahang	Malaysia
14434	Temerluh	Pahang	Malaysia
14435	Butterworth	Penang	Malaysia
14436	Perai	Penang	Malaysia
14437	Bukit Mertajam	Penang	Malaysia
14438	Nibong Tebal	Penang	Malaysia
14439	Parit Buntar	Perak	Malaysia
14440	Tasek Glugor	Penang	Malaysia
14441	George Town	Penang	Malaysia
14442	Serendah	Selangor	Malaysia
14443	Rawang	Selangor	Malaysia
14444	Petaling Jaya	Selangor	Malaysia
14445	Kuala Lumpur	Kuala Lumpur	Malaysia
14446	Sabak Bernam	Selangor	Malaysia
14447	Sungai Besar	Selangor	Malaysia
14448	Kuantan	Pahang	Malaysia
14449	Batu Gajah	Perak	Malaysia
14450	Kampar	Perak	Malaysia
14451	Tapah Road	Perak	Malaysia
14452	Bidur	Perak	Malaysia
14453	Lumut	Perak	Malaysia
14454	Teluk Intan	Perak	Malaysia
14455	Gurun	Kedah	Malaysia
14456	Sungai Petani	Kedah	Malaysia
14457	Kepala Batas	Penang	Malaysia
14458	Tanah Merah	Kelantan	Malaysia
14459	Kuching	Sarawak	Malaysia
14460	Simanggang	Sarawak	Malaysia
14461	Sarikei	Sarawak	Malaysia
14462	Sibu	Sarawak	Malaysia
14463	Kangar	Perlis	Malaysia
14464	Jitra	Kedah	Malaysia
14465	Kuala Kedah	Kedah	Malaysia
14466	Alor Setar	Kedah	Malaysia
14467	Pasir Mas	Kelantan	Malaysia
14468	Kota Bharu	Kelantan	Malaysia
14469	Kudat	Sabah	Malaysia
14470	Kapit	Sarawak	Malaysia
14471	Bintulu	Sarawak	Malaysia
14472	Limbang	Sarawak	Malaysia
14473	Miri	Sarawak	Malaysia
14474	Ulu Tiram	Johor	Malaysia
14475	Tanjung Tokong	Penang	Malaysia
14476	Tanjung Sepat	Selangor	Malaysia
14477	Permatang Kuching	Penang	Malaysia
14478	Peringat	Kelantan	Malaysia
14479	Ladang Seri Kundang	Selangor	Malaysia
14480	Pantai Remis	Perak	Malaysia
14481	Kuang	Selangor	Malaysia
14482	Klebang Besar	Melaka	Malaysia
14483	Kampung Tanjung Karang	Selangor	Malaysia
14484	Kampung Sungai Ara	Penang	Malaysia
14485	Kampung Simpang Renggam	Johor	Malaysia
14486	Kampong Pangkal Kalong	Kelantan	Malaysia
14487	Kampong Masjid Tanah	Melaka	Malaysia
14488	Kampong Kadok	Kelantan	Malaysia
14489	Kampong Dungun	Perak	Malaysia
14490	Kampung Bukit Baharu	Melaka	Malaysia
14491	Kampung Baru Subang	Selangor	Malaysia
14492	Kampung Baharu Nilai	Negeri Sembilan	Malaysia
14493	Kampong Baharu Balakong	Selangor	Malaysia
14494	Kampung Ayer Molek	Melaka	Malaysia
14495	Bukit Rambai	Melaka	Malaysia
14496	Bentong Town	Pahang	Malaysia
14497	Batu Berendam	Melaka	Malaysia
14498	Putrajaya	Putrajaya	Malaysia
14499	Bandar Labuan	Sabah	Malaysia
14500	Subang Jaya	Selangor	Malaysia
14501	Putra Heights	Selangor	Malaysia
14502	Pantai Cenang	Perlis	Malaysia
14503	Xai-Xai	Gaza	Mozambique
14504	Dondo	Sofala	Mozambique
14505	Macia	Gaza	Mozambique
14506	Tete	Tete	Mozambique
14507	Ressano Garcia	Maputo	Mozambique
14509	Pemba	Cabo Delgado	Mozambique
14510	Nampula	Nampula	Mozambique
14511	Nacala	Nampula	Mozambique
14512	Montepuez	Cabo Delgado	Mozambique
14515	Maxixe	Inhambane	Mozambique
14516	Matola	Maputo	Mozambique
14517	Maputo	Maputo City	Mozambique
14518	Manjacaze	Gaza	Mozambique
14519	Lichinga	Niassa	Mozambique
14520	Inhambane	Inhambane	Mozambique
14521	Cuamba	Niassa	Mozambique
14523	Chimoio	Manica	Mozambique
14524	Chibuto	Gaza	Mozambique
14525	Beira	Sofala	Mozambique
14528	Katima Mulilo	Zambezi	Namibia
14529	Windhoek	Khomas	Namibia
14530	Swakopmund	Erongo	Namibia
14531	Rundu	Kavango East	Namibia
14532	Rehoboth	Hardap	Namibia
14533	Otjiwarongo	Otjozondjupa	Namibia
14534	Oshakati	Oshana	Namibia
14535	Okahandja	Otjozondjupa	Namibia
14537	Keetmanshoop	Karas	Namibia
14538	Grootfontein	Otjozondjupa	Namibia
14539	Gobabis	Omaheke	Namibia
14540	Walvis Bay	Erongo	Namibia
14542	Mont-Dore	South Province	New Caledonia
14544	Birni N Konni	Tahoua	Niger
14545	Zinder	Zinder	Niger
14547	Tibiri	Maradi	Niger
14548	Tessaoua	Maradi	Niger
14550	Tanout	Zinder	Niger
14551	Tahoua	Tahoua	Niger
14552	Niamey	Niamey	Niger
14553	Nguigmi	Diffa	Niger
14554	Mirriah	Zinder	Niger
14555	Mayahi	Maradi	Niger
14556	Matamey	Zinder	Niger
14557	Maradi	Maradi	Niger
14558	Magaria	Zinder	Niger
14559	Madaoua	Tahoua	Niger
14561	Gaya	Dosso	Niger
14562	Dosso	Dosso	Niger
14563	Dogondoutchi	Dosso	Niger
14564	Diffa	Diffa	Niger
14565	Dakoro	Maradi	Niger
14567	Alaghsas	Agadez	Niger
14568	Agadez	Agadez	Niger
14569	Kingston	N/A	Norfolk Island
14570	Zuru	Kebbi	Nigeria
14571	Zungeru	Niger	Nigeria
14572	Zaria	Kaduna	Nigeria
14573	Yola	Adamawa	Nigeria
14574	Yenagoa	Bayelsa	Nigeria
14575	Wukari	Taraba	Nigeria
14576	Wudil	Kano	Nigeria
14577	Warri	Delta	Nigeria
14578	Wamba	Nassarawa	Nigeria
14579	Uyo	Akwa Ibom	Nigeria
14580	Uromi	Edo	Nigeria
14581	Umuahia	Abia	Nigeria
14582	Ughelli	Delta	Nigeria
14583	Ugep	Cross River	Nigeria
14584	Uga	Anambra	Nigeria
14585	Ubiaja	Edo	Nigeria
14586	Tegina	Niger	Nigeria
14587	Tambuwal	Sokoto	Nigeria
14588	Talata Mafara	Zamfara	Nigeria
14589	Takum	Benue	Nigeria
14590	Suleja	Niger	Nigeria
14591	Sokoto	Sokoto	Nigeria
14592	Soba	Kaduna	Nigeria
14593	Saki	Oyo	Nigeria
14594	Shagamu	Ogun	Nigeria
14595	Sapele	Delta	Nigeria
14596	Rijau	Niger	Nigeria
14597	Rano	Kano	Nigeria
14598	Potiskum	Yobe	Nigeria
14599	Port Harcourt	Rivers	Nigeria
14600	Pindiga	Gombe	Nigeria
14601	Patigi	Kwara	Nigeria
14602	Pankshin	Plateau	Nigeria
14603	Ozubulu	Anambra	Nigeria
14604	Oyo	Oyo	Nigeria
14605	Oyan	Osun	Nigeria
14606	Owo	Ondo	Nigeria
14607	Owerri	Imo	Nigeria
14608	Otukpa	Benue	Nigeria
14609	Otan Ayegbaju	Osun	Nigeria
14610	Osogbo	Osun	Nigeria
14611	Orita Eruwa	Oyo	Nigeria
14612	Onitsha	Anambra	Nigeria
14613	Ondo	Ondo	Nigeria
14614	Olupona	Osun	Nigeria
14615	Okuta	Kwara	Nigeria
14616	Okrika	Rivers	Nigeria
14617	Okigwe	Imo	Nigeria
14618	Okene	Kogi	Nigeria
14619	Oke Mesi	Osun	Nigeria
14620	Oke Ila	Ekiti	Nigeria
14621	Ohafia-Ifigh	Abia	Nigeria
14622	Ogwashi-Uku	Delta	Nigeria
14623	Oguta	Imo	Nigeria
14624	Ogoja	Cross River	Nigeria
14625	Ogaminana	Kogi	Nigeria
14626	Offa	Kwara	Nigeria
14627	Ode	Ondo	Nigeria
14628	Obudu	Cross River	Nigeria
14629	Obonoma	Rivers	Nigeria
14630	Numan	Adamawa	Nigeria
14631	Nsukka	Enugu	Nigeria
14632	Nnewi	Anambra	Nigeria
14633	Nkwerre	Imo	Nigeria
14634	Nkpor	Anambra	Nigeria
14635	Nguru	Yobe	Nigeria
14636	Nasarawa	Nassarawa	Nigeria
14637	Nafada	Gombe	Nigeria
14638	Mubi	Adamawa	Nigeria
14639	Moriki	Zamfara	Nigeria
14640	Monguno	Borno	Nigeria
14641	Mokwa	Niger	Nigeria
14642	Modakeke	Osun	Nigeria
14643	Minna	Niger	Nigeria
14644	Marte	Borno	Nigeria
14645	Malumfashi	Katsina	Nigeria
14646	Makurdi	Benue	Nigeria
14647	Makoko	Lagos	Nigeria
14648	Maiduguri	Borno	Nigeria
14649	Magumeri	Borno	Nigeria
14650	Lokoja	Kogi	Nigeria
14651	Lere	Kaduna	Nigeria
14652	Lapai	Niger	Nigeria
14653	Lalupon	Oyo	Nigeria
14654	Lagos	Lagos	Nigeria
14655	Lafiagi	Kwara	Nigeria
14656	Lafia	Nassarawa	Nigeria
14657	Kwale	Delta	Nigeria
14658	Kumo	Gombe	Nigeria
14659	Kumagunnam	Yobe	Nigeria
14660	Kukawa	Borno	Nigeria
14661	Kuje	Abuja Federal Capital Territory	Nigeria
14662	Kontagora	Niger	Nigeria
14663	Kiyawa	Jigawa	Nigeria
14664	Kisi	Oyo	Nigeria
14665	Keffi	Nassarawa	Nigeria
14666	Kaura Namoda	Zamfara	Nigeria
14667	Katsina-Ala	Benue	Nigeria
14668	Katsina	Katsina	Nigeria
14669	Kari	Bauchi	Nigeria
14670	Kano	Kano	Nigeria
14671	Kamba	Kebbi	Nigeria
14672	Kaiama	Kwara	Nigeria
14673	Kagoro	Kaduna	Nigeria
14674	Kafanchan	Kaduna	Nigeria
14675	Kaduna	Kaduna	Nigeria
14676	Kachia	Kaduna	Nigeria
14677	Kabba	Kogi	Nigeria
14678	Jos	Plateau	Nigeria
14679	Jimeta	Adamawa	Nigeria
14680	Jega	Kebbi	Nigeria
14681	Jebba	Kwara	Nigeria
14682	Jalingo	Taraba	Nigeria
14683	Iwo	Osun	Nigeria
14684	Itu	Akwa Ibom	Nigeria
14685	Isieke	Ebonyi	Nigeria
14686	Ise-Ekiti	Ekiti	Nigeria
14687	Isanlu-Itedoijowa	Kogi	Nigeria
14688	Ipoti	Ekiti	Nigeria
14689	Iperu	Ogun	Nigeria
14690	Inisa	Osun	Nigeria
14691	Ilorin	Kwara	Nigeria
14692	Ilobu	Osun	Nigeria
14693	Illela	Sokoto	Nigeria
14694	Ilesa	Osun	Nigeria
14695	Ilaro	Ogun	Nigeria
14696	Ila Orangun	Osun	Nigeria
14697	Ikot Ekpene	Akwa Ibom	Nigeria
14698	Ikom	Cross River	Nigeria
14699	Ikirun	Osun	Nigeria
14700	Ikire	Osun	Nigeria
14701	Ikere-Ekiti	Ekiti	Nigeria
14702	Ikeja	Lagos	Nigeria
14703	Ijero-Ekiti	Ekiti	Nigeria
14704	Ijebu-Ode	Ogun	Nigeria
14705	Ijebu-Jesa	Osun	Nigeria
14706	Ijebu-Igbo	Ogun	Nigeria
14707	Ihiala	Anambra	Nigeria
14708	Igede-Ekiti	Ekiti	Nigeria
14709	Igbo-Ukwu	Anambra	Nigeria
14710	Igbor	Benue	Nigeria
14711	Igbo-Ora	Oyo	Nigeria
14712	Igboho	Oyo	Nigeria
14713	Igbeti	Oyo	Nigeria
14714	Igbara-Odo	Ekiti	Nigeria
14715	Ifo	Ogun	Nigeria
14716	Idanre	Ondo	Nigeria
14717	Idah	Kogi	Nigeria
14718	Ibi	Taraba	Nigeria
14719	Ibeto	Niger	Nigeria
14720	Ibadan	Oyo	Nigeria
14721	Hadejia	Jigawa	Nigeria
14722	Gwoza	Borno	Nigeria
14723	Gwarzo	Kano	Nigeria
14724	Gwaram	Jigawa	Nigeria
14725	Gwadabawa	Sokoto	Nigeria
14726	Gusau	Zamfara	Nigeria
14727	Gummi	Zamfara	Nigeria
14728	Gumel	Jigawa	Nigeria
14729	Gombi	Adamawa	Nigeria
14730	Gombe	Gombe	Nigeria
14731	Gembu	Taraba	Nigeria
14732	Geidam	Yobe	Nigeria
14733	Gbongan	Osun	Nigeria
14734	Gaya	Kano	Nigeria
14735	Gashua	Yobe	Nigeria
14736	Garko	Gombe	Nigeria
14737	Ganye	Adamawa	Nigeria
14738	Gamboru	Borno	Nigeria
14739	Funtua	Katsina	Nigeria
14740	Fiditi	Oyo	Nigeria
14741	Ezza-Ohu	Ebonyi	Nigeria
14742	Esuk Oron	Akwa Ibom	Nigeria
14743	Epe	Lagos	Nigeria
14744	Enugu-Ukwu	Anambra	Nigeria
14745	Enugu-Ezike	Enugu	Nigeria
14746	Enugu	Enugu	Nigeria
14747	Emure-Ekiti	Ekiti	Nigeria
14748	Elele	Rivers	Nigeria
14749	Ekpoma	Edo	Nigeria
14750	Eket	Akwa Ibom	Nigeria
14751	Ejigbo	Osun	Nigeria
14752	Eha Amufu	Enugu	Nigeria
14753	Egbe	Kogi	Nigeria
14754	Effon Alaiye	Osun	Nigeria
14755	Effium	Ebonyi	Nigeria
14756	Ebute Ikorodu	Lagos	Nigeria
14757	Dutsen Wai	Kaduna	Nigeria
14758	Dutse	Jigawa	Nigeria
14759	Dukku	Gombe	Nigeria
14760	Doma	Nassarawa	Nigeria
14761	Dikwa	Borno	Nigeria
14762	Deba	Gombe	Nigeria
14763	Daura	Katsina	Nigeria
14764	Daura	Yobe	Nigeria
14765	Darazo	Bauchi	Nigeria
14766	Damboa	Borno	Nigeria
14767	Damaturu	Yobe	Nigeria
14768	Calabar	Cross River	Nigeria
14769	Burutu	Delta	Nigeria
14770	Bukuru	Plateau	Nigeria
14771	Buguma	Rivers	Nigeria
14772	Bonny	Rivers	Nigeria
14773	Bode Saadu	Kwara	Nigeria
14774	Biu	Borno	Nigeria
14775	Birnin Kudu	Jigawa	Nigeria
14776	Birnin Kebbi	Kebbi	Nigeria
14777	Sofo-Birnin-Gwari	Kaduna	Nigeria
14778	Billiri	Gombe	Nigeria
14779	Bida	Niger	Nigeria
14780	Benin City	Edo	Nigeria
14781	Bende	Abia	Nigeria
14782	Beli	Taraba	Nigeria
14783	Bauchi	Bauchi	Nigeria
14784	Baro	Niger	Nigeria
14785	Bama	Borno	Nigeria
14786	Badagry	Lagos	Nigeria
14787	Babana	Niger	Nigeria
14788	Azare	Bauchi	Nigeria
14789	Awka	Anambra	Nigeria
14790	Awgu	Enugu	Nigeria
14791	Auchi	Edo	Nigeria
14792	Asaba	Delta	Nigeria
14793	Argungu	Kebbi	Nigeria
14794	Aramoko-Ekiti	Ekiti	Nigeria
14795	Apomu	Osun	Nigeria
14796	Anchau	Kaduna	Nigeria
14797	Amaigbo	Abia	Nigeria
14798	Akwanga	Nassarawa	Nigeria
14799	Akure	Ondo	Nigeria
14800	Aku	Enugu	Nigeria
14801	Ajaokuta	Kogi	Nigeria
14802	Agulu	Anambra	Nigeria
14803	Agbor	Delta	Nigeria
14804	Afikpo	Ebonyi	Nigeria
14805	Ado Odo	Ogun	Nigeria
14806	Ado-Ekiti	Ekiti	Nigeria
14807	Abuja	Abuja Federal Capital Territory	Nigeria
14808	Abeokuta	Ogun	Nigeria
14809	Abakaliki	Ebonyi	Nigeria
14810	Aba	Abia	Nigeria
14811	Degema Hulk	Rivers	Nigeria
14812	Tipitapa	Managua	Nicaragua
14813	Somoto	Madriz	Nicaragua
14814	Somotillo	Chinandega	Nicaragua
14816	San Rafael del Sur	Managua	Nicaragua
14817	San Marcos	Carazo	Nicaragua
14818	Rivas	Rivas	Nicaragua
14822	Ocotal	Nueva Segovia	Nicaragua
14824	Nandaime	Granada	Nicaragua
14826	Matagalpa	Matagalpa	Nicaragua
14827	Masaya	Masaya	Nicaragua
14828	Masatepe	Masaya	Nicaragua
14829	Managua	Managua	Nicaragua
14832	Juigalpa	Chontales	Nicaragua
14833	Jinotepe	Carazo	Nicaragua
14834	Jinotega	Jinotega	Nicaragua
14835	Jalapa	Nueva Segovia	Nicaragua
14836	Granada	Granada	Nicaragua
14838	El Viejo	Chinandega	Nicaragua
14839	El Crucero	Managua	Nicaragua
14840	Diriamba	Carazo	Nicaragua
14841	Corinto	Chinandega	Nicaragua
14842	Chinandega	Chinandega	Nicaragua
14843	Chichigalpa	Chinandega	Nicaragua
14844	Camoapa	Boaco	Nicaragua
14845	Boaco	Boaco	Nicaragua
14847	Ciudad Sandino	Managua	Nicaragua
14848	Zwolle	Overijssel	Netherlands
14849	Zwijndrecht	South Holland	Netherlands
14850	Zutphen	Gelderland	Netherlands
14851	Zundert	North Brabant	Netherlands
14852	Zoetermeer	South Holland	Netherlands
14853	Zevenaar	Gelderland	Netherlands
14854	Zeist	Utrecht	Netherlands
14855	Zeewolde	Flevoland	Netherlands
14856	Zandvoort	North Holland	Netherlands
14857	Zaltbommel	Gelderland	Netherlands
14858	Zaanstad	North Holland	Netherlands
14859	Zaandam	North Holland	Netherlands
14860	Wolvega	Friesland	Netherlands
14861	Woerden	Utrecht	Netherlands
14862	Woensdrecht	North Brabant	Netherlands
14863	Wisch	Gelderland	Netherlands
14864	Winterswijk	Gelderland	Netherlands
14865	Winschoten	Groningen	Netherlands
14866	Wijk bij Duurstede	Utrecht	Netherlands
14867	Wijchen	Gelderland	Netherlands
14868	Wierden	Overijssel	Netherlands
14869	Westervoort	Gelderland	Netherlands
14870	Werkendam	North Brabant	Netherlands
14871	Weesp	North Holland	Netherlands
14872	Weert	Limburg	Netherlands
14873	Wassenaar	South Holland	Netherlands
14874	Wageningen	Gelderland	Netherlands
14875	Waddinxveen	South Holland	Netherlands
14876	Waalwijk	North Brabant	Netherlands
14877	Waalre	North Brabant	Netherlands
14878	Vught	North Brabant	Netherlands
14879	Voorst	Gelderland	Netherlands
14880	Voorschoten	South Holland	Netherlands
14881	Voorhout	South Holland	Netherlands
14882	Voorburg	South Holland	Netherlands
14883	Volendam	North Holland	Netherlands
14884	Vlissingen	Zeeland	Netherlands
14885	Vlagtwedde	Groningen	Netherlands
14886	Vlaardingen	South Holland	Netherlands
14887	Vianen	Utrecht	Netherlands
14888	Venray	Limburg	Netherlands
14889	Venlo	Limburg	Netherlands
14890	Velsen-Zuid	North Holland	Netherlands
14891	Velp	Gelderland	Netherlands
14892	Veldhoven	North Brabant	Netherlands
14893	Veghel	North Brabant	Netherlands
14894	Veere	Zeeland	Netherlands
14895	Veenendaal	Utrecht	Netherlands
14896	Veendam	Groningen	Netherlands
14897	Valkenswaard	North Brabant	Netherlands
14898	Utrecht	Utrecht	Netherlands
14899	Urk	Flevoland	Netherlands
14900	Uithoorn	North Holland	Netherlands
14901	Uden	North Brabant	Netherlands
14902	Tubbergen	Overijssel	Netherlands
14903	Tongelre	North Brabant	Netherlands
14904	Tilburg	North Brabant	Netherlands
14905	Tiel	Gelderland	Netherlands
14906	Terneuzen	Zeeland	Netherlands
14907	Tegelen	Limburg	Netherlands
14908	Steenwijk	Overijssel	Netherlands
14909	Steenbergen	North Brabant	Netherlands
14910	Staphorst	Overijssel	Netherlands
14911	Stadskanaal	Groningen	Netherlands
14912	Spijkenisse	South Holland	Netherlands
14913	Someren	North Brabant	Netherlands
14914	Soest	Utrecht	Netherlands
14915	Sneek	Friesland	Netherlands
14916	Sliedrecht	South Holland	Netherlands
14917	Sittard	Limburg	Netherlands
14918	Sint-Oedenrode	North Brabant	Netherlands
14919	s-Hertogenbosch	North Brabant	Netherlands
14920	s-Gravenzande	South Holland	Netherlands
14921	The Hague	South Holland	Netherlands
14922	Schijndel	North Brabant	Netherlands
14923	Schiedam	South Holland	Netherlands
14924	Scheveningen	South Holland	Netherlands
14925	Schagen	North Holland	Netherlands
14926	Rucphen	North Brabant	Netherlands
14927	Rotterdam	South Holland	Netherlands
14928	Roosendaal	North Brabant	Netherlands
14929	Roermond	Limburg	Netherlands
14930	Rijswijk	South Holland	Netherlands
14931	Ridderkerk	South Holland	Netherlands
14932	Rhoon	South Holland	Netherlands
14933	Rhenen	Utrecht	Netherlands
14934	Raalte	Overijssel	Netherlands
14935	Putten	Gelderland	Netherlands
14936	Purmerend	North Holland	Netherlands
14937	Pijnacker	South Holland	Netherlands
14938	Papendrecht	South Holland	Netherlands
14939	Oud-Beijerland	South Holland	Netherlands
14940	Oss	North Brabant	Netherlands
14941	Oosterhout	North Brabant	Netherlands
14942	Oldenzaal	Overijssel	Netherlands
14943	Oldebroek	Gelderland	Netherlands
14944	Oisterwijk	North Brabant	Netherlands
14945	Oegstgeest	South Holland	Netherlands
14946	Nuth	Limburg	Netherlands
14947	Nunspeet	Gelderland	Netherlands
14948	Nuenen	North Brabant	Netherlands
14949	Noordwijkerhout	South Holland	Netherlands
14950	Noordwijk-Binnen	South Holland	Netherlands
14951	Nijmegen	Gelderland	Netherlands
14952	Nijkerk	Gelderland	Netherlands
14953	Nieuwegein	Utrecht	Netherlands
14954	Nederweert	Limburg	Netherlands
14955	Naarden	North Holland	Netherlands
14956	Naaldwijk	South Holland	Netherlands
14957	Mijdrecht	Utrecht	Netherlands
14958	Middelharnis	South Holland	Netherlands
14959	Middelburg	Zeeland	Netherlands
14960	Meppel	Drenthe	Netherlands
14961	Meerssen	Limburg	Netherlands
14962	Medemblik	North Holland	Netherlands
14963	Maastricht	Limburg	Netherlands
14964	Maassluis	South Holland	Netherlands
14965	Maarssen	Utrecht	Netherlands
14966	Losser	Overijssel	Netherlands
14967	Loon op Zand	North Brabant	Netherlands
14968	Lisse	South Holland	Netherlands
14969	Lindenholt	Gelderland	Netherlands
14970	Lichtenvoorde	Gelderland	Netherlands
14971	Leusden	Utrecht	Netherlands
14972	Lelystad	Flevoland	Netherlands
14973	Leiderdorp	South Holland	Netherlands
14974	Leiden	South Holland	Netherlands
14975	Leeuwarden	Friesland	Netherlands
14976	Leerdam	South Holland	Netherlands
14977	Leek	Groningen	Netherlands
14978	Krimpen aan den IJssel	South Holland	Netherlands
14979	Korrewegwijk	Groningen	Netherlands
14980	Kerkrade	Limburg	Netherlands
14981	Katwijk aan Zee	South Holland	Netherlands
14982	Kampen	Overijssel	Netherlands
14983	IJsselstein	Utrecht	Netherlands
14984	Huizen	North Holland	Netherlands
14985	Houten	Utrecht	Netherlands
14986	Horst	Gelderland	Netherlands
14987	Hoorn	North Holland	Netherlands
14988	Hoogezand	Groningen	Netherlands
14989	Hoogeveen	Drenthe	Netherlands
14990	Hoofddorp	North Holland	Netherlands
14991	Hoge Vucht	North Brabant	Netherlands
14992	Hoensbroek	Limburg	Netherlands
14993	Hilversum	North Holland	Netherlands
14994	Hilvarenbeek	North Brabant	Netherlands
14995	Hillegom	South Holland	Netherlands
14996	Heusden	North Brabant	Netherlands
14997	Hengelo	Overijssel	Netherlands
14998	Hendrik-Ido-Ambacht	South Holland	Netherlands
14999	Helmond	North Brabant	Netherlands
15000	Hellevoetsluis	South Holland	Netherlands
15001	Heiloo	North Holland	Netherlands
15002	Heesch	North Brabant	Netherlands
15003	Heerlen	Limburg	Netherlands
15004	Heerhugowaard	North Holland	Netherlands
15005	Heerenveen	Friesland	Netherlands
15006	Heerde	Gelderland	Netherlands
15007	Heemstede	North Holland	Netherlands
15008	Heemskerk	North Holland	Netherlands
15009	Harlingen	Friesland	Netherlands
15010	Harenkarspel	North Holland	Netherlands
15011	Haren	Groningen	Netherlands
15012	Harderwijk	Gelderland	Netherlands
15013	Hardenberg	Overijssel	Netherlands
15014	Haarlem	North Holland	Netherlands
15015	Haaksbergen	Overijssel	Netherlands
15016	Groningen	Groningen	Netherlands
15017	Groesbeek	Gelderland	Netherlands
15018	Gouda	South Holland	Netherlands
15019	Gorinchem	South Holland	Netherlands
15020	Goirle	North Brabant	Netherlands
15021	Goes	Zeeland	Netherlands
15022	Gennep	Limburg	Netherlands
15023	Gendringen	Gelderland	Netherlands
15024	Geldrop	North Brabant	Netherlands
15025	Geldermalsen	Gelderland	Netherlands
15026	Geertruidenberg	North Brabant	Netherlands
15027	Ermelo	Gelderland	Netherlands
15028	Epe	Gelderland	Netherlands
15029	Enschede	Overijssel	Netherlands
15030	Enkhuizen	North Holland	Netherlands
15031	Emmen	Drenthe	Netherlands
15032	Emmeloord	Flevoland	Netherlands
15033	Elst	Gelderland	Netherlands
15034	Elburg	Gelderland	Netherlands
15035	Eindhoven	North Brabant	Netherlands
15036	Eibergen	Gelderland	Netherlands
15037	Eersel	North Brabant	Netherlands
15038	Ede	Gelderland	Netherlands
15039	Duiven	Gelderland	Netherlands
15040	Druten	Gelderland	Netherlands
15041	Dronten	Flevoland	Netherlands
15042	Drimmelen	North Brabant	Netherlands
15043	Driebergen-Rijsenburg	Utrecht	Netherlands
15044	Drachten	Friesland	Netherlands
15045	Dordrecht	South Holland	Netherlands
15046	Dongen	North Brabant	Netherlands
15047	Doetinchem	Gelderland	Netherlands
15048	Diemen	North Holland	Netherlands
15049	Deventer	Overijssel	Netherlands
15050	Den Helder	North Holland	Netherlands
15051	Delfzijl	Groningen	Netherlands
15052	Delft	South Holland	Netherlands
15053	Delfshaven	South Holland	Netherlands
15054	De Bilt	Utrecht	Netherlands
15055	Dalfsen	Overijssel	Netherlands
15056	Culemborg	Gelderland	Netherlands
15057	Cuijk	North Brabant	Netherlands
15058	Cranendonck	North Brabant	Netherlands
15059	Castricum	North Holland	Netherlands
15060	Capelle aan den IJssel	South Holland	Netherlands
15061	Bussum	North Holland	Netherlands
15062	Bunschoten	Utrecht	Netherlands
15063	Brunssum	Limburg	Netherlands
15064	Brummen	Gelderland	Netherlands
15065	Broek op Langedijk	North Holland	Netherlands
15066	Broek in Waterland	North Holland	Netherlands
15067	Breda	North Brabant	Netherlands
15068	Boxtel	North Brabant	Netherlands
15069	Boskoop	South Holland	Netherlands
15070	Borssele	Zeeland	Netherlands
15071	Borne	Overijssel	Netherlands
15072	Born	Limburg	Netherlands
15073	Borger	Drenthe	Netherlands
15074	Bodegraven	South Holland	Netherlands
15075	Bloemendaal	North Holland	Netherlands
15076	Bladel	North Brabant	Netherlands
15077	Beverwijk	North Holland	Netherlands
15078	Beuningen	Gelderland	Netherlands
15079	Best	North Brabant	Netherlands
15080	Bergschenhoek	South Holland	Netherlands
15081	Bergeijk	North Brabant	Netherlands
15082	Bergen op Zoom	North Brabant	Netherlands
15083	Benthuizen	South Holland	Netherlands
15084	Beek	Limburg	Netherlands
15085	Barneveld	Gelderland	Netherlands
15086	Barendrecht	South Holland	Netherlands
15087	Baarn	Utrecht	Netherlands
15088	Asten	North Brabant	Netherlands
15089	Assen	Drenthe	Netherlands
15090	Arnhem	Gelderland	Netherlands
15091	Apeldoorn	Gelderland	Netherlands
15092	Anloo	Drenthe	Netherlands
15093	Amsterdam	North Holland	Netherlands
15094	Amstelveen	North Holland	Netherlands
15095	Amersfoort	Utrecht	Netherlands
15096	Alphen aan den Rijn	South Holland	Netherlands
15097	Almere Stad	Flevoland	Netherlands
15098	Almelo	Overijssel	Netherlands
15099	Alkmaar	North Holland	Netherlands
15100	Alblasserdam	South Holland	Netherlands
15101	Aalten	Gelderland	Netherlands
15102	Aalsmeer	North Holland	Netherlands
15103	Amsterdam-Zuidoost	North Holland	Netherlands
15104	Berkel en Rodenrijs	South Holland	Netherlands
15105	Ypenburg	South Holland	Netherlands
15110	Stavanger	Rogaland	Norway
15111	Skien	Telemark	Norway
15113	Sandnes	Rogaland	Norway
15114	Sandefjord	Vestfold	Norway
15115	Porsgrunn	Telemark	Norway
15116	Oslo	Oslo	Norway
15119	Mo i Rana	Nordland	Norway
15120	Lillehammer	Oppland	Norway
15121	Larvik	Vestfold	Norway
15123	Kristiansand	Vest-Agder	Norway
15124	Kongsberg	Buskerud	Norway
15125	Horten	Vestfold	Norway
15126	Haugesund	Rogaland	Norway
15127	Harstad	Troms	Norway
15128	Hamar	Hedmark	Norway
15132	Drammen	Buskerud	Norway
15134	Bergen	Hordaland	Norway
15135	Arendal	Aust-Agder	Norway
15138	Ytrebygda	Hordaland	Norway
15139	Waling	Western Region	Nepal
15140	Tulsipur	Mid Western	Nepal
15141	Tikapur	Far Western	Nepal
15142	Tansen	Western Region	Nepal
15143	Siraha	Eastern Region	Nepal
15144	Rajbiraj	Eastern Region	Nepal
15145	Pokhara	Western Region	Nepal
15146	Patan	Central Region	Nepal
15148	Malangwa	Central Region	Nepal
15149	Mahendranagar	Far Western	Nepal
15150	Lahan	Eastern Region	Nepal
15151	Kirtipur	Central Region	Nepal
15152	Khandbari	Eastern Region	Nepal
15153	Kathmandu	Central Region	Nepal
15154	Janakpur	Central Region	Nepal
15155	Jaleswar	Central Region	Nepal
15156	Ithari	Eastern Region	Nepal
15157	Ilam	Eastern Region	Nepal
15158	Hetauda	Central Region	Nepal
15159	Gulariya	Mid Western	Nepal
15160	Gaur	Central Region	Nepal
15161	Dharan Bazar	Eastern Region	Nepal
15162	Dhankuta	Eastern Region	Nepal
15163	Dhangarhi	Far Western	Nepal
15164	Darchula	Western Region	Nepal
15165	Dailekh	Mid Western	Nepal
15166	Dadeldhura	Far Western	Nepal
15167	Butwal	Western Region	Nepal
15168	Birganj	Central Region	Nepal
15169	Biratnagar	Eastern Region	Nepal
15170	Bharatpur	Central Region	Nepal
15171	Bhairahawa	Western Region	Nepal
15172	Bhadrapur	Eastern Region	Nepal
15173	Banepa	Central Region	Nepal
15174	Baglung	Western Region	Nepal
15175	Birendranagar	Mid Western	Nepal
15176	Dipayal	Far Western	Nepal
15177	Nepalgunj	Mid Western	Nepal
15178	Yaren	Yaren	Nauru
15179	Alofi	N/A	Niue
15180	Wellington	Wellington	New Zealand
15181	Wanganui	Manawatu-Wanganui	New Zealand
15182	Timaru	Canterbury	New Zealand
15183	Taupo	Waikato	New Zealand
15184	Pukekohe East	Auckland	New Zealand
15185	Porirua	Wellington	New Zealand
15186	Paraparaumu	Wellington	New Zealand
15187	Palmerston North	Manawatu-Wanganui	New Zealand
15188	North Shore	Auckland	New Zealand
15189	New Plymouth	Taranaki	New Zealand
15190	Nelson	Nelson	New Zealand
15191	Napier	Hawkes Bay	New Zealand
15192	Manukau City	Auckland	New Zealand
15193	Mangere	Auckland	New Zealand
15194	Lower Hutt	Wellington	New Zealand
15195	Invercargill	Southland	New Zealand
15196	Hastings	Hawkes Bay	New Zealand
15197	Hamilton	Waikato	New Zealand
15198	Dunedin	Otago	New Zealand
15199	Christchurch	Canterbury	New Zealand
15200	Auckland	Auckland	New Zealand
15201	Levin	Manawatu-Wanganui	New Zealand
15202	Gisborne	Gisborne	New Zealand
15203	Masterton	Wellington	New Zealand
15204	Tauranga	Bay of Plenty	New Zealand
15205	Papakura	Auckland	New Zealand
15206	Whakatane	Bay of Plenty	New Zealand
15207	Ashburton	Canterbury	New Zealand
15208	Whangarei	Northland	New Zealand
15209	Cambridge	Waikato	New Zealand
15210	Rotorua	Bay of Plenty	New Zealand
15211	Blenheim	Marlborough	New Zealand
15212	Upper Hutt	Wellington	New Zealand
15213	Taradale	Hawkes Bay	New Zealand
15214	Waitakere	Auckland	New Zealand
15215	Sur	Ash Sharqiyah South Governorate	Oman
15216	Sohar	Al Batinah North Governorate	Oman
15218	Shinas	Al Batinah North Governorate	Oman
15220	Sa?am	Al Batinah North Governorate	Oman
15223	Khasab	Musandam	Oman
15231	Badiyah	Ash Sharqiyah North Governorate	Oman
15232	As Suwayq	Al Batinah North Governorate	Oman
15234	Rustaq	Al Batinah South Governorate	Oman
15236	Al Khaburah	Al Batinah North Governorate	Oman
15237	Al Buraymi	Al Buraimi	Oman
15243	Santiago de Veraguas	Veraguas	Panama
15259	Changuinola	Bocas del Toro	Panama
15264	Yurimaguas	Loreto	Peru
15267	Tumbes	Tumbes	Peru
15268	Trujillo	La Libertad	Peru
15271	Tambo Grande	Piura	Peru
15272	Talara	Piura	Peru
15273	Sullana	Piura	Peru
15274	Sechura	Piura	Peru
15275	Santiago de Cao	La Libertad	Peru
15276	San Pedro de Lloc	La Libertad	Peru
15279	Querecotillo	Piura	Peru
15280	Pucallpa	Ucayali	Peru
15281	Piura	Piura	Peru
15282	Pimentel	Lambayeque	Peru
15283	Picsi	Lambayeque	Peru
15284	Paita	Piura	Peru
15286	Pacasmayo	La Libertad	Peru
15289	Moche	La Libertad	Peru
15290	Marcavelica	Piura	Peru
15292	Laredo	La Libertad	Peru
15293	La Peca	Amazonas	Peru
15294	Lambayeque	Lambayeque	Peru
15297	Iquitos	Loreto	Peru
15298	Huaraz	Ancash	Peru
15300	Huamachuco	La Libertad	Peru
15301	Guadalupe	La Libertad	Peru
15303	Coishco	Ancash	Peru
15304	Chulucanas	Piura	Peru
15305	Chongoyape	Lambayeque	Peru
15306	Chocope	La Libertad	Peru
15307	Chimbote	Ancash	Peru
15308	Chiclayo	Lambayeque	Peru
15310	Chachapoyas	Amazonas	Peru
15311	Catacaos	Piura	Peru
15312	Cajamarca	Cajamarca	Peru
15314	Bagua Grande	Amazonas	Peru
15315	La Breita	Piura	Peru
15316	Zarumilla	Tumbes	Peru
15317	Yunguyo	Puno	Peru
15318	Yanacancha	Huanuco	Peru
15320	Tambopata	Madre de Dios	Peru
15321	Tacna	Tacna	Peru
15322	Santiago de Surco	Lima region	Peru
15323	Sicuani	Cusco	Peru
15326	Santa Ana	Cusco	Peru
15327	San Isidro	Lima region	Peru
15328	San Clemente	Ica	Peru
15329	Puno	Puno	Peru
15330	Puerto Maldonado	Madre de Dios	Peru
15331	Pisco	Ica	Peru
15332	Paramonga	Lima region	Peru
15333	Nuevo Imperial	Lima region	Peru
15334	Nazca	Ica	Peru
15335	Moquegua	Moquegua	Peru
15336	Mollendo	Arequipa	Peru
15337	Minas de Marcona	Ica	Peru
15338	Mala	Lima region	Peru
15339	Lima	Lima Province	Peru
15342	Juliaca	Puno	Peru
15344	Imperial	Lima region	Peru
15345	Ilo	Moquegua	Peru
15346	Ilave	Puno	Peru
15347	Ica	Ica	Peru
15348	Huaura	Lima region	Peru
15349	Huarmey	Ancash	Peru
15350	Huaral	Lima region	Peru
15351	Huanta	Ayacucho	Peru
15353	Huancavelica	Huancavelica	Peru
15354	Hualmay	Lima region	Peru
15355	Huacho	Lima region	Peru
15356	Cusco	Cusco	Peru
15357	Chosica	Lima region	Peru
15358	Chincha Alta	Ica	Peru
15359	Chaupimarca	Pasco	Peru
15360	Chancay	Lima region	Peru
15361	Cerro de Pasco	Pasco	Peru
15363	Callao	Callao	Peru
15364	Barranca	Lima region	Peru
15365	Ayaviri	Puno	Peru
15366	Ayacucho	Ayacucho	Peru
15367	Arequipa	Arequipa	Peru
15370	La Rinconada	Puno	Peru
15374	Wewak	East Sepik	Papua New Guinea
15375	Port Moresby	National Capital	Papua New Guinea
15376	Popondetta	Northern Province	Papua New Guinea
15377	Mount Hagen	Western Highlands	Papua New Guinea
15378	Mendi	Southern Highlands	Papua New Guinea
15379	Madang	Madang	Papua New Guinea
15380	Lae	Morobe	Papua New Guinea
15381	Kokopo	East New Britain	Papua New Guinea
15382	Kimbe	West New Britain	Papua New Guinea
15383	Goroka	Eastern Highlands	Papua New Guinea
15384	Daru	Western Province	Papua New Guinea
15385	Bulolo	Morobe	Papua New Guinea
15386	Arawa	Bougainville	Papua New Guinea
15387	Zamboanga	Zamboanga Peninsula	Philippines
15388	Wao	Autonomous Region in Muslim Mindanao	Philippines
15389	Virac	Bicol	Philippines
15390	Vigan	Ilocos	Philippines
15391	Victorias	Western Visayas	Philippines
15392	Victoria	Calabarzon	Philippines
15393	Veruela	Caraga	Philippines
15394	Valencia	Northern Mindanao	Philippines
15395	Urdaneta	Ilocos	Philippines
15396	Ualog	Western Visayas	Philippines
15397	Tupi	Davao	Philippines
15398	Tuguegarao City	Cagayan Valley	Philippines
15399	Trento	Caraga	Philippines
15400	Toledo	Central Visayas	Philippines
15401	Tiwi	Bicol	Philippines
15402	Ternate	Calabarzon	Philippines
15403	Teresa	Calabarzon	Philippines
15404	Telabastagan	Central Luzon	Philippines
15405	Taytay	Calabarzon	Philippines
15406	Tayabas	Calabarzon	Philippines
15407	Tarlac City	Central Luzon	Philippines
15408	Tanza	Metro Manila	Philippines
15409	Tanjay	Central Visayas	Philippines
15410	Tangub	Northern Mindanao	Philippines
15411	Tandag	Caraga	Philippines
15412	Tanay	Calabarzon	Philippines
15413	Tanauan	Calabarzon	Philippines
15414	Tanauan	Eastern Visayas	Philippines
15415	Taloc	Western Visayas	Philippines
15416	Talisay	Calabarzon	Philippines
15417	Talisay	Western Visayas	Philippines
15418	Talisay	Central Visayas	Philippines
15419	Talavera	Central Luzon	Philippines
15420	Talacogon	Caraga	Philippines
15421	Tagum	Davao	Philippines
15422	Taguig	Calabarzon	Philippines
15423	Tagudin	Ilocos	Philippines
15424	Tagoloan	Northern Mindanao	Philippines
15425	Tagbilaran City	Central Visayas	Philippines
15426	Tagas	Bicol	Philippines
15427	Tacurong	Soccsksargen	Philippines
15428	Tabuk	Cordillera	Philippines
15429	Tabaco	Bicol	Philippines
15430	Taal	Calabarzon	Philippines
15431	Surigao	Caraga	Philippines
15432	Surallah	Soccsksargen	Philippines
15433	Subic	Central Luzon	Philippines
15434	Suay	Western Visayas	Philippines
15435	Sorsogon	Bicol	Philippines
15436	Solano	Cagayan Valley	Philippines
15437	Solana	Cagayan Valley	Philippines
15438	Sitangkai	Autonomous Region in Muslim Mindanao	Philippines
15439	Sipalay	Western Visayas	Philippines
15440	Silang	Calabarzon	Philippines
15441	Sibulan	Central Visayas	Philippines
15442	Sexmoan	Central Luzon	Philippines
15443	Sebu	Soccsksargen	Philippines
15444	Sariaya	Calabarzon	Philippines
15445	San Vicente	Central Luzon	Philippines
15446	Santo Tomas	Calabarzon	Philippines
15447	Santol	Central Luzon	Philippines
15448	Santiago	Cagayan Valley	Philippines
15449	Santa Rosa	Calabarzon	Philippines
15450	Santa Maria	Ilocos	Philippines
15451	Santa Maria	Davao	Philippines
15452	Santa Cruz	Central Luzon	Philippines
15453	Santa Cruz	Central Luzon	Philippines
15454	Santa Cruz	Calabarzon	Philippines
15455	Santa Catalina	Central Visayas	Philippines
15456	Santa Barbara	Ilocos	Philippines
15457	Santa Ana	Central Luzon	Philippines
15458	San Simon	Central Luzon	Philippines
15459	San Pedro	Calabarzon	Philippines
15460	San Pascual	Calabarzon	Philippines
15461	San Pablo	Calabarzon	Philippines
15462	San Nicolas	Ilocos	Philippines
15463	San Narciso	Central Luzon	Philippines
15464	San Miguel	Central Luzon	Philippines
15465	San Miguel	Central Luzon	Philippines
15466	San Mateo	Cagayan Valley	Philippines
15467	San Mateo	Calabarzon	Philippines
15468	San Mariano	Davao	Philippines
15469	San Marcelino	Central Luzon	Philippines
15470	San Luis	Central Luzon	Philippines
15471	San Leonardo	Central Luzon	Philippines
15472	San Juan	Metro Manila	Philippines
15473	San Jose del Monte	Central Luzon	Philippines
15474	San Jose	Bicol	Philippines
15475	San Jose	Mimaropa	Philippines
15476	San Ildefonso	Central Luzon	Philippines
15477	San Francisco	Central Luzon	Philippines
15478	Aurora	Calabarzon	Philippines
15479	San Francisco	Caraga	Philippines
15480	San Fernando	Ilocos	Philippines
15481	San Fernando	Central Luzon	Philippines
15482	San Fernando	Central Visayas	Philippines
15483	San Antonio	Central Luzon	Philippines
15484	San Antonio	Central Luzon	Philippines
15485	San Antonio	Central Luzon	Philippines
15486	Sampaloc	Calabarzon	Philippines
15487	Samal	Central Luzon	Philippines
15488	Samal	Davao	Philippines
15489	Sagay	Western Visayas	Philippines
15490	Sablayan	Mimaropa	Philippines
15491	Roxas	Cagayan Valley	Philippines
15492	Roxas City	Western Visayas	Philippines
15493	Roxas	Mimaropa	Philippines
15494	Romblon	Mimaropa	Philippines
15495	Rizal	Central Luzon	Philippines
15496	Recodo	Zamboanga Peninsula	Philippines
15497	Ramos	Central Luzon	Philippines
15498	Ramon	Cagayan Valley	Philippines
15499	Quiapo	Metro Manila	Philippines
15500	Quezon City	Metro Manila	Philippines
15501	Quezon	Central Luzon	Philippines
15502	Quezon	Northern Mindanao	Philippines
15503	Pulupandan	Western Visayas	Philippines
15504	Pulong Santa Cruz	Calabarzon	Philippines
15505	Pulilan	Central Luzon	Philippines
15506	Puerto Princesa	Mimaropa	Philippines
15507	Port Area	Metro Manila	Philippines
15508	Porac	Central Luzon	Philippines
15509	Polomolok	Davao	Philippines
15510	Polangui	Bicol	Philippines
15511	Plaridel	Central Luzon	Philippines
15512	Pio	Central Luzon	Philippines
15513	Pinamungahan	Central Visayas	Philippines
15514	Pinamalayan	Mimaropa	Philippines
15515	Pililla	Calabarzon	Philippines
15516	Pilar	Central Luzon	Philippines
15517	Pila	Calabarzon	Philippines
15519	Patuto	Calabarzon	Philippines
15520	Passi	Western Visayas	Philippines
15521	Parang	Autonomous Region in Muslim Mindanao	Philippines
15522	Paraiso	Western Visayas	Philippines
15523	Papaya	Central Luzon	Philippines
15524	Paombong	Central Luzon	Philippines
15525	Pantubig	Central Luzon	Philippines
15526	Paniqui	Central Luzon	Philippines
15527	Pangil	Calabarzon	Philippines
15528	Pandi	Central Luzon	Philippines
15529	Pandacaqui	Central Luzon	Philippines
15530	Panalanoy	Eastern Visayas	Philippines
15531	Panabo	Davao	Philippines
15532	Palo	Eastern Visayas	Philippines
15533	Palayan City	Central Luzon	Philippines
15534	Pagbilao	Calabarzon	Philippines
15536	Pagadian	Zamboanga Peninsula	Philippines
15537	Paete	Calabarzon	Philippines
15538	Pacol	Western Visayas	Philippines
15539	Ozamiz City	Northern Mindanao	Philippines
15540	Oroquieta	Northern Mindanao	Philippines
15541	Ormoc	Eastern Visayas	Philippines
15542	Orion	Central Luzon	Philippines
15543	Orani	Central Luzon	Philippines
15544	Olongapo	Central Luzon	Philippines
15545	Obando	Central Luzon	Philippines
15546	Noveleta	Calabarzon	Philippines
15547	Norzagaray	Central Luzon	Philippines
15548	New Corella	Davao	Philippines
15549	Nasugbu	Calabarzon	Philippines
15550	Narra	Mimaropa	Philippines
15551	Naic	Calabarzon	Philippines
15552	Nagcarlan	Calabarzon	Philippines
15553	Naga	Bicol	Philippines
15554	Naga	Central Visayas	Philippines
15555	Nabunturan	Davao	Philippines
15556	Nabua	Bicol	Philippines
15557	Muricay	Zamboanga Peninsula	Philippines
15558	Murcia	Western Visayas	Philippines
15560	Morong	Central Luzon	Philippines
15561	Morong	Calabarzon	Philippines
15562	Rodriguez	Calabarzon	Philippines
15563	Monkayo	Davao	Philippines
15564	Molave	Zamboanga Peninsula	Philippines
15565	Minglanilla	Central Visayas	Philippines
15566	Midsayap	Soccsksargen	Philippines
15567	Meycauayan	Central Luzon	Philippines
15568	Mexico	Central Luzon	Philippines
15569	Mercedes	Bicol	Philippines
15571	Mauban	Calabarzon	Philippines
15572	Mati	Davao	Philippines
15573	Masinloc	Central Luzon	Philippines
15574	Masbate	Bicol	Philippines
15575	Masantol	Central Luzon	Philippines
15576	Mariveles	Central Luzon	Philippines
15577	Marilao	Central Luzon	Philippines
15578	Mariano	Northern Mindanao	Philippines
15579	Marawi City	Autonomous Region in Muslim Mindanao	Philippines
15580	Maramag	Northern Mindanao	Philippines
15581	Maragondon	Calabarzon	Philippines
15582	Mantampay	Northern Mindanao	Philippines
15583	Mansilingan	Western Visayas	Philippines
15584	Mansalay	Mimaropa	Philippines
15585	Manolo Fortich	Northern Mindanao	Philippines
15586	Manila	Metro Manila	Philippines
15587	Manibaug Pasig	Central Luzon	Philippines
15588	Mangaldan	Ilocos	Philippines
15589	Mandaue City	Central Visayas	Philippines
15590	Mandaluyong City	Metro Manila	Philippines
15591	Mankayan	Cordillera	Philippines
15592	Manay	Davao	Philippines
15593	Manapla	Western Visayas	Philippines
15594	Manaoag	Ilocos	Philippines
15595	Mamburao	Mimaropa	Philippines
15596	Mamatid	Calabarzon	Philippines
15597	Malvar	Calabarzon	Philippines
15598	Maluso	Autonomous Region in Muslim Mindanao	Philippines
15600	Malolos	Central Luzon	Philippines
15601	Malita	Davao	Philippines
15602	Malilipot	Bicol	Philippines
15603	Malaybalay	Northern Mindanao	Philippines
15604	Malapatan	Soccsksargen	Philippines
15605	Malanday	Calabarzon	Philippines
15606	Malabanban Norte	Calabarzon	Philippines
15607	Makati City	Metro Manila	Philippines
15608	Mahayag	Zamboanga Peninsula	Philippines
15609	Magsaysay	Davao	Philippines
15610	Magarao	Bicol	Philippines
15611	Maganoy	Autonomous Region in Muslim Mindanao	Philippines
15612	Magalang	Central Luzon	Philippines
15613	Mabalacat City	Central Luzon	Philippines
15614	Maasin	Eastern Visayas	Philippines
15615	Maao	Western Visayas	Philippines
15616	Lupon	Davao	Philippines
15617	Lumbang	Calabarzon	Philippines
15618	Lucena	Calabarzon	Philippines
15619	Lucban	Calabarzon	Philippines
15620	Lubao	Central Luzon	Philippines
15622	Lopez	Calabarzon	Philippines
15623	Loma de Gato	Central Luzon	Philippines
15624	Loboc	Central Visayas	Philippines
15625	Lipa City	Calabarzon	Philippines
15626	Lingayen	Ilocos	Philippines
15627	Limay	Central Luzon	Philippines
15628	Liloan	Central Visayas	Philippines
15629	Lilio	Calabarzon	Philippines
15630	Libon	Bicol	Philippines
15631	Libertad	Caraga	Philippines
15632	Legaspi	Bicol	Philippines
15633	Laur	Central Luzon	Philippines
15634	La Trinidad	Cordillera	Philippines
15635	Lapu-Lapu City	Central Visayas	Philippines
15636	La Paz	Central Luzon	Philippines
15637	Laoang	Eastern Visayas	Philippines
15638	Laoag	Ilocos	Philippines
15639	Lala	Northern Mindanao	Philippines
15640	Laguilayan	Soccsksargen	Philippines
15641	La Castellana	Western Visayas	Philippines
15642	La Carlota	Western Visayas	Philippines
15643	Labo	Bicol	Philippines
15644	Koronadal	Soccsksargen	Philippines
15645	Kidapawan	Soccsksargen	Philippines
15646	Kawit	Calabarzon	Philippines
15647	Kalibo (poblacion)	Western Visayas	Philippines
15648	Kabankalan	Western Visayas	Philippines
15649	Kabacan	Soccsksargen	Philippines
15651	Jolo	Autonomous Region in Muslim Mindanao	Philippines
15652	Jasaan	Northern Mindanao	Philippines
15653	Jalajala	Calabarzon	Philippines
15654	Jagna	Central Visayas	Philippines
15655	Jaen	Central Luzon	Philippines
15656	Itogon	Cordillera	Philippines
15657	Isulan	Soccsksargen	Philippines
15658	Isabela	Western Visayas	Philippines
15659	City of Isabela	Autonomous Region in Muslim Mindanao	Philippines
15660	Irosin	Bicol	Philippines
15661	Iriga City	Bicol	Philippines
15662	Ipil	Zamboanga Peninsula	Philippines
15663	Indang	Calabarzon	Philippines
15664	Imus	Calabarzon	Philippines
15665	Iloilo	Western Visayas	Philippines
15666	Iligan City	Soccsksargen	Philippines
15667	Ilagan	Cagayan Valley	Philippines
15668	Iba	Central Luzon	Philippines
15669	Hinigaran	Western Visayas	Philippines
15670	Himamaylan	Western Visayas	Philippines
15671	Hermosa	Central Luzon	Philippines
15672	Hagonoy	Central Luzon	Philippines
15673	Guyong	Central Luzon	Philippines
15674	Gumaca	Calabarzon	Philippines
15675	Guiset East	Ilocos	Philippines
15676	Guimba	Central Luzon	Philippines
15678	Guiguinto	Central Luzon	Philippines
15679	Goa	Bicol	Philippines
15680	Glan	Soccsksargen	Philippines
15681	Gerona	Central Luzon	Philippines
15682	General Trias	Calabarzon	Philippines
15683	General Tinio	Central Luzon	Philippines
15684	General Santos	Soccsksargen	Philippines
15685	General Mamerto Natividad	Central Luzon	Philippines
15686	Gapan	Central Luzon	Philippines
15687	Escalante	Western Visayas	Philippines
15688	Saravia	Western Visayas	Philippines
15689	Dumaguete	Central Visayas	Philippines
15690	Don Carlos	Northern Mindanao	Philippines
15691	Domalanoan	Ilocos	Philippines
15692	Dologon	Northern Mindanao	Philippines
15693	Dipolog	Zamboanga Peninsula	Philippines
15694	Dinalupihan	Central Luzon	Philippines
15695	Digos	Davao	Philippines
15696	Diadi	Cagayan Valley	Philippines
15697	Del Pilar	Central Luzon	Philippines
15698	Davao	Davao	Philippines
15700	Dapitan	Zamboanga Peninsula	Philippines
15701	Danao	Central Visayas	Philippines
15702	Danao	Central Visayas	Philippines
15703	Daet	Bicol	Philippines
15704	Cuenca	Calabarzon	Philippines
15705	Cotabato	Autonomous Region in Muslim Mindanao	Philippines
15706	Cordova	Central Visayas	Philippines
15707	Consolacion	Central Visayas	Philippines
15708	Concepcion	Central Luzon	Philippines
15709	Concepcion Ibaba	Calabarzon	Philippines
15710	Compostela	Central Visayas	Philippines
15711	Compostela	Davao	Philippines
15712	Cebu City	Central Visayas	Philippines
15713	Cavite City	Calabarzon	Philippines
15714	Catbalogan	Eastern Visayas	Philippines
15715	Catarman	Eastern Visayas	Philippines
15716	Catanauan	Calabarzon	Philippines
15717	Castillejos	Central Luzon	Philippines
15718	Carmona	Calabarzon	Philippines
15719	Cogan	Central Visayas	Philippines
15720	Carigara	Eastern Visayas	Philippines
15721	Cardona	Calabarzon	Philippines
15722	Carcar	Central Visayas	Philippines
15723	Capas	Central Luzon	Philippines
15724	Canlaon	Central Visayas	Philippines
15725	Candelaria	Calabarzon	Philippines
15726	Candaba	Central Luzon	Philippines
15727	Camiling	Central Luzon	Philippines
15728	Calumpit	Central Luzon	Philippines
15729	Calumpang	Metro Manila	Philippines
15730	Calbayog City	Eastern Visayas	Philippines
15731	Calauan	Calabarzon	Philippines
15732	Calauag	Calabarzon	Philippines
15733	Calatagan	Calabarzon	Philippines
15734	Calasiao	Ilocos	Philippines
15735	Calapan	Mimaropa	Philippines
15736	Calamba	Calabarzon	Philippines
15737	Calaca	Calabarzon	Philippines
15738	Calabanga	Bicol	Philippines
15739	Cainta	Calabarzon	Philippines
15740	Cagayan de Oro	Northern Mindanao	Philippines
15741	Cadiz	Western Visayas	Philippines
15742	Cabiao	Central Luzon	Philippines
15743	Cabayangan	Davao	Philippines
15744	Cabanatuan City	Central Luzon	Philippines
15745	Cabagan	Cagayan Valley	Philippines
15746	Cabadbaran	Caraga	Philippines
15747	Butuan	Caraga	Philippines
15748	Bustos	Central Luzon	Philippines
15749	Boroon	Northern Mindanao	Philippines
15750	Burgos	Central Luzon	Philippines
15751	Bunawan	Caraga	Philippines
15752	Buluan	Autonomous Region in Muslim Mindanao	Philippines
15753	Bulaon	Central Luzon	Philippines
15754	Bulan	Bicol	Philippines
15755	Bulacan	Central Luzon	Philippines
15756	Buhi	Bicol	Philippines
15757	Bugo	Northern Mindanao	Philippines
15758	Buenavista	Caraga	Philippines
15759	Budta	Autonomous Region in Muslim Mindanao	Philippines
15760	Botolan	Central Luzon	Philippines
15761	Borongan	Eastern Visayas	Philippines
15762	Bongao	Autonomous Region in Muslim Mindanao	Philippines
15763	Bongabon	Central Luzon	Philippines
15764	Bogo	Central Visayas	Philippines
15765	Bocaue	Central Luzon	Philippines
15766	Bislig	Caraga	Philippines
15767	Binonga	Western Visayas	Philippines
15768	Binmaley	Ilocos	Philippines
15769	Binangonan	Calabarzon	Philippines
15770	Binalbagan	Western Visayas	Philippines
15771	Bignay Uno	Calabarzon	Philippines
15772	Bayugan	Caraga	Philippines
15773	Bayombong	Cagayan Valley	Philippines
15774	Baybay	Eastern Visayas	Philippines
15775	Bayawan	Central Visayas	Philippines
15776	Bayambang	Ilocos	Philippines
15777	Bay	Calabarzon	Philippines
15778	Bauang	Ilocos	Philippines
15779	Bauan	Calabarzon	Philippines
15780	Bato	Bicol	Philippines
15781	Batangas	Calabarzon	Philippines
15782	Batac City	Ilocos	Philippines
15783	Baras	Calabarzon	Philippines
15784	Bantayan	Central Visayas	Philippines
15785	Bansalan	Davao	Philippines
15787	Banaybanay	Calabarzon	Philippines
15788	Bambang	Cagayan Valley	Philippines
15789	Baliuag	Central Luzon	Philippines
15790	Balayan	Calabarzon	Philippines
15791	Balanga	Central Luzon	Philippines
15792	Balamban	Central Visayas	Philippines
15793	Balagtas	Central Luzon	Philippines
15794	Bais	Central Visayas	Philippines
15795	Bah-Bah	Caraga	Philippines
15796	Baguio	Cordillera	Philippines
15797	Bago City	Western Visayas	Philippines
15798	Baggabag B	Cagayan Valley	Philippines
15799	Bacoor	Calabarzon	Philippines
15800	Bacolod City	Western Visayas	Philippines
15801	Babo-Pangulo	Central Luzon	Philippines
15802	Baao	Bicol	Philippines
15803	Atimonan	Calabarzon	Philippines
15804	Asia	Western Visayas	Philippines
15805	Aringay	Ilocos	Philippines
15806	Arayat	Central Luzon	Philippines
15807	Aparri	Cagayan Valley	Philippines
15808	Apalit	Central Luzon	Philippines
15809	Antipolo	Calabarzon	Philippines
15810	Angono	Calabarzon	Philippines
15811	Angeles City	Central Luzon	Philippines
15812	Angat	Central Luzon	Philippines
15813	Amadeo	Calabarzon	Philippines
15814	Alicia	Cagayan Valley	Philippines
15815	Aliaga	Central Luzon	Philippines
15816	Alaminos	Calabarzon	Philippines
15817	Alabel	Soccsksargen	Philippines
15818	Agoo	Ilocos	Philippines
15819	Abuyog	Eastern Visayas	Philippines
15820	Abucay	Central Luzon	Philippines
15821	Bagong Pagasa	Calabarzon	Philippines
15822	Malingao	Soccsksargen	Philippines
15823	Pasig City	Metro Manila	Philippines
15824	Pandan	Western Visayas	Philippines
15825	Apas	Central Visayas	Philippines
15826	Chuhar Jamali	Sindh	Pakistan
15827	Rawala Kot	Azad Kashmir	Pakistan
15828	Pir jo Goth	Sindh	Pakistan
15829	Khairpur	Sindh	Pakistan
15830	Zhob	Balochistan	Pakistan
15831	Zaida	Khyber Pakhtunkhwa	Pakistan
15832	Zahir Pir	Punjab	Pakistan
15833	Zafarwal	Punjab	Pakistan
15834	Yazman	Punjab	Pakistan
15835	Wazirabad	Punjab	Pakistan
15836	Warburton	Punjab	Pakistan
15837	Warah	Sindh	Pakistan
15838	Vihari	Punjab	Pakistan
15839	Utmanzai	Khyber Pakhtunkhwa	Pakistan
15840	Uthal	Balochistan	Pakistan
15841	Usta Muhammad	Balochistan	Pakistan
15842	Umarkot	Sindh	Pakistan
15843	Ubauro	Sindh	Pakistan
15844	Turbat	Balochistan	Pakistan
15845	Topi	Khyber Pakhtunkhwa	Pakistan
15846	Toba Tek Singh	Punjab	Pakistan
15847	Thul	Sindh	Pakistan
15848	Thatta	Sindh	Pakistan
15849	Tharu Shah	Sindh	Pakistan
15850	Taunsa	Punjab	Pakistan
15851	Tank	Khyber Pakhtunkhwa	Pakistan
15852	Tangi	Khyber Pakhtunkhwa	Pakistan
15853	Tando Muhammad Khan	Sindh	Pakistan
15854	Tando Jam	Sindh	Pakistan
15855	Tando Allahyar	Sindh	Pakistan
15856	Tando Adam	Sindh	Pakistan
15857	Tandlianwala	Punjab	Pakistan
15858	Talhar	Sindh	Pakistan
15859	Talamba	Punjab	Pakistan
15860	Talagang	Punjab	Pakistan
15861	Tal	Khyber Pakhtunkhwa	Pakistan
15862	Swabi	Khyber Pakhtunkhwa	Pakistan
15863	Surkhpur	Punjab	Pakistan
15864	Sukkur	Sindh	Pakistan
15865	Sukheke Mandi	Punjab	Pakistan
15866	Sodhra	Punjab	Pakistan
15867	Sita Road	Sindh	Pakistan
15868	Sinjhoro	Sindh	Pakistan
15869	Sillanwali	Punjab	Pakistan
15870	Sibi	Balochistan	Pakistan
15871	Sialkot	Punjab	Pakistan
15872	Shujaabad	Punjab	Pakistan
15873	Shorko	Khyber Pakhtunkhwa	Pakistan
15874	Shikarpur	Sindh	Pakistan
15875	Sheikhupura	Punjab	Pakistan
15876	Sharqpur	Punjab	Pakistan
15877	Shakargarr	Punjab	Pakistan
15878	Shahr Sultan	Punjab	Pakistan
15879	Shahpur Chakar	Sindh	Pakistan
15880	Shahkot	Punjab	Pakistan
15881	Shahdadpur	Sindh	Pakistan
15882	Shahdadkot	Sindh	Pakistan
15883	Shabqadar	Khyber Pakhtunkhwa	Pakistan
15884	Sehwan	Sindh	Pakistan
15885	Sargodha	Punjab	Pakistan
15886	Sarai Sidhu	Punjab	Pakistan
15887	Sarai Naurang	Khyber Pakhtunkhwa	Pakistan
15888	Sarai Alamgir	Punjab	Pakistan
15889	Sangla Hill	Punjab	Pakistan
15890	Sanghar	Sindh	Pakistan
15891	Sambrial	Punjab	Pakistan
15892	Sakrand	Sindh	Pakistan
15893	Sahiwal	Punjab	Pakistan
15894	Sahiwal	Punjab	Pakistan
15895	Sadiqabad	Punjab	Pakistan
15896	Rohri	Sindh	Pakistan
15897	Renala Khurd	Punjab	Pakistan
15898	Rawalpindi	Punjab	Pakistan
15899	Ratodero	Sindh	Pakistan
15900	Ranipur	Sindh	Pakistan
15901	Rajanpur	Punjab	Pakistan
15902	Raja Jang	Punjab	Pakistan
15903	Raiwind	Punjab	Pakistan
15904	Radhan	Sindh	Pakistan
15905	Rabwah	Punjab	Pakistan
15906	Quetta	Balochistan	Pakistan
15907	Kambar	Sindh	Pakistan
15908	Qadirpur Ran	Punjab	Pakistan
15909	Pishin	Balochistan	Pakistan
15910	Pir Mahal	Punjab	Pakistan
15911	Pindi Gheb	Punjab	Pakistan
15912	Pindi Bhattian	Punjab	Pakistan
15913	Pind Dadan Khan	Punjab	Pakistan
15914	Phalia	Punjab	Pakistan
15915	Peshawar	Khyber Pakhtunkhwa	Pakistan
15916	Pattoki	Punjab	Pakistan
15917	Pasrur	Punjab	Pakistan
15918	Pasni	Balochistan	Pakistan
15919	Pano Aqil	Sindh	Pakistan
15920	Pakpattan	Punjab	Pakistan
15921	Paharpur	Khyber Pakhtunkhwa	Pakistan
15922	Pad Idan	Sindh	Pakistan
15923	Pabbi	Khyber Pakhtunkhwa	Pakistan
15924	Okara	Punjab	Pakistan
15925	Nushki	Balochistan	Pakistan
15926	Nawabshah	Sindh	Pakistan
15927	Naushahro Firoz	Sindh	Pakistan
15928	Naushahra Virkan	Punjab	Pakistan
15929	Naudero	Sindh	Pakistan
15930	Nasirabad	Sindh	Pakistan
15931	Narowal	Punjab	Pakistan
15932	Narang	Punjab	Pakistan
15933	Naukot	Sindh	Pakistan
15934	Nankana Sahib	Punjab	Pakistan
15935	Muzaffargarh	Punjab	Pakistan
15936	Muzaffarabad	Azad Kashmir	Pakistan
15937	Mustafabad	Punjab	Pakistan
15938	Murree	Punjab	Pakistan
15939	Muridke	Punjab	Pakistan
15940	Multan	Punjab	Pakistan
15941	Moro	Sindh	Pakistan
15942	Mithi	Sindh	Pakistan
15943	Mitha Tiwana	Punjab	Pakistan
15944	Mirpur Mathelo	Sindh	Pakistan
15945	Mirpur Khas	Sindh	Pakistan
15946	Mingora	Khyber Pakhtunkhwa	Pakistan
15947	Minchinabad	Punjab	Pakistan
15948	Mianwali	Punjab	Pakistan
15949	Mian Channun	Punjab	Pakistan
15950	Mehrabpur	Balochistan	Pakistan
15951	Mehar	Sindh	Pakistan
15952	Matli	Sindh	Pakistan
15953	Matiari	Sindh	Pakistan
15954	Mastung	Balochistan	Pakistan
15955	Mardan	Khyber Pakhtunkhwa	Pakistan
15956	Mansehra	Khyber Pakhtunkhwa	Pakistan
15957	Mangla	Punjab	Pakistan
15958	Mandi Bahauddin	Punjab	Pakistan
15959	Mananwala	Punjab	Pakistan
15960	Mamu Kanjan	Punjab	Pakistan
15961	Malir Cantonment	Sindh	Pakistan
15962	Malakwal	Punjab	Pakistan
15963	Mailsi	Punjab	Pakistan
15964	Mach	Balochistan	Pakistan
15965	Loralai	Balochistan	Pakistan
15966	Lodhran	Punjab	Pakistan
15967	Layyah	Punjab	Pakistan
15968	Larkana	Sindh	Pakistan
15969	Lalian	Punjab	Pakistan
15970	Lala Musa	Punjab	Pakistan
15971	Lakki Marwat	Khyber Pakhtunkhwa	Pakistan
15972	Lahore	Punjab	Pakistan
15973	Ladhewala Waraich	Punjab	Pakistan
15974	Lachi	Khyber Pakhtunkhwa	Pakistan
15975	Kunri	Sindh	Pakistan
15976	Kunjah	Punjab	Pakistan
15977	Kundian	Punjab	Pakistan
15978	Kulachi	Khyber Pakhtunkhwa	Pakistan
15979	Kot Samaba	Punjab	Pakistan
15980	Kotri	Sindh	Pakistan
15981	Kot Radha Kishan	Punjab	Pakistan
15982	Kot Mumin	Punjab	Pakistan
15983	Kot Malik	Balochistan	Pakistan
15984	Kotli Loharan	Punjab	Pakistan
15985	Kotli	Azad Kashmir	Pakistan
15986	Kot Ghulam Muhammad	Punjab	Pakistan
15987	Kot Diji	Sindh	Pakistan
15988	Kot Addu	Punjab	Pakistan
15989	Kohat	Khyber Pakhtunkhwa	Pakistan
15990	Khushab	Punjab	Pakistan
15991	Khurrianwala	Punjab	Pakistan
15992	Khewra	Punjab	Pakistan
15993	Kharian	Punjab	Pakistan
15994	Kharan	Balochistan	Pakistan
15995	Khanpur	Punjab	Pakistan
15996	Khanpur	Sindh	Pakistan
15997	Khangarh	Punjab	Pakistan
15998	Khangah Dogran	Punjab	Pakistan
15999	Khalabat	Khyber Pakhtunkhwa	Pakistan
16000	Khairpur Nathan Shah	Sindh	Pakistan
16001	Khairpur	Punjab	Pakistan
16002	Khairpur	Sindh	Pakistan
16003	Kasur	Punjab	Pakistan
16004	Kashmor	Sindh	Pakistan
16005	Karor	Punjab	Pakistan
16006	Karachi	Sindh	Pakistan
16007	Kanganpur	Punjab	Pakistan
16008	Kandiaro	Sindh	Pakistan
16009	Kandhkot	Sindh	Pakistan
16010	Kamra	Punjab	Pakistan
16011	Kamoke	Punjab	Pakistan
16012	Kamir	Punjab	Pakistan
16013	Kamar Mushani	Punjab	Pakistan
16014	Kamalia	Punjab	Pakistan
16015	Kalur Kot	Punjab	Pakistan
16016	Kallar Kahar	Punjab	Pakistan
16017	Kaleke Mandi	Punjab	Pakistan
16018	Kalat	Balochistan	Pakistan
16019	Kalabagh	Punjab	Pakistan
16020	Kahuta	Punjab	Pakistan
16021	Kohror Pakka	Punjab	Pakistan
16022	Kahna	Punjab	Pakistan
16023	Kabirwala	Punjab	Pakistan
16024	Johi	Sindh	Pakistan
16025	Jiwani	Balochistan	Pakistan
16026	Jhumra	Punjab	Pakistan
16027	Jhol	Sindh	Pakistan
16028	Jhelum	Punjab	Pakistan
16029	Jhawarian	Punjab	Pakistan
16030	Jhang Sadr	Punjab	Pakistan
16031	Jauharabad	Punjab	Pakistan
16032	Jatoi Shimali	Punjab	Pakistan
16033	Jaranwala	Punjab	Pakistan
16034	Jand	Punjab	Pakistan
16035	Jampur	Punjab	Pakistan
16036	Jalalpur Pirwala	Punjab	Pakistan
16037	Jalalpur	Punjab	Pakistan
16038	Jahanian Shah	Punjab	Pakistan
16039	Jacobabad	Sindh	Pakistan
16040	Islamabad	Islamabad	Pakistan
16041	Hyderabad	Sindh	Pakistan
16042	Hujra	Punjab	Pakistan
16043	Hingorja	Sindh	Pakistan
16044	Hazro	Punjab	Pakistan
16045	Havelian	Khyber Pakhtunkhwa	Pakistan
16046	Haveli	Punjab	Pakistan
16047	Hasilpur	Punjab	Pakistan
16048	Hasan Abdal	Punjab	Pakistan
16049	Haru Zbad	Punjab	Pakistan
16050	Harnoli	Punjab	Pakistan
16051	Haripur	Khyber Pakhtunkhwa	Pakistan
16052	Hangu	Khyber Pakhtunkhwa	Pakistan
16053	Hala	Sindh	Pakistan
16054	Hafizabad	Punjab	Pakistan
16055	Hadali	Punjab	Pakistan
16056	Gwadar	Balochistan	Pakistan
16057	Gujrat	Punjab	Pakistan
16058	Gujranwala	Punjab	Pakistan
16059	Gujar Khan	Punjab	Pakistan
16060	Gojra	Punjab	Pakistan
16061	Ghotki	Sindh	Pakistan
16062	Ghauspur	Sindh	Pakistan
16063	Gharo	Sindh	Pakistan
16064	Garh Maharaja	Punjab	Pakistan
16065	Gambat	Sindh	Pakistan
16066	Fort Abbas	Punjab	Pakistan
16067	Fazalpur	Punjab	Pakistan
16068	Chak Two Hundred Forty-Nine TDA	Punjab	Pakistan
16069	Faruka	Punjab	Pakistan
16070	Faqirwali	Punjab	Pakistan
16071	Faisalabad	Punjab	Pakistan
16072	Eminabad	Punjab	Pakistan
16073	Dunyapur	Punjab	Pakistan
16074	Dunga Bunga	Punjab	Pakistan
16075	Dullewala	Punjab	Pakistan
16076	Dir	Khyber Pakhtunkhwa	Pakistan
16077	Dipalpur	Punjab	Pakistan
16078	Dinga	Punjab	Pakistan
16079	Dijkot	Punjab	Pakistan
16080	Digri	Sindh	Pakistan
16081	Dhoro Naro	Sindh	Pakistan
16082	Dhanot	Punjab	Pakistan
16083	Dera Ismail Khan	Khyber Pakhtunkhwa	Pakistan
16084	Dera Ghazi Khan	Punjab	Pakistan
16085	Dera Bugti	Balochistan	Pakistan
16086	Daur	Sindh	Pakistan
16087	Daud Khel	Punjab	Pakistan
16088	Daska	Punjab	Pakistan
16089	Darya Khan	Punjab	Pakistan
16090	Dajal	Punjab	Pakistan
16091	Dadu	Sindh	Pakistan
16092	Dadhar	Balochistan	Pakistan
16093	Chunian	Punjab	Pakistan
16094	Chuhar Kana	Punjab	Pakistan
16095	Chor	Sindh	Pakistan
16096	Choa Saidan Shah	Punjab	Pakistan
16097	Chishtian Mandi	Punjab	Pakistan
16098	Chiniot	Punjab	Pakistan
16099	Chichawatni	Punjab	Pakistan
16100	Chawinda	Punjab	Pakistan
16101	Charsadda	Khyber Pakhtunkhwa	Pakistan
16102	Chaman	Balochistan	Pakistan
16103	Chakwal	Punjab	Pakistan
16104	Chak Azam Saffo	Punjab	Pakistan
16105	Burewala	Punjab	Pakistan
16106	Bhopalwala	Punjab	Pakistan
16107	Bhit Shah	Sindh	Pakistan
16108	Bhimbar	Azad Kashmir	Pakistan
16109	Bhera	Punjab	Pakistan
16110	Bhawana	Punjab	Pakistan
16111	Bhan	Sindh	Pakistan
16112	Bhalwal	Punjab	Pakistan
16113	Bhakkar	Punjab	Pakistan
16114	Bhai Pheru	Punjab	Pakistan
16115	Bela	Balochistan	Pakistan
16116	Bat Khela	Khyber Pakhtunkhwa	Pakistan
16117	Basirpur	Punjab	Pakistan
16118	Bannu	Khyber Pakhtunkhwa	Pakistan
16119	Bahawalpur	Punjab	Pakistan
16120	Bahawalnagar	Punjab	Pakistan
16121	Badin	Sindh	Pakistan
16122	Baddomalhi	Punjab	Pakistan
16123	Attock City	Punjab	Pakistan
16124	Arifwala	Punjab	Pakistan
16125	Amangarh	Khyber Pakhtunkhwa	Pakistan
16126	Alipur	Punjab	Pakistan
16127	Akora	Khyber Pakhtunkhwa	Pakistan
16128	Ahmadpur East	Punjab	Pakistan
16129	Abbottabad	Khyber Pakhtunkhwa	Pakistan
16130	Bahawalnagar	Punjab	Pakistan
16131	Nowshera Cantonment	Khyber Pakhtunkhwa	Pakistan
16132	Ahmadpur Sial	Punjab	Pakistan
16133	New Badah	Sindh	Pakistan
16134	Tando Ghulam Ali	Sindh	Pakistan
16135	Setharja Old	Sindh	Pakistan
16136	Risalpur	Khyber Pakhtunkhwa	Pakistan
16137	Malakwal City	Punjab	Pakistan
16139	Zoliborz	Masovian Voivodeship	Poland
16140	Zielonka	Masovian Voivodeship	Poland
16141	Zamosc	Lublin Voivodeship	Poland
16143	Zabki	Masovian Voivodeship	Poland
16145	Wolomin	Masovian Voivodeship	Poland
16146	Wola	Masovian Voivodeship	Poland
16147	Wlochy	Masovian Voivodeship	Poland
16148	Wieliczka	Lesser Poland Voivodeship	Poland
16149	Wesola	Masovian Voivodeship	Poland
16150	Wawer	Masovian Voivodeship	Poland
16151	Warsaw	Masovian Voivodeship	Poland
16152	Ursus	Masovian Voivodeship	Poland
16156	Tarnobrzeg	Subcarpathian Voivodeship	Poland
16158	Szczytno	Warmian-Masurian Voivodeship	Poland
16159	Swidnik	Lublin Voivodeship	Poland
16160	Suwalki	Podlasie	Poland
16163	Starachowice	Swietokrzyskie	Poland
16164	Stalowa Wola	Subcarpathian Voivodeship	Poland
16168	Sochaczew	Masovian Voivodeship	Poland
16170	Skarzysko-Kamienna	Swietokrzyskie	Poland
16171	Siemiatycze	Podlasie	Poland
16172	Siedlce	Masovian Voivodeship	Poland
16173	Sanok	Subcarpathian Voivodeship	Poland
16174	Sandomierz	Swietokrzyskie	Poland
16176	Ropczyce	Subcarpathian Voivodeship	Poland
16179	Radzyn Podlaski	Lublin Voivodeship	Poland
16180	Radom	Masovian Voivodeship	Poland
16181	Pultusk	Masovian Voivodeship	Poland
16182	Pulawy	Lublin Voivodeship	Poland
16183	Przeworsk	Subcarpathian Voivodeship	Poland
16184	Przemysl	Subcarpathian Voivodeship	Poland
16185	Przasnysz	Masovian Voivodeship	Poland
16187	Plonsk	Masovian Voivodeship	Poland
16188	Pisz	Warmian-Masurian Voivodeship	Poland
16189	Pionki	Masovian Voivodeship	Poland
16191	Piaseczno	Masovian Voivodeship	Poland
16192	Otwock	Masovian Voivodeship	Poland
16194	Ostrowiec Swietokrzyski	Swietokrzyskie	Poland
16195	Ostroleka	Masovian Voivodeship	Poland
16197	Olsztyn	Warmian-Masurian Voivodeship	Poland
16198	Olecko	Warmian-Masurian Voivodeship	Poland
16199	Ochota	Masovian Voivodeship	Poland
16200	Nowy Targ	Lesser Poland Voivodeship	Poland
16201	Nowy Sacz	Lesser Poland Voivodeship	Poland
16203	Nisko	Subcarpathian Voivodeship	Poland
16204	Mragowo	Warmian-Masurian Voivodeship	Poland
16206	Mlawa	Masovian Voivodeship	Poland
16207	Minsk Mazowiecki	Masovian Voivodeship	Poland
16209	Mielec	Subcarpathian Voivodeship	Poland
16210	Miedzyrzec Podlaski	Lublin Voivodeship	Poland
16211	Marki	Masovian Voivodeship	Poland
16213	Lublin	Lublin Voivodeship	Poland
16215	Lomza	Podlasie	Poland
16216	Lomianki	Masovian Voivodeship	Poland
16217	Lidzbark Warminski	Warmian-Masurian Voivodeship	Poland
16218	Legionowo	Masovian Voivodeship	Poland
16219	Leczna	Lublin Voivodeship	Poland
16220	Lapy	Podlasie	Poland
16221	Lancut	Subcarpathian Voivodeship	Poland
16222	Krosno	Subcarpathian Voivodeship	Poland
16223	Krasnystaw	Lublin Voivodeship	Poland
16224	Krasnik	Lublin Voivodeship	Poland
16225	Kozienice	Masovian Voivodeship	Poland
16226	Konstancin-Jeziorna	Masovian Voivodeship	Poland
16227	Konskie	Swietokrzyskie	Poland
16228	Kobylka	Masovian Voivodeship	Poland
16229	Kielce	Swietokrzyskie	Poland
16230	Ketrzyn	Warmian-Masurian Voivodeship	Poland
16231	Kabaty	Masovian Voivodeship	Poland
16234	Jaslo	Subcarpathian Voivodeship	Poland
16235	Jaroslaw	Subcarpathian Voivodeship	Poland
16238	Grodzisk Mazowiecki	Masovian Voivodeship	Poland
16239	Grajewo	Podlasie	Poland
16240	Gorlice	Lesser Poland Voivodeship	Poland
16241	Gizycko	Warmian-Masurian Voivodeship	Poland
16242	Gierloz	Warmian-Masurian Voivodeship	Poland
16243	Garwolin	Masovian Voivodeship	Poland
16244	Elk	Warmian-Masurian Voivodeship	Poland
16245	Dzialdowo	Warmian-Masurian Voivodeship	Poland
16246	Deblin	Lublin Voivodeship	Poland
16247	Debica	Subcarpathian Voivodeship	Poland
16249	Chelm	Lublin Voivodeship	Poland
16251	Brzesko	Lesser Poland Voivodeship	Poland
16252	Bochnia	Lesser Poland Voivodeship	Poland
16253	Bilgoraj	Lublin Voivodeship	Poland
16254	Bielsk Podlaski	Podlasie	Poland
16255	Bielany	Masovian Voivodeship	Poland
16256	Bialystok	Podlasie	Poland
16257	Bialoleka	Masovian Voivodeship	Poland
16258	Biala Podlaska	Lublin Voivodeship	Poland
16259	Bemowo	Masovian Voivodeship	Poland
16260	Bartoszyce	Warmian-Masurian Voivodeship	Poland
16262	Zywiec	Silesian Voivodeship	Poland
16263	Zory	Silesian Voivodeship	Poland
16265	Zlotoryja	Lower Silesian Voivodeship	Poland
16267	Zgorzelec	Lower Silesian Voivodeship	Poland
16270	Zawiercie	Silesian Voivodeship	Poland
16271	Zary	Lubusz	Poland
16272	Zakopane	Lesser Poland Voivodeship	Poland
16273	Zagan	Lubusz	Poland
16274	Zabrze	Silesian Voivodeship	Poland
16275	Zabkowice Slaskie	Lower Silesian Voivodeship	Poland
16276	Wrzesnia	Greater Poland Voivodeship	Poland
16277	Wroclaw	Lower Silesian Voivodeship	Poland
16278	Wodzislaw Slaski	Silesian Voivodeship	Poland
16279	Wloclawek	Kujawsko-Pomorskie	Poland
16281	Wejherowo	Pomeranian Voivodeship	Poland
16282	Walcz	West Pomeranian Voivodeship	Poland
16283	Walbrzych	Lower Silesian Voivodeship	Poland
16284	Wagrowiec	Greater Poland Voivodeship	Poland
16285	Wadowice	Lesser Poland Voivodeship	Poland
16286	Ustron	Silesian Voivodeship	Poland
16287	Ustka	Pomeranian Voivodeship	Poland
16288	Tychy	Silesian Voivodeship	Poland
16289	Turek	Greater Poland Voivodeship	Poland
16290	Trzebinia	Lesser Poland Voivodeship	Poland
16291	Trzcianka	Greater Poland Voivodeship	Poland
16292	Torun	Kujawsko-Pomorskie	Poland
16293	Tczew	Pomeranian Voivodeship	Poland
16295	Szczecinek	West Pomeranian Voivodeship	Poland
16296	Szczecin	West Pomeranian Voivodeship	Poland
16297	Szamotuly	Greater Poland Voivodeship	Poland
16298	Swinoujscie	West Pomeranian Voivodeship	Poland
16299	Swietochlowice	Silesian Voivodeship	Poland
16300	Swiebodzin	Lubusz	Poland
16301	Swiecie	Kujawsko-Pomorskie	Poland
16302	Swiebodzice	Lower Silesian Voivodeship	Poland
16303	Swidwin	West Pomeranian Voivodeship	Poland
16304	Swidnica	Lower Silesian Voivodeship	Poland
16305	Swarzedz	Greater Poland Voivodeship	Poland
16307	Strzelce Opolskie	Opole Voivodeship	Poland
16308	Strzegom	Lower Silesian Voivodeship	Poland
16309	Starogard Gdanski	Pomeranian Voivodeship	Poland
16310	Stargard Szczecinski	West Pomeranian Voivodeship	Poland
16311	Sroda Wielkopolska	Greater Poland Voivodeship	Poland
16312	Srem	Greater Poland Voivodeship	Poland
16313	Sosnowiec	Silesian Voivodeship	Poland
16314	Sopot	Pomeranian Voivodeship	Poland
16315	Solec Kujawski	Kujawsko-Pomorskie	Poland
16316	Slupsk	Pomeranian Voivodeship	Poland
16317	Slubice	Lubusz	Poland
16318	Skawina	Lesser Poland Voivodeship	Poland
16319	Sierpc	Masovian Voivodeship	Poland
16321	Siemianowice Slaskie	Silesian Voivodeship	Poland
16322	Rypin	Kujawsko-Pomorskie	Poland
16323	Rydultowy	Silesian Voivodeship	Poland
16324	Rybnik	Silesian Voivodeship	Poland
16325	Rumia	Pomeranian Voivodeship	Poland
16326	Ruda Slaska	Silesian Voivodeship	Poland
16327	Reda	Pomeranian Voivodeship	Poland
16328	Rawicz	Greater Poland Voivodeship	Poland
16331	Radlin	Silesian Voivodeship	Poland
16333	Pyskowice	Silesian Voivodeship	Poland
16334	Pszczyna	Silesian Voivodeship	Poland
16335	Pruszcz Gdanski	Pomeranian Voivodeship	Poland
16336	Prudnik	Opole Voivodeship	Poland
16337	Poznan	Greater Poland Voivodeship	Poland
16338	Polkowice	Lower Silesian Voivodeship	Poland
16339	Police	West Pomeranian Voivodeship	Poland
16340	Plock	Masovian Voivodeship	Poland
16341	Pleszew	Greater Poland Voivodeship	Poland
16343	Pila	Greater Poland Voivodeship	Poland
16344	Piekary Slaskie	Silesian Voivodeship	Poland
16347	Oswiecim	Lesser Poland Voivodeship	Poland
16350	Orzesze	Silesian Voivodeship	Poland
16351	Opole	Opole Voivodeship	Poland
16352	Olkusz	Lesser Poland Voivodeship	Poland
16353	Olesnica	Lower Silesian Voivodeship	Poland
16354	Olawa	Lower Silesian Voivodeship	Poland
16355	Oborniki	Greater Poland Voivodeship	Poland
16356	Nysa	Opole Voivodeship	Poland
16357	Nowy Tomysl	Greater Poland Voivodeship	Poland
16358	Nowogard	West Pomeranian Voivodeship	Poland
16360	Nowa Ruda	Lower Silesian Voivodeship	Poland
16362	Naklo nad Notecia	Kujawsko-Pomorskie	Poland
16364	Myslowice	Silesian Voivodeship	Poland
16365	Myslenice	Lesser Poland Voivodeship	Poland
16367	Miedzyrzecz	Lubusz	Poland
16368	Malbork	Pomeranian Voivodeship	Poland
16369	Lubon	Greater Poland Voivodeship	Poland
16370	Lubliniec	Silesian Voivodeship	Poland
16371	Lubin	Lower Silesian Voivodeship	Poland
16372	Luban	Lower Silesian Voivodeship	Poland
16375	Libiaz	Lesser Poland Voivodeship	Poland
16376	Leszno	Greater Poland Voivodeship	Poland
16377	Legnica	Lower Silesian Voivodeship	Poland
16378	Ledziny	Silesian Voivodeship	Poland
16380	Lebork	Pomeranian Voivodeship	Poland
16383	Kwidzyn	Pomeranian Voivodeship	Poland
16385	Krotoszyn	Greater Poland Voivodeship	Poland
16386	Krapkowice	Opole Voivodeship	Poland
16388	Koszalin	West Pomeranian Voivodeship	Poland
16389	Kostrzyn nad Odra	Lubusz	Poland
16390	Koscierzyna	Pomeranian Voivodeship	Poland
16391	Koscian	Greater Poland Voivodeship	Poland
16393	Konin	Greater Poland Voivodeship	Poland
16394	Kolobrzeg	West Pomeranian Voivodeship	Poland
16395	Kolo	Greater Poland Voivodeship	Poland
16397	Kluczbork	Opole Voivodeship	Poland
16398	Klodzko	Lower Silesian Voivodeship	Poland
16399	Kety	Lesser Poland Voivodeship	Poland
16400	Kedzierzyn-Kozle	Opole Voivodeship	Poland
16401	Katowice	Silesian Voivodeship	Poland
16402	Kartuzy	Pomeranian Voivodeship	Poland
16404	Kalisz	Greater Poland Voivodeship	Poland
16406	Jelcz	Lower Silesian Voivodeship	Poland
16407	Jaworzno	Silesian Voivodeship	Poland
16408	Jawor	Lower Silesian Voivodeship	Poland
16410	Jarocin	Greater Poland Voivodeship	Poland
16411	Inowroclaw	Kujawsko-Pomorskie	Poland
16412	Ilawa	Warmian-Masurian Voivodeship	Poland
16413	Gubin	Lubusz	Poland
16414	Gryfino	West Pomeranian Voivodeship	Poland
16415	Gryfice	West Pomeranian Voivodeship	Poland
16416	Grudziadz	Kujawsko-Pomorskie	Poland
16417	Gostynin	Masovian Voivodeship	Poland
16418	Gostyn	Greater Poland Voivodeship	Poland
16421	Gniezno	Greater Poland Voivodeship	Poland
16422	Glucholazy	Opole Voivodeship	Poland
16425	Gliwice	Silesian Voivodeship	Poland
16426	Gdynia	Pomeranian Voivodeship	Poland
16427	Gdansk	Pomeranian Voivodeship	Poland
16428	Fordon	Kujawsko-Pomorskie	Poland
16429	Elblag	Warmian-Masurian Voivodeship	Poland
16432	Czestochowa	Silesian Voivodeship	Poland
16433	Czerwionka-Leszczyny	Silesian Voivodeship	Poland
16434	Czeladz	Silesian Voivodeship	Poland
16435	Czechowice-Dziedzice	Silesian Voivodeship	Poland
16436	Cieszyn	Silesian Voivodeship	Poland
16438	Choszczno	West Pomeranian Voivodeship	Poland
16440	Chojnice	Pomeranian Voivodeship	Poland
16441	Chodziez	Greater Poland Voivodeship	Poland
16442	Chelmza	Kujawsko-Pomorskie	Poland
16443	Chelmno	Kujawsko-Pomorskie	Poland
16445	Bytom	Silesian Voivodeship	Poland
16446	Bydgoszcz	Kujawsko-Pomorskie	Poland
16447	Brzeg	Opole Voivodeship	Poland
16448	Brodnica	Kujawsko-Pomorskie	Poland
16449	Braniewo	Warmian-Masurian Voivodeship	Poland
16450	Boleslawiec	Lower Silesian Voivodeship	Poland
16452	Bogatynia	Lower Silesian Voivodeship	Poland
16453	Bierun	Silesian Voivodeship	Poland
16454	Bielsko-Biala	Silesian Voivodeship	Poland
16455	Bielawa	Lower Silesian Voivodeship	Poland
16456	Bialogard	West Pomeranian Voivodeship	Poland
16458	Bedzin	Silesian Voivodeship	Poland
16463	Praga Poludnie	Masovian Voivodeship	Poland
16464	Jelcz Laskowice	Lower Silesian Voivodeship	Poland
16465	Saint-Pierre	Saint-Pierre	Saint Pierre and Miquelon
16466	Adamstown	N/A	Pitcairn
16467	Aguadilla	Aguadilla	Puerto Rico
16468	Arecibo	Arecibo	Puerto Rico
16469	Barceloneta	Barceloneta	Puerto Rico
16471	Caguas	Caguas	Puerto Rico
16472	Candelaria	Toa Baja	Puerto Rico
16473	Carolina	Carolina	Puerto Rico
16475	Cayey	Cayey	Puerto Rico
16476	Fajardo	Fajardo	Puerto Rico
16477	Guayama	Guayama	Puerto Rico
16478	Guaynabo	Guaynabo	Puerto Rico
16479	Humacao	Humacao	Puerto Rico
16480	Levittown	Toa Baja	Puerto Rico
16483	Ponce	Ponce	Puerto Rico
16484	San Juan	San Juan	Puerto Rico
16485	Trujillo Alto	Trujillo Alto	Puerto Rico
16486	Vega Baja	Vega Baja	Puerto Rico
16487	Yauco	Yauco	Puerto Rico
16488	Rafa?	Gaza Strip	Palestinian Territory
16489	An Nusayrat	Gaza Strip	Palestinian Territory
16490	Khan Yunis	Gaza Strip	Palestinian Territory
16491	Jabalya	Gaza Strip	Palestinian Territory
16492	Gaza	Gaza Strip	Palestinian Territory
16493	Dayr al Bala?	Gaza Strip	Palestinian Territory
16494	Bayt Lahya	Gaza Strip	Palestinian Territory
16495	Bayt ?anun	Gaza Strip	Palestinian Territory
16496	Bani Suhayla	Gaza Strip	Palestinian Territory
16497	Al Burayj	Gaza Strip	Palestinian Territory
16499	Yuta	West Bank	Palestinian Territory
16500	Tulkarm	West Bank	Palestinian Territory
16501	Tubas	West Bank	Palestinian Territory
16503	Ramallah	West Bank	Palestinian Territory
16504	Qalqilyah	West Bank	Palestinian Territory
16505	Qabatiyah	West Bank	Palestinian Territory
16506	Nablus	West Bank	Palestinian Territory
16507	Janin	West Bank	Palestinian Territory
16508	Idhna	West Bank	Palestinian Territory
16509	?al?ul	West Bank	Palestinian Territory
16510	Dura	West Bank	Palestinian Territory
16511	Bethlehem	West Bank	Palestinian Territory
16512	Bayt Jala	West Bank	Palestinian Territory
16514	Balatah	West Bank	Palestinian Territory
16517	Ar Ram wa ?a?iyat al Barid	West Bank	Palestinian Territory
16518	Jericho	West Bank	Palestinian Territory
16519	Al Yamun	West Bank	Palestinian Territory
16520	Hebron	West Bank	Palestinian Territory
16521	Al Birah	West Bank	Palestinian Territory
16523	Old City	West Bank	Palestinian Territory
16524	Al Qararah	Gaza Strip	Palestinian Territory
16525	Az Zuwaydah	Gaza Strip	Palestinian Territory
16526	East Jerusalem	West Bank	Palestinian Territory
16527	Vila Franca de Xira	Lisbon	Portugal
16528	Vialonga	Lisbon	Portugal
16529	Torres Vedras	Lisbon	Portugal
16531	Sintra	Lisbon	Portugal
16539	Rio de Mouro	Lisbon	Portugal
16540	Ramada	Lisbon	Portugal
16541	Queluz	Lisbon	Portugal
16542	Quarteira	Faro	Portugal
16545	Portalegre	Portalegre	Portugal
16546	Pontinha	Lisbon	Portugal
16547	Pombal	Leiria	Portugal
16550	Peniche	Leiria	Portugal
16551	Parede	Lisbon	Portugal
16555	Odivelas	Lisbon	Portugal
16557	Monte Estoril	Lisbon	Portugal
16560	Marinha Grande	Leiria	Portugal
16561	Loures	Lisbon	Portugal
16563	Lisbon	Lisbon	Portugal
16564	Linda-a-Velha	Lisbon	Portugal
16565	Leiria	Leiria	Portugal
16566	Laranjeiro	Faro	Portugal
16567	Lagos	Faro	Portugal
16568	Funchal	Madeira	Portugal
16569	Faro	Faro	Portugal
16571	Estoril	Lisbon	Portugal
16575	Castelo Branco	Castelo Branco	Portugal
16576	Cascais	Lisbon	Portugal
16577	Carnaxide	Lisbon	Portugal
16578	Carcavelos	Lisbon	Portugal
16580	Camarate	Lisbon	Portugal
16582	Caldas da Rainha	Leiria	Portugal
16584	Belas	Lisbon	Portugal
16585	Beja	Beja	Portugal
16589	Amadora	Lisbon	Portugal
16592	Alcabideche	Lisbon	Portugal
16593	Albufeira	Faro	Portugal
16594	Viseu	Viseu	Portugal
16595	Vila Real	Vila Real	Portugal
16596	Vilar de Andorinho	Porto	Portugal
16597	Vila Nova de Gaia	Porto	Portugal
16598	Vila do Conde	Porto	Portugal
16599	Viana do Castelo	Viana do Castelo	Portugal
16600	Valongo	Porto	Portugal
16601	Sequeira	Guarda	Portugal
16602	Senhora da Hora	Porto	Portugal
16606	Rio Tinto	Porto	Portugal
16608	Porto	Porto	Portugal
16609	Ponte de Lima	Viana do Castelo	Portugal
16610	Pedroso	Porto	Portugal
16611	Ovar	Aveiro	Portugal
16612	Oliveira do Douro	Porto	Portugal
16614	Matosinhos	Porto	Portugal
16615	Maia	Porto	Portugal
16620	Guarda	Guarda	Portugal
16621	Gondomar	Porto	Portugal
16622	Feira	Aveiro	Portugal
16624	Fafe	Braga	Portugal
16625	Esposende	Braga	Portugal
16626	Esposende	Braga	Portugal
16627	Ermesinde	Porto	Portugal
16628	Custoias	Guarda	Portugal
16630	Coimbra	Coimbra	Portugal
16631	Canidelo	Porto	Portugal
16633	Braga	Braga	Portugal
16634	Bougado	Porto	Portugal
16635	Barcelos	Braga	Portugal
16636	Baguim do Monte	Porto	Portugal
16637	Aveiro	Aveiro	Portugal
16639	Ponta Delgada	Azores	Portugal
16640	Melekeok	Melekeok	Palau
16642	Villa Hayes	Presidente Hayes	Paraguay
16643	Villa Elisa	Central	Paraguay
16644	San Lorenzo	Central	Paraguay
16645	San Juan Bautista	Misiones	Paraguay
16646	San Antonio	Central	Paraguay
16649	Pedro Juan Caballero	Amambay	Paraguay
16650	Nemby	Central	Paraguay
16651	Limpio	Central	Paraguay
16655	Fernando de la Mora	Central	Paraguay
16659	Colonia Mariano Roque Alonso	Central	Paraguay
16666	Umm Salal Mu?ammad	Baladiyat Umm Salal	Qatar
16667	Ar Rayyan	Baladiyat ar Rayyan	Qatar
16668	Al Wakrah	Al Wakrah	Qatar
16669	Al Khawr	Al Khawr	Qatar
16670	Doha	Baladiyat ad Daw?ah	Qatar
16684	Piton Saint-Leu	N/A	Reunion
16685	Zimnicea	Teleorman	Romania
16686	Zarne?ti	Brasov	Romania
16687	Zalau	Salaj	Romania
16688	Vulcan	Hunedoara	Romania
16689	Voluntari	Ilfov	Romania
16690	Viseu de Sus	Maramures	Romania
16691	Vatra Dornei	Suceava	Romania
16692	Vaslui	Vaslui	Romania
16693	Urziceni	Ialomita	Romania
16694	Turnu Magurele	Teleorman	Romania
16695	Turda	Cluj	Romania
16696	Tulcea	Tulcea	Romania
16703	Timisoara	Timis	Romania
16704	Tecuci	Galati	Romania
16705	Suceava	Suceava	Romania
16706	Slatina	Olt	Romania
16707	Simleu Silvaniei	Salaj	Romania
16708	Sighetu Marmatiei	Maramures	Romania
16709	Sibiu	Sibiu	Romania
16711	Sebes	Alba	Romania
16712	Satu Mare	Satu Mare	Romania
16713	Salonta	Bihor	Romania
16714	Sacele	Brasov	Romania
16715	Ro?iorii de Vede	Teleorman	Romania
16716	Roman	Neamt	Romania
16720	Resita	Caras-Severin	Romania
16721	Reghin-Sat	Mures	Romania
16722	Radau?i	Suceava	Romania
16723	Popesti-Leordeni	Ilfov	Romania
16724	Ploiesti	Prahova	Romania
16725	Pitesti	Arges	Romania
16726	Piatra Neamt	Neamt	Romania
16727	Petrosani	Hunedoara	Romania
16728	Petrila	Hunedoara	Romania
16729	Pantelimon	Ilfov	Romania
16730	Orastie	Hunedoara	Romania
16731	Oradea	Bihor	Romania
16732	Oltenita	Calarasi	Romania
16733	Odorheiu Secuiesc	Harghita	Romania
16734	Ocna Mures	Alba	Romania
16735	Navodari	Constan?a	Romania
16736	Motru	Gorj	Romania
16738	Moinesti	Bacau	Romania
16739	Mizil	Prahova	Romania
16740	Miercurea-Ciuc	Harghita	Romania
16741	Medias	Sibiu	Romania
16742	Medgidia	Constan?a	Romania
16743	Mangalia	Constan?a	Romania
16744	Lupeni	Hunedoara	Romania
16745	Lugoj	Timis	Romania
16746	Ludus	Mures	Romania
16747	Iasi	Iasi	Romania
16748	Husi	Vaslui	Romania
16749	Hunedoara	Hunedoara	Romania
16750	Gura Humorului	Suceava	Romania
16751	Giurgiu	Giurgiu	Romania
16752	Gherla	Cluj	Romania
16753	Gheorgheni	Harghita	Romania
16754	Galati	Galati	Romania
16756	Foc?ani	Vrancea	Romania
16757	Filiasi	Dolj	Romania
16758	Fete?ti-Gara	Ialomita	Romania
16759	Fetesti	Ialomita	Romania
16760	Falticeni	Suceava	Romania
16761	Fagara?	Brasov	Romania
16762	Drobeta-Turnu Severin	Mehedinti	Romania
16764	Dorohoi	Botosani	Romania
16765	Deva	Hunedoara	Romania
16766	Dej	Cluj	Romania
16767	Curtea de Arges	Arges	Romania
16768	Cugir	Alba	Romania
16769	Craiova	Dolj	Romania
16770	Corabia	Olt	Romania
16771	Constanta	Constan?a	Romania
16772	Comanesti	Bacau	Romania
16773	Codlea	Brasov	Romania
16774	Cluj-Napoca	Cluj	Romania
16775	Cisnadie	Sibiu	Romania
16779	Cernavoda	Constan?a	Romania
16780	Carei	Satu Mare	Romania
16781	Caransebes	Caras-Severin	Romania
16782	Caracal	Olt	Romania
16783	Calafat	Dolj	Romania
16784	Buzau	Buzau	Romania
16785	Buhusi	Bacau	Romania
16786	Buftea	Ilfov	Romania
16787	Bucharest	Bucuresti	Romania
16788	Breaza	Prahova	Romania
16789	Brasov	Brasov	Romania
16790	Braila	Braila	Romania
16791	Brad	Hunedoara	Romania
16792	Botosani	Botosani	Romania
16793	Borsa	Maramures	Romania
16794	Bocsa	Caras-Severin	Romania
16795	Blaj	Alba	Romania
16796	Bistrita	Bistrita-Nasaud	Romania
16798	Bals	Olt	Romania
16799	Bailesti	Dolj	Romania
16800	Baicoi	Prahova	Romania
16801	Baia Sprie	Maramures	Romania
16802	Baia Mare	Maramures	Romania
16803	Bacau	Bacau	Romania
16804	Arad	Arad	Romania
16805	Alexandria	Teleorman	Romania
16806	Alba Iulia	Alba	Romania
16807	Aiud	Alba	Romania
16808	Adjud	Vrancea	Romania
16809	Baia Mare	Satu Mare	Romania
16810	Pascani	Iasi	Romania
16811	Mioveni	Arges	Romania
16812	Sighi?oara	Mures	Romania
16813	Slobozia	Ialomita	Romania
16814	Sector 1	Bucuresti	Romania
16815	Sector 2	Bucuresti	Romania
16816	Sector 3	Bucuresti	Romania
16817	Sector 4	Bucuresti	Romania
16818	Sector 5	Bucuresti	Romania
16819	Sector 6	Bucuresti	Romania
16820	Zrenjanin	Vojvodina	Serbia
16821	Zemun	Central Serbia	Serbia
16822	Zajecar	Central Serbia	Serbia
16824	Vranje	Central Serbia	Serbia
16825	Trstenik	Central Serbia	Serbia
16826	Stara Pazova	Vojvodina	Serbia
16827	Sremcica	Central Serbia	Serbia
16828	Smederevska Palanka	Central Serbia	Serbia
16829	Smederevo	Central Serbia	Serbia
16830	Senta	Vojvodina	Serbia
16831	Prokuplje	Central Serbia	Serbia
16833	Pirot	Central Serbia	Serbia
16834	Pancevo	Vojvodina	Serbia
16835	Obrenovac	Central Serbia	Serbia
16836	Novi Pazar	Central Serbia	Serbia
16837	Nova Pazova	Vojvodina	Serbia
16839	Negotin	Central Serbia	Serbia
16840	Leskovac	Central Serbia	Serbia
16841	Lazarevac	Central Serbia	Serbia
16843	Kraljevo	Central Serbia	Serbia
16844	Kragujevac	Central Serbia	Serbia
16845	Kikinda	Vojvodina	Serbia
16846	Jagodina	Central Serbia	Serbia
16847	Indija	Vojvodina	Serbia
16848	Gornji Milanovac	Central Serbia	Serbia
16849	Cuprija	Central Serbia	Serbia
16850	Cacak	Central Serbia	Serbia
16851	Bor	Central Serbia	Serbia
16852	Belgrade	Central Serbia	Serbia
16853	Becej	Vojvodina	Serbia
16854	Arandelovac	Central Serbia	Serbia
16855	Vrbas	Vojvodina	Serbia
16856	Valjevo	Central Serbia	Serbia
16858	Subotica	Vojvodina	Serbia
16859	Sremska Mitrovica	Vojvodina	Serbia
16860	Sombor	Vojvodina	Serbia
16862	Ruma	Vojvodina	Serbia
16863	Novi Sad	Vojvodina	Serbia
16864	Backa Topola	Vojvodina	Serbia
16865	Backa Palanka	Vojvodina	Serbia
16866	Apatin	Vojvodina	Serbia
16867	Knjazevac	Central Serbia	Serbia
16868	Udomlya	Tverskaya	Russia
16869	Sosnovka	St.-Petersburg	Russia
16870	Sasovo	Rjazan	Russia
16871	Zyuzino	Moscow	Russia
16872	Zyablikovo	Moscow	Russia
16873	Zverevo	Rostov	Russia
16874	Zvenigorod	MO	Russia
16875	Zlatoust	Chelyabinsk	Russia
16876	Zimovniki	Rostov	Russia
16877	Zhulebino	Moscow	Russia
16878	Zhukovskiy	MO	Russia
16879	Zhukovka	Brjansk	Russia
16880	Zhirnovsk	Volgograd	Russia
16881	Zhigulevsk	Samara	Russia
16882	Zherdevka	Tambov	Russia
16883	Zheleznovodsk	Stavropolskiy	Russia
16884	Zheleznogorsk	Kursk	Russia
16885	Zheleznodorozhnyy	MO	Russia
16886	Zernograd	Rostov	Russia
16887	Zelenokumsk	Stavropolskiy	Russia
16888	Zelenograd	Moscow	Russia
16889	Zelenodolsk	Tatarstan	Russia
16890	Zelenchukskaya	Karachayevo-Cherkesiya	Russia
16892	Zarechnyy	Penza	Russia
16893	Zaraysk	MO	Russia
16894	Zapolyarnyy	Murmansk	Russia
16896	Zainsk	Tatarstan	Russia
16898	Yoshkar-Ola	Mariy-El	Russia
16899	Yeysk	Krasnodarskiy	Russia
16900	Yessentukskaya	Stavropolskiy	Russia
16901	Yessentuki	Stavropolskiy	Russia
16902	Yershov	Saratov	Russia
16903	Yemva	Komi Republic	Russia
16904	Yelizavetinskaya	Krasnodarskiy	Russia
16905	Yelets	Lipetsk	Russia
16907	Yelabuga	Tatarstan	Russia
16909	Yegorlykskaya	Rostov	Russia
16910	Yefremov	Tula	Russia
16911	Yasnyy	Orenburg	Russia
16912	Yasnogorsk	Tula	Russia
16913	Yasenevo	Moscow	Russia
16914	Yartsevo	Smolensk	Russia
16915	Yaroslavl	Jaroslavl	Russia
16916	Yaransk	Kirov	Russia
16917	Yanaul	Bashkortostan	Russia
16918	Yagry	Arkhangelskaya	Russia
16919	Yablonovskiy	Adygeya	Russia
16921	Vyselki	Krasnodarskiy	Russia
16922	Vyksa	Nizjnij Novgorod	Russia
16923	Vykhino-Zhulebino	Moscow	Russia
16924	Vyborg	Leningrad	Russia
16925	Vyazniki	Vladimir	Russia
16927	Vyatskiye Polyany	Kirov	Russia
16928	Vsevolozhsk	Leningrad	Russia
16929	Votkinsk	Udmurtiya	Russia
16930	Vostryakovo	MO	Russia
16931	Vostryakovo	MO	Russia
16932	Voskresensk	MO	Russia
16933	Voronezh	Voronezj	Russia
16936	Volzhskiy	Volgograd	Russia
16937	Volzhsk	Mariy-El	Russia
16939	Volokolamsk	MO	Russia
16940	Vologda	Vologda	Russia
16941	Volkhov	Leningrad	Russia
16942	Nagornyy	Moscow	Russia
16943	Volgorechensk	Kostroma	Russia
16944	Volgograd	Volgograd	Russia
16945	Volgodonsk	Rostov	Russia
16946	Vnukovo	Moscow	Russia
16947	Novovladykino	Moscow	Russia
16948	Vladimir	Vladimir	Russia
16949	Vladikavkaz	North Ossetia	Russia
16950	Vidnoye	MO	Russia
16951	Vichuga	Ivanovo	Russia
16952	Veshnyaki	Moscow	Russia
16953	Vereshchagino	Perm	Russia
16956	Velikiy Ustyug	Vologda	Russia
16957	Velikiye Luki	Pskov	Russia
16958	Vatutino	Moscow	Russia
16959	Valuyki	Belgorod	Russia
16960	Valday	Novgorod	Russia
16961	Vagonoremont	Moscow	Russia
16962	Uzlovaya	Tula	Russia
16963	Uvarovo	Tambov	Russia
16964	Uva	Udmurtiya	Russia
16969	Uryupinsk	Volgograd	Russia
16970	Urus-Martan	Chechnya	Russia
16971	Uritsk	St.-Petersburg	Russia
16972	Unecha	Brjansk	Russia
16973	Ulyanovsk	Ulyanovsk	Russia
16974	Ukhta	Komi Republic	Russia
16975	Uglich	Jaroslavl	Russia
16976	Ufa	Bashkortostan	Russia
16977	Uchkeken	Karachayevo-Cherkesiya	Russia
16978	Uchaly	Bashkortostan	Russia
16979	Uchaly	Bashkortostan	Russia
16980	Tyrnyauz	Kabardino-Balkariya	Russia
16981	Tver	Tverskaya	Russia
16982	Tuymazy	Bashkortostan	Russia
16983	Tutayev	Jaroslavl	Russia
16984	Tula	Tula	Russia
16985	Tuchkovo	MO	Russia
16986	Tuapse	Krasnodarskiy	Russia
16987	Tsimlyansk	Rostov	Russia
16988	Trubchevsk	Brjansk	Russia
16990	Troitskaya	Ingushetiya	Russia
16991	Troitsk	Moscow	Russia
16992	Tosno	Leningrad	Russia
16993	Torzhok	Tverskaya	Russia
16994	Tomilino	MO	Russia
16997	Tikhvin	Leningrad	Russia
16998	Tikhoretsk	Krasnodarskiy	Russia
16999	Teykovo	Ivanovo	Russia
17000	Terek	Kabardino-Balkariya	Russia
17001	Tyoply Stan	Moscow	Russia
17002	Temryuk	Krasnodarskiy	Russia
17004	Tbilisskaya	Krasnodarskiy	Russia
17005	Tambov	Tambov	Russia
17007	Taganrog	Rostov	Russia
17008	Taganskiy	Moscow	Russia
17010	Syktyvkar	Komi Republic	Russia
17011	Svobody	Stavropolskiy	Russia
17012	Sviblovo	Moscow	Russia
17013	Svetogorsk	Leningrad	Russia
17014	Svetlyy	Kaliningrad	Russia
17015	Svetlograd	Stavropolskiy	Russia
17016	Suvorovskaya	Stavropolskiy	Russia
17017	Suvorov	Tula	Russia
17018	Surovikino	Volgograd	Russia
17019	Surkhakhi	Ingushetiya	Russia
17020	Sukhinichi	Kaluga	Russia
17021	Stupino	MO	Russia
17022	Strunino	Vladimir	Russia
17024	Strogino	Moscow	Russia
17025	Sterlitamak	Bashkortostan	Russia
17027	Staryy Oskol	Belgorod	Russia
17028	Staroshcherbinovskaya	Krasnodarskiy	Russia
17029	Starominskaya	Krasnodarskiy	Russia
17030	Starodub	Brjansk	Russia
17031	Staraya Russa	Novgorod	Russia
17032	Staraya Kupavna	MO	Russia
17033	Staraya Derevnya	St.-Petersburg	Russia
17034	Sovetsk	Kirov	Russia
17035	Sovetsk	Kaliningrad	Russia
17036	Sosnovyy Bor	Leningrad	Russia
17037	Sosnovaya Polyana	St.-Petersburg	Russia
17038	Sosnogorsk	Komi Republic	Russia
17039	Sortavala	Republic of Karelia	Russia
17040	Sorochinsk	Orenburg	Russia
17041	Solntsevo	Moscow	Russia
17042	Solnechnogorsk	MO	Russia
17044	Solikamsk	Perm	Russia
17046	Sokol	Moscow	Russia
17047	Sokol	Vologda	Russia
17048	Sofrino	MO	Russia
17049	Sochi	Krasnodarskiy	Russia
17050	Sobinka	Vladimir	Russia
17051	Smolensk	Smolensk	Russia
17052	Slobodskoy	Kirov	Russia
17053	Slobodka	Moscow	Russia
17054	Slavyansk-na-Kubani	Krasnodarskiy	Russia
17055	Slantsy	Leningrad	Russia
17056	Skopin	Rjazan	Russia
17057	Skhodnya	MO	Russia
17058	Sim	Chelyabinsk	Russia
17059	Sibay	Bashkortostan	Russia
17060	Shuya	Ivanovo	Russia
17061	Shushary	St.-Petersburg	Russia
17062	Shumerlya	Chuvashia	Russia
17063	Mikhaylovsk	Stavropolskiy	Russia
17064	Shilovo	Rjazan	Russia
17065	Sheksna	Vologda	Russia
17066	Shebekino	Belgorod	Russia
17067	Shchukino	Moscow	Russia
17068	Shchigry	Kursk	Russia
17069	Shcherbinka	Moscow	Russia
17070	Shchelkovo	MO	Russia
17072	Shatura	MO	Russia
17074	Shali	Chechnya	Russia
17076	Shakhty	Rostov	Russia
17077	Severskaya	Krasnodarskiy	Russia
17078	Severo-Zadonsk	Tula	Russia
17080	Severomorsk	Murmansk	Russia
17081	Severodvinsk	Arkhangelskaya	Russia
17082	Severnyy	Moscow	Russia
17084	Sestroretsk	St.-Petersburg	Russia
17085	Sertolovo	Leningrad	Russia
17086	Serpukhov	MO	Russia
17087	Sergiyev Posad	MO	Russia
17088	Sergach	Nizjnij Novgorod	Russia
17089	Serdobsk	Penza	Russia
17090	Semiluki	Voronezj	Russia
17091	Semikarakorsk	Rostov	Russia
17095	Segezha	Republic of Karelia	Russia
17096	Satka	Chelyabinsk	Russia
17097	Sarov	Nizjnij Novgorod	Russia
17098	Saratov	Saratov	Russia
17099	Sarapul	Udmurtiya	Russia
17100	Saransk	Mordoviya	Russia
17101	Saraktash	Orenburg	Russia
17102	Saint Petersburg	St.-Petersburg	Russia
17103	Samara	Samara	Russia
17105	Salavat	Bashkortostan	Russia
17106	Safonovo	Smolensk	Russia
17107	Rzhev	Tverskaya	Russia
17108	Rybnoye	Rjazan	Russia
17109	Rybinsk	Jaroslavl	Russia
17110	Rybatskoye	Leningrad	Russia
17111	Ryazhsk	Rjazan	Russia
17113	Ruzayevka	Mordoviya	Russia
17115	Rtishchevo	Saratov	Russia
17116	Rostov-na-Donu	Rostov	Russia
17117	Rostov	Jaroslavl	Russia
17118	Rostokino	Moscow	Russia
17123	Rodniki	Ivanovo	Russia
17124	Revda	Sverdlovsk	Russia
17125	Reutov	MO	Russia
17126	Razumnoye	Belgorod	Russia
17127	Rayevskiy	Bashkortostan	Russia
17128	Rasskazovo	Tambov	Russia
17129	Ramenki	Moscow	Russia
17130	Pyatigorsk	Stavropolskiy	Russia
17131	Pushkino	MO	Russia
17132	Pushkin	St.-Petersburg	Russia
17133	Pushchino	MO	Russia
17134	Pugachev	Saratov	Russia
17135	Pskov	Pskov	Russia
17136	Protvino	MO	Russia
17137	Proletarsk	Rostov	Russia
17138	Prokhladnyy	Kabardino-Balkariya	Russia
17139	Priyutovo	Bashkortostan	Russia
17140	Privolzhskiy	Saratov	Russia
17141	Privolzhsk	Ivanovo	Russia
17143	Primorsko-Akhtarsk	Krasnodarskiy	Russia
17144	Pridonskoy	Voronezj	Russia
17145	Povorino	Voronezj	Russia
17146	Kotlovka	Moscow	Russia
17147	Annino	Moscow	Russia
17148	Polyarnyye Zori	Murmansk	Russia
17149	Polyarnyy	Murmansk	Russia
17151	Pokrov	Vladimir	Russia
17152	Pokhvistnevo	Samara	Russia
17155	Pochep	Brjansk	Russia
17156	Ryazanskiy	Moscow	Russia
17157	Plavsk	Tula	Russia
17159	Petushki	Vladimir	Russia
17160	Petrozavodsk	Republic of Karelia	Russia
17161	Petrovskaya	MO	Russia
17162	Petrovsk	Saratov	Russia
17163	Petrodvorets	St.-Petersburg	Russia
17164	Peterhof	St.-Petersburg	Russia
17165	Pestovo	Novgorod	Russia
17167	Perovo	Moscow	Russia
17168	Perm	Perm	Russia
17170	Novo-Peredelkino	Moscow	Russia
17171	Penza	Penza	Russia
17172	Pechora	Komi Republic	Russia
17173	Pavlovskiy Posad	MO	Russia
17174	Pavlovskaya	Krasnodarskiy	Russia
17175	Pavlovsk	St.-Petersburg	Russia
17176	Pavlovsk	Voronezj	Russia
17177	Pashkovskiy	Krasnodarskiy	Russia
17178	Pallasovka	Volgograd	Russia
17180	Ozerki	St.-Petersburg	Russia
17181	Otradnyy	Samara	Russia
17182	Otradnoye	Moscow	Russia
17183	Otradnoye	Leningrad	Russia
17184	Otradnaya	Krasnodarskiy	Russia
17185	Ostrov	Pskov	Russia
17186	Ostrogozhsk	Voronezj	Russia
17187	Ostashkov	Tverskaya	Russia
17188	Ostankinskiy	Moscow	Russia
17189	Osa	Perm	Russia
17190	Orsk	Orenburg	Russia
17191	Orlovskiy	Rostov	Russia
17192	Orenburg	Orenburg	Russia
17194	Orekhovo-Zuyevo	MO	Russia
17195	Orekhovo-Borisovo Severnoye	Moscow	Russia
17196	Ordzhonikidzevskaya	Ingushetiya	Russia
17197	Onega	Arkhangelskaya	Russia
17198	Omutninsk	Kirov	Russia
17199	Olenegorsk	Murmansk	Russia
17200	Tsotsin-Yurt	Chechnya	Russia
17202	Odintsovo	MO	Russia
17204	Ochakovo-Matveyevskoye	Moscow	Russia
17205	Obninsk	Kaluga	Russia
17206	Nytva	Perm	Russia
17207	Nyandoma	Arkhangelskaya	Russia
17208	Nurlat	Tatarstan	Russia
17209	Novyy Oskol	Belgorod	Russia
17212	Novozybkov	Brjansk	Russia
17213	Novovoronezh	Voronezj	Russia
17214	Novouzensk	Saratov	Russia
17216	Novotroitsk	Orenburg	Russia
17217	Novotitarovskaya	Krasnodarskiy	Russia
17218	Novoshakhtinsk	Rostov	Russia
17219	Novorossiysk	Krasnodarskiy	Russia
17220	Novopokrovskaya	Krasnodarskiy	Russia
17221	Novopavlovsk	Stavropolskiy	Russia
17222	Novomoskovsk	Tula	Russia
17223	Novomichurinsk	Rjazan	Russia
17225	Novokuybyshevsk	Samara	Russia
17226	Novokubansk	Krasnodarskiy	Russia
17227	Novokhovrino	Moscow	Russia
17228	Novogireyevo	MO	Russia
17229	Novodvinsk	Arkhangelskaya	Russia
17230	Novocherkassk	Rostov	Russia
17231	Novocheboksarsk	Chuvashia	Russia
17232	Novoanninskiy	Volgograd	Russia
17233	Novoaleksandrovsk	Stavropolskiy	Russia
17234	Velikiy Novgorod	Novgorod	Russia
17236	Novaya Derevnya	St.-Petersburg	Russia
17237	Noginsk	MO	Russia
17238	Nizhnyaya Tura	Sverdlovsk	Russia
17239	Nizhniy Tagil	Sverdlovsk	Russia
17240	Nizhniy Novgorod	Nizjnij Novgorod	Russia
17241	Nizhniy Lomov	Penza	Russia
17242	Nizhnekamsk	Tatarstan	Russia
17243	Nikulino	Moscow	Russia
17247	Nikolayevsk	Volgograd	Russia
17249	Nezlobnaya	Stavropolskiy	Russia
17250	Nevinnomyssk	Stavropolskiy	Russia
17252	Nesterovskaya	Ingushetiya	Russia
17253	Nerekhta	Kostroma	Russia
17254	Nelidovo	Tverskaya	Russia
17255	Neftekamsk	Bashkortostan	Russia
17256	Neftegorsk	Samara	Russia
17258	Navashino	Nizjnij Novgorod	Russia
17259	Naryan-Mar	Nenetskiy Avtonomnyy Okrug	Russia
17260	Nartkala	Kabardino-Balkariya	Russia
17261	Naro-Fominsk	MO	Russia
17263	Nakhabino	MO	Russia
17264	Naberezhnyye Chelny	Tatarstan	Russia
17265	Mytishchi	MO	Russia
17266	Murom	Vladimir	Russia
17267	Murmansk	Murmansk	Russia
17268	Mtsensk	Orjol	Russia
17269	Mozhga	Udmurtiya	Russia
17270	Mozhaysk	MO	Russia
17271	Mozdok	North Ossetia	Russia
17272	Mostovskoy	Krasnodarskiy	Russia
17273	Moscow	Moscow	Russia
17274	Morshansk	Tambov	Russia
17275	Morozovsk	Rostov	Russia
17276	Monino	MO	Russia
17277	Monchegorsk	Murmansk	Russia
17278	Mirnyy	Arkhangelskaya	Russia
17279	Mineralnye Vody	Stavropolskiy	Russia
17280	Millerovo	Rostov	Russia
17281	Mikhaylovka	Volgograd	Russia
17282	Mikhalkovo	Moscow	Russia
17283	Michurinsk	Tambov	Russia
17284	Metallostroy	St.-Petersburg	Russia
17285	Menzelinsk	Tatarstan	Russia
17286	Mendeleyevsk	Tatarstan	Russia
17287	Meleuz	Bashkortostan	Russia
17288	Melenki	Vladimir	Russia
17290	Medvedovskaya	Krasnodarskiy	Russia
17291	Medvedevo	Mariy-El	Russia
17292	Mednogorsk	Orenburg	Russia
17293	Maykop	Adygeya	Russia
17294	Matveyevskoye	Moscow	Russia
17295	Marks	Saratov	Russia
17298	Manturovo	Kostroma	Russia
17299	Yaroslavskiy	Moscow	Russia
17300	Maloyaroslavets	Kaluga	Russia
17301	Malgobek	Ingushetiya	Russia
17302	Malakhovka	MO	Russia
17303	Makhachkala	Dagestan	Russia
17304	Magnitogorsk	Chelyabinsk	Russia
17305	Lyudinovo	Kaluga	Russia
17306	Lyublino	Moscow	Russia
17307	Lyubertsy	MO	Russia
17308	Lytkarino	MO	Russia
17310	Lyskovo	Nizjnij Novgorod	Russia
17311	Luzhniki	Moscow	Russia
17312	Lukhovitsy	MO	Russia
17313	Luga	Leningrad	Russia
17314	Losino-Petrovskiy	MO	Russia
17315	Lomonosov	St.-Petersburg	Russia
17316	Lodeynoye Pole	Leningrad	Russia
17317	Lobnya	MO	Russia
17318	Livny	Orjol	Russia
17319	Liski	Voronezj	Russia
17320	Lipetsk	Lipetsk	Russia
17321	Likino-Dulevo	MO	Russia
17322	Likhobory	Moscow	Russia
17323	Lianozovo	Moscow	Russia
17325	Levoberezhnaya	MO	Russia
17326	Komendantsky aerodrom	St.-Petersburg	Russia
17327	Lermontov	Stavropolskiy	Russia
17328	Leonovo	Moscow	Russia
17329	Leninskiye Gory	MO	Russia
17330	Leninsk	Volgograd	Russia
17331	Leninogorsk	Tatarstan	Russia
17332	Tsaritsyno	Moscow	Russia
17333	Leningradskaya	Krasnodarskiy	Russia
17334	Yubileyny	MO	Russia
17335	Lefortovo	Moscow	Russia
17337	Lazarevskoye	Krasnodarskiy	Russia
17338	Lakinsk	Vladimir	Russia
17339	Labinsk	Krasnodarskiy	Russia
17340	Dugulubgey	Kabardino-Balkariya	Russia
17341	Kuznetsk	Penza	Russia
17343	Kuvandyk	Orenburg	Russia
17344	Kuskovo	MO	Russia
17345	Kushva	Sverdlovsk	Russia
17347	Kusa	Chelyabinsk	Russia
17349	Kursk	Kursk	Russia
17350	Kurovskoye	MO	Russia
17351	Kurganinsk	Krasnodarskiy	Russia
17352	Kurchatov	Kursk	Russia
17353	Kurchaloy	Chechnya	Russia
17354	Kupchino	St.-Petersburg	Russia
17355	Kungur	Perm	Russia
17356	Kumertau	Bashkortostan	Russia
17357	Kulebaki	Nizjnij Novgorod	Russia
17358	Kukmor	Tatarstan	Russia
17359	Kudymkar	Perm	Russia
17360	Kudepsta	Krasnodarskiy	Russia
17361	Kubinka	MO	Russia
17362	Kstovo	Nizjnij Novgorod	Russia
17363	Krymsk	Krasnodarskiy	Russia
17364	Kropotkin	Krasnodarskiy	Russia
17365	Kronshtadt	St.-Petersburg	Russia
17366	Krasnyy Sulin	Rostov	Russia
17368	Krasnoye Selo	St.-Petersburg	Russia
17369	Krasnovishersk	Perm	Russia
17370	Krasnoufimsk	Sverdlovsk	Russia
17371	Krasnokamsk	Perm	Russia
17372	Krasnogvardeyskoye	Stavropolskiy	Russia
17373	Krasnogorsk	MO	Russia
17374	Krasnodar	Krasnodarskiy	Russia
17375	Krasnoarmeyskaya	Krasnodarskiy	Russia
17376	Krasnoarmeysk	MO	Russia
17377	Krasnoarmeysk	Saratov	Russia
17378	Presnenskiy	MO	Russia
17380	Kozhukhovo	MO	Russia
17381	Kozeyevo	Moscow	Russia
17383	Kovylkino	Mordoviya	Russia
17384	Kovrov	Vladimir	Russia
17385	Kovdor	Murmansk	Russia
17386	Kotovsk	Tambov	Russia
17387	Kotovo	Volgograd	Russia
17388	Kotlas	Arkhangelskaya	Russia
17392	Kostroma	Kostroma	Russia
17393	Kostomuksha	Republic of Karelia	Russia
17394	Kosaya Gora	Tula	Russia
17395	Koryazhma	Arkhangelskaya	Russia
17396	Korenovsk	Krasnodarskiy	Russia
17397	Konstantinovsk	Rostov	Russia
17398	Kondrovo	Kaluga	Russia
17399	Kondopoga	Republic of Karelia	Russia
17400	Konakovo	Tverskaya	Russia
17401	Kommunar	Leningrad	Russia
17402	Kolpino	St.-Petersburg	Russia
17403	Kolomyagi	St.-Petersburg	Russia
17404	Kolomna	MO	Russia
17405	Kolomenskoye	Moscow	Russia
17407	Kokhma	Ivanovo	Russia
17408	Klintsy	Brjansk	Russia
17409	Klin	MO	Russia
17410	Klimovsk	MO	Russia
17411	Kizlyar	Dagestan	Russia
17412	Kizilyurt	Dagestan	Russia
17413	Kizel	Perm	Russia
17414	Kislovodsk	Stavropolskiy	Russia
17415	Kirzhach	Vladimir	Russia
17416	Kirsanov	Tambov	Russia
17417	Kirovsk	Murmansk	Russia
17418	Kirovsk	Leningrad	Russia
17419	Kirovo-Chepetsk	Kirov	Russia
17420	Kirov	Kirov	Russia
17421	Kirov	Kaluga	Russia
17422	Kirishi	Leningrad	Russia
17423	Kireyevsk	Tula	Russia
17424	Kingisepp	Leningrad	Russia
17425	Kineshma	Ivanovo	Russia
17428	Kimry	Tverskaya	Russia
17429	Kimovsk	Tula	Russia
17430	Khotkovo	MO	Russia
17431	Khosta	Krasnodarskiy	Russia
17433	Kholmskiy	Krasnodarskiy	Russia
17434	Khimki	Moscow	Russia
17435	Khasavyurt	Dagestan	Russia
17436	Kharabali	Astrakhan	Russia
17437	Khadyzhensk	Krasnodarskiy	Russia
17438	Kazan	Tatarstan	Russia
17439	Katav-Ivanovsk	Chelyabinsk	Russia
17440	Kastanayevo	MO	Russia
17441	Kaspiysk	Dagestan	Russia
17442	Kasimov	Rjazan	Russia
17443	Kashira	MO	Russia
17444	Kashin	Tverskaya	Russia
17445	Karachev	Brjansk	Russia
17446	Karachayevsk	Karachayevo-Cherkesiya	Russia
17447	Karabulak	Ingushetiya	Russia
17448	Karabanovo	Vladimir	Russia
17449	Kapotnya	Moscow	Russia
17450	Kantyshevo	Ingushetiya	Russia
17451	Kanevskaya	Krasnodarskiy	Russia
17452	Kandalaksha	Murmansk	Russia
17453	Kanash	Chuvashia	Russia
17454	Kamyzyak	Astrakhan	Russia
17455	Kamyshin	Volgograd	Russia
17456	Kamensk-Shakhtinskiy	Rostov	Russia
17457	Kaluga	Kaluga	Russia
17458	Kalininsk	Saratov	Russia
17459	Korolev	MO	Russia
17460	Kaliningrad	Kaliningrad	Russia
17461	Kalach-na-Donu	Volgograd	Russia
17462	Kalach	Voronezj	Russia
17463	Kachkanar	Sverdlovsk	Russia
17464	Kabanovo	MO	Russia
17466	Izmaylovo	MO	Russia
17467	Izhevsk	Udmurtiya	Russia
17468	Izberbash	Dagestan	Russia
17469	Ivanteyevka	MO	Russia
17470	Ivanovskoye	Moscow	Russia
17471	Ivanovo	Ivanovo	Russia
17472	Istra	MO	Russia
17473	Ishimbay	Bashkortostan	Russia
17474	Ipatovo	Stavropolskiy	Russia
17475	Inza	Ulyanovsk	Russia
17476	Inozemtsevo	Stavropolskiy	Russia
17478	Igra	Udmurtiya	Russia
17480	Gusev	Kaliningrad	Russia
17482	Gukovo	Rostov	Russia
17483	Gudermes	Chechnya	Russia
17484	Gubkin	Belgorod	Russia
17485	Gubakha	Perm	Russia
17486	Gryazovets	Vologda	Russia
17487	Gryazi	Lipetsk	Russia
17488	Groznyy	Chechnya	Russia
17489	Gribanovskiy	Voronezj	Russia
17490	Grazhdanka	St.-Petersburg	Russia
17491	Goryachiy Klyuch	Krasnodarskiy	Russia
17492	Goryachevodskiy	Stavropolskiy	Russia
17493	Gorodishche	Volgograd	Russia
17494	Gorodets	Nizjnij Novgorod	Russia
17495	Gorelovo	St.-Petersburg	Russia
17497	Golitsyno	MO	Russia
17498	Glazov	Udmurtiya	Russia
17499	Giaginskaya	Adygeya	Russia
17500	Georgiyevsk	Stavropolskiy	Russia
17501	Gelendzhik	Krasnodarskiy	Russia
17502	Gay	Orenburg	Russia
17503	Gavrilov-Yam	Jaroslavl	Russia
17504	Gatchina	Leningrad	Russia
17505	Galich	Kostroma	Russia
17506	Gagarin	Smolensk	Russia
17507	Furmanov	Ivanovo	Russia
17508	Fryazino	MO	Russia
17509	Fryazevo	MO	Russia
17510	Frolovo	Volgograd	Russia
17511	Fili	MO	Russia
17512	Ezhva	Komi Republic	Russia
17514	Enem	Adygeya	Russia
17515	Elista	Kalmykiya	Russia
17516	Elektrougli	MO	Russia
17518	Elektrogorsk	MO	Russia
17519	Ekazhevo	Ingushetiya	Russia
17520	Dzerzhinskiy	MO	Russia
17521	Dzerzhinsk	Nizjnij Novgorod	Russia
17522	Dyurtyuli	Bashkortostan	Russia
17524	Dubovka	Volgograd	Russia
17525	Dubna	MO	Russia
17526	Dorogomilovo	MO	Russia
17527	Donskoye	Stavropolskiy	Russia
17528	Donskoy	Tula	Russia
17529	Donetsk	Rostov	Russia
17530	Domodedovo	MO	Russia
17531	Dolgoprudnyy	MO	Russia
17532	Dobryanka	Perm	Russia
17533	Dmitrov	MO	Russia
17534	Divnoye	Stavropolskiy	Russia
17535	Dinskaya	Krasnodarskiy	Russia
17536	Dimitrovgrad	Ulyanovsk	Russia
17537	Desnogorsk	Smolensk	Russia
17538	Derbent	Dagestan	Russia
17539	Zapadnoye Degunino	Moscow	Russia
17540	Dedovsk	MO	Russia
17541	Davydkovo	Moscow	Russia
17542	Davlekanovo	Bashkortostan	Russia
17543	Dankov	Lipetsk	Russia
17544	Danilov	Jaroslavl	Russia
17545	Dagestanskiye Ogni	Dagestan	Russia
17546	Dachnoye	St.-Petersburg	Russia
17547	Chusovoy	Perm	Russia
17548	Chudovo	Novgorod	Russia
17550	Chishmy	Bashkortostan	Russia
17551	Chernyanka	Belgorod	Russia
17552	Chernyakhovsk	Kaliningrad	Russia
17553	Chernushka	Perm	Russia
17554	Chernogolovka	MO	Russia
17555	Cherkessk	Karachayevo-Cherkesiya	Russia
17556	Cherepovets	Vologda	Russia
17558	Chekhov	MO	Russia
17559	Chegem	Kabardino-Balkariya	Russia
17560	Cheboksary	Chuvashia	Russia
17561	Chaykovskiy	Perm	Russia
17562	Chapayevsk	Samara	Russia
17563	Buzuluk	Orenburg	Russia
17564	Buynaksk	Dagestan	Russia
17565	Buy	Kostroma	Russia
17566	Buturlinovka	Voronezj	Russia
17567	Businovo	Moscow	Russia
17568	Buinsk	Tatarstan	Russia
17569	Buguruslan	Orenburg	Russia
17572	Bryukhovetskaya	Krasnodarskiy	Russia
17573	Bryansk	Brjansk	Russia
17574	Bronnitsy	MO	Russia
17575	Brateyevo	Moscow	Russia
17576	Borovichi	Novgorod	Russia
17577	Borisoglebsk	Voronezj	Russia
17578	Bor	Nizjnij Novgorod	Russia
17580	Bologoye	Tverskaya	Russia
17581	Boksitogorsk	Leningrad	Russia
17582	Boguchar	Voronezj	Russia
17583	Bogorodskoye	MO	Russia
17584	Bogorodsk	Nizjnij Novgorod	Russia
17585	Bogoroditsk	Tula	Russia
17586	Bobrov	Voronezj	Russia
17587	Blagoveshchensk	Bashkortostan	Russia
17588	Blagodarnyy	Stavropolskiy	Russia
17590	Birsk	Bashkortostan	Russia
17591	Bibirevo	Moscow	Russia
17592	Bezhetsk	Tverskaya	Russia
17593	Bezenchuk	Samara	Russia
17594	Beslan	North Ossetia	Russia
17595	Berezniki	Perm	Russia
17596	Beloretsk	Bashkortostan	Russia
17597	Belorechensk	Krasnodarskiy	Russia
17599	Belgorod	Belgorod	Russia
17601	Belebey	Bashkortostan	Russia
17602	Belaya Kalitva	Rostov	Russia
17603	Belaya Glina	Krasnodarskiy	Russia
17604	Baymak	Bashkortostan	Russia
17605	Bavly	Tatarstan	Russia
17606	Bataysk	Rostov	Russia
17607	Barysh	Ulyanovsk	Russia
17608	Balezino	Udmurtiya	Russia
17609	Balashov	Saratov	Russia
17610	Balashikha	MO	Russia
17611	Balakovo	Saratov	Russia
17612	Novaya Balakhna	Nizjnij Novgorod	Russia
17613	Balabanovo	Kaluga	Russia
17614	Baksan	Kabardino-Balkariya	Russia
17615	Bakal	Chelyabinsk	Russia
17616	Bagayevskaya	Rostov	Russia
17617	Babushkin	Moscow	Russia
17618	Azov	Rostov	Russia
17619	Avtury	Chechnya	Russia
17620	Avtovo	St.-Petersburg	Russia
17621	Atkarsk	Saratov	Russia
17622	Astrakhan	Astrakhan	Russia
17623	Asha	Chelyabinsk	Russia
17624	Arzgir	Stavropolskiy	Russia
17625	Arzamas	Nizjnij Novgorod	Russia
17626	Arsk	Tatarstan	Russia
17627	Armavir	Krasnodarskiy	Russia
17629	Argun	Chechnya	Russia
17630	Ardon	North Ossetia	Russia
17631	Apsheronsk	Krasnodarskiy	Russia
17632	Aprelevka	MO	Russia
17633	Apatity	Murmansk	Russia
17634	Anna	Voronezj	Russia
17635	Andreyevskoye	MO	Russia
17636	Anapa	Krasnodarskiy	Russia
17639	Aleksin	Tula	Russia
17640	Alekseyevka	MO	Russia
17641	Alekseyevka	Belgorod	Russia
17642	Aleksandrovskoye	Stavropolskiy	Russia
17643	Aleksandrovsk	Perm	Russia
17644	Aleksandrov	Vladimir	Russia
17646	Levoberezhnyy	MO	Russia
17647	Aksay	Rostov	Russia
17648	Akhtyrskiy	Krasnodarskiy	Russia
17649	Akhtubinsk	Astrakhan	Russia
17650	Agryz	Tatarstan	Russia
17651	Afipskiy	Krasnodarskiy	Russia
17652	Adler	Krasnodarskiy	Russia
17653	Achkhoy-Martan	Chechnya	Russia
17654	Abinsk	Krasnodarskiy	Russia
17655	Abdulino	Orenburg	Russia
17658	Neftekumsk	Stavropolskiy	Russia
17659	Alagir	North Ossetia	Russia
17660	Persianovka	Rostov	Russia
17661	Annino	MO	Russia
17662	Dagomys	Krasnodarskiy	Russia
17663	Pavlovo	Nizjnij Novgorod	Russia
17664	Belidzhi	Dagestan	Russia
17665	Lesnoy	Sverdlovsk	Russia
17667	Mirnyy	Arkhangelskaya	Russia
17668	Znamensk	Astrakhan	Russia
17669	Zarechnyy	Penza	Russia
17670	Kochubeyevskoye	Stavropolskiy	Russia
17671	Vnukovo	MO	Russia
17672	Moskovskiy	Moscow	Russia
17673	Usinsk	Komi Republic	Russia
17674	Obukhovo	St.-Petersburg	Russia
17675	Staryy Malgobek	Ingushetiya	Russia
17676	Zavodoukovsk	Tjumen	Russia
17677	Zarinsk	Altai Krai	Russia
17678	Zarechnyy	Sverdlovsk	Russia
17679	Yuzhnyy	Altai Krai	Russia
17681	Yurga	Kemerovo	Russia
17682	Yeniseysk	Krasnoyarskiy	Russia
17683	Yemanzhelinsk	Chelyabinsk	Russia
17684	Yekaterinburg	Sverdlovsk	Russia
17685	Yashkino	Kemerovo	Russia
17686	Yarovoye	Altai Krai	Russia
17687	Yalutorovsk	Tjumen	Russia
17688	Vorkuta	Komi Republic	Russia
17689	Vorgashor	Komi Republic	Russia
17690	Verkhnyaya Salda	Sverdlovsk	Russia
17691	Verkhnyaya Pyshma	Sverdlovsk	Russia
17692	Verkhniy Ufaley	Chelyabinsk	Russia
17693	Uzhur	Krasnoyarskiy	Russia
17694	Zelenogorsk	Krasnoyarskiy	Russia
17695	Uray	Khanty-Mansiyskiy Avtonomnyy Okrug	Russia
17696	Tyumen	Tjumen	Russia
17697	Turinsk	Sverdlovsk	Russia
17698	Troitsk	Chelyabinsk	Russia
17699	Topki	Kemerovo	Russia
17700	Tomsk	Tomsk	Russia
17701	Toguchin	Novosibirsk	Russia
17703	Tayshet	Irkutsk	Russia
17704	Tayga	Kemerovo	Russia
17705	Tavda	Sverdlovsk	Russia
17706	Tatarsk	Novosibirsk	Russia
17707	Tashtagol	Kemerovo	Russia
17708	Tarko-Sale	Yamalo-Nenetskiy Avtonomnyy Okrug	Russia
17709	Tara	Omsk	Russia
17710	Talnakh	Krasnoyarskiy	Russia
17712	Talitsa	Sverdlovsk	Russia
17713	Talitsa	Sverdlovsk	Russia
17715	Suzun	Novosibirsk	Russia
17716	Surgut	Khanty-Mansiyskiy Avtonomnyy Okrug	Russia
17717	Sukhoy Log	Sverdlovsk	Russia
17718	Strezhevoy	Tomsk	Russia
17719	Sredneuralsk	Sverdlovsk	Russia
17720	Sovetskiy	Khanty-Mansiyskiy Avtonomnyy Okrug	Russia
17721	Sosnovoborsk	Krasnoyarskiy	Russia
17722	Slavgorod	Altai Krai	Russia
17723	Shushenskoye	Krasnoyarskiy	Russia
17724	Shumikha	Kurgan	Russia
17725	Sharypovo	Krasnoyarskiy	Russia
17726	Shadrinsk	Kurgan	Russia
17727	Serov	Sverdlovsk	Russia
17728	Sayanogorsk	Khakasiya	Russia
17729	Salekhard	Yamalo-Nenetskiy Avtonomnyy Okrug	Russia
17730	Rubtsovsk	Altai Krai	Russia
17731	Rezh	Sverdlovsk	Russia
17732	Reftinskiy	Sverdlovsk	Russia
17733	Promyshlennaya	Kemerovo	Russia
17735	Poykovskiy	Khanty-Mansiyskiy Avtonomnyy Okrug	Russia
17736	Polysayevo	Kemerovo	Russia
17737	Polevskoy	Sverdlovsk	Russia
17738	Plast	Chelyabinsk	Russia
17739	Osinniki	Kemerovo	Russia
17740	Omsk	Omsk	Russia
17742	Nyagan	Khanty-Mansiyskiy Avtonomnyy Okrug	Russia
17743	Noyabrsk	Yamalo-Nenetskiy Avtonomnyy Okrug	Russia
17744	Novyy Urengoy	Yamalo-Nenetskiy Avtonomnyy Okrug	Russia
17745	Novosilikatnyy	Altai Krai	Russia
17746	Novosibirsk	Novosibirsk	Russia
17747	Novokuznetsk	Kemerovo	Russia
17748	Novoaltaysk	Altai Krai	Russia
17749	Norilsk	Krasnoyarskiy	Russia
17750	Nizhnyaya Salda	Sverdlovsk	Russia
17751	Nizhnevartovsk	Khanty-Mansiyskiy Avtonomnyy Okrug	Russia
17752	Nizhneudinsk	Irkutsk	Russia
17754	Nefteyugansk	Khanty-Mansiyskiy Avtonomnyy Okrug	Russia
17755	Nazarovo	Krasnoyarskiy	Russia
17756	Nadym	Yamalo-Nenetskiy Avtonomnyy Okrug	Russia
17757	Myski	Kemerovo	Russia
17758	Minusinsk	Krasnoyarskiy	Russia
17759	Miass	Chelyabinsk	Russia
17760	Mezhdurechensk	Kemerovo	Russia
17761	Megion	Khanty-Mansiyskiy Avtonomnyy Okrug	Russia
17762	Mayma	Altai Republic	Russia
17763	Mariinsk	Kemerovo	Russia
17765	Lesosibirsk	Krasnoyarskiy	Russia
17766	Leninsk-Kuznetsky	Kemerovo	Russia
17767	Labytnangi	Yamalo-Nenetskiy Avtonomnyy Okrug	Russia
17768	Kyzyl	Tyva	Russia
17769	Kyshtym	Chelyabinsk	Russia
17770	Kuybyshev	Novosibirsk	Russia
17771	Kurtamysh	Kurgan	Russia
17772	Kurgan	Kurgan	Russia
17773	Kupino	Novosibirsk	Russia
17774	Kulunda	Altai Krai	Russia
17775	Krasnoyarsk	Krasnoyarskiy	Russia
17778	Krasnoobsk	Novosibirsk	Russia
17779	Korkino	Chelyabinsk	Russia
17780	Kopeysk	Chelyabinsk	Russia
17781	Yugorsk	Khanty-Mansiyskiy Avtonomnyy Okrug	Russia
17782	Kolpashevo	Tomsk	Russia
17783	Kodinsk	Krasnoyarskiy	Russia
17786	Kirovgrad	Sverdlovsk	Russia
17787	Khanty-Mansiysk	Khanty-Mansiyskiy Avtonomnyy Okrug	Russia
17788	Kemerovo	Kemerovo	Russia
17789	Kedrovka	Kemerovo	Russia
17790	Kayyerkan	Krasnoyarskiy	Russia
17791	Kataysk	Kurgan	Russia
17792	Kasli	Chelyabinsk	Russia
17793	Kartaly	Chelyabinsk	Russia
17794	Karpinsk	Sverdlovsk	Russia
17795	Karasuk	Novosibirsk	Russia
17796	Karabash	Chelyabinsk	Russia
17797	Kansk	Krasnoyarskiy	Russia
17798	Kamyshlov	Sverdlovsk	Russia
17801	Kaltan	Kemerovo	Russia
17802	Kalachinsk	Omsk	Russia
17804	Iskitim	Novosibirsk	Russia
17805	Ishim	Tjumen	Russia
17806	Irbit	Sverdlovsk	Russia
17807	Ilanskiy	Krasnoyarskiy	Russia
17809	Gornyak	Altai Krai	Russia
17810	Gorno-Altaysk	Altai Republic	Russia
17811	Dudinka	Krasnoyarskiy	Russia
17812	Divnogorsk	Krasnoyarskiy	Russia
17813	Degtyarsk	Sverdlovsk	Russia
17814	Chunskiy	Irkutsk	Russia
17815	Chernogorsk	Khakasiya	Russia
17816	Cherepanovo	Novosibirsk	Russia
17817	Chelyabinsk	Chelyabinsk	Russia
17819	Borovskiy	Tjumen	Russia
17820	Borodino	Krasnoyarskiy	Russia
17821	Bolotnoye	Novosibirsk	Russia
17822	Bogotol	Krasnoyarskiy	Russia
17823	Bogdanovich	Sverdlovsk	Russia
17824	Biysk	Altai Krai	Russia
17825	Beryozovsky	Sverdlovsk	Russia
17828	Berdsk	Novosibirsk	Russia
17829	Beloyarskiy	Khanty-Mansiyskiy Avtonomnyy Okrug	Russia
17830	Belovo	Kemerovo	Russia
17831	Barnaul	Altai Krai	Russia
17832	Barabinsk	Novosibirsk	Russia
17833	Asino	Tomsk	Russia
17834	Asbest	Sverdlovsk	Russia
17836	Aramil	Sverdlovsk	Russia
17837	Anzhero-Sudzhensk	Kemerovo	Russia
17838	Aleysk	Altai Krai	Russia
17839	Alapayevsk	Sverdlovsk	Russia
17840	Akademgorodok	Novosibirsk	Russia
17841	Achinsk	Krasnoyarskiy	Russia
17842	Abaza	Khakasiya	Russia
17843	Abakan	Khakasiya	Russia
17844	Snezhinsk	Chelyabinsk	Russia
17845	Ozersk	Chelyabinsk	Russia
17846	Zheleznogorsk	Krasnoyarskiy	Russia
17848	Seversk	Tomsk	Russia
17849	Gubkinskiy	Yamalo-Nenetskiy Avtonomnyy Okrug	Russia
17850	Raduzhny	Khanty-Mansiyskiy Avtonomnyy Okrug	Russia
17851	Muravlenko	Yamalo-Nenetskiy Avtonomnyy Okrug	Russia
17852	Lyantor	Khanty-Mansiyskiy Avtonomnyy Okrug	Russia
17853	Zima	Irkutsk	Russia
17854	Zheleznogorsk-Ilimskiy	Irkutsk	Russia
17855	Zeya	Amur	Russia
17856	Yakutsk	Sakha	Russia
17857	Vyazemskiy	Khabarovsk Krai	Russia
17859	Vladivostok	Primorskiy	Russia
17860	Vikhorevka	Irkutsk	Russia
17863	Ussuriysk	Primorskiy	Russia
17865	Ulan-Ude	Respublika Buryatiya	Russia
17866	Udachny	Sakha	Russia
17867	Tynda	Amur	Russia
17868	Tulun	Irkutsk	Russia
17869	Trudovoye	Primorskiy	Russia
17870	Fokino	Primorskiy	Russia
17871	Svobodnyy	Amur	Russia
17873	Slyudyanka	Irkutsk	Russia
17874	Shimanovsk	Amur	Russia
17875	Shelekhov	Irkutsk	Russia
17877	Raychikhinsk	Amur	Russia
17879	Partizansk	Primorskiy	Russia
17880	Neryungri	Sakha	Russia
17881	Nerchinsk	Transbaikal Territory	Russia
17882	Nakhodka	Primorskiy	Russia
17883	Mirny	Sakha	Russia
17884	Luchegorsk	Primorskiy	Russia
17885	Lesozavodsk	Primorskiy	Russia
17886	Lensk	Sakha	Russia
17887	Kyakhta	Respublika Buryatiya	Russia
17888	Krasnokamensk	Transbaikal Territory	Russia
17889	Komsomolsk-on-Amur	Khabarovsk Krai	Russia
17890	Khabarovsk	Khabarovsk Krai	Russia
17891	Kavalerovo	Primorskiy	Russia
17892	Irkutsk	Irkutsk	Russia
17893	Gusinoozyorsk	Respublika Buryatiya	Russia
17895	Chita	Transbaikal Territory	Russia
17896	Cheremkhovo	Irkutsk	Russia
17897	Borzya	Transbaikal Territory	Russia
17899	Bodaybo	Irkutsk	Russia
17900	Blagoveshchensk	Amur	Russia
17901	Birobidzhan	Jewish Autonomous Oblast	Russia
17902	Bikin	Khabarovsk Krai	Russia
17903	Belogorsk	Amur	Russia
17905	Aykhal	Sakha	Russia
17908	Angarsk	Irkutsk	Russia
17909	Amursk	Khabarovsk Krai	Russia
17910	Aldan	Sakha	Russia
17911	Dalnegorsk	Primorskiy	Russia
17912	Bratsk	Irkutsk	Russia
17913	Sayansk	Irkutsk	Russia
17914	Khabarovsk Vtoroy	Khabarovsk Krai	Russia
17915	Markova	Irkutsk	Russia
17916	Vilyuchinsk	Kamtsjatka	Russia
17917	Yuzhno-Sakhalinsk	Sakhalin	Russia
17918	Yelizovo	Kamtsjatka	Russia
17919	Vanino	Khabarovsk Krai	Russia
17921	Poronaysk	Sakhalin	Russia
17922	Petropavlovsk-Kamchatsky	Kamtsjatka	Russia
17923	Okha	Sakhalin	Russia
17924	Nikolayevsk-on-Amure	Khabarovsk Krai	Russia
17926	Magadan	Magadan	Russia
17927	Korsakov	Sakhalin	Russia
17928	Kholmsk	Sakhalin	Russia
17929	Baltiysk	Kaliningrad	Russia
17930	Isakogorka	Arkhangelskaya	Russia
17931	Krasnoznamensk	MO	Russia
17932	Chertanovo Yuzhnoye	Moscow	Russia
17934	Orekhovo-Borisovo	Moscow	Russia
17935	Metrogorodok	Moscow	Russia
17936	Kogalym	Khanty-Mansiyskiy Avtonomnyy Okrug	Russia
17937	Pyt-Yakh	Khanty-Mansiyskiy Avtonomnyy Okrug	Russia
17938	Langepas	Khanty-Mansiyskiy Avtonomnyy Okrug	Russia
17939	Lesnoy	Sverdlovsk	Russia
17940	Zarya	MO	Russia
17941	Raduzhnyy	Vladimir	Russia
17942	Nizhnesortymskiy	Khanty-Mansiyskiy Avtonomnyy Okrug	Russia
17943	Pokachi	Khanty-Mansiyskiy Avtonomnyy Okrug	Russia
17944	Izluchinsk	Khanty-Mansiyskiy Avtonomnyy Okrug	Russia
17945	Kurortnyy	Leningrad	Russia
17946	Chernaya Rechka	Leningrad	Russia
17947	Untolovo	Leningrad	Russia
17948	Petrogradka	St.-Petersburg	Russia
17949	Vasylevsky Ostrov	St.-Petersburg	Russia
17950	Parnas	Leningrad	Russia
17951	Kalininskiy	Leningrad	Russia
17952	Krasnogvargeisky	St.-Petersburg	Russia
17953	Admiralteisky	St.-Petersburg	Russia
17954	Krestovskiy ostrov	Leningrad	Russia
17955	Akademicheskoe	Leningrad	Russia
17956	Finlyandskiy	Leningrad	Russia
17957	Centralniy	St.-Petersburg	Russia
17958	Svetlanovskiy	Leningrad	Russia
17959	Sampsonievskiy	Leningrad	Russia
17960	Vostochnoe Degunino	MO	Russia
17961	Rwamagana	Eastern Province	Rwanda
17962	Musanze	Northern Province	Rwanda
17963	Nzega	Southern Province	Rwanda
17964	Kigali	Kigali	Rwanda
17965	Kibuye	Western Province	Rwanda
17966	Kibungo	Eastern Province	Rwanda
17967	Gitarama	Southern Province	Rwanda
17968	Cyangugu	Western Province	Rwanda
17969	Gisenyi	Western Province	Rwanda
17970	Byumba	Northern Province	Rwanda
17971	Butare	Southern Province	Rwanda
17972	Yanbu	Al Madinah al Munawwarah	Saudi Arabia
17973	Umm Lajj	Mintaqat Tabuk	Saudi Arabia
17974	Turayf	Northern Borders	Saudi Arabia
17975	Turabah	Makkah	Saudi Arabia
17976	Tarut	Eastern Province	Saudi Arabia
17977	Tabuk	Mintaqat Tabuk	Saudi Arabia
17978	Tubarjal	Al Jawf	Saudi Arabia
17979	Sultanah	Al Madinah al Munawwarah	Saudi Arabia
17980	Sayhat	Eastern Province	Saudi Arabia
17981	Samitah	Jizan	Saudi Arabia
17982	Sakakah	Al Jawf	Saudi Arabia
17984	Sabya	Jizan	Saudi Arabia
17985	Ra?imah	Eastern Province	Saudi Arabia
17986	Rabigh	Makkah	Saudi Arabia
17988	Najran	Najran	Saudi Arabia
17989	Mecca	Makkah	Saudi Arabia
17991	Jizan	Jizan	Saudi Arabia
17992	Jeddah	Makkah	Saudi Arabia
17993	Hail	?ail	Saudi Arabia
17994	Duba	Mintaqat Tabuk	Saudi Arabia
17995	Buraydah	Al-Qassim	Saudi Arabia
17996	Abqaiq	Eastern Province	Saudi Arabia
17997	Badr ?unayn	Al Madinah al Munawwarah	Saudi Arabia
17998	Az Zulfi	Ar Riya?	Saudi Arabia
17999	Dhahran	Eastern Province	Saudi Arabia
18000	At Taraf	Eastern Province	Saudi Arabia
18002	As Sulayyil	Ar Riya?	Saudi Arabia
18003	Riyadh	Ar Riya?	Saudi Arabia
18004	Ar Rass	Al-Qassim	Saudi Arabia
18007	Qurayyat	Al Jawf	Saudi Arabia
18008	Al Wajh	Mintaqat Tabuk	Saudi Arabia
18010	Al Qaysumah	Eastern Province	Saudi Arabia
18011	Al Qatif	Eastern Province	Saudi Arabia
18012	Al Munayzilah	Eastern Province	Saudi Arabia
18013	Al Mubarraz	Eastern Province	Saudi Arabia
18014	Al Mithnab	Al-Qassim	Saudi Arabia
18015	Medina	Al Madinah al Munawwarah	Saudi Arabia
18016	Khobar	Eastern Province	Saudi Arabia
18017	Al Khafji	Eastern Province	Saudi Arabia
18018	Al Jumum	Makkah	Saudi Arabia
18019	Al Jubayl	Eastern Province	Saudi Arabia
18020	Al Hufuf	Eastern Province	Saudi Arabia
18021	Al Bukayriyah	Al-Qassim	Saudi Arabia
18022	Al Battaliyah	Eastern Province	Saudi Arabia
18023	Al Ba?ah	Mintaqat al Ba?ah	Saudi Arabia
18025	Ad Dilam	Ar Riya?	Saudi Arabia
18026	Ad Dawadimi	Ar Riya?	Saudi Arabia
18027	Dammam	Eastern Province	Saudi Arabia
18030	Ash Shafa	Makkah	Saudi Arabia
18031	Unaizah	Al-Qassim	Saudi Arabia
18032	Honiara	Guadalcanal	Solomon Islands
18033	Victoria	English River	Seychelles
18034	Zalingei	Central Darfur	Sudan
18035	Wad Medani	Al Jazirah	Sudan
18036	Umm Ruwaba	Shamal Kurdufan	Sudan
18037	Omdurman	Khartoum	Sudan
18038	Tokar	Red Sea	Sudan
18039	Tandalti	White Nile	Sudan
18040	Singa	Sinnar	Sudan
18041	Shendi	River Nile	Sudan
18042	Sawakin	Red Sea	Sudan
18043	Sinnar	Sinnar	Sudan
18044	Rabak	White Nile	Sudan
18045	Maiurno	Sinnar	Sudan
18046	Kosti	White Nile	Sudan
18047	Kuraymah	Northern State	Sudan
18048	Kinana	Sinnar	Sudan
18049	Kassala	Kassala	Sudan
18050	Kadugli	Southern Kordofan	Sudan
18051	Doka	Al Qa?arif	Sudan
18052	Dilling	Southern Kordofan	Sudan
18053	Port Sudan	Red Sea	Sudan
18054	Berber	River Nile	Sudan
18055	Barah	Shamal Kurdufan	Sudan
18056	Atbara	River Nile	Sudan
18057	As Suki	Sinnar	Sudan
18058	Ar Ruseris	Blue Nile	Sudan
18059	Ar Rahad	Shamal Kurdufan	Sudan
18060	An Nuhud	West Kordofan State	Sudan
18061	El Obeid	Shamal Kurdufan	Sudan
18062	Al Qitena	White Nile	Sudan
18063	Al Qadarif	Al Qa?arif	Sudan
18064	Al Mijlad	West Kordofan State	Sudan
18065	Al Manaqil	Al Jazirah	Sudan
18066	Khartoum	Khartoum	Sudan
18067	Geneina	Western Darfur	Sudan
18068	Al Hilaliyya	Al Jazirah	Sudan
18069	Al ?awatah	Al Qa?arif	Sudan
18070	Al Hasaheisa	Al Jazirah	Sudan
18071	El Fasher	Northern Darfur	Sudan
18072	El Bauga	River Nile	Sudan
18073	Ad Douiem	White Nile	Sudan
18074	El Daein	Eastern Darfur	Sudan
18075	Ad Dindar	Sinnar	Sudan
18076	Ed Damer	River Nile	Sudan
18077	Ad-Damazin	Blue Nile	Sudan
18078	Abu Zabad	West Kordofan State	Sudan
18079	Abu Jibeha	Southern Kordofan	Sudan
18084	Kiruna	Norrbotten	Sweden
18085	Boden	Norrbotten	Sweden
18087	Visby	Gotland	Sweden
18092	Varberg	Halland	Sweden
18094	Vallentuna	Stockholm	Sweden
18095	Uppsala	Uppsala	Sweden
18098	Tumba	Stockholm	Sweden
18099	Tullinge	Stockholm	Sweden
18104	Sundbyberg	Stockholm	Sweden
18105	Stockholm	Stockholm	Sweden
18106	Solna	Stockholm	Sweden
18107	Sollentuna	Stockholm	Sweden
18116	Oskarshamn	Kalmar	Sweden
18123	Nacka	Stockholm	Sweden
18134	Kungsbacka	Halland	Sweden
18141	Karlskrona	Blekinge	Sweden
18143	Karlshamn	Blekinge	Sweden
18144	Kalmar	Kalmar	Sweden
18146	Jakobsberg	Stockholm	Sweden
18148	Huddinge	Stockholm	Sweden
18152	Haninge	Stockholm	Sweden
18153	Halmstad	Halland	Sweden
18156	Gamla Uppsala	Uppsala	Sweden
18157	Falun	Dalarna	Sweden
18159	Falkenberg	Halland	Sweden
18163	Bromma	Stockholm	Sweden
18166	Boo	Stockholm	Sweden
18172	Singapore	Central Singapore	Singapore
18173	Jamestown	Saint Helena	Saint Helena
18174	Trbovlje	Trbovlje	Slovenia
18175	Velenje	Velenje	Slovenia
18176	Ptuj	Ptuj	Slovenia
18177	Novo Mesto	Novo Mesto	Slovenia
18178	Maribor	Maribor	Slovenia
18179	Ljubljana	Ljubljana	Slovenia
18180	Kranj	Kranj	Slovenia
18181	Koper	Koper-Capodistria	Slovenia
18182	Celje	Celje	Slovenia
18183	Longyearbyen	Svalbard	Svalbard and Jan Mayen
18206	Sellye	Nitriansky	Slovakia
18209	Prievidza	Nitriansky	Slovakia
18216	Nitra	Nitriansky	Slovakia
18221	Levice	Nitriansky	Slovakia
18236	Waterloo	Western Area	Sierra Leone
18237	Segbwema	Eastern Province	Sierra Leone
18238	Port Loko	Northern Province	Sierra Leone
18239	Makeni	Northern Province	Sierra Leone
18240	Lunsar	Northern Province	Sierra Leone
18241	Koidu	Eastern Province	Sierra Leone
18242	Kenema	Eastern Province	Sierra Leone
18243	Kabala	Northern Province	Sierra Leone
18244	Freetown	Western Area	Sierra Leone
18245	Bo	Southern Province	Sierra Leone
18246	San Marino	San Marino	San Marino
18247	Ziguinchor	Ziguinchor	Senegal
18249	Touba	Diourbel	Senegal
18252	Tambacounda	Tambacounda	Senegal
18254	Saint-Louis	Saint-Louis	Senegal
18255	Richard-Toll	Saint-Louis	Senegal
18257	Pourham	Fatick	Senegal
18258	Pikine	Dakar	Senegal
18259	Nioro du Rip	Kaolack	Senegal
18264	Matam	Matam	Senegal
18265	Louga	Louga	Senegal
18266	Kolda	Kolda	Senegal
18269	Kaolack	Kaolack	Senegal
18270	Kaffrine	Kaffrine	Senegal
18273	Dara	Louga	Senegal
18274	Dakar	Dakar	Senegal
18275	Bignona	Ziguinchor	Senegal
18276	Wanlaweyn	Lower Shabeelle	Somalia
18277	Qoryooley	Lower Shabeelle	Somalia
18278	Qandala	Bari	Somalia
18279	Mogadishu	Banaadir	Somalia
18280	Marka	Lower Shabeelle	Somalia
18281	Luuq	Gedo	Somalia
18282	Kismayo	Lower Juba	Somalia
18283	Jilib	Middle Juba	Somalia
18284	Jawhar	Middle Shabele	Somalia
18285	Jamaame	Lower Juba	Somalia
18286	Hargeysa	Woqooyi Galbeed	Somalia
18287	Garoowe	Nugaal	Somalia
18288	Gaalkacyo	Mudug	Somalia
18289	Eyl	Nugaal	Somalia
18290	Ceerigaabo	Sanaag	Somalia
18291	Ceeldheer	Galguduud	Somalia
18292	Buurhakaba	Bay	Somalia
18293	Buulobarde	Hiiraan	Somalia
18294	Burao	Togdheer	Somalia
18295	Bosaso	Bari	Somalia
18296	Berbera	Woqooyi Galbeed	Somalia
18297	Beledweyne	Hiiraan	Somalia
18298	Baidoa	Bay	Somalia
18299	Baardheere	Gedo	Somalia
18300	Afgooye	Lower Shabeelle	Somalia
18301	Laascaanood	Sool	Somalia
18302	Baki	Awdal	Somalia
18303	Paramaribo	Paramaribo	Suriname
18304	Lelydorp	Wanica	Suriname
18305	Yei	Central Equatoria	South Sudan
18306	Yambio	Western Equatoria	South Sudan
18307	Wau	Western Bahr al Ghazal	South Sudan
18308	Aweil	Northern Bahr al Ghazal	South Sudan
18309	Torit	Eastern Equatoria	South Sudan
18310	Tonj	Warrap	South Sudan
18311	Rumbek	Lakes	South Sudan
18312	Malakal	Upper Nile	South Sudan
18313	Juba	Central Equatoria	South Sudan
18314	Gogrial	Warrap	South Sudan
18315	Pajok	Eastern Equatoria	South Sudan
18316	Bor	Jonglei	South Sudan
18318	Zacatecoluca	La Paz	El Salvador
18320	Soyapango	San Salvador	El Salvador
18321	Sonzacate	Sonsonate	El Salvador
18322	Sonsonate	Sonsonate	El Salvador
18324	San Vicente	San Vicente	El Salvador
18326	Santa Ana	Santa Ana	El Salvador
18327	San Salvador	San Salvador	El Salvador
18328	San Rafael Oriente	San Miguel	El Salvador
18329	San Miguel	San Miguel	El Salvador
18331	San Marcos	San Salvador	El Salvador
18333	Quezaltepeque	La Libertad	El Salvador
18335	Santa Tecla	La Libertad	El Salvador
18337	Mejicanos	San Salvador	El Salvador
18339	La Libertad	La Libertad	El Salvador
18340	Izalco	Sonsonate	El Salvador
18341	Ilopango	San Salvador	El Salvador
18342	Delgado	San Salvador	El Salvador
18343	Cuscatancingo	San Salvador	El Salvador
18345	Chalchuapa	Santa Ana	El Salvador
18346	Chalatenango	Chalatenango	El Salvador
18347	Ayutuxtepeque	San Salvador	El Salvador
18348	Apopa	San Salvador	El Salvador
18351	Aguilares	San Salvador	El Salvador
18352	Acajutla	Sonsonate	El Salvador
18353	Philipsburg	N/A	Sint Maarten
18354	Yabrud	Rif-dimashq	Syria
18355	Tayyibat al Imam	Hama	Syria
18356	Tartouss	Tartus	Syria
18358	Tallkalakh	Homs	Syria
18359	Tallbisah	Homs	Syria
18360	Tafas	Daraa	Syria
18361	Tadmur	Homs	Syria
18362	Tadif	Aleppo	Syria
18363	Souran	Hama	Syria
18364	Subaykhan	Deir ez-Zor	Syria
18365	Ash Shaykh Miskin	Daraa	Syria
18366	Saraqib	Idlib	Syria
18367	Salqin	Idlib	Syria
18368	As Salamiyah	Hama	Syria
18369	Satita	Tartus	Syria
18370	Qatana	Rif-dimashq	Syria
18371	Jasim	Daraa	Syria
18372	Qarah	Rif-dimashq	Syria
18373	Nubl	Aleppo	Syria
18374	Masyaf	Hama	Syria
18375	Manbij	Aleppo	Syria
18377	Khan Shaykhun	Idlib	Syria
18378	Kafr Zayta	Hama	Syria
18379	Kafr Takharim	Idlib	Syria
18380	Kafr Nubl	Idlib	Syria
18381	Kafr Laha	Homs	Syria
18382	Jisr ash Shughur	Idlib	Syria
18383	Jayrud	Rif-dimashq	Syria
18384	Jarabulus	Aleppo	Syria
18385	Jablah	Latakia	Syria
18387	Inkhil	Daraa	Syria
18388	Idlib	Idlib	Syria
18389	Homs	Homs	Syria
18390	?arasta	Rif-dimashq	Syria
18391	?amah	Hama	Syria
18392	?alfaya	Hama	Syria
18393	Aleppo	Aleppo	Syria
18394	Douma	Rif-dimashq	Syria
18395	Damascus	Dimashq	Syria
18396	Dayr ?afir	Aleppo	Syria
18397	Deir ez-Zor	Deir ez-Zor	Syria
18398	Ad Darbasiyah	Al-Hasakah	Syria
18399	Darayya	Rif-dimashq	Syria
18401	Binnish	Idlib	Syria
18402	Baniyas	Tartus	Syria
18403	Az Zabadani	Rif-dimashq	Syria
18406	At Tall	Rif-dimashq	Syria
18407	Ath Thawrah	Ar-Raqqah	Syria
18409	As Sanamayn	Daraa	Syria
18410	As Safirah	Aleppo	Syria
18411	Ar Rastan	Homs	Syria
18412	Ar Raqqah	Ar-Raqqah	Syria
18413	An Nabk	Rif-dimashq	Syria
18414	Al Qutayfah	Rif-dimashq	Syria
18415	Al Qusayr	Homs	Syria
18416	Al Qunaytirah	Quneitra	Syria
18417	Al Qaryatayn	Homs	Syria
18418	Al Mayadin	Deir ez-Zor	Syria
18419	Latakia	Latakia	Syria
18420	Al Kiswah	Rif-dimashq	Syria
18421	Al ?asakah	Al-Hasakah	Syria
18422	Al ?arak	Daraa	Syria
18423	Al Bab	Aleppo	Syria
18425	Ad Dana	Idlib	Syria
18426	Albu Kamal	Deir ez-Zor	Syria
18427	Hajin	Deir ez-Zor	Syria
18428	Mbabane	Hhohho	Swaziland
18429	Manzini	Manzini	Swaziland
18430	Lobamba	Hhohho	Swaziland
18431	Cockburn Town	N/A	Turks and Caicos Islands
18432	Fada	Ennedi-Ouest	Chad
18433	Am Timan	Salamat	Chad
18435	Sagh	Moyen-Chari	Chad
18436	Pala	Mayo-Kebbi Ouest	Chad
18437	Oum Hadjer	Batha	Chad
18438	NDjamena	Chari-Baguirmi	Chad
18439	Moussoro	Barh el Gazel	Chad
18440	Moundou	Logone Occidental	Chad
18443	Massakory	Hadjer-Lamis	Chad
18444	Massaguet	Hadjer-Lamis	Chad
18445	Mao	Kanem	Chad
18448	Koumra	Mandoul	Chad
18450	Dourbali	Chari-Baguirmi	Chad
18451	Doba	Logone Oriental	Chad
18452	Bongor	Mayo-Kebbi Est	Chad
18454	Benoy	Logone Occidental	Chad
18455	Ati	Batha	Chad
18457	Vogan	Maritime	Togo
18459	Tchamba	Centrale	Togo
18460	Sotouboua	Centrale	Togo
18463	Niamtougou	Kara	Togo
18467	Kara	Kara	Togo
18468	Dapaong	Savanes	Togo
18469	Bassar	Kara	Togo
18470	Bafilo	Kara	Togo
18471	Badou	Plateaux	Togo
18474	Ban Talat Yai	Phuket	Thailand
18475	Ban Talat Nua	Phuket	Thailand
18476	Sam Roi Yot	Prachuap Khiri Khan	Thailand
18477	Phetchaburi	Phetchaburi	Thailand
18478	Trang	Trang	Thailand
18479	Thung Song	Nakhon Si Thammarat	Thailand
18480	Thoen	Lampang	Thailand
18481	Thap Than	Uthai Thani	Thailand
18482	Tha Muang	Kanchanaburi	Thailand
18483	Tha Maka	Kanchanaburi	Thailand
18484	Tak	Tak	Thailand
18485	Surat Thani	Surat Thani	Thailand
18486	Sukhothai	Sukhothai	Thailand
18487	Si Satchanalai	Sukhothai	Thailand
18488	Sawankhalok	Sukhothai	Thailand
18489	San Pa Tong	Chiang Mai	Thailand
18490	San Kamphaeng	Chiang Mai	Thailand
18491	Ron Phibun	Nakhon Si Thammarat	Thailand
18492	Ratchaburi	Ratchaburi	Thailand
18493	Ranong	Ranong	Thailand
18494	Pran Buri	Prachuap Khiri Khan	Thailand
18495	Prachuap Khiri Khan	Prachuap Khiri Khan	Thailand
18496	Phunphin	Surat Thani	Thailand
18497	Phuket	Phuket	Thailand
18498	Photharam	Ratchaburi	Thailand
18499	Phayao	Phayao	Thailand
18500	Pa Sang	Lamphun	Thailand
18501	Nakhon Si Thammarat	Nakhon Si Thammarat	Thailand
18502	Mae Sot	Tak	Thailand
18503	Mae Sai	Chiang Rai	Thailand
18504	Mae Ramat	Tak	Thailand
18505	Mae Chan	Chiang Rai	Thailand
18506	Lat Yao	Nakhon Sawan	Thailand
18507	Lang Suan	Chumphon	Thailand
18508	Lamphun	Lamphun	Thailand
18509	Lampang	Lampang	Thailand
18510	Kui Buri	Prachuap Khiri Khan	Thailand
18511	Krabi	Krabi	Thailand
18512	Khao Yoi	Phetchaburi	Thailand
18513	Khanu Woralaksaburi	Kamphaeng Phet	Thailand
18514	Kathu	Phuket	Thailand
18515	Kanchanaburi	Kanchanaburi	Thailand
18516	Kamphaeng Phet	Kamphaeng Phet	Thailand
18517	Huai Yot	Trang	Thailand
18518	Hua Hin	Prachuap Khiri Khan	Thailand
18519	Hang Dong	Chiang Mai	Thailand
18520	Dok Kham Tai	Phayao	Thailand
18521	Damnoen Saduak	Ratchaburi	Thailand
18522	Chumphon	Chumphon	Thailand
18523	Chom Bueng	Ratchaburi	Thailand
18524	Chiang Rai	Chiang Rai	Thailand
18525	Chiang Mai	Chiang Mai	Thailand
18526	Cha-am	Phetchaburi	Thailand
18527	Bo Phloi	Kanchanaburi	Thailand
18528	Ban Tak	Tak	Thailand
18529	Ko Samui	Surat Thani	Thailand
18530	Ban Pong	Ratchaburi	Thailand
18531	Ban Na San	Surat Thani	Thailand
18532	Ban Na	Sukhothai	Thailand
18533	Bang Saphan	Prachuap Khiri Khan	Thailand
18534	Bang Phae	Ratchaburi	Thailand
18535	Nong Kung Si	Kalasin	Thailand
18536	Ban Nong Wua So	Changwat Udon Thani	Thailand
18537	Ban Mai	Songkhla	Thailand
18538	Ban Huai Thalaeng	Nakhon Ratchasima	Thailand
18539	Ban Khlong Bang Sao Thong	Samut Prakan	Thailand
18540	Na Klang	Changwat Nong Bua Lamphu	Thailand
18541	Yasothon	Yasothon	Thailand
18542	Yaring	Pattani	Thailand
18543	Yala	Yala	Thailand
18544	Wiset Chaichan	Ang Thong	Thailand
18545	Wichian Buri	Phetchabun	Thailand
18546	Warin Chamrap	Changwat Ubon Ratchathani	Thailand
18547	Wang Saphung	Loei	Thailand
18548	Wang Noi	Phra Nakhon Si Ayutthaya	Thailand
18549	Wang Nam Yen	Sa Kaeo	Thailand
18550	Uttaradit	Uttaradit	Thailand
18551	Uthai Thani	Uthai Thani	Thailand
18552	Udon Thani	Changwat Udon Thani	Thailand
18553	Ubon Ratchathani	Changwat Ubon Ratchathani	Thailand
18554	Trat	Trat	Thailand
18555	Tha Yang	Phetchaburi	Thailand
18556	Tha Ruea	Phra Nakhon Si Ayutthaya	Thailand
18557	Thap Khlo	Phichit	Thailand
18558	Tha Mai	Chanthaburi	Thailand
18559	Tha Bo	Nong Khai	Thailand
18560	Taphan Hin	Phichit	Thailand
18561	Tak Bai	Narathiwat	Thailand
18562	Surin	Surin	Thailand
18563	Suphan Buri	Suphan Buri	Thailand
18564	Su-ngai Kolok	Narathiwat	Thailand
18565	Songkhla	Songkhla	Thailand
18566	Si Sa Ket	Sisaket	Thailand
18567	Si Racha	Chon Buri	Thailand
18568	Sing Buri	Sing Buri	Thailand
18569	Seka	Changwat Bueng Kan	Thailand
18570	Sawang Daen Din	Sakon Nakhon	Thailand
18571	Satun	Satun	Thailand
18572	Sattahip	Chon Buri	Thailand
18573	Saraburi	Sara Buri	Thailand
18574	Samut Songkhram	Samut Songkhram	Thailand
18575	Samut Sakhon	Samut Sakhon	Thailand
18576	Samut Prakan	Samut Prakan	Thailand
18577	Sam Phran	Nakhon Pathom	Thailand
18578	Sakon Nakhon	Sakon Nakhon	Thailand
18579	Sa Kaeo	Sa Kaeo	Thailand
18580	Sadao	Songkhla	Thailand
18581	Roi Et	Roi Et	Thailand
18582	Rayong	Rayong	Thailand
18583	Ranot	Songkhla	Thailand
18584	Ra-ngae	Narathiwat	Thailand
18585	Prakhon Chai	Buriram	Thailand
18586	Prachin Buri	Prachin Buri	Thailand
18587	Phu Kradueng	Loei	Thailand
18588	Phu Khiao	Chaiyaphum	Thailand
18589	Phra Pradaeng	Samut Prakan	Thailand
18590	Phra Phutthabat	Sara Buri	Thailand
18591	Phra Nakhon Si Ayutthaya	Phra Nakhon Si Ayutthaya	Thailand
18592	Phrae	Phrae	Thailand
18593	Phon Charoen	Nong Khai	Thailand
18594	Phitsanulok	Phitsanulok	Thailand
18595	Phichit	Phichit	Thailand
18596	Phibun Mangsahan	Changwat Ubon Ratchathani	Thailand
18597	Phetchabun	Phetchabun	Thailand
18598	Phatthalung	Phatthalung	Thailand
18599	Phan Thong	Chon Buri	Thailand
18600	Phanom Sarakham	Chachoengsao	Thailand
18601	Phanat Nikhom	Chon Buri	Thailand
18602	Phak Hai	Phra Nakhon Si Ayutthaya	Thailand
18603	Pattani	Pattani	Thailand
18604	Pathum Thani	Pathum Thani	Thailand
18605	Pak Phanang	Nakhon Si Thammarat	Thailand
18606	Pak Kret	Nonthaburi	Thailand
18607	Pak Chong	Nakhon Ratchasima	Thailand
18608	Mueang Nonthaburi	Nonthaburi	Thailand
18609	Non Sung	Nakhon Ratchasima	Thailand
18610	Nong Phai	Phetchabun	Thailand
18611	Nong Khai	Nong Khai	Thailand
18612	Nong Khae	Sara Buri	Thailand
18613	Nong Bua Lamphu	Changwat Nong Bua Lamphu	Thailand
18614	Narathiwat	Narathiwat	Thailand
18615	Nang Rong	Buriram	Thailand
18616	Nan	Nan	Thailand
18617	Nam Som	Changwat Udon Thani	Thailand
18618	Nakhon Sawan	Nakhon Sawan	Thailand
18619	Nakhon Ratchasima	Nakhon Ratchasima	Thailand
18620	Nakhon Phanom	Nakhon Phanom	Thailand
18621	Nakhon Pathom	Nakhon Pathom	Thailand
18622	Nakhon Nayok	Nakhon Nayok	Thailand
18623	Nakhon Luang	Phra Nakhon Si Ayutthaya	Thailand
18624	Mukdahan	Mukdahan	Thailand
18625	Maha Sarakham	Maha Sarakham	Thailand
18626	Lop Buri	Lop Buri	Thailand
18627	Lom Sak	Phetchabun	Thailand
18628	Loei	Loei	Thailand
18629	Laem Sing	Chanthaburi	Thailand
18630	Kut Chap	Changwat Udon Thani	Thailand
18631	Kuchinarai	Kalasin	Thailand
18632	Bangkok	Bangkok	Thailand
18633	Krathum Baen	Samut Sakhon	Thailand
18634	Klaeng	Rayong	Thailand
18635	Khon Kaen	Khon Kaen	Thailand
18636	Khon Buri	Nakhon Ratchasima	Thailand
18637	Khlong Luang	Pathum Thani	Thailand
18638	Khao Wong	Kalasin	Thailand
18639	Kaset Wisai	Roi Et	Thailand
18640	Kaset Sombun	Chaiyaphum	Thailand
18641	Kantharalak	Sisaket	Thailand
18642	Kamalasai	Kalasin	Thailand
18643	Kalasin	Kalasin	Thailand
18644	Kaeng Khoi	Sara Buri	Thailand
18645	Kaeng Khro	Chaiyaphum	Thailand
18646	Kabin Buri	Prachin Buri	Thailand
18647	Hat Yai	Songkhla	Thailand
18648	Det Udom	Changwat Ubon Ratchathani	Thailand
18649	Den Chai	Phrae	Thailand
18650	Dan Khun Thot	Nakhon Ratchasima	Thailand
18651	Chum Phae	Khon Kaen	Thailand
18652	Chon Daen	Phetchabun	Thailand
18653	Chon Buri	Chon Buri	Thailand
18654	Chok Chai	Nakhon Ratchasima	Thailand
18655	Chanthaburi	Chanthaburi	Thailand
18656	Chaiyaphum	Chaiyaphum	Thailand
18657	Chai Nat	Chai Nat	Thailand
18658	Chai Badan	Lop Buri	Thailand
18659	Chachoengsao	Chachoengsao	Thailand
18660	Buriram	Buriram	Thailand
18661	Bua Yai	Nakhon Ratchasima	Thailand
18662	Betong	Yala	Thailand
18663	Ban Selaphum	Roi Et	Thailand
18664	Ban Rangsit	Pathum Thani	Thailand
18665	Phatthaya	Chon Buri	Thailand
18666	Ban Phan Don	Changwat Udon Thani	Thailand
18667	Ban Phai	Khon Kaen	Thailand
18668	Ban Phaeo	Samut Sakhon	Thailand
18669	Ban Mo	Sara Buri	Thailand
18670	Ban Lam Luk Ka	Pathum Thani	Thailand
18671	Bang Rakam	Phitsanulok	Thailand
18672	Bang Racham	Sing Buri	Thailand
18673	Bang Pakong	Chachoengsao	Thailand
18674	Bang Pa-in	Phra Nakhon Si Ayutthaya	Thailand
18675	Bang Mun Nak	Phichit	Thailand
18676	Bang Len	Nakhon Pathom	Thailand
18677	Bang Lamung	Chon Buri	Thailand
18678	Bang Kruai	Nonthaburi	Thailand
18679	Bang Krathum	Phitsanulok	Thailand
18680	Bang Bua Thong	Nonthaburi	Thailand
18681	Bang Ban	Phra Nakhon Si Ayutthaya	Thailand
18682	Ban Dung	Changwat Udon Thani	Thailand
18683	Ban Chang	Rayong	Thailand
18684	Ban Bueng	Chon Buri	Thailand
18685	Ban Talat Bueng	Chon Buri	Thailand
18686	Ban Bang Kadi Pathum Thani	Phra Nakhon Si Ayutthaya	Thailand
18687	Bang Bo District	Samut Prakan	Thailand
18688	Aranyaprathet	Sa Kaeo	Thailand
18689	Amnat Charoen	Amnat Charoen	Thailand
18690	Amphoe Sikhiu	Nakhon Ratchasima	Thailand
18691	Wichit	Phuket	Thailand
18692	Ban Chalong	Phuket	Thailand
18693	Ban Ratsada	Phuket	Thailand
18694	Yovon	Khatlon	Tajikistan
18696	Vakhsh	Khatlon	Tajikistan
18697	Istaravshan	Viloyati Sughd	Tajikistan
18698	Tursunzoda	Republican Subordination	Tajikistan
18699	Qurghonteppa	Khatlon	Tajikistan
18700	Panjakent	Viloyati Sughd	Tajikistan
18701	Farkhor	Khatlon	Tajikistan
18702	Vahdat	Republican Subordination	Tajikistan
18703	Norak	Khatlon	Tajikistan
18704	Kulob	Khatlon	Tajikistan
18705	Kolkhozobod	Khatlon	Tajikistan
18706	Khorugh	Gorno-Badakhshan	Tajikistan
18707	Ishqoshim	Gorno-Badakhshan	Tajikistan
18708	Hisor	Republican Subordination	Tajikistan
18709	Dushanbe	Dushanbe	Tajikistan
18710	Danghara	Khatlon	Tajikistan
18711	Chubek	Khatlon	Tajikistan
18712	Boshkengash	Dushanbe	Tajikistan
18713	Proletar	Viloyati Sughd	Tajikistan
18714	Khujand	Viloyati Sughd	Tajikistan
18715	Konibodom	Viloyati Sughd	Tajikistan
18716	Isfara	Viloyati Sughd	Tajikistan
18717	Chkalov	Viloyati Sughd	Tajikistan
18718	Moskovskiy	Khatlon	Tajikistan
18719	Suai	Cova Lima	East Timor
18721	Maliana	Bobonaro	East Timor
18724	Baucau	Baucau	East Timor
18725	Aileu	Aileu	East Timor
18726	Same	Manufahi	East Timor
18728	Venilale	Baucau	East Timor
18729	Balkanabat	Balkan	Turkmenistan
18730	Kaka	Ahal	Turkmenistan
18731	Gumdag	Balkan	Turkmenistan
18732	Gazanjyk	Balkan	Turkmenistan
18733	Abadan	Ahal	Turkmenistan
18734	Baharly	Ahal	Turkmenistan
18735	Ashgabat	Ahal	Turkmenistan
18736	Annau	Ahal	Turkmenistan
18737	Yylanly	Dasoguz	Turkmenistan
18738	Tagta	Dasoguz	Turkmenistan
18741	Boldumsaz	Dasoguz	Turkmenistan
18742	Dasoguz	Dasoguz	Turkmenistan
18744	Tejen	Ahal	Turkmenistan
18745	Seydi	Mary	Turkmenistan
18747	Mary	Mary	Turkmenistan
18748	Atamyrat	Lebap	Turkmenistan
18749	Gowurdak	Lebap	Turkmenistan
18751	Bayramaly	Mary	Turkmenistan
18752	Gazojak	Lebap	Turkmenistan
18753	Zaghouan	Zaghwan	Tunisia
18754	Oued Lill	Tunis	Tunisia
18755	Tunis	Tunis	Tunisia
18756	Tozeur	Tawzar	Tunisia
18757	Tataouine	Tataouine	Tunisia
18758	Thala	Al Qasrayn	Tunisia
18759	Takelsa	Nabul	Tunisia
18760	Tajerouine	Kef	Tunisia
18761	Sousse	Susah	Tunisia
18762	Siliana	Silyanah	Tunisia
18763	Sidi Bouzid	Sidi Bu Zayd	Tunisia
18764	Skanes	Al Munastir	Tunisia
18765	Sfax	Safaqis	Tunisia
18766	La Sebala du Mornag	Tunis	Tunisia
18768	Ksour Essaf	Al Mahdiyah	Tunisia
18769	Korba	Nabul	Tunisia
18771	Kebili	Qibili	Tunisia
18772	Ksar Hellal	Al Munastir	Tunisia
18773	Carthage	Tunis	Tunisia
18774	El Fahs	Zaghwan	Tunisia
18775	Galaat el Andeless	Ariana	Tunisia
18776	Gafsa	Gafsa	Tunisia
18778	Nefta	Tawzar	Tunisia
18779	Nabeul	Nabul	Tunisia
18780	Midoun	Madanin	Tunisia
18781	Mateur	Banzart	Tunisia
18782	Msaken	Susah	Tunisia
18783	Menzel Jemil	Banzart	Tunisia
18784	Mennzel Bou Zelfa	Nabul	Tunisia
18785	Menzel Bourguiba	Banzart	Tunisia
18786	Menzel Abderhaman	Banzart	Tunisia
18787	Manouba	Manouba	Tunisia
18788	Medjez el Bab	Bajah	Tunisia
18789	Medenine	Madanin	Tunisia
18790	Jendouba	Jundubah	Tunisia
18791	Zarzis	Madanin	Tunisia
18792	Djemmal	Al Munastir	Tunisia
18793	Houmt Souk	Madanin	Tunisia
18794	Hammam Sousse	Susah	Tunisia
18795	Hammam-Lif	Tunis	Tunisia
18796	La Goulette	Tunis	Tunisia
18797	Douz	Qibili	Tunisia
18798	Douar Tindja	Banzart	Tunisia
18799	Dar Chabanne	Nabul	Tunisia
18801	Bizerte	Banzart	Tunisia
18802	Beni Khiar	Nabul	Tunisia
18804	Zouila	Al Mahdiyah	Tunisia
18805	Chebba	Al Mahdiyah	Tunisia
18806	Ariana	Ariana	Tunisia
18807	Ar Rudayyif	Gafsa	Tunisia
18808	Ouardenine	Al Munastir	Tunisia
18809	Kairouan	Al Qayrawan	Tunisia
18810	Kasserine	Al Qasrayn	Tunisia
18811	Gremda	Safaqis	Tunisia
18812	Monastir	Al Munastir	Tunisia
18813	La Mohammedia	Tunis	Tunisia
18814	Metlaoui	Gafsa	Tunisia
18816	Mahdia	Al Mahdiyah	Tunisia
18817	El Kef	Kef	Tunisia
18818	El Jem	Al Mahdiyah	Tunisia
18819	Hammamet	Nabul	Tunisia
18820	El Hamma	Qabis	Tunisia
18821	Bekalta	Al Munastir	Tunisia
18822	El Alia	Banzart	Tunisia
18823	Akouda	Susah	Tunisia
18824	Douane	Nabul	Tunisia
18827	Yozgat	Yozgat	Turkey
18828	Yesilli	Mardin	Turkey
18829	Erzin	Hatay	Turkey
18831	Didim	Aydin	Turkey
18832	Yatagan	Mugla	Turkey
18834	Yahyali	Kayseri	Turkey
18835	Viransehir	Sanliurfa	Turkey
18836	Varto	Mus	Turkey
18837	Van	Van	Turkey
18838	Cimin	Erzincan	Turkey
18839	Usak	Usak	Turkey
18840	Urla	Izmir	Turkey
18842	Sanliurfa	Sanliurfa	Turkey
18843	Turgutlu	Manisa	Turkey
18844	Tunceli	Tunceli	Turkey
18845	Torbali	Izmir	Turkey
18846	Tire	Izmir	Turkey
18847	Tekirova	Antalya	Turkey
18849	Tatvan	Bitlis	Turkey
18850	Tarsus	Mersin	Turkey
18851	Talas	Kayseri	Turkey
18852	Susurluk	Balikesir	Turkey
18854	Sorgun	Yozgat	Turkey
18855	Soma	Manisa	Turkey
18858	Siverek	Sanliurfa	Turkey
18859	Sivas	Sivas	Turkey
18860	Sirnak	Sirnak	Turkey
18862	Silvan	Diyarbakir	Turkey
18863	Silopi	Sirnak	Turkey
18864	Silifke	Mersin	Turkey
18865	Siirt	Siirt	Turkey
18866	Seydisehir	Konya	Turkey
18867	Serinyol	Hatay	Turkey
18868	Serik	Antalya	Turkey
18870	Senirkent	Isparta	Turkey
18873	Seferhisar	Izmir	Turkey
18874	Sarkisla	Sivas	Turkey
18877	Sandikli	Afyonkarahisar	Turkey
18878	Salihli	Manisa	Turkey
18879	Reyhanli	Hatay	Turkey
18880	Polatli	Ankara	Turkey
18881	Pazarcik	Kahramanmaras	Turkey
18882	Patnos	Agri	Turkey
18883	Pasinler	Erzurum	Turkey
18884	Osmaniye	Osmaniye	Turkey
18886	Ortaca	Mugla	Turkey
18888	Nusaybin	Mardin	Turkey
18889	Nizip	Gaziantep	Turkey
18890	Nigde	Nigde	Turkey
18891	Nevsehir	Nevsehir	Turkey
18892	Nazilli	Aydin	Turkey
18893	Mut	Mersin	Turkey
18894	Mus	Mus	Turkey
18895	Mugla	Mugla	Turkey
18896	Mucur	Kirsehir	Turkey
18897	Milas	Mugla	Turkey
18898	Midyat	Mardin	Turkey
18899	Mercin	Mersin	Turkey
18900	Menemen	Izmir	Turkey
18901	Marmaris	Mugla	Turkey
18902	Mardin	Mardin	Turkey
18903	Manisa	Manisa	Turkey
18904	Manavgat	Antalya	Turkey
18905	Malazgirt	Mus	Turkey
18906	Malatya	Malatya	Turkey
18907	Mahmutlar	Antalya	Turkey
18908	Lice	Diyarbakir	Turkey
18910	Kusadasi	Aydin	Turkey
18911	Kurtalan	Siirt	Turkey
18912	Beykonak	Antalya	Turkey
18913	Kulu	Konya	Turkey
18914	Kulp	Diyarbakir	Turkey
18915	Kula	Manisa	Turkey
18916	Kozluk	Batman	Turkey
18917	Kozan	Adana	Turkey
18918	Kovancilar	Elazig	Turkey
18919	Korkuteli	Antalya	Turkey
18920	Konya	Konya	Turkey
18921	Kiziltepe	Mardin	Turkey
18922	Serinhisar	Denizli	Turkey
18923	Kirsehir	Kirsehir	Turkey
18925	Kirikkale	Kirikkale	Turkey
18926	Kirikhan	Hatay	Turkey
18927	Kilis	Kilis	Turkey
18928	Keskin	Kirikkale	Turkey
18929	Kemer	Antalya	Turkey
18930	Kemalpasa	Izmir	Turkey
18931	Kayseri	Kayseri	Turkey
18932	Karapinar	Konya	Turkey
18933	Karaman	Karaman	Turkey
18934	Agri	Agri	Turkey
18937	Kaman	Kirsehir	Turkey
18939	Kahramanmaras	Kahramanmaras	Turkey
18940	Kadirli	Adana	Turkey
18941	Kadinhani	Konya	Turkey
18942	Izmir	Izmir	Turkey
18943	Isparta	Igdir	Turkey
18944	Idil	Sirnak	Turkey
18945	Hizan	Bitlis	Turkey
18946	Hinis	Erzurum	Turkey
18947	Hilvan	Sanliurfa	Turkey
18948	Hadim	Konya	Turkey
18949	Hacilar	Kayseri	Turkey
18954	Gemerek	Sivas	Turkey
18956	Gazipasa	Antalya	Turkey
18957	Gaziantep	Gaziantep	Turkey
18959	Fethiye	Mugla	Turkey
18961	Eskisehir	Eskisehir	Turkey
18962	Erzurum	Erzurum	Turkey
18963	Erzincan	Erzincan	Turkey
18964	Ermenek	Karaman	Turkey
18965	Ergani	Diyarbakir	Turkey
18966	Eregli	Konya	Turkey
18967	Erdemli	Mersin	Turkey
18968	Ercis	Van	Turkey
18969	Emirdag	Afyonkarahisar	Turkey
18971	Elmali	Antalya	Turkey
18972	Elmadag	Ankara	Turkey
18973	Eleskirt	Agri	Turkey
18974	Elbistan	Kahramanmaras	Turkey
18975	Elazig	Elazig	Turkey
18976	Egirdir	Isparta	Turkey
18977	Edremit	Balikesir	Turkey
18978	Dursunbey	Balikesir	Turkey
18980	Dogubayazit	Agri	Turkey
18981	Diyarbakir	Diyarbakir	Turkey
18982	Diyadin	Agri	Turkey
18983	Dinar	Afyonkarahisar	Turkey
18984	Develi	Kayseri	Turkey
18985	Denizli	Denizli	Turkey
18986	Demirci	Manisa	Turkey
18988	Darende	Malatya	Turkey
18990	Menderes	Izmir	Turkey
18992	Cizre	Sirnak	Turkey
18994	Ceylanpinar	Sanliurfa	Turkey
18995	Ceyhan	Adana	Turkey
19000	Burhaniye	Balikesir	Turkey
19001	Burdur	Burdur	Turkey
19002	Bulanik	Mus	Turkey
19003	Bucak	Burdur	Turkey
19004	Bozyazi	Mersin	Turkey
19006	Bozova	Sanliurfa	Turkey
19007	Bor	Nigde	Turkey
19008	Bolvadin	Afyonkarahisar	Turkey
19009	Bodrum	Mugla	Turkey
19010	Bitlis	Bitlis	Turkey
19011	Bismil	Diyarbakir	Turkey
19012	Birecik	Sanliurfa	Turkey
19015	Beysehir	Konya	Turkey
19016	Besni	Adiyaman	Turkey
19017	Bergama	Izmir	Turkey
19018	Belen	Hatay	Turkey
19019	Belek	Antalya	Turkey
19020	Bayindir	Izmir	Turkey
19021	Batman	Batman	Turkey
19022	Baskil	Elazig	Turkey
19023	Banaz	Usak	Turkey
19024	Balikesir	Balikesir	Turkey
19026	Ayvalik	Balikesir	Turkey
19027	Aydin	Aydin	Turkey
19028	Askale	Erzurum	Turkey
19029	Antalya	Antalya	Turkey
19030	Antakya	Hatay	Turkey
19031	Ankara	Ankara	Turkey
19032	Anamur	Mersin	Turkey
19033	Aliaga	Izmir	Turkey
19034	Alasehir	Manisa	Turkey
19035	Alanya	Antalya	Turkey
19036	Aksehir	Konya	Turkey
19037	Aksaray	Aksaray	Turkey
19038	Akhisar	Manisa	Turkey
19039	Akdagmadeni	Yozgat	Turkey
19041	Ahlat	Bitlis	Turkey
19042	Afyonkarahisar	Afyonkarahisar	Turkey
19043	Afsin	Kahramanmaras	Turkey
19044	Adiyaman	Adiyaman	Turkey
19045	Adilcevaz	Bitlis	Turkey
19046	Adana	Adana	Turkey
19047	Denizciler	Hatay	Turkey
19048	Batikent	Ankara	Turkey
19049	Dalaman	Mugla	Turkey
19050	Zonguldak	Zonguldak	Turkey
19051	Zile	Tokat	Turkey
19052	Zeytinburnu	Istanbul	Turkey
19053	Yomra	Trabzon	Turkey
19054	Yenisehir	Bursa	Turkey
19056	Yalova	Yalova	Turkey
19057	Yakuplu	Istanbul	Turkey
19059	Vakfikebir	Trabzon	Turkey
19063	Umraniye	Istanbul	Turkey
19064	Turhal	Tokat	Turkey
19065	Trabzon	Trabzon	Turkey
19066	Tosya	Kastamonu	Turkey
19067	Tokat	Tokat	Turkey
19068	Tirebolu	Giresun	Turkey
19069	Terme	Samsun	Turkey
19070	Tepecik	Istanbul	Turkey
19072	Tekirdag	Tekirdag	Turkey
19073	Tasova	Amasya	Turkey
19075	Susehri	Sivas	Turkey
19078	Suluova	Amasya	Turkey
19079	Sisli	Istanbul	Turkey
19080	Sinop	Sinop	Turkey
19081	Silivri	Istanbul	Turkey
19082	Sebin Karahisar	Giresun	Turkey
19083	Sarikamis	Kars	Turkey
19084	Sapanca	Sakarya	Turkey
19085	Samsun	Samsun	Turkey
19087	Rize	Rize	Turkey
19088	Osmaneli	Bilecik	Turkey
19090	Orhangazi	Bursa	Turkey
19091	Ordu	Ordu	Turkey
19092	Oltu	Erzurum	Turkey
19093	Of	Trabzon	Turkey
19094	Niksar	Tokat	Turkey
19095	Nallihan	Ankara	Turkey
19096	Mustafakemalpasa	Bursa	Turkey
19097	Mudanya	Bursa	Turkey
19098	Mimarsinan	Istanbul	Turkey
19099	Merzifon	Amasya	Turkey
19100	Maltepe	Istanbul	Turkey
19101	Malkara	Tekirdag	Turkey
19103	Kumru	Ordu	Turkey
19104	Korgan	Ordu	Turkey
19105	Kocaali	Sakarya	Turkey
19106	Kizilcahamam	Ankara	Turkey
19107	Kirklareli	Kirklareli	Turkey
19108	Kestel	Bursa	Turkey
19109	Kesan	Edirne	Turkey
19111	Kazan	Ankara	Turkey
19112	Kavakli	Istanbul	Turkey
19113	Kastamonu	Kastamonu	Turkey
19114	Kars	Kars	Turkey
19115	Karasu	Sakarya	Turkey
19117	Karacabey	Bursa	Turkey
19119	Kagizman	Kars	Turkey
19120	Iznik	Bursa	Turkey
19121	Izmit	Kocaeli	Turkey
19122	Istanbul	Istanbul	Turkey
19124	Inegol	Bursa	Turkey
19125	Horasan	Erzurum	Turkey
19126	Hopa	Artvin	Turkey
19127	Hendek	Sakarya	Turkey
19128	Hayrabolu	Tekirdag	Turkey
19129	Havza	Samsun	Turkey
19137	Giresun	Giresun	Turkey
19138	Geyve	Sakarya	Turkey
19139	Gerede	Bolu	Turkey
19140	Gemlik	Bursa	Turkey
19142	Gebze	Kocaeli	Turkey
19143	Ferizli	Sakarya	Turkey
19144	Fatsa	Ordu	Turkey
19145	Esenyurt	Istanbul	Turkey
19146	Esenler	Istanbul	Turkey
19147	Eregli	Zonguldak	Turkey
19148	Erdek	Balikesir	Turkey
19149	Erbaa	Tokat	Turkey
19151	Edirne	Edirne	Turkey
19153	Devrek	Zonguldak	Turkey
19166	Bursa	Bursa	Turkey
19167	Bulancak	Giresun	Turkey
19168	Boyabat	Sinop	Turkey
19169	Bolu	Bolu	Turkey
19170	Bilecik	Bilecik	Turkey
19172	Beypazari	Ankara	Turkey
19174	Bayburt	Bayburt	Turkey
19175	Bartin	Bartin	Turkey
19176	Bandirma	Balikesir	Turkey
19177	Bagcilar	Istanbul	Turkey
19178	Bafra	Samsun	Turkey
19179	Babaeski	Kirklareli	Turkey
19180	Artvin	Artvin	Turkey
19181	Arsin	Trabzon	Turkey
19182	Arhavi	Artvin	Turkey
19183	Ardesen	Rize	Turkey
19184	Ardahan	Ardahan	Turkey
19185	Arakli	Trabzon	Turkey
19186	Amasya	Amasya	Turkey
19187	Alapli	Zonguldak	Turkey
19189	Akyazi	Sakarya	Turkey
19192	Adapazari	Sakarya	Turkey
19193	Espiye	Giresun	Turkey
19194	merter keresteciler	Istanbul	Turkey
19196	Turgutreis	Mugla	Turkey
19197	Sarigerme	Mugla	Turkey
19198	Atasehir	Istanbul	Turkey
19199	Basaksehir	Istanbul	Turkey
19204	Sultangazi	Istanbul	Turkey
19205	Sultanbeyli	Istanbul	Turkey
19206	Sancaktepe	Istanbul	Turkey
19207	Karabaglar	Izmir	Turkey
19208	Muratpasa	Antalya	Turkey
19209	Tunapuna	Tunapuna/Piarco	Trinidad and Tobago
19210	Scarborough	Tobago	Trinidad and Tobago
19211	Sangre Grande	Sangre Grande	Trinidad and Tobago
19212	San Fernando	City of San Fernando	Trinidad and Tobago
19213	Rio Claro	Mayaro	Trinidad and Tobago
19214	Port of Spain	City of Port of Spain	Trinidad and Tobago
19215	Point Fortin	Point Fortin	Trinidad and Tobago
19216	Paradise	Tunapuna/Piarco	Trinidad and Tobago
19217	Mon Repos	City of San Fernando	Trinidad and Tobago
19218	Marabella	City of San Fernando	Trinidad and Tobago
19219	Laventille	San Juan/Laventille	Trinidad and Tobago
19220	Chaguanas	Chaguanas	Trinidad and Tobago
19221	Arima	Borough of Arima	Trinidad and Tobago
19222	Funafuti	Funafuti	Tuvalu
19223	Douliu	Taiwan	Taiwan
19224	Yujing	Taiwan	Taiwan
19225	Taipei	Taipei	Taiwan
19226	Tainan	Taiwan	Taiwan
19227	Taichung	Taiwan	Taiwan
19228	Daxi	Taiwan	Taiwan
19229	Banqiao	Taipei	Taiwan
19230	Puli	Taiwan	Taiwan
19231	Nantou	Taiwan	Taiwan
19232	Magong	Taiwan	Taiwan
19233	Lugu	Taiwan	Taiwan
19234	Kaohsiung	Kaohsiung	Taiwan
19235	Yilan	Taiwan	Taiwan
19236	Hualien City	Taiwan	Taiwan
19237	Hsinchu	Taiwan	Taiwan
19238	Hengchun	Taiwan	Taiwan
19239	Jincheng	Fukien	Taiwan
19240	Keelung	Taiwan	Taiwan
19241	Taoyuan City	Taiwan	Taiwan
19242	Taitung City	Taiwan	Taiwan
19243	Zhongxing New Village	Taiwan	Taiwan
19244	Zanzibar	Zanzibar Urban/West	Tanzania
19245	Wete	Pemba North	Tanzania
19246	Vwawa	Mbeya	Tanzania
19247	Vikindu	Pwani	Tanzania
19248	Uyovu	Geita	Tanzania
19249	Uvinza	Kigoma	Tanzania
19250	Ushirombo	Geita	Tanzania
19251	Usevia	Katavi	Tanzania
19252	Usagara	Mwanza	Tanzania
19253	Usa River	Arusha	Tanzania
19254	Urambo	Tabora	Tanzania
19255	Tunduma	Mbeya	Tanzania
19256	Tumbi	Tabora	Tanzania
19257	Tukuyu	Mbeya	Tanzania
19258	Tinde	Shinyanga	Tanzania
19259	Tarime	Mara	Tanzania
19260	Tanga	Tanga	Tanzania
19261	Tabora	Tabora	Tanzania
19262	Sumbawanga	Rukwa	Tanzania
19263	Songwa	Shinyanga	Tanzania
19264	Somanda	Simiyu	Tanzania
19265	Sokoni	Zanzibar Central/South	Tanzania
19266	Sirari	Mara	Tanzania
19267	Singida	Singida	Tanzania
19268	Sikonge	Tabora	Tanzania
19269	Shinyanga	Shinyanga	Tanzania
19270	Shelui	Singida	Tanzania
19271	Sepuka	Singida	Tanzania
19272	Same	Kilimanjaro	Tanzania
19273	Rulenge	Kagera	Tanzania
19274	Rujewa	Mbeya	Tanzania
19275	Puma	Singida	Tanzania
19276	Old Shinyanga	Shinyanga	Tanzania
19277	Nzega	Tabora	Tanzania
19278	Nyamuswa	Mara	Tanzania
19279	Nyalikungu	Simiyu	Tanzania
19280	Nyakabindi	Simiyu	Tanzania
19281	Nsunga	Kagera	Tanzania
19282	Nshamba	Kagera	Tanzania
19283	Njombe	Njombe	Tanzania
19284	Nguruka	Kigoma	Tanzania
19285	Ngudu	Mwanza	Tanzania
19286	Ngerengere	Morogoro	Tanzania
19287	Ngara	Kagera	Tanzania
19288	Nangwa	Manyara	Tanzania
19289	Namanyere	Rukwa	Tanzania
19290	Mwanza	Mwanza	Tanzania
19291	Mwadui	Shinyanga	Tanzania
19292	Mvomero	Pwani	Tanzania
19293	Musoma	Mara	Tanzania
19294	Muriti	Mara	Tanzania
19295	Mungaa	Singida	Tanzania
19296	Muheza	Tanga	Tanzania
19297	Mugumu	Mara	Tanzania
19298	Mtwango	Njombe	Tanzania
19299	Mto wa Mbu	Arusha	Tanzania
19300	Mtinko	Singida	Tanzania
19301	Msowero	Morogoro	Tanzania
19302	Mpwapwa	Dodoma	Tanzania
19303	Mpanda	Katavi	Tanzania
19304	Moshi	Kilimanjaro	Tanzania
19305	Morogoro	Morogoro	Tanzania
19306	Mlowo	Mbeya	Tanzania
19307	Mlimba	Morogoro	Tanzania
19308	Mlangali	Njombe	Tanzania
19309	Mlandizi	Pwani	Tanzania
19310	Mlalo	Tanga	Tanzania
19311	Mkuranga	Pwani	Tanzania
19312	Mwandiga	Kigoma	Tanzania
19313	Misungwi	Mwanza	Tanzania
19314	Mikumi	Morogoro	Tanzania
19315	Mhango	Shinyanga	Tanzania
19316	Mgandu	Singida	Tanzania
19317	Mbuguni	Arusha	Tanzania
19318	Mbeya	Mbeya	Tanzania
19319	Mazinde	Tanga	Tanzania
19320	Matui	Tanga	Tanzania
19321	Matai	Rukwa	Tanzania
19322	Maswa	Simiyu	Tanzania
19323	Masumbwe	Geita	Tanzania
19324	Maramba	Tanga	Tanzania
19325	Malinyi	Morogoro	Tanzania
19326	Malampaka	Simiyu	Tanzania
19327	Makuyuni	Tanga	Tanzania
19328	Makumbako	Njombe	Tanzania
19329	Mahanje	Ruvuma	Tanzania
19330	Kihangara	Mwanza	Tanzania
19331	Magugu	Manyara	Tanzania
19332	Magomeni	Dar es Salaam	Tanzania
19333	Magole	Morogoro	Tanzania
19334	Mafinga	Iringa	Tanzania
19335	Mabama	Tabora	Tanzania
19336	Lushoto	Tanga	Tanzania
19337	Lugoba	Pwani	Tanzania
19338	Liwale	Lindi	Tanzania
19339	Lembeni	Kilimanjaro	Tanzania
19340	Lalago	Simiyu	Tanzania
19341	Laela	Rukwa	Tanzania
19342	Kyela	Mbeya	Tanzania
19343	Kondoa	Dodoma	Tanzania
19344	Kiwira	Mbeya	Tanzania
19345	Kishapu	Shinyanga	Tanzania
19346	Kisesa	Simiyu	Tanzania
19347	Kirando	Rukwa	Tanzania
19348	Kiomboi	Singida	Tanzania
19349	Kingori	Arusha	Tanzania
19350	Kilosa	Morogoro	Tanzania
19351	Kigoma	Kigoma	Tanzania
19352	Kidodi	Morogoro	Tanzania
19353	Kidatu	Morogoro	Tanzania
19354	Kibondo	Kigoma	Tanzania
19355	Kibiti	Pwani	Tanzania
19356	Kibara	Mara	Tanzania
19357	Kibakwe	Dodoma	Tanzania
19358	Kibaha	Pwani	Tanzania
19359	Katumba	Mbeya	Tanzania
19360	Katoro	Geita	Tanzania
19361	Katerero	Kagera	Tanzania
19362	Kasulu	Kigoma	Tanzania
19363	Kasamwa	Geita	Tanzania
19364	Kiratu	Arusha	Tanzania
19365	Kamachumu	Kagera	Tanzania
19366	Kakonko	Kigoma	Tanzania
19367	Kahama	Shinyanga	Tanzania
19368	Kabanga	Kagera	Tanzania
19369	Izazi	Iringa	Tanzania
19370	Itigi	Singida	Tanzania
19371	Isaka	Shinyanga	Tanzania
19372	Iringa	Iringa	Tanzania
19373	Ipinda	Mbeya	Tanzania
19374	Ilula	Iringa	Tanzania
19375	Ilongero	Singida	Tanzania
19376	Ilembula	Njombe	Tanzania
19377	Ikungi	Singida	Tanzania
19378	Igurusi	Mbeya	Tanzania
19379	Igunga	Tabora	Tanzania
19380	Igugunu	Singida	Tanzania
19381	Ifakara	Morogoro	Tanzania
19382	Hedaru	Kilimanjaro	Tanzania
19383	Geita	Geita	Tanzania
19384	Geiro	Morogoro	Tanzania
19385	Galappo	Manyara	Tanzania
19386	Dongobesh	Manyara	Tanzania
19387	Dodoma	Dodoma	Tanzania
19388	Dar es Salaam	Dar es Salaam	Tanzania
19389	Dareda	Manyara	Tanzania
19390	Chimala	Mbeya	Tanzania
19391	Chato	Geita	Tanzania
19392	Chanika	Tanga	Tanzania
19393	Chalinze	Pwani	Tanzania
19394	Chala	Rukwa	Tanzania
19395	Chake Chake	Pemba South	Tanzania
19396	Butiama	Mara	Tanzania
19397	Buseresere	Geita	Tanzania
19398	Bungu	Pwani	Tanzania
19399	Bunda	Mara	Tanzania
19400	Bukoba	Kagera	Tanzania
19401	Bugarama	Kagera	Tanzania
19402	Biharamulo	Kagera	Tanzania
19403	Basotu	Manyara	Tanzania
19404	Bashanet	Manyara	Tanzania
19405	Bariadi	Simiyu	Tanzania
19406	Bagamoyo	Pwani	Tanzania
19407	Babati	Manyara	Tanzania
19408	Arusha	Arusha	Tanzania
19409	Tingi	Ruvuma	Tanzania
19410	Tandahimba	Mtwara	Tanzania
19411	Songea	Ruvuma	Tanzania
19412	Nyangao	Lindi	Tanzania
19413	Newala Kisimani	Mtwara	Tanzania
19414	Nanyamba	Mtwara	Tanzania
19415	Nangomba	Mtwara	Tanzania
19416	Nanganga	Mtwara	Tanzania
19417	Nachingwea	Lindi	Tanzania
19418	Mtwara	Mtwara	Tanzania
19419	Mbinga	Ruvuma	Tanzania
19420	Matiri	Ruvuma	Tanzania
19421	Masasi	Mtwara	Tanzania
19422	Maposeni	Ruvuma	Tanzania
19423	Lukuledi	Mtwara	Tanzania
19424	Luchingu	Mtwara	Tanzania
19425	Lindi	Lindi	Tanzania
19426	Kitama	Mtwara	Tanzania
19427	Kigonsera	Ruvuma	Tanzania
19428	Merelani	Arusha	Tanzania
19429	Lebedyn	Sumy	Ukraine
19430	Druzhkivka	Donetsk	Ukraine
19431	Vasylivka	Zaporizhia	Ukraine
19432	Zvenyhorodka	Cherkasy	Ukraine
19433	Zuhres	Donetsk	Ukraine
19434	Zolotonosha	Cherkasy	Ukraine
19435	Zolochiv	Lviv	Ukraine
19436	Znomenka	Kirovohrad	Ukraine
19437	Zmiyiv	Kharkiv	Ukraine
19438	Zhytomyr	Zhytomyr	Ukraine
19439	Zhmerynka	Vinnytska	Ukraine
19440	Zhovti Vody	Dnipropetrovsk	Ukraine
19441	Zhashkiv	Cherkasy	Ukraine
19442	Zdolbuniv	Rivne	Ukraine
19443	Zaporizhzhya	Zaporizhia	Ukraine
19444	Yuzhne	Odessa	Ukraine
19445	Yevpatoriya	Crimea	Ukraine
19446	Yenakiyeve	Donetsk	Ukraine
19447	Yasynuvata	Donetsk	Ukraine
19448	Yalta	Crimea	Ukraine
19449	Yahotyn	Kiev	Ukraine
19450	Vyshhorod	Kiev	Ukraine
19451	Vynohradiv	Zakarpattia	Ukraine
19452	Voznesensk	Mykolaiv	Ukraine
19453	Volnovakha	Donetsk	Ukraine
19456	Vyshneve	Kiev	Ukraine
19457	Vinnytsya	Vinnytska	Ukraine
19458	Vatutine	Cherkasy	Ukraine
19459	Vasylkiv	Kiev	Ukraine
19460	Uzhhorod	Zakarpattia	Ukraine
19464	Truskavets	Lviv	Ukraine
19465	Torez	Donetsk	Ukraine
19466	Tokmak	Zaporizhia	Ukraine
19472	Svatove	Luhansk	Ukraine
19473	Svalyava	Zakarpattia	Ukraine
19474	Sumy	Sumy	Ukraine
19475	Stryi	Lviv	Ukraine
19476	Stebnyk	Lviv	Ukraine
19477	Starokostyantyniv	Khmelnytskyi	Ukraine
19479	Stakhanov	Luhansk	Ukraine
19481	Snizhne	Donetsk	Ukraine
19482	Smila	Cherkasy	Ukraine
19483	Sloviansk	Donetsk	Ukraine
19484	Slavuta	Khmelnytskyi	Ukraine
19485	Skvyra	Kiev	Ukraine
19488	Simferopol	Crimea	Ukraine
19489	Shpola	Cherkasy	Ukraine
19490	Shostka	Sumy	Ukraine
19491	Shepetivka	Khmelnytskyi	Ukraine
19494	Selydove	Donetsk	Ukraine
19495	Sarny	Rivne	Ukraine
19496	Sambir	Lviv	Ukraine
19497	Saky	Crimea	Ukraine
19498	Rubizhne	Luhansk	Ukraine
19501	Romny	Sumy	Ukraine
19502	Rivne	Rivne	Ukraine
19503	Reni	Odessa	Ukraine
19505	Piatykhatky	Dnipropetrovsk	Ukraine
19507	Pryluky	Chernihiv	Ukraine
19508	Popasna	Luhansk	Ukraine
19509	Poltava	Poltava	Ukraine
19510	Polonne	Khmelnytskyi	Ukraine
19511	Polohy	Zaporizhia	Ukraine
19512	Pidhorodne	Dnipropetrovsk	Ukraine
19513	Pyryatyn	Poltava	Ukraine
19518	Pavlohrad	Dnipropetrovsk	Ukraine
19519	Ovruch	Zhytomyr	Ukraine
19520	Orikhiv	Zaporizhia	Ukraine
19521	Oleksandriya	Kirovohrad	Ukraine
19522	Odessa	Odessa	Ukraine
19523	Ochakiv	Mykolaiv	Ukraine
19524	Obukhiv	Kiev	Ukraine
19525	Novyy Buh	Mykolaiv	Ukraine
19527	Novoukrayinka	Kirovohrad	Ukraine
19530	Nova Kakhovka	Kherson	Ukraine
19531	Nosivka	Chernihiv	Ukraine
19532	Nizhyn	Chernihiv	Ukraine
19535	Netishyn	Khmelnytskyi	Ukraine
19536	Nadvirna	Ivano-Frankivsk	Ukraine
19537	Mykolayiv	Mykolaiv	Ukraine
19538	Mukacheve	Zakarpattia	Ukraine
19541	Miskhor	Crimea	Ukraine
19542	Myrhorod	Poltava	Ukraine
19543	Merefa	Kharkiv	Ukraine
19545	Mariupol	Donetsk	Ukraine
19547	Malyn	Zhytomyr	Ukraine
19548	Makiyivka	Donetsk	Ukraine
19549	Lyubotyn	Kharkiv	Ukraine
19550	Lviv	Lviv	Ukraine
19551	Lutuhyne	Luhansk	Ukraine
19553	Luhansk	Luhansk	Ukraine
19554	Lubny	Poltava	Ukraine
19555	Lozova	Kharkiv	Ukraine
19557	Ladyzhyn	Vinnytska	Ukraine
19558	Kiev	Kyiv City	Ukraine
19560	Kurakhovo	Donetsk	Ukraine
19561	Kupjansk	Kharkiv	Ukraine
19562	Kryvyi Rih	Dnipropetrovsk	Ukraine
19564	Kreminna	Luhansk	Ukraine
19566	Kremenchuk	Poltava	Ukraine
19567	Krasnyy Luch	Luhansk	Ukraine
19568	Krasnyy Lyman	Donetsk	Ukraine
19570	Krasnohrad	Kharkiv	Ukraine
19571	Krasnodon	Luhansk	Ukraine
19573	Krasyliv	Khmelnytskyi	Ukraine
19575	Kivsharivka	Kharkiv	Ukraine
19580	Korostyshiv	Zhytomyr	Ukraine
19582	Kostyantynivka	Donetsk	Ukraine
19583	Konotop	Sumy	Ukraine
19585	Kolomyya	Ivano-Frankivsk	Ukraine
19586	Kivertsi	Volyn	Ukraine
19588	Kirovohrad	Kirovohrad	Ukraine
19589	Kiliya	Odessa	Ukraine
19590	Khust	Zakarpattia	Ukraine
19593	Kherson	Kherson	Ukraine
19595	Kharkiv	Kharkiv	Ukraine
19596	Kerch	Crimea	Ukraine
19597	Kozyatyn	Vinnytska	Ukraine
19598	Karlivka	Poltava	Ukraine
19599	Kaniv	Cherkasy	Ukraine
19600	Kamieniec Podolski	Khmelnytskyi	Ukraine
19601	Kalush	Ivano-Frankivsk	Ukraine
19602	Kalynivka	Vinnytska	Ukraine
19603	Kakhovka	Kherson	Ukraine
19604	Izyum	Kharkiv	Ukraine
19605	Izyaslav	Khmelnytskyi	Ukraine
19606	Izmayil	Odessa	Ukraine
19608	Irpin	Kiev	Ukraine
19611	Horodok	Khmelnytskyi	Ukraine
19612	Horlivka	Donetsk	Ukraine
19613	Hlukhiv	Sumy	Ukraine
19614	Hulyaypole	Zaporizhia	Ukraine
19615	Horodok	Lviv	Ukraine
19616	Horodyshche	Cherkasy	Ukraine
19619	Hayvoron	Kirovohrad	Ukraine
19620	Haysyn	Vinnytska	Ukraine
19621	Hadyach	Poltava	Ukraine
19622	Feodosiya	Crimea	Ukraine
19623	Fastiv	Kiev	Ukraine
19624	Energodar	Zaporizhia	Ukraine
19625	Dzhankoy	Crimea	Ukraine
19627	Dunaivtsi	Khmelnytskyi	Ukraine
19628	Dubno	Rivne	Ukraine
19629	Drohobych	Lviv	Ukraine
19630	Donetsk	Donetsk	Ukraine
19631	Dolyna	Ivano-Frankivsk	Ukraine
19632	Dolynska	Kirovohrad	Ukraine
19634	Dobropillya	Donetsk	Ukraine
19635	Dnipropetrovsk	Dnipropetrovsk	Ukraine
19637	Dniprorudne	Zaporizhia	Ukraine
19638	Dymytrov	Donetsk	Ukraine
19639	Derhachi	Kharkiv	Ukraine
19641	Chuhuyiv	Kharkiv	Ukraine
19642	Chortkiv	Ternopil	Ukraine
19644	Chervonohrad	Lviv	Ukraine
19645	Chernivtsi	Chernivtsi	Ukraine
19646	Chernihiv	Chernihiv	Ukraine
19647	Cherkasy	Cherkasy	Ukraine
19648	Bucha	Kiev	Ukraine
19649	Bryanka	Luhansk	Ukraine
19650	Brovary	Kiev	Ukraine
19651	Brody	Lviv	Ukraine
19652	Boyarka	Kiev	Ukraine
19654	Boryslav	Lviv	Ukraine
19655	Bolhrad	Odessa	Ukraine
19656	Bohuslav	Kiev	Ukraine
19657	Bohodukhiv	Kharkiv	Ukraine
19659	Bila Tserkva	Kiev	Ukraine
19660	????????	Ternopil	Ukraine
19661	Berehove	Zakarpattia	Ukraine
19662	Berdychiv	Zhytomyr	Ukraine
19664	Bilopillya	Sumy	Ukraine
19666	Bar	Vinnytska	Ukraine
19667	Balta	Odessa	Ukraine
19668	Balakliya	Kharkiv	Ukraine
19670	Bakhmach	Chernihiv	Ukraine
19671	Bakhchysaray	Crimea	Ukraine
19672	Avdiyivka	Donetsk	Ukraine
19673	Artsyz	Odessa	Ukraine
19676	Apostolove	Dnipropetrovsk	Ukraine
19677	Antratsyt	Luhansk	Ukraine
19678	Amvrosiyivka	Donetsk	Ukraine
19679	Alushta	Crimea	Ukraine
19681	Okhtyrka	Sumy	Ukraine
19682	Komsomolsk	Poltava	Ukraine
19683	????????	Kiev	Ukraine
19684	Yuzhnoukrainsk	Mykolaiv	Ukraine
19685	Novoyavorivsk	Lviv	Ukraine
19686	Yumbe	Northern Region	Uganda
19687	Wobulenzi	Central Region	Uganda
19688	Wakiso	Central Region	Uganda
19689	Tororo	Eastern Region	Uganda
19690	Soroti	Eastern Region	Uganda
19691	Pallisa	Eastern Region	Uganda
19692	Paidha	Northern Region	Uganda
19693	Nyachera	Western Region	Uganda
19694	Ntungamo	Western Region	Uganda
19695	Ntungamo	Western Region	Uganda
19696	Njeru	Central Region	Uganda
19697	Nebbi	Northern Region	Uganda
19698	Namasuba	Central Region	Uganda
19699	Mukono	Central Region	Uganda
19700	Mubende	Central Region	Uganda
19701	Moyo	Northern Region	Uganda
19702	Mityana	Central Region	Uganda
19703	Mbarara	Western Region	Uganda
19704	Mbale	Eastern Region	Uganda
19705	Masindi	Western Region	Uganda
19706	Masaka	Central Region	Uganda
19707	Luwero	Central Region	Uganda
19708	Lugazi	Central Region	Uganda
19709	Lira	Northern Region	Uganda
19710	Kyenjojo	Western Region	Uganda
19711	Kotido	Northern Region	Uganda
19712	Kitgum	Northern Region	Uganda
19713	Kireka	Central Region	Uganda
19714	Kayunga	Central Region	Uganda
19715	Kasese	Western Region	Uganda
19716	Kamwenge	Western Region	Uganda
19717	Kampala	Central Region	Uganda
19718	Kabale	Western Region	Uganda
19719	Jinja	Eastern Region	Uganda
19720	Iganga	Eastern Region	Uganda
19721	Hoima	Western Region	Uganda
19722	Gulu	Northern Region	Uganda
19723	Fort Portal	Western Region	Uganda
19724	Entebbe	Central Region	Uganda
19725	Bwizibwera	Western Region	Uganda
19726	Buwenge	Eastern Region	Uganda
19727	Busia	Eastern Region	Uganda
19728	Busembatia	Eastern Region	Uganda
19729	Bundibugyo	Western Region	Uganda
19730	Bugiri	Eastern Region	Uganda
19731	Arua	Northern Region	Uganda
19732	Adjumani	Northern Region	Uganda
19733	Fort Hunt	Virginia	United States
19734	Bessemer	Alabama	United States
19735	Paducah	Kentucky	United States
19736	Birmingham	Alabama	United States
19737	Center Point	Alabama	United States
19738	Daphne	Alabama	United States
19739	Decatur	Alabama	United States
19740	Dothan	Alabama	United States
19741	East Florence	Alabama	United States
19742	Enterprise	Alabama	United States
19743	Fairhope	Alabama	United States
19744	Florence	Alabama	United States
19745	Gadsden	Alabama	United States
19746	Helena	Alabama	United States
19747	Homewood	Alabama	United States
19748	Hoover	Alabama	United States
19749	Hueytown	Alabama	United States
19750	Huntsville	Alabama	United States
19751	Madison	Alabama	United States
19752	Mobile	Alabama	United States
19753	Montgomery	Alabama	United States
19754	Mountain Brook	Alabama	United States
19755	Northport	Alabama	United States
19756	Opelika	Alabama	United States
19757	Oxford	Alabama	United States
19758	Pelham	Alabama	United States
19759	Phenix City	Alabama	United States
19760	Prattville	Alabama	United States
19761	Prichard	Alabama	United States
19762	Selma	Alabama	United States
19763	Talladega	Alabama	United States
19764	Tillmans Corner	Alabama	United States
19765	Troy	Alabama	United States
19766	Trussville	Alabama	United States
19767	Tuscaloosa	Alabama	United States
19768	Vestavia Hills	Alabama	United States
19769	Bella Vista	Arkansas	United States
19770	Benton	Arkansas	United States
19771	Bentonville	Arkansas	United States
19772	Blytheville	Arkansas	United States
19773	Bryant	Arkansas	United States
19774	Cabot	Arkansas	United States
19775	Conway	Arkansas	United States
19776	El Dorado	Arkansas	United States
19777	Fayetteville	Arkansas	United States
19778	Forrest City	Arkansas	United States
19779	Fort Smith	Arkansas	United States
19780	Hot Springs	Arkansas	United States
19781	Jacksonville	Arkansas	United States
19782	Jonesboro	Arkansas	United States
19783	Little Rock	Arkansas	United States
19784	Maumelle	Arkansas	United States
19785	North Little Rock	Arkansas	United States
19786	Paragould	Arkansas	United States
19787	Pine Bluff	Arkansas	United States
19788	Rogers	Arkansas	United States
19789	Russellville	Arkansas	United States
19790	Searcy	Arkansas	United States
19791	Siloam Springs	Arkansas	United States
19792	Springdale	Arkansas	United States
19793	Texarkana	Arkansas	United States
19794	Van Buren	Arkansas	United States
19795	West Memphis	Arkansas	United States
19796	"Washington	United States	 D.C."
19797	Bear	Delaware	United States
19798	Dover	Delaware	United States
19799	Middletown	Delaware	United States
19800	Newark	Delaware	United States
19801	Wilmington	Delaware	United States
19802	Allapattah	Florida	United States
19803	Altamonte Springs	Florida	United States
19804	Apopka	Florida	United States
19805	Aventura	Florida	United States
19806	Bartow	Florida	United States
19807	Bayonet Point	Florida	United States
19808	Bayshore Gardens	Florida	United States
19809	Belle Glade	Florida	United States
19810	Bellview	Florida	United States
19811	Bloomingdale	Florida	United States
19812	Boca Del Mar	Florida	United States
19813	Boca Raton	Florida	United States
19814	Bonita Springs	Florida	United States
19815	Boynton Beach	Florida	United States
19816	Bradenton	Florida	United States
19817	Brandon	Florida	United States
19818	Brent	Florida	United States
19819	Brownsville	Florida	United States
19820	Buenaventura Lakes	Florida	United States
19821	Cantonment	Florida	United States
19822	Cape Coral	Florida	United States
19823	Carol City	Florida	United States
19824	Carrollwood	Florida	United States
19825	Carrollwood Village	Florida	United States
19826	Casselberry	Florida	United States
19827	Citrus Park	Florida	United States
19828	Clearwater	Florida	United States
19829	Clermont	Florida	United States
19830	Cocoa	Florida	United States
19831	Coconut Creek	Florida	United States
19832	Coconut Grove	Florida	United States
19833	Cooper City	Florida	United States
19834	Coral Gables	Florida	United States
19835	Coral Springs	Florida	United States
19836	Coral Terrace	Florida	United States
19837	Country Walk	Florida	United States
19838	Country Club	Florida	United States
19839	Crestview	Florida	United States
19840	Cutler	Florida	United States
19841	Cutler Ridge	Florida	United States
19842	Dania Beach	Florida	United States
19843	Davie	Florida	United States
19844	Daytona Beach	Florida	United States
19845	DeLand	Florida	United States
19846	DeBary	Florida	United States
19847	Deerfield Beach	Florida	United States
19848	Delray Beach	Florida	United States
19849	Deltona	Florida	United States
19850	Doral	Florida	United States
19851	Dunedin	Florida	United States
19852	East Lake	Florida	United States
19853	East Pensacola Heights	Florida	United States
19854	Edgewater	Florida	United States
19855	Egypt Lake-Leto	Florida	United States
19856	Ensley	Florida	United States
19857	Estero	Florida	United States
19858	Eustis	Florida	United States
19859	Ferry Pass	Florida	United States
19860	Flagami	Florida	United States
19861	Florida Ridge	Florida	United States
19862	Fort Lauderdale	Florida	United States
19863	Fort Myers	Florida	United States
19864	Fort Pierce	Florida	United States
19865	Fort Walton Beach	Florida	United States
19866	Fountainebleau	Florida	United States
19867	Fruit Cove	Florida	United States
19868	Gainesville	Florida	United States
19869	Glenvar Heights	Florida	United States
19870	Golden Gate	Florida	United States
19871	Golden Glades	Florida	United States
19872	Greenacres City	Florida	United States
19873	Haines City	Florida	United States
19874	Hallandale Beach	Florida	United States
19875	Hialeah	Florida	United States
19876	Hialeah Gardens	Florida	United States
19877	Holiday	Florida	United States
19878	Hollywood	Florida	United States
19879	Homestead	Florida	United States
19880	Immokalee	Florida	United States
19881	Iona	Florida	United States
19882	Ives Estates	Florida	United States
19883	Jacksonville	Florida	United States
19884	Jacksonville Beach	Florida	United States
19885	Jasmine Estates	Florida	United States
19886	Jupiter	Florida	United States
19887	Kendale Lakes	Florida	United States
19888	Kendall	Florida	United States
19889	Key West	Florida	United States
19890	Keystone	Florida	United States
19891	Kissimmee	Florida	United States
19892	Lake Butler	Florida	United States
19893	Lake Magdalene	Florida	United States
19894	Lake Worth	Florida	United States
19895	Lake Worth Corridor	Florida	United States
19896	Lakeland	Florida	United States
19897	Lakeside	Florida	United States
19898	Land O Lakes	Florida	United States
19899	Largo	Florida	United States
19900	Lauderdale Lakes	Florida	United States
19901	Lauderhill	Florida	United States
19902	Lealman	Florida	United States
19903	Leesburg	Florida	United States
19904	Lehigh Acres	Florida	United States
19905	Leisure City	Florida	United States
19906	Lutz	Florida	United States
19907	Lynn Haven	Florida	United States
19908	Maitland	Florida	United States
19909	Margate	Florida	United States
19910	Meadow Woods	Florida	United States
19911	Melbourne	Florida	United States
19912	Merritt Island	Florida	United States
19913	Miami	Florida	United States
19914	Miami Beach	Florida	United States
19915	Miami Gardens	Florida	United States
19916	Miami Lakes	Florida	United States
19917	Miramar	Florida	United States
19918	Myrtle Grove	Florida	United States
19919	Naples	Florida	United States
19920	Navarre	Florida	United States
19921	New Smyrna Beach	Florida	United States
19922	Norland	Florida	United States
19923	North Fort Myers	Florida	United States
20037	Decatur	Georgia	United States
19924	North Lauderdale	Florida	United States
19925	North Miami	Florida	United States
19926	North Miami Beach	Florida	United States
19927	North Port	Florida	United States
19928	Oak Ridge	Florida	United States
19929	Oakland Park	Florida	United States
19930	Ocala	Florida	United States
19931	Ocoee	Florida	United States
19932	Ojus	Florida	United States
19933	Opa-locka	Florida	United States
19934	Orlando	Florida	United States
19935	Ormond Beach	Florida	United States
19936	Oviedo	Florida	United States
19937	Pace	Florida	United States
19938	Palm Bay	Florida	United States
19939	Palm Beach Gardens	Florida	United States
19940	Palm City	Florida	United States
19941	Palm Coast	Florida	United States
19942	Palm Harbor	Florida	United States
19943	Palm Springs	Florida	United States
19944	Palm Valley	Florida	United States
19945	Palmetto Bay	Florida	United States
19946	Panama City	Florida	United States
19947	Parkland	Florida	United States
19948	Pembroke Pines	Florida	United States
19949	Pensacola	Florida	United States
19950	Pine Hills	Florida	United States
19951	Pinecrest	Florida	United States
19952	Pinellas Park	Florida	United States
19953	Pinewood	Florida	United States
19954	Plant City	Florida	United States
19955	Plantation	Florida	United States
19956	Poinciana	Florida	United States
19957	Pompano Beach	Florida	United States
19958	Ponte Vedra Beach	Florida	United States
19959	Port Charlotte	Florida	United States
19960	Port Orange	Florida	United States
19961	Port Saint Lucie	Florida	United States
19962	Princeton	Florida	United States
19963	Punta Gorda	Florida	United States
19964	Punta Gorda Isles	Florida	United States
19965	Richmond West	Florida	United States
19966	Riverview	Florida	United States
19967	Riviera Beach	Florida	United States
19968	Rockledge	Florida	United States
19969	Royal Palm Beach	Florida	United States
19970	Ruskin	Florida	United States
19971	Safety Harbor	Florida	United States
19972	Saint Cloud	Florida	United States
19973	Saint Petersburg	Florida	United States
19974	San Carlos Park	Florida	United States
19975	Sanford	Florida	United States
19976	Sarasota	Florida	United States
19977	Sebastian	Florida	United States
19978	Seminole	Florida	United States
19979	South Bradenton	Florida	United States
19980	South Miami Heights	Florida	United States
19981	Southchase	Florida	United States
19982	Spring Hill	Florida	United States
19983	Stuart	Florida	United States
19984	Sun City Center	Florida	United States
19985	Sunny Isles Beach	Florida	United States
19986	Sunrise	Florida	United States
19987	Sunset	Florida	United States
19988	Tallahassee	Florida	United States
19989	Tamarac	Florida	United States
19990	Tamiami	Florida	United States
19991	Tampa	Florida	United States
19992	Tarpon Springs	Florida	United States
19993	Temple Terrace	Florida	United States
19994	The Crossings	Florida	United States
19995	The Hammocks	Florida	United States
19996	The Villages	Florida	United States
19997	Three Lakes	Florida	United States
19998	Titusville	Florida	United States
19999	Town n Country	Florida	United States
20000	University Park	Florida	United States
20001	Valrico	Florida	United States
20002	Venice	Florida	United States
20003	Vero Beach	Florida	United States
20004	Wekiwa Springs	Florida	United States
20005	Wellington	Florida	United States
20006	Wesley Chapel	Florida	United States
20007	Westchase	Florida	United States
20008	West Little River	Florida	United States
20009	West Melbourne	Florida	United States
20010	West Palm Beach	Florida	United States
20011	West Pensacola	Florida	United States
20012	West and East Lealman	Florida	United States
20013	Westchester	Florida	United States
20014	Weston	Florida	United States
20015	Winter Garden	Florida	United States
20016	Winter Haven	Florida	United States
20017	Winter Park	Florida	United States
20018	Winter Springs	Florida	United States
20019	Wright	Florida	United States
20020	Acworth	Georgia	United States
20021	Albany	Georgia	United States
20022	Alpharetta	Georgia	United States
20023	Americus	Georgia	United States
20024	Athens	Georgia	United States
20025	Atlanta	Georgia	United States
20026	Augusta	Georgia	United States
20027	Belvedere Park	Georgia	United States
20028	Brookhaven	Georgia	United States
20029	Brunswick	Georgia	United States
20030	Calhoun	Georgia	United States
20031	Canton	Georgia	United States
20032	Carrollton	Georgia	United States
20033	Cartersville	Georgia	United States
20034	Columbus	Georgia	United States
20035	Conyers	Georgia	United States
20036	Dalton	Georgia	United States
20038	Douglasville	Georgia	United States
20039	Dublin	Georgia	United States
20040	Duluth	Georgia	United States
20041	Dunwoody	Georgia	United States
20042	East Point	Georgia	United States
20043	Evans	Georgia	United States
20044	Fayetteville	Georgia	United States
20045	Forest Park	Georgia	United States
20046	Gainesville	Georgia	United States
20047	Griffin	Georgia	United States
20048	Hinesville	Georgia	United States
20049	Kennesaw	Georgia	United States
20050	Kingsland	Georgia	United States
20051	La Grange	Georgia	United States
20052	Lawrenceville	Georgia	United States
20053	Lithia Springs	Georgia	United States
20054	Mableton	Georgia	United States
20055	Macon	Georgia	United States
20056	Marietta	Georgia	United States
20057	Martinez	Georgia	United States
20058	McDonough	Georgia	United States
20059	Milledgeville	Georgia	United States
20060	Newnan	Georgia	United States
20061	North Decatur	Georgia	United States
20062	North Druid Hills	Georgia	United States
20063	Peachtree City	Georgia	United States
20064	Pooler	Georgia	United States
20065	Redan	Georgia	United States
20066	Riverdale	Georgia	United States
20067	Rome	Georgia	United States
20068	Roswell	Georgia	United States
20069	St. Marys	Georgia	United States
20070	Sandy Springs	Georgia	United States
20071	Savannah	Georgia	United States
20072	Smyrna	Georgia	United States
20073	Snellville	Georgia	United States
20074	Statesboro	Georgia	United States
20075	Stockbridge	Georgia	United States
20076	Sugar Hill	Georgia	United States
20077	Suwanee	Georgia	United States
20078	Thomasville	Georgia	United States
20079	Tifton	Georgia	United States
20080	Tucker	Georgia	United States
20081	Union City	Georgia	United States
20082	Valdosta	Georgia	United States
20083	Warner Robins	Georgia	United States
20084	Wilmington Island	Georgia	United States
20085	Woodstock	Georgia	United States
20086	Alton	Illinois	United States
20087	Belleville	Illinois	United States
20088	Cahokia	Illinois	United States
20089	Carbondale	Illinois	United States
20090	Charleston	Illinois	United States
20091	Collinsville	Illinois	United States
20092	Decatur	Illinois	United States
20093	East Saint Louis	Illinois	United States
20094	Edwardsville	Illinois	United States
20095	Fairview Heights	Illinois	United States
20096	Godfrey	Illinois	United States
20097	Granite City	Illinois	United States
20098	Jacksonville	Illinois	United States
20099	Marion	Illinois	United States
20100	Mattoon	Illinois	United States
20101	Mount Vernon	Illinois	United States
20102	OFallon	Illinois	United States
20103	Quincy	Illinois	United States
20104	Springfield	Illinois	United States
20105	Upper Alton	Illinois	United States
20106	Bloomington	Indiana	United States
20107	Broad Ripple	Indiana	United States
20108	Brownsburg	Indiana	United States
20109	Carmel	Indiana	United States
20110	Clarksville	Indiana	United States
20111	Columbus	Indiana	United States
20112	Evansville	Indiana	United States
20113	Fishers	Indiana	United States
20114	Greenfield	Indiana	United States
20115	Greenwood	Indiana	United States
20116	Indianapolis	Indiana	United States
20117	Jasper	Indiana	United States
20118	Jeffersonville	Indiana	United States
20119	Lawrence	Indiana	United States
20120	New Albany	Indiana	United States
20121	New Castle	Indiana	United States
20122	Plainfield	Indiana	United States
20123	Richmond	Indiana	United States
20124	Seymour	Indiana	United States
20125	Shelbyville	Indiana	United States
20126	Terre Haute	Indiana	United States
20127	Vincennes	Indiana	United States
20128	Derby	Kansas	United States
20129	Emporia	Kansas	United States
20130	Gardner	Kansas	United States
20131	Great Bend	Kansas	United States
20132	Hays	Kansas	United States
20133	Hutchinson	Kansas	United States
20134	Junction City	Kansas	United States
20135	Kansas City	Kansas	United States
20136	Lawrence	Kansas	United States
20137	Leavenworth	Kansas	United States
20138	Leawood	Kansas	United States
20139	Lenexa	Kansas	United States
20140	Manhattan	Kansas	United States
20141	Newton	Kansas	United States
20142	Olathe	Kansas	United States
20143	Overland Park	Kansas	United States
20144	Pittsburg	Kansas	United States
20145	Prairie Village	Kansas	United States
20146	Salina	Kansas	United States
20147	Shawnee	Kansas	United States
20148	Topeka	Kansas	United States
20149	Wichita	Kansas	United States
20150	Ashland	Kentucky	United States
20151	Bowling Green	Kentucky	United States
20152	Burlington	Kentucky	United States
20153	Covington	Kentucky	United States
20154	Danville	Kentucky	United States
20155	Elizabethtown	Kentucky	United States
20156	Erlanger	Kentucky	United States
20157	Fern Creek	Kentucky	United States
20158	Florence	Kentucky	United States
20159	Fort Thomas	Kentucky	United States
20160	Frankfort	Kentucky	United States
20161	Georgetown	Kentucky	United States
20162	Henderson	Kentucky	United States
20163	Highview	Kentucky	United States
20164	Hopkinsville	Kentucky	United States
20165	Independence	Kentucky	United States
20166	Ironville	Kentucky	United States
20167	Jeffersontown	Kentucky	United States
20168	Lexington	Kentucky	United States
20169	Lexington-Fayette	Kentucky	United States
20170	Louisville	Kentucky	United States
20171	Madisonville	Kentucky	United States
20172	Meads	Kentucky	United States
20173	Murray	Kentucky	United States
20174	Newburg	Kentucky	United States
20175	Newport	Kentucky	United States
20176	Nicholasville	Kentucky	United States
20177	Okolona	Kentucky	United States
20178	Owensboro	Kentucky	United States
20179	Pleasure Ridge Park	Kentucky	United States
20180	Radcliff	Kentucky	United States
20181	Richmond	Kentucky	United States
20182	Saint Matthews	Kentucky	United States
20183	Shively	Kentucky	United States
20184	Valley Station	Kentucky	United States
20185	Winchester	Kentucky	United States
20186	Alexandria	Louisiana	United States
20187	Baton Rouge	Louisiana	United States
20188	Bayou Cane	Louisiana	United States
20189	Bossier City	Louisiana	United States
20190	Central	Louisiana	United States
20191	Chalmette	Louisiana	United States
20192	Estelle	Louisiana	United States
20193	Gretna	Louisiana	United States
20194	Hammond	Louisiana	United States
20195	Harvey	Louisiana	United States
20196	Houma	Louisiana	United States
20197	Kenner	Louisiana	United States
20198	Lafayette	Louisiana	United States
20199	Lake Charles	Louisiana	United States
20200	Laplace	Louisiana	United States
20201	Marrero	Louisiana	United States
20202	Metairie	Louisiana	United States
20203	Metairie Terrace	Louisiana	United States
20204	Monroe	Louisiana	United States
20205	Natchitoches	Louisiana	United States
20206	New Iberia	Louisiana	United States
20207	New Orleans	Louisiana	United States
20208	Opelousas	Louisiana	United States
20209	Prairieville	Louisiana	United States
20210	Ruston	Louisiana	United States
20211	Shenandoah	Louisiana	United States
20212	Shreveport	Louisiana	United States
20213	Slidell	Louisiana	United States
20214	Sulphur	Louisiana	United States
20215	Terrytown	Louisiana	United States
20216	Adelphi	Maryland	United States
20217	Annapolis	Maryland	United States
20218	Arbutus	Maryland	United States
20219	Arnold	Maryland	United States
20220	Aspen Hill	Maryland	United States
20221	Baltimore	Maryland	United States
20222	Ballenger Creek	Maryland	United States
20223	Beltsville	Maryland	United States
20224	Bethesda	Maryland	United States
20225	Bowie	Maryland	United States
20226	Calverton	Maryland	United States
20227	Camp Springs	Maryland	United States
20228	Carney	Maryland	United States
20229	Catonsville	Maryland	United States
20230	Chillum	Maryland	United States
20231	Cloverly	Maryland	United States
20232	Clinton	Maryland	United States
20233	Cockeysville	Maryland	United States
20234	College Park	Maryland	United States
20235	Columbia	Maryland	United States
20236	Crofton	Maryland	United States
20237	Cumberland	Maryland	United States
20238	Damascus	Maryland	United States
20239	Dundalk	Maryland	United States
20240	East Riverdale	Maryland	United States
20241	Easton	Maryland	United States
20242	Edgewood	Maryland	United States
20243	Eldersburg	Maryland	United States
20244	Elkton	Maryland	United States
20245	Elkridge	Maryland	United States
20246	Ellicott City	Maryland	United States
20247	Essex	Maryland	United States
20248	Fairland	Maryland	United States
20249	Ferndale	Maryland	United States
20250	Fort Washington	Maryland	United States
20251	Frederick	Maryland	United States
20252	Gaithersburg	Maryland	United States
20253	Germantown	Maryland	United States
20254	Glassmanor	Maryland	United States
20255	Glen Burnie	Maryland	United States
20256	Green Haven	Maryland	United States
20257	Greenbelt	Maryland	United States
20258	Hagerstown	Maryland	United States
20259	Hanover	Maryland	United States
20260	Hillcrest Heights	Maryland	United States
20261	Hunt Valley	Maryland	United States
20262	Hyattsville	Maryland	United States
20263	Ilchester	Maryland	United States
20264	Lake Shore	Maryland	United States
20265	Landover	Maryland	United States
20266	Langley Park	Maryland	United States
20267	Laurel	Maryland	United States
20268	Lochearn	Maryland	United States
20269	Maryland City	Maryland	United States
20270	Middle River	Maryland	United States
20271	Milford Mill	Maryland	United States
20272	Montgomery Village	Maryland	United States
20273	North Bel Air	Maryland	United States
20274	North Bethesda	Maryland	United States
20275	North Potomac	Maryland	United States
20276	Odenton	Maryland	United States
20277	Olney	Maryland	United States
20278	Owings Mills	Maryland	United States
20279	Oxon Hill	Maryland	United States
20280	Parkville	Maryland	United States
20281	Parole	Maryland	United States
20282	Pasadena	Maryland	United States
20283	Perry Hall	Maryland	United States
20284	Pikesville	Maryland	United States
20285	Potomac	Maryland	United States
20286	Randallstown	Maryland	United States
20287	Redland	Maryland	United States
20288	Reisterstown	Maryland	United States
20289	Rockville	Maryland	United States
20290	Rosedale	Maryland	United States
20291	Rossville	Maryland	United States
20292	Saint Charles	Maryland	United States
20293	Salisbury	Maryland	United States
20294	Seabrook	Maryland	United States
20295	Severn	Maryland	United States
20296	Severna Park	Maryland	United States
20297	Silver Spring	Maryland	United States
20298	South Bel Air	Maryland	United States
20299	South Gate	Maryland	United States
20300	South Laurel	Maryland	United States
20301	Suitland	Maryland	United States
20302	Takoma Park	Maryland	United States
20303	Towson	Maryland	United States
20304	Waldorf	Maryland	United States
20305	West Elkridge	Maryland	United States
20306	Westminster	Maryland	United States
20307	Wheaton	Maryland	United States
20308	White Oak	Maryland	United States
20309	Woodlawn	Maryland	United States
20310	Affton	Missouri	United States
20311	Arnold	Missouri	United States
20312	Ballwin	Missouri	United States
20313	Belton	Missouri	United States
20314	Blue Springs	Missouri	United States
20315	Cape Girardeau	Missouri	United States
20316	Chesterfield	Missouri	United States
20317	Clayton	Missouri	United States
20318	Columbia	Missouri	United States
20319	Concord	Missouri	United States
20320	Creve Coeur	Missouri	United States
20321	East Independence	Missouri	United States
20322	Farmington	Missouri	United States
20323	Ferguson	Missouri	United States
20324	Florissant	Missouri	United States
20325	Gladstone	Missouri	United States
20326	Grandview	Missouri	United States
20327	Hannibal	Missouri	United States
20328	Hazelwood	Missouri	United States
20329	Independence	Missouri	United States
20330	Jefferson City	Missouri	United States
20331	Joplin	Missouri	United States
20332	Kansas City	Missouri	United States
20333	Kirkwood	Missouri	United States
20334	Lees Summit	Missouri	United States
20335	Lemay	Missouri	United States
20336	Liberty	Missouri	United States
20337	Manchester	Missouri	United States
20338	Maryland Heights	Missouri	United States
20339	Mehlville	Missouri	United States
20340	Nixa	Missouri	United States
20341	OFallon	Missouri	United States
20342	Oakville	Missouri	United States
20343	Overland	Missouri	United States
20344	Ozark	Missouri	United States
20345	Poplar Bluff	Missouri	United States
20346	Raymore	Missouri	United States
20347	Raytown	Missouri	United States
20348	Rolla	Missouri	United States
20349	Saint Charles	Missouri	United States
20350	Saint Joseph	Missouri	United States
20351	St. Louis	Missouri	United States
20352	Saint Peters	Missouri	United States
20353	Sedalia	Missouri	United States
20354	Sikeston	Missouri	United States
20355	Spanish Lake	Missouri	United States
20356	Springfield	Missouri	United States
20357	University City	Missouri	United States
20358	Warrensburg	Missouri	United States
20359	Webster Groves	Missouri	United States
20360	Wentzville	Missouri	United States
20361	Wildwood	Missouri	United States
20362	Biloxi	Mississippi	United States
20363	Brandon	Mississippi	United States
20364	Clarksdale	Mississippi	United States
20365	Clinton	Mississippi	United States
20366	Columbus	Mississippi	United States
20367	Gautier	Mississippi	United States
20368	Greenville	Mississippi	United States
20369	Greenwood	Mississippi	United States
20370	Gulfport	Mississippi	United States
20371	Hattiesburg	Mississippi	United States
20372	Horn Lake	Mississippi	United States
20373	Jackson	Mississippi	United States
20374	Laurel	Mississippi	United States
20375	Madison	Mississippi	United States
20376	Meridian	Mississippi	United States
20377	Natchez	Mississippi	United States
20487	Pickerington	Ohio	United States
20378	Ocean Springs	Mississippi	United States
20379	Olive Branch	Mississippi	United States
20380	Oxford	Mississippi	United States
20381	Pascagoula	Mississippi	United States
20382	Pearl	Mississippi	United States
20383	Ridgeland	Mississippi	United States
20384	Southaven	Mississippi	United States
20385	Starkville	Mississippi	United States
20386	Tupelo	Mississippi	United States
20387	Vicksburg	Mississippi	United States
20388	West Gulfport	Mississippi	United States
20389	Albemarle	North Carolina	United States
20390	Apex	North Carolina	United States
20391	Asheboro	North Carolina	United States
20392	Asheville	North Carolina	United States
20393	Boone	North Carolina	United States
20394	Burlington	North Carolina	United States
20395	Carrboro	North Carolina	United States
20396	Cary	North Carolina	United States
20397	Chapel Hill	North Carolina	United States
20398	Charlotte	North Carolina	United States
20399	Clayton	North Carolina	United States
20400	Clemmons	North Carolina	United States
20401	Concord	North Carolina	United States
20402	Cornelius	North Carolina	United States
20403	Durham	North Carolina	United States
20404	Eden	North Carolina	United States
20405	Elizabeth City	North Carolina	United States
20406	Fayetteville	North Carolina	United States
20407	Fuquay-Varina	North Carolina	United States
20408	Garner	North Carolina	United States
20409	Gastonia	North Carolina	United States
20410	Goldsboro	North Carolina	United States
20411	Greensboro	North Carolina	United States
20412	Greenville	North Carolina	United States
20413	Havelock	North Carolina	United States
20414	Henderson	North Carolina	United States
20415	Hickory	North Carolina	United States
20416	High Point	North Carolina	United States
20417	Holly Springs	North Carolina	United States
20418	Hope Mills	North Carolina	United States
20419	Huntersville	North Carolina	United States
20420	Indian Trail	North Carolina	United States
20421	Jacksonville	North Carolina	United States
20422	Kannapolis	North Carolina	United States
20423	Kernersville	North Carolina	United States
20424	Kinston	North Carolina	United States
20425	Laurinburg	North Carolina	United States
20426	Lenoir	North Carolina	United States
20427	Lexington	North Carolina	United States
20428	Lumberton	North Carolina	United States
20429	Matthews	North Carolina	United States
20430	Mint Hill	North Carolina	United States
20431	Monroe	North Carolina	United States
20432	Mooresville	North Carolina	United States
20433	Morganton	North Carolina	United States
20434	Morrisville	North Carolina	United States
20435	New Bern	North Carolina	United States
20436	Raleigh	North Carolina	United States
20437	Roanoke Rapids	North Carolina	United States
20438	Rocky Mount	North Carolina	United States
20439	Salisbury	North Carolina	United States
20440	Sanford	North Carolina	United States
20441	Shelby	North Carolina	United States
20442	Statesville	North Carolina	United States
20443	Thomasville	North Carolina	United States
20444	Wake Forest	North Carolina	United States
20445	West Raleigh	North Carolina	United States
20446	Wilmington	North Carolina	United States
20447	Wilson	North Carolina	United States
20448	Winston-Salem	North Carolina	United States
20449	Atlantic City	New Jersey	United States
20450	Bridgeton	New Jersey	United States
20451	Camden	New Jersey	United States
20452	Cherry Hill	New Jersey	United States
20453	Glassboro	New Jersey	United States
20454	Jackson	New Jersey	United States
20455	Lindenwold	New Jersey	United States
20456	Maple Shade	New Jersey	United States
20457	Millville	New Jersey	United States
20458	Mount Laurel	New Jersey	United States
20459	Ocean Acres	New Jersey	United States
20460	Pennsauken	New Jersey	United States
20461	Pleasantville	New Jersey	United States
20462	Sicklerville	New Jersey	United States
20463	South Vineland	New Jersey	United States
20464	Toms River	New Jersey	United States
20465	Vineland	New Jersey	United States
20466	Williamstown	New Jersey	United States
20467	Athens	Ohio	United States
20468	Beavercreek	Ohio	United States
20469	Centerville	Ohio	United States
20470	Cincinnati	Ohio	United States
20471	Columbus	Ohio	United States
20472	Dayton	Ohio	United States
20473	Fairborn	Ohio	United States
20474	Fairfield	Ohio	United States
20475	Forest Park	Ohio	United States
20476	Grove City	Ohio	United States
20477	Hamilton	Ohio	United States
20478	Huber Heights	Ohio	United States
20479	Kettering	Ohio	United States
20480	Lancaster	Ohio	United States
20481	Lebanon	Ohio	United States
20482	Mason	Ohio	United States
20483	Miamisburg	Ohio	United States
20484	Middletown	Ohio	United States
20485	Norwood	Ohio	United States
20486	Oxford	Ohio	United States
20488	Portsmouth	Ohio	United States
20489	Reynoldsburg	Ohio	United States
20490	Riverside	Ohio	United States
20491	Springboro	Ohio	United States
20492	Springfield	Ohio	United States
20493	Trotwood	Ohio	United States
20494	Upper Arlington	Ohio	United States
20495	Vandalia	Ohio	United States
20496	White Oak	Ohio	United States
20497	Whitehall	Ohio	United States
20498	Xenia	Ohio	United States
20499	Zanesville	Ohio	United States
20500	Ada	Oklahoma	United States
20501	Altus	Oklahoma	United States
20502	Ardmore	Oklahoma	United States
20503	Bartlesville	Oklahoma	United States
20504	Bethany	Oklahoma	United States
20505	Bixby	Oklahoma	United States
20506	Broken Arrow	Oklahoma	United States
20507	Chickasha	Oklahoma	United States
20508	Claremore	Oklahoma	United States
20509	Del City	Oklahoma	United States
20510	Duncan	Oklahoma	United States
20511	Durant	Oklahoma	United States
20512	Edmond	Oklahoma	United States
20513	El Reno	Oklahoma	United States
20514	Enid	Oklahoma	United States
20515	Jenks	Oklahoma	United States
20516	Lawton	Oklahoma	United States
20517	McAlester	Oklahoma	United States
20518	Midwest City	Oklahoma	United States
20519	Moore	Oklahoma	United States
20520	Muskogee	Oklahoma	United States
20521	Mustang	Oklahoma	United States
20522	Norman	Oklahoma	United States
20523	Oklahoma City	Oklahoma	United States
20524	Owasso	Oklahoma	United States
20525	Ponca City	Oklahoma	United States
20526	Sand Springs	Oklahoma	United States
20527	Sapulpa	Oklahoma	United States
20528	Shawnee	Oklahoma	United States
20529	Stillwater	Oklahoma	United States
20530	Tahlequah	Oklahoma	United States
20531	Tulsa	Oklahoma	United States
20532	Yukon	Oklahoma	United States
20533	Chambersburg	Pennsylvania	United States
20534	Chester	Pennsylvania	United States
20535	Drexel Hill	Pennsylvania	United States
20536	Hanover	Pennsylvania	United States
20537	Philadelphia	Pennsylvania	United States
20538	Springfield	Pennsylvania	United States
20539	West Chester	Pennsylvania	United States
20540	York	Pennsylvania	United States
20541	Aiken	South Carolina	United States
20542	Anderson	South Carolina	United States
20543	Charleston	South Carolina	United States
20544	Columbia	South Carolina	United States
20545	Conway	South Carolina	United States
20546	Easley	South Carolina	United States
20547	Florence	South Carolina	United States
20548	Goose Creek	South Carolina	United States
20549	Greenville	South Carolina	United States
20550	Greenwood	South Carolina	United States
20551	Greer	South Carolina	United States
20552	Hanahan	South Carolina	United States
20553	Hilton Head Island	South Carolina	United States
20554	Lexington	South Carolina	United States
20555	Mauldin	South Carolina	United States
20556	Mount Pleasant	South Carolina	United States
20557	Myrtle Beach	South Carolina	United States
20558	North Augusta	South Carolina	United States
20559	North Charleston	South Carolina	United States
20560	Rock Hill	South Carolina	United States
20561	Saint Andrews	South Carolina	United States
20562	Seven Oaks	South Carolina	United States
20563	Simpsonville	South Carolina	United States
20564	Socastee	South Carolina	United States
20565	Spartanburg	South Carolina	United States
20566	Summerville	South Carolina	United States
20567	Sumter	South Carolina	United States
20568	Taylors	South Carolina	United States
20569	Wade Hampton	South Carolina	United States
20570	Bartlett	Tennessee	United States
20571	Brentwood	Tennessee	United States
20572	Brentwood Estates	Tennessee	United States
20573	Bristol	Tennessee	United States
20574	Chattanooga	Tennessee	United States
20575	Clarksville	Tennessee	United States
20576	Cleveland	Tennessee	United States
20577	Collierville	Tennessee	United States
20578	Columbia	Tennessee	United States
20579	Cookeville	Tennessee	United States
20580	Dyersburg	Tennessee	United States
20581	East Brainerd	Tennessee	United States
20582	East Chattanooga	Tennessee	United States
20583	East Ridge	Tennessee	United States
20584	Farragut	Tennessee	United States
20585	Franklin	Tennessee	United States
20586	Gallatin	Tennessee	United States
20587	Germantown	Tennessee	United States
20588	Goodlettsville	Tennessee	United States
20589	Greeneville	Tennessee	United States
20590	Hendersonville	Tennessee	United States
20591	Jackson	Tennessee	United States
20592	Johnson City	Tennessee	United States
20593	Kingsport	Tennessee	United States
20594	Knoxville	Tennessee	United States
20595	La Vergne	Tennessee	United States
20596	Lebanon	Tennessee	United States
20597	Maryville	Tennessee	United States
20598	Memphis	Tennessee	United States
20599	Morristown	Tennessee	United States
20600	Mount Juliet	Tennessee	United States
20601	Murfreesboro	Tennessee	United States
20602	Nashville	Tennessee	United States
20603	New South Memphis	Tennessee	United States
20604	Oak Ridge	Tennessee	United States
20605	Shelbyville	Tennessee	United States
20606	Smyrna	Tennessee	United States
20607	Spring Hill	Tennessee	United States
20608	Springfield	Tennessee	United States
20609	Tullahoma	Tennessee	United States
20610	Abilene	Texas	United States
20611	Alamo	Texas	United States
20612	Aldine	Texas	United States
20613	Alice	Texas	United States
20614	Allen	Texas	United States
20615	Alvin	Texas	United States
20616	Angleton	Texas	United States
20617	Arlington	Texas	United States
20618	Atascocita	Texas	United States
20619	Austin	Texas	United States
20620	Balch Springs	Texas	United States
20621	Baytown	Texas	United States
20622	Beaumont	Texas	United States
20623	Bedford	Texas	United States
20624	Bellaire	Texas	United States
20625	Belton	Texas	United States
20626	Benbrook	Texas	United States
20627	Brenham	Texas	United States
20628	Brownsville	Texas	United States
20629	Brownwood	Texas	United States
20630	Brushy Creek	Texas	United States
20631	Bryan	Texas	United States
20632	Burleson	Texas	United States
20633	Canyon Lake	Texas	United States
20634	Carrollton	Texas	United States
20635	Cedar Hill	Texas	United States
20636	Cedar Park	Texas	United States
20637	Channelview	Texas	United States
20638	Cibolo	Texas	United States
20639	Cinco Ranch	Texas	United States
20640	Cleburne	Texas	United States
20641	Cloverleaf	Texas	United States
20642	College Station	Texas	United States
20643	Colleyville	Texas	United States
20644	Conroe	Texas	United States
20645	Converse	Texas	United States
20646	Coppell	Texas	United States
20647	Copperas Cove	Texas	United States
20648	Corinth	Texas	United States
20649	Corpus Christi	Texas	United States
20650	Corsicana	Texas	United States
20651	Cypress	Texas	United States
20652	Dallas	Texas	United States
20653	DeSoto	Texas	United States
20654	Deer Park	Texas	United States
20655	Denison	Texas	United States
20656	Denton	Texas	United States
20657	Dickinson	Texas	United States
20658	Donna	Texas	United States
20659	Duncanville	Texas	United States
20660	Edinburg	Texas	United States
20661	Ennis	Texas	United States
20662	Euless	Texas	United States
20663	Farmers Branch	Texas	United States
20664	Flower Mound	Texas	United States
20665	Fort Worth	Texas	United States
20666	Fresno	Texas	United States
20667	Friendswood	Texas	United States
20668	Frisco	Texas	United States
20669	Gainesville	Texas	United States
20670	Galveston	Texas	United States
20671	Garland	Texas	United States
20672	Gatesville	Texas	United States
20673	Georgetown	Texas	United States
20674	Grand Prairie	Texas	United States
20675	Grapevine	Texas	United States
20676	Greenville	Texas	United States
20677	Groves	Texas	United States
20678	Haltom City	Texas	United States
20679	Harker Heights	Texas	United States
20680	Harlingen	Texas	United States
20681	Highland Village	Texas	United States
20682	Houston	Texas	United States
20683	Humble	Texas	United States
20684	Huntsville	Texas	United States
20685	Hurst	Texas	United States
20686	Irving	Connecticut	United States
20687	West Hartford	Connecticut	United States
20688	West Haven	Connecticut	United States
20689	West Torrington	Connecticut	United States
20690	Westport	Connecticut	United States
20691	Wethersfield	Connecticut	United States
20692	Willimantic	Connecticut	United States
20693	Wilton	Connecticut	United States
20694	Windham	Connecticut	United States
20695	Windsor	Connecticut	United States
20696	Wolcott	Connecticut	United States
20697	Ames	Iowa	United States
20698	Ankeny	Iowa	United States
20699	Bettendorf	Iowa	United States
20700	Burlington	Iowa	United States
20701	Cedar Falls	Iowa	United States
20702	Cedar Rapids	Iowa	United States
20703	Clinton	Iowa	United States
20704	Clive	Iowa	United States
20705	Coralville	Iowa	United States
20706	Council Bluffs	Iowa	United States
20707	Davenport	Iowa	United States
20708	Des Moines	Iowa	United States
20709	Dubuque	Iowa	United States
20710	Fort Dodge	Iowa	United States
20711	Iowa City	Iowa	United States
20712	Johnston	Iowa	United States
20713	Marion	Iowa	United States
20714	Marshalltown	Iowa	United States
20715	Mason City	Iowa	United States
20716	Muscatine	Iowa	United States
20717	Newton	Iowa	United States
20718	Ottumwa	Iowa	United States
20719	Sioux City	Iowa	United States
20720	Urbandale	Iowa	United States
20721	Waterloo	Iowa	United States
20722	West Des Moines	Iowa	United States
20723	Addison	Illinois	United States
20724	Algonquin	Illinois	United States
20725	Alsip	Illinois	United States
20726	Arlington Heights	Illinois	United States
20727	Aurora	Illinois	United States
20728	Bartlett	Illinois	United States
20729	Batavia	Illinois	United States
20730	Bellwood	Illinois	United States
20731	Belvidere	Illinois	United States
20732	Bensenville	Illinois	United States
20733	Berwyn	Illinois	United States
20734	Bloomingdale	Illinois	United States
20735	Bloomington	Illinois	United States
20736	Blue Island	Illinois	United States
20737	Bolingbrook	Illinois	United States
20738	Bourbonnais	Illinois	United States
20739	Bradley	Illinois	United States
20740	Bridgeview	Illinois	United States
20741	Brookfield	Illinois	United States
20742	Buffalo Grove	Illinois	United States
20743	Burbank	Illinois	United States
20744	Calumet City	Illinois	United States
20745	Carol Stream	Illinois	United States
20746	Carpentersville	Illinois	United States
20747	Cary	Illinois	United States
20748	Champaign	Illinois	United States
20749	Chicago	Illinois	United States
20750	Chicago Heights	Illinois	United States
20751	Cicero	Illinois	United States
20752	Country Club Hills	Illinois	United States
20753	Crest Hill	Illinois	United States
20754	Crystal Lake	Illinois	United States
20755	Danville	Illinois	United States
20756	Darien	Illinois	United States
20757	DeKalb	Illinois	United States
20758	Deerfield	Illinois	United States
20759	Des Plaines	Illinois	United States
20760	Dixon	Illinois	United States
20761	Dolton	Illinois	United States
20762	Downers Grove	Illinois	United States
20763	East Moline	Illinois	United States
20764	East Peoria	Illinois	United States
20765	Elgin	Illinois	United States
20766	Elk Grove Village	Illinois	United States
20767	Elmhurst	Illinois	United States
20768	Elmwood Park	Illinois	United States
20769	Evanston	Illinois	United States
20770	Evergreen Park	Illinois	United States
20771	Frankfort	Illinois	United States
20772	Franklin Park	Illinois	United States
20773	Freeport	Illinois	United States
20774	Galesburg	Illinois	United States
20775	Geneva	Illinois	United States
20776	Glen Ellyn	Illinois	United States
20777	Glenview	Illinois	United States
20778	Goodings Grove	Illinois	United States
20779	Grayslake	Illinois	United States
20780	Gurnee	Illinois	United States
20781	Hanover Park	Illinois	United States
20782	Harvey	Illinois	United States
20783	Highland Park	Illinois	United States
20784	Hinsdale	Illinois	United States
20785	Hoffman Estates	Illinois	United States
20786	Homer Glen	Illinois	United States
20787	Homewood	Illinois	United States
20788	Huntley	Illinois	United States
20789	Joliet	Illinois	United States
20790	Kankakee	Illinois	United States
20791	La Grange	Illinois	United States
20792	Lake Forest	Illinois	United States
20793	Lake Zurich	Illinois	United States
20794	Lake in the Hills	Illinois	United States
20795	Lansing	Illinois	United States
20796	Lemont	Illinois	United States
20797	Libertyville	Illinois	United States
20798	Lisle	Illinois	United States
20799	Lockport	Illinois	United States
20800	Lombard	Illinois	United States
20801	Loves Park	Illinois	United States
20802	Machesney Park	Illinois	United States
20803	Macomb	Illinois	United States
20804	Matteson	Illinois	United States
20805	Maywood	Illinois	United States
20806	McHenry	Illinois	United States
20807	Melrose Park	Illinois	United States
20808	Mokena	Illinois	United States
20809	Moline	Illinois	United States
20810	Montgomery	Illinois	United States
20811	Morton	Illinois	United States
20812	Morton Grove	Illinois	United States
20813	Mount Prospect	Illinois	United States
20814	Mundelein	Illinois	United States
20815	Naperville	Illinois	United States
20816	New Lenox	Illinois	United States
20817	Niles	Illinois	United States
20818	Normal	Illinois	United States
20819	North Aurora	Illinois	United States
20820	North Chicago	Illinois	United States
20821	North Peoria	Illinois	United States
20822	Northbrook	Illinois	United States
20823	Oak Forest	Illinois	United States
20824	Oak Lawn	Illinois	United States
20825	Oak Park	Illinois	United States
20826	Orland Park	Illinois	United States
20827	Oswego	Illinois	United States
20828	Ottawa	Illinois	United States
20829	Palatine	Illinois	United States
20830	Palos Hills	Illinois	United States
20831	Park Forest	Illinois	United States
20832	Park Ridge	Illinois	United States
20833	Pekin	Illinois	United States
20834	Peoria	Illinois	United States
20835	Plainfield	Illinois	United States
20836	Prospect Heights	Illinois	United States
20837	Rock Island	Illinois	United States
20838	Rockford	Illinois	United States
20839	Rolling Meadows	Illinois	United States
20840	Romeoville	Illinois	United States
20841	Roselle	Illinois	United States
20842	Round Lake	Illinois	United States
20843	Round Lake Beach	Illinois	United States
20844	Saint Charles	Illinois	United States
20845	Schaumburg	Illinois	United States
20846	Shorewood	Illinois	United States
20847	Skokie	Illinois	United States
20848	South Elgin	Illinois	United States
20849	South Holland	Illinois	United States
20850	Sterling	Illinois	United States
20851	Streamwood	Illinois	United States
20852	Sycamore	Illinois	United States
20853	Tinley Park	Illinois	United States
20854	Urbana	Illinois	United States
20855	Vernon Hills	Illinois	United States
20856	Villa Park	Illinois	United States
20857	Wasco	Illinois	United States
20858	Washington	Illinois	United States
20859	Waukegan	Illinois	United States
20860	West Chicago	Illinois	United States
20861	Westchester	Illinois	United States
20862	Westmont	Illinois	United States
20863	Wheaton	Illinois	United States
20864	Wheeling	Illinois	United States
20865	Wilmette	Illinois	United States
20866	Woodridge	Illinois	United States
20867	Woodstock	Illinois	United States
20868	Yorkville	Illinois	United States
20869	Zion	Illinois	United States
20870	Anderson	Indiana	United States
20871	Crawfordsville	Indiana	United States
20872	Crown Point	Indiana	United States
20873	Dyer	Indiana	United States
20874	East Chicago	Indiana	United States
20875	Elkhart	Indiana	United States
20876	Fort Wayne	Indiana	United States
20877	Frankfort	Indiana	United States
20878	Gary	Indiana	United States
20879	Goshen	Indiana	United States
20880	Granger	Indiana	United States
20881	Griffith	Indiana	United States
20882	Hammond	Indiana	United States
20883	Highland	Indiana	United States
20884	Hobart	Indiana	United States
20885	Huntington	Indiana	United States
20886	Kokomo	Indiana	United States
20887	LaPorte	Indiana	United States
20888	Lafayette	Indiana	United States
20889	Lebanon	Indiana	United States
20890	Logansport	Indiana	United States
20891	Marion	Indiana	United States
20892	Merrillville	Indiana	United States
20893	Michigan City	Indiana	United States
20894	Mishawaka	Indiana	United States
20895	Muncie	Indiana	United States
20896	Munster	Indiana	United States
20897	Noblesville	Indiana	United States
20898	Portage	Indiana	United States
20899	Schererville	Indiana	United States
20900	South Bend	Indiana	United States
20901	Valparaiso	Indiana	United States
20902	West Lafayette	Indiana	United States
20903	Westfield	Indiana	United States
20904	Abington	Massachusetts	United States
20905	Acton	Massachusetts	United States
20906	Agawam	Massachusetts	United States
20907	Amesbury	Massachusetts	United States
20908	Amherst Center	Massachusetts	United States
20909	Arlington	Massachusetts	United States
20910	Ashland	Massachusetts	United States
20911	Attleboro	Massachusetts	United States
20912	Auburn	Massachusetts	United States
20913	Barnstable	Massachusetts	United States
20914	Belmont	Massachusetts	United States
20915	Beverly	Massachusetts	United States
20916	Beverly Cove	Massachusetts	United States
20917	Billerica	Massachusetts	United States
20918	Boston	Massachusetts	United States
20919	Braintree	Massachusetts	United States
20920	Brockton	Massachusetts	United States
20921	Brookline	Massachusetts	United States
20922	Burlington	Massachusetts	United States
20923	Cambridge	Massachusetts	United States
20924	Canton	Massachusetts	United States
20925	Chelmsford	Massachusetts	United States
20926	Chelsea	Massachusetts	United States
20927	Chicopee	Massachusetts	United States
20928	Concord	Massachusetts	United States
20929	Danvers	Massachusetts	United States
20930	Dedham	Massachusetts	United States
20931	Dracut	Massachusetts	United States
20932	East Longmeadow	Massachusetts	United States
20933	Easthampton	Massachusetts	United States
20934	Easton	Massachusetts	United States
20935	Everett	Massachusetts	United States
20936	Fairhaven	Massachusetts	United States
20937	Fall River	Massachusetts	United States
20938	Fitchburg	Massachusetts	United States
20939	Framingham	Massachusetts	United States
20940	Framingham Center	Massachusetts	United States
20941	Franklin	Massachusetts	United States
20942	Gardner	Massachusetts	United States
20943	Gloucester	Massachusetts	United States
20944	Grafton	Massachusetts	United States
20945	Greenfield	Massachusetts	United States
20946	Hanover	Massachusetts	United States
20947	Haverhill	Massachusetts	United States
20948	Holden	Massachusetts	United States
20949	Holyoke	Massachusetts	United States
20950	Jamaica Plain	Massachusetts	United States
20951	Lawrence	Massachusetts	United States
20952	Leominster	Massachusetts	United States
20953	Lexington	Massachusetts	United States
20954	Longmeadow	Massachusetts	United States
20955	Lowell	Massachusetts	United States
20956	Ludlow	Massachusetts	United States
20957	Lynn	Massachusetts	United States
20958	Malden	Massachusetts	United States
20959	Mansfield	Massachusetts	United States
20960	Marblehead	Massachusetts	United States
20961	Marlborough	Massachusetts	United States
20962	Medford	Massachusetts	United States
20963	Melrose	Massachusetts	United States
20964	Methuen	Massachusetts	United States
20965	Milford	Massachusetts	United States
20966	Milton	Massachusetts	United States
20967	Natick	Massachusetts	United States
20968	Needham	Massachusetts	United States
20969	New Bedford	Massachusetts	United States
20970	Newburyport	Massachusetts	United States
20971	Newton	Massachusetts	United States
20972	North Chicopee	Massachusetts	United States
20973	Northampton	Massachusetts	United States
20974	Norton	Massachusetts	United States
20975	Norwood	Massachusetts	United States
20976	Palmer	Massachusetts	United States
20977	Peabody	Massachusetts	United States
20978	Pittsfield	Massachusetts	United States
20979	Quincy	Massachusetts	United States
20980	Randolph	Massachusetts	United States
20981	Reading	Massachusetts	United States
20982	Rockland	Massachusetts	United States
20983	Salem	Massachusetts	United States
20984	Saugus	Massachusetts	United States
20985	Shrewsbury	Massachusetts	United States
20986	Somerset	Massachusetts	United States
20987	Somerville	Massachusetts	United States
20988	South Boston	Massachusetts	United States
20989	South Hadley	Massachusetts	United States
20990	South Peabody	Massachusetts	United States
20991	Southbridge	Massachusetts	United States
20992	Springfield	Massachusetts	United States
20993	Stoneham	Massachusetts	United States
20994	Stoughton	Massachusetts	United States
20995	Sudbury	Massachusetts	United States
20996	Swansea	Massachusetts	United States
20997	Taunton	Massachusetts	United States
20998	Tewksbury	Massachusetts	United States
20999	Wakefield	Massachusetts	United States
21000	Waltham	Massachusetts	United States
21001	Watertown	Massachusetts	United States
21002	Wellesley	Massachusetts	United States
21003	West Springfield	Massachusetts	United States
21004	Westfield	Massachusetts	United States
21005	Westford	Massachusetts	United States
21006	Weymouth	Massachusetts	United States
21007	Wilmington	Massachusetts	United States
21008	Winchester	Massachusetts	United States
21009	Winthrop	Massachusetts	United States
21010	Woburn	Massachusetts	United States
21011	Worcester	Massachusetts	United States
21012	Yarmouth	Massachusetts	United States
21013	Auburn	Maine	United States
21014	Augusta	Maine	United States
21015	Bangor	Maine	United States
21016	Biddeford	Maine	United States
21017	Brunswick	Maine	United States
21018	Lewiston	Maine	United States
21019	Portland	Maine	United States
21020	Saco	Maine	United States
21021	South Portland	Maine	United States
21022	South Portland Gardens	Maine	United States
21023	Waterville	Maine	United States
21024	West Scarborough	Maine	United States
21025	Westbrook	Maine	United States
21026	Adrian	Michigan	United States
21027	Allen Park	Michigan	United States
21028	Allendale	Michigan	United States
21029	Ann Arbor	Michigan	United States
21030	Auburn Hills	Michigan	United States
21031	Battle Creek	Michigan	United States
21032	Bay City	Michigan	United States
21033	Birmingham	Michigan	United States
21034	Burton	Michigan	United States
21035	Canton	Michigan	United States
21036	Clinton	Michigan	United States
21037	Dearborn	Michigan	United States
21038	Dearborn Heights	Michigan	United States
21039	Detroit	Michigan	United States
21040	East Lansing	Michigan	United States
21041	Eastpointe	Michigan	United States
21042	Farmington Hills	Michigan	United States
21043	Ferndale	Michigan	United States
21044	Flint	Michigan	United States
21045	Forest Hills	Michigan	United States
21046	Garden City	Michigan	United States
21047	Grand Rapids	Michigan	United States
21048	Grandville	Michigan	United States
21049	Grosse Pointe Woods	Michigan	United States
21050	Hamtramck	Michigan	United States
21051	Haslett	Michigan	United States
21052	Hazel Park	Michigan	United States
21053	Holland	Michigan	United States
21054	Holt	Michigan	United States
21055	Iron River	Michigan	United States
21056	Jackson	Michigan	United States
21057	Jenison	Michigan	United States
21058	Kalamazoo	Michigan	United States
21059	Kentwood	Michigan	United States
21060	Lansing	Michigan	United States
21061	Lincoln Park	Michigan	United States
21062	Livonia	Michigan	United States
21063	Madison Heights	Michigan	United States
21064	Marquette	Michigan	United States
21065	Midland	Michigan	United States
21066	Monroe	Michigan	United States
21067	Mount Clemens	Michigan	United States
21068	Mount Pleasant	Michigan	United States
21069	Muskegon	Michigan	United States
21070	Norton Shores	Michigan	United States
21071	Novi	Michigan	United States
21072	Oak Park	Michigan	United States
21073	Okemos	Michigan	United States
21074	Owosso	Michigan	United States
21075	Pontiac	Michigan	United States
21076	Port Huron	Michigan	United States
21077	Portage	Michigan	United States
21078	Redford	Michigan	United States
21079	Rochester Hills	Michigan	United States
21080	Romulus	Michigan	United States
21081	Roseville	Michigan	United States
21082	Royal Oak	Michigan	United States
21083	Saginaw	Michigan	United States
21084	Shelby	Michigan	United States
21085	Southfield	Michigan	United States
21086	Southgate	Michigan	United States
21087	Saint Clair Shores	Michigan	United States
21088	Sterling Heights	Michigan	United States
21089	Taylor	Michigan	United States
21090	Trenton	Michigan	United States
21091	Troy	Michigan	United States
21092	Walker	Michigan	United States
21093	Warren	Michigan	United States
21094	Waterford	Michigan	United States
21095	Waverly	Michigan	United States
21096	Wayne	Michigan	United States
21097	Westland	Michigan	United States
21098	Wyandotte	Michigan	United States
21099	Wyoming	Michigan	United States
21100	Ypsilanti	Michigan	United States
21101	Albert Lea	Minnesota	United States
21102	Andover	Minnesota	United States
21103	Anoka	Minnesota	United States
21104	Apple Valley	Minnesota	United States
21105	Austin	Minnesota	United States
21106	Blaine	Minnesota	United States
21107	Bloomington	Minnesota	United States
21108	Brooklyn Center	Minnesota	United States
21109	Brooklyn Park	Minnesota	United States
21110	Buffalo	Minnesota	United States
21111	Burnsville	Minnesota	United States
21112	Champlin	Minnesota	United States
21113	Chanhassen	Minnesota	United States
21114	Chaska	Minnesota	United States
21115	Columbia Heights	Minnesota	United States
21116	Coon Rapids	Minnesota	United States
21117	Cottage Grove	Minnesota	United States
21118	Crystal	Minnesota	United States
21119	Duluth	Minnesota	United States
21120	Eagan	Minnesota	United States
21121	Eden Prairie	Minnesota	United States
21122	Edina	Minnesota	United States
21123	Elk River	Minnesota	United States
21124	Faribault	Minnesota	United States
21125	Farmington	Minnesota	United States
21126	Forest Lake	Minnesota	United States
21127	Fridley	Minnesota	United States
21128	Golden Valley	Minnesota	United States
21129	Ham Lake	Minnesota	United States
21130	Hastings	Minnesota	United States
21131	Hibbing	Minnesota	United States
21132	Hopkins	Minnesota	United States
21133	Inver Grove Heights	Minnesota	United States
21134	Lakeville	Minnesota	United States
21135	Lino Lakes	Minnesota	United States
21136	Mankato	Minnesota	United States
21137	Maple Grove	Minnesota	United States
21138	Maplewood	Minnesota	United States
21139	Minneapolis	Minnesota	United States
21140	Minnetonka	Minnesota	United States
21141	Minnetonka Mills	Minnesota	United States
21142	Moorhead	Minnesota	United States
21143	New Brighton	Minnesota	United States
21144	New Hope	Minnesota	United States
21145	Northfield	Minnesota	United States
21146	Oakdale	Minnesota	United States
21147	Owatonna	Minnesota	United States
21148	Plymouth	Minnesota	United States
21149	Prior Lake	Minnesota	United States
21150	Ramsey	Minnesota	United States
21151	Red Wing	Minnesota	United States
21152	Richfield	Minnesota	United States
21153	Rochester	Minnesota	United States
21154	Rosemount	Minnesota	United States
21155	Roseville	Minnesota	United States
21156	Saint Cloud	Minnesota	United States
21157	Saint Louis Park	Minnesota	United States
21158	Saint Michael	Minnesota	United States
21159	Saint Paul	Minnesota	United States
21160	Sartell	Minnesota	United States
21161	Savage	Minnesota	United States
21162	Shakopee	Minnesota	United States
21163	Shoreview	Minnesota	United States
21164	South Saint Paul	Minnesota	United States
21165	Stillwater	Minnesota	United States
21166	West Coon Rapids	Minnesota	United States
21167	West Saint Paul	Minnesota	United States
21168	White Bear Lake	Minnesota	United States
21169	Willmar	Minnesota	United States
21170	Winona	Minnesota	United States
21171	Woodbury	Minnesota	United States
21172	Kirksville	Missouri	United States
21173	Fargo	North Dakota	United States
21174	Grand Forks	North Dakota	United States
21175	Jamestown	North Dakota	United States
21176	West Fargo	North Dakota	United States
21177	Bellevue	Nebraska	United States
21178	Columbus	Nebraska	United States
21179	Fremont	Nebraska	United States
21180	Grand Island	Nebraska	United States
21181	Hastings	Nebraska	United States
21182	Kearney	Nebraska	United States
21183	La Vista	Nebraska	United States
21184	Lincoln	Nebraska	United States
21185	Norfolk	Nebraska	United States
21186	Omaha	Nebraska	United States
21187	Papillion	Nebraska	United States
21188	Bedford	New Hampshire	United States
21189	Concord	New Hampshire	United States
21190	Derry	New Hampshire	United States
21191	Derry Village	New Hampshire	United States
21192	Dover	New Hampshire	United States
21193	East Concord	New Hampshire	United States
21194	Keene	New Hampshire	United States
21195	Laconia	New Hampshire	United States
21196	Manchester	New Hampshire	United States
21197	Merrimack	New Hampshire	United States
21198	Nashua	New Hampshire	United States
21199	Portsmouth	New Hampshire	United States
21200	Rochester	New Hampshire	United States
21201	Salem	New Hampshire	United States
21202	Asbury Park	New Jersey	United States
21203	Avenel	New Jersey	United States
21204	Bayonne	New Jersey	United States
21205	Belleville	New Jersey	United States
21206	Bergenfield	New Jersey	United States
21207	Bloomfield	New Jersey	United States
21208	Carteret	New Jersey	United States
21209	Cliffside Park	New Jersey	United States
21210	Clifton	New Jersey	United States
21211	Colonia	New Jersey	United States
21212	Cranford	New Jersey	United States
21213	Dover	New Jersey	United States
21214	Dumont	New Jersey	United States
21215	East Brunswick	New Jersey	United States
21216	East Orange	New Jersey	United States
21217	Edison	New Jersey	United States
21218	Elizabeth	New Jersey	United States
21219	Elmwood Park	New Jersey	United States
21220	Englewood	New Jersey	United States
21221	Ewing	New Jersey	United States
21222	Fair Lawn	New Jersey	United States
21223	Fords	New Jersey	United States
21224	Fort Lee	New Jersey	United States
21225	Garfield	New Jersey	United States
21226	Hackensack	New Jersey	United States
21227	Hawthorne	New Jersey	United States
21228	Hillside	New Jersey	United States
21229	Hoboken	New Jersey	United States
21230	Hopatcong	New Jersey	United States
21231	Hopatcong Hills	New Jersey	United States
21232	Irvington	New Jersey	United States
21233	Iselin	New Jersey	United States
21234	Jersey City	New Jersey	United States
21235	Kearny	New Jersey	United States
21236	Lakewood	New Jersey	United States
21237	Linden	New Jersey	United States
21238	Livingston	New Jersey	United States
21239	Lodi	New Jersey	United States
21240	Long Branch	New Jersey	United States
21241	Lyndhurst	New Jersey	United States
21242	Madison	New Jersey	United States
21243	Mahwah	New Jersey	United States
21244	Maplewood	New Jersey	United States
21245	Marlboro	New Jersey	United States
21246	Montclair	New Jersey	United States
21247	Morristown	New Jersey	United States
21248	New Brunswick	New Jersey	United States
21249	New Milford	New Jersey	United States
21250	Newark	New Jersey	United States
21251	North Arlington	New Jersey	United States
21252	North Bergen	New Jersey	United States
21253	North Plainfield	New Jersey	United States
21254	Nutley	New Jersey	United States
21255	Old Bridge	New Jersey	United States
21256	Orange	New Jersey	United States
21257	Palisades Park	New Jersey	United States
21258	Paramus	New Jersey	United States
21259	Parsippany	New Jersey	United States
21260	Passaic	New Jersey	United States
21261	Paterson	New Jersey	United States
21262	Perth Amboy	New Jersey	United States
21263	Piscataway	New Jersey	United States
21264	Plainfield	New Jersey	United States
21265	Point Pleasant	New Jersey	United States
21266	Rahway	New Jersey	United States
21267	Ridgewood	New Jersey	United States
21268	Roselle	New Jersey	United States
21269	Rutherford	New Jersey	United States
21270	Sayreville	New Jersey	United States
21271	Sayreville Junction	New Jersey	United States
21272	Scotch Plains	New Jersey	United States
21273	Secaucus	New Jersey	United States
21274	Somerset	New Jersey	United States
21275	South Old Bridge	New Jersey	United States
21276	South Orange	New Jersey	United States
21277	South Plainfield	New Jersey	United States
21278	South River	New Jersey	United States
21279	Summit	New Jersey	United States
21280	Teaneck	New Jersey	United States
21281	Tinton Falls	New Jersey	United States
21282	Trenton	New Jersey	United States
21283	Union	New Jersey	United States
21284	Union City	New Jersey	United States
21285	Wayne	New Jersey	United States
21286	West Milford	New Jersey	United States
21287	West New York	New Jersey	United States
21288	West Orange	New Jersey	United States
21289	Westfield	New Jersey	United States
21290	Willingboro	New Jersey	United States
21291	Woodbridge	New Jersey	United States
21292	Wyckoff	New Jersey	United States
21293	Albany	New York	United States
21294	Amherst	New York	United States
21295	Amsterdam	New York	United States
21296	Auburn	New York	United States
21297	Baldwin	New York	United States
21298	Batavia	New York	United States
21299	Bay Shore	New York	United States
21300	Beacon	New York	United States
21301	Bellmore	New York	United States
21302	Bensonhurst	New York	United States
21303	Bethpage	New York	United States
21304	Binghamton	New York	United States
21305	Brentwood	New York	United States
21306	Brighton	New York	United States
21307	The Bronx	New York	United States
21308	Brooklyn	New York	United States
21309	Buffalo	New York	United States
21310	Centereach	New York	United States
21311	Central Islip	New York	United States
21312	Cheektowaga	New York	United States
21313	Cohoes	New York	United States
21314	Commack	New York	United States
21315	Coney Island	New York	United States
21316	Copiague	New York	United States
21317	Coram	New York	United States
21318	Cortland	New York	United States
21319	Deer Park	New York	United States
21320	Depew	New York	United States
21321	Dix Hills	New York	United States
21322	East Meadow	New York	United States
21323	East Massapequa	New York	United States
21324	East New York	New York	United States
21325	East Northport	New York	United States
21326	East Patchogue	New York	United States
21327	East Setauket	New York	United States
21328	Eastchester	New York	United States
21329	Eggertsville	New York	United States
21330	Elmira	New York	United States
21331	Elmont	New York	United States
21332	Farmingville	New York	United States
21333	Floral Park	New York	United States
21334	Franklin Square	New York	United States
21335	Freeport	New York	United States
21336	Garden City	New York	United States
21337	Glen Cove	New York	United States
21338	Gloversville	New York	United States
21339	Greenburgh	New York	United States
21340	Harrison	New York	United States
21341	Hauppauge	New York	United States
21342	Hempstead	New York	United States
21343	Hicksville	New York	United States
21344	Holbrook	New York	United States
21345	Holtsville	New York	United States
21346	Huntington	New York	United States
21347	Huntington Station	New York	United States
21348	Irondequoit	New York	United States
21349	Islip	New York	United States
21350	Ithaca	New York	United States
21351	Jamaica	New York	United States
21352	Jamestown	New York	United States
21353	Johnson City	New York	United States
21354	Kenmore	New York	United States
21355	Kings Park	New York	United States
21356	Kingston	New York	United States
21357	Kiryas Joel	New York	United States
21358	Lackawanna	New York	United States
21359	Lake Ronkonkoma	New York	United States
21360	Levittown	New York	United States
21361	Lindenhurst	New York	United States
21362	Lockport	New York	United States
21363	Long Beach	New York	United States
21364	Long Island City	New York	United States
21365	Lynbrook	New York	United States
21366	Mamaroneck	New York	United States
21367	Manhattan	New York	United States
21368	Massapequa	New York	United States
21369	Massapequa Park	New York	United States
21370	Mastic	New York	United States
21371	Medford	New York	United States
21372	Melville	New York	United States
21373	Merrick	New York	United States
21374	Middletown	New York	United States
21375	Mineola	New York	United States
21376	Monsey	New York	United States
21377	Mount Vernon	New York	United States
21378	Nanuet	New York	United States
21379	New City	New York	United States
21380	New Rochelle	New York	United States
21381	New York City	New York	United States
21382	Newburgh	New York	United States
21383	Niagara Falls	New York	United States
21384	North Amityville	New York	United States
21385	North Babylon	New York	United States
21386	North Bay Shore	New York	United States
21387	North Bellmore	New York	United States
21388	North Massapequa	New York	United States
21389	North Tonawanda	New York	United States
21390	North Valley Stream	New York	United States
21391	Oceanside	New York	United States
21392	Ossining	New York	United States
21393	Oswego	New York	United States
21394	Pearl River	New York	United States
21395	Peekskill	New York	United States
21396	Plainview	New York	United States
21397	Plattsburgh	New York	United States
21398	Port Chester	New York	United States
21399	Port Washington	New York	United States
21400	Poughkeepsie	New York	United States
21401	Borough of Queens	New York	United States
21402	Rochester	New York	United States
21403	Rockville Centre	New York	United States
21404	Rome	New York	United States
21405	Ronkonkoma	New York	United States
21406	Roosevelt	New York	United States
21407	Rotterdam	New York	United States
21408	Rye	New York	United States
21409	Saratoga Springs	New York	United States
21410	Sayville	New York	United States
21411	Scarsdale	New York	United States
21412	Schenectady	New York	United States
21413	Seaford	New York	United States
21414	Selden	New York	United States
21415	Shirley	New York	United States
21416	Smithtown	New York	United States
21417	Spring Valley	New York	United States
21418	Staten Island	New York	United States
21419	Syosset	New York	United States
21420	Syracuse	New York	United States
21421	Tonawanda	New York	United States
21422	Troy	New York	United States
21423	Uniondale	New York	United States
21424	Utica	New York	United States
21425	Valley Stream	New York	United States
21426	Wantagh	New York	United States
21427	Watertown	New York	United States
21428	West Albany	New York	United States
21429	West Babylon	New York	United States
21430	West Hempstead	New York	United States
21431	West Islip	New York	United States
21432	West Seneca	New York	United States
21433	Westbury	New York	United States
21434	White Plains	New York	United States
21435	Woodmere	New York	United States
21436	Yonkers	New York	United States
21437	Akron	Ohio	United States
21438	Alliance	Ohio	United States
21439	Ashland	Ohio	United States
21440	Ashtabula	Ohio	United States
21441	Aurora	Ohio	United States
21442	Austintown	Ohio	United States
21443	Avon	Ohio	United States
21444	Avon Center	Ohio	United States
21445	Avon Lake	Ohio	United States
21446	Barberton	Ohio	United States
21447	Bay Village	Ohio	United States
21448	Berea	Ohio	United States
21449	Boardman	Ohio	United States
21450	Bowling Green	Ohio	United States
21451	Broadview Heights	Ohio	United States
21452	Brook Park	Ohio	United States
21453	Brunswick	Ohio	United States
21454	Canton	Ohio	United States
21455	Cleveland	Ohio	United States
21456	Cuyahoga Falls	Ohio	United States
21457	Defiance	Ohio	United States
21458	Delaware	Ohio	United States
21459	Dublin	Ohio	United States
21460	East Cleveland	Ohio	United States
21461	Eastlake	Ohio	United States
21462	Elyria	Ohio	United States
21463	Euclid	Ohio	United States
21464	Fairview Park	Ohio	United States
21465	Findlay	Ohio	United States
21466	Fremont	Ohio	United States
21467	Gahanna	Ohio	United States
21468	Garfield Heights	Ohio	United States
21469	Green	Ohio	United States
21470	Hilliard	Ohio	United States
21471	Hudson	Ohio	United States
21472	Kent	Ohio	United States
21473	Lakewood	Ohio	United States
21474	Lima	Ohio	United States
21475	Lorain	Ohio	United States
21476	Mansfield	Ohio	United States
21477	Maple Heights	Ohio	United States
21478	Marion	Ohio	United States
21479	Marysville	Ohio	United States
21480	Massillon	Ohio	United States
21481	Mayfield Heights	Ohio	United States
21482	Medina	Ohio	United States
21483	Mentor	Ohio	United States
21484	Middleburg Heights	Ohio	United States
21485	Mount Vernon	Ohio	United States
21486	New Philadelphia	Ohio	United States
21487	Newark	Ohio	United States
21488	Niles	Ohio	United States
21489	North Canton	Ohio	United States
21490	North Olmsted	Ohio	United States
21491	North Ridgeville	Ohio	United States
21492	North Royalton	Ohio	United States
21493	Norwalk	Ohio	United States
21494	Oregon	Ohio	United States
21495	Painesville	Ohio	United States
21496	Parma	Ohio	United States
21497	Parma Heights	Ohio	United States
21498	Perrysburg	Ohio	United States
21499	Piqua	Ohio	United States
21500	Rocky River	Ohio	United States
21501	Sandusky	Ohio	United States
21502	Shaker Heights	Ohio	United States
21503	Sidney	Ohio	United States
21504	Solon	Ohio	United States
21505	South Euclid	Ohio	United States
21506	Steubenville	Ohio	United States
21507	Stow	Ohio	United States
21508	Streetsboro	Ohio	United States
21509	Strongsville	Ohio	United States
21510	Sylvania	Ohio	United States
21511	Tallmadge	Ohio	United States
21512	Tiffin	Ohio	United States
21513	Toledo	Ohio	United States
21514	Troy	Ohio	United States
21515	Twinsburg	Ohio	United States
21516	Wadsworth	Ohio	United States
21517	Warren	Ohio	United States
21518	Westerville	Ohio	United States
21519	Westlake	Ohio	United States
21520	Willoughby	Ohio	United States
21521	Wooster	Ohio	United States
21522	Youngstown	Ohio	United States
21523	Allentown	Pennsylvania	United States
21524	Allison Park	Pennsylvania	United States
21525	Altoona	Pennsylvania	United States
21526	Back Mountain	Pennsylvania	United States
21527	Baldwin	Pennsylvania	United States
21528	Bethel Park	Pennsylvania	United States
21529	Bethlehem	Pennsylvania	United States
21530	Carlisle	Pennsylvania	United States
21531	Easton	Pennsylvania	United States
21532	Erie	Pennsylvania	United States
21533	Harrisburg	Pennsylvania	United States
21534	Hazleton	Pennsylvania	United States
21535	Hermitage	Pennsylvania	United States
21536	Johnstown	Pennsylvania	United States
21537	King of Prussia	Pennsylvania	United States
21538	Lancaster	Pennsylvania	United States
21539	Lansdale	Pennsylvania	United States
21540	Lebanon	Pennsylvania	United States
21541	Levittown	Pennsylvania	United States
21542	Limerick	Pennsylvania	United States
21543	McKeesport	Pennsylvania	United States
21544	Monroeville	Pennsylvania	United States
21545	Mount Lebanon	Pennsylvania	United States
21546	Mountain Top	Pennsylvania	United States
21547	Murrysville	Pennsylvania	United States
21548	New Castle	Pennsylvania	United States
21549	Norristown	Pennsylvania	United States
21550	Penn Hills	Pennsylvania	United States
21551	Phoenixville	Pennsylvania	United States
21552	Pittsburgh	Pennsylvania	United States
21553	Plum	Pennsylvania	United States
21554	Pottstown	Pennsylvania	United States
21555	Radnor	Pennsylvania	United States
21556	Reading	Pennsylvania	United States
21557	Scranton	Pennsylvania	United States
21558	State College	Pennsylvania	United States
21559	Upper Saint Clair	Pennsylvania	United States
21560	Wayne	Pennsylvania	United States
21561	West Mifflin	Pennsylvania	United States
21562	Whitehall Township	Pennsylvania	United States
21563	Wilkes-Barre	Pennsylvania	United States
21564	Wilkinsburg	Pennsylvania	United States
21565	Williamsport	Pennsylvania	United States
21566	Willow Grove	Pennsylvania	United States
21567	Barrington	Rhode Island	United States
21568	Bristol	Rhode Island	United States
21569	Central Falls	Rhode Island	United States
21570	Coventry	Rhode Island	United States
21571	Cranston	Rhode Island	United States
21572	Cumberland	Rhode Island	United States
21573	East Providence	Rhode Island	United States
21574	Middletown	Rhode Island	United States
21575	Newport	Rhode Island	United States
21576	North Kingstown	Rhode Island	United States
21577	North Providence	Rhode Island	United States
21578	Pawtucket	Rhode Island	United States
21579	Portsmouth	Rhode Island	United States
21580	Providence	Rhode Island	United States
21581	Smithfield	Rhode Island	United States
21582	Warwick	Rhode Island	United States
21583	West Warwick	Rhode Island	United States
21584	Westerly	Rhode Island	United States
21585	Woonsocket	Rhode Island	United States
21586	Aberdeen	South Dakota	United States
21587	Brookings	South Dakota	United States
21588	Mitchell	South Dakota	United States
21589	Sioux Falls	South Dakota	United States
21590	Watertown	South Dakota	United States
21591	Burlington	Vermont	United States
21592	Colchester	Vermont	United States
21593	Rutland	Vermont	United States
21594	South Burlington	Vermont	United States
21595	Appleton	Wisconsin	United States
21596	Ashwaubenon	Wisconsin	United States
21597	Beaver Dam	Wisconsin	United States
21598	Beloit	Wisconsin	United States
21599	Brookfield	Wisconsin	United States
21600	Caledonia	Wisconsin	United States
21601	Cudahy	Wisconsin	United States
21602	De Pere	Wisconsin	United States
21603	Eau Claire	Wisconsin	United States
21604	Fitchburg	Wisconsin	United States
21605	Fond du Lac	Wisconsin	United States
21606	Franklin	Wisconsin	United States
21607	Germantown	Wisconsin	United States
21608	Green Bay	Wisconsin	United States
21609	Greenfield	Wisconsin	United States
21610	Howard	Wisconsin	United States
21611	Janesville	Wisconsin	United States
21612	Kaukauna	Wisconsin	United States
21613	Kenosha	Wisconsin	United States
21614	La Crosse	Wisconsin	United States
21615	Madison	Wisconsin	United States
21616	Manitowoc	Wisconsin	United States
21617	Marshfield	Wisconsin	United States
21618	Menasha	Wisconsin	United States
21619	Menomonee Falls	Wisconsin	United States
21620	Menomonie	Wisconsin	United States
21621	Mequon	Wisconsin	United States
21622	Middleton	Wisconsin	United States
21623	Milwaukee	Wisconsin	United States
21624	Muskego	Wisconsin	United States
21625	Neenah	Wisconsin	United States
21626	New Berlin	Wisconsin	United States
21627	North La Crosse	Wisconsin	United States
21628	Oak Creek	Wisconsin	United States
21629	Oconomowoc	Wisconsin	United States
21630	Onalaska	Wisconsin	United States
21631	Oshkosh	Wisconsin	United States
21632	Pleasant Prairie	Wisconsin	United States
21633	Racine	Wisconsin	United States
21634	Sheboygan	Wisconsin	United States
21635	South Milwaukee	Wisconsin	United States
21636	Stevens Point	Wisconsin	United States
21637	Sun Prairie	Wisconsin	United States
21638	Superior	Wisconsin	United States
21639	Watertown	Wisconsin	United States
21640	Waukesha	Wisconsin	United States
21641	Wausau	Wisconsin	United States
21642	Wauwatosa	Wisconsin	United States
21643	West Allis	Wisconsin	United States
21644	West Bend	Wisconsin	United States
21645	Wisconsin Rapids	Wisconsin	United States
21646	Weirton	West Virginia	United States
21647	Weirton Heights	West Virginia	United States
21648	Wheeling	West Virginia	United States
21649	Ansonia	Connecticut	United States
21650	Bridgeport	Connecticut	United States
21651	Bristol	Connecticut	United States
21652	Branford	Connecticut	United States
21653	Cheshire	Connecticut	United States
21654	Fillmore	California	United States
21655	Buckeye	Arizona	United States
21656	Bullhead City	Arizona	United States
21657	Casa Grande	Arizona	United States
21658	Casas Adobes	Arizona	United States
21659	Catalina Foothills	Arizona	United States
21660	Chandler	Arizona	United States
21661	Douglas	Arizona	United States
21662	Drexel Heights	Arizona	United States
21663	El Mirage	Arizona	United States
21664	Eloy	Arizona	United States
21665	Flagstaff	Arizona	United States
21666	Florence	Arizona	United States
21667	Flowing Wells	Arizona	United States
21668	Fortuna Foothills	Arizona	United States
21669	Fountain Hills	Arizona	United States
21670	Gilbert	Arizona	United States
21671	Glendale	Arizona	United States
21672	Goodyear	Arizona	United States
21673	Green Valley	Arizona	United States
21674	Kingman	Arizona	United States
21675	Lake Havasu City	Arizona	United States
21676	Marana	Arizona	United States
21677	Maricopa	Arizona	United States
21678	Mesa	Arizona	United States
21679	Nogales	Arizona	United States
21680	Oro Valley	Arizona	United States
21681	Payson	Arizona	United States
21682	Peoria	Arizona	United States
21683	Phoenix	Arizona	United States
21684	Prescott	Arizona	United States
21685	Prescott Valley	Arizona	United States
21686	Queen Creek	Arizona	United States
21687	Rio Rico	Arizona	United States
21688	Sahuarita	Arizona	United States
21689	San Luis	Arizona	United States
21690	Scottsdale	Arizona	United States
21691	Sierra Vista	Arizona	United States
21692	Sun City	Arizona	United States
21693	Sun City West	Arizona	United States
21694	Surprise	Arizona	United States
21695	Tanque Verde	Arizona	United States
21696	Tempe	Arizona	United States
21697	Tempe Junction	Arizona	United States
21698	Tucson	Arizona	United States
21699	Yuma	Arizona	United States
21700	Adelanto	California	United States
21701	Agoura	California	United States
21702	Agoura Hills	California	United States
21703	Alameda	California	United States
21704	Albany	California	United States
21705	Alhambra	California	United States
21706	Aliso Viejo	California	United States
21707	Altadena	California	United States
21708	Alum Rock	California	United States
21709	American Canyon	California	United States
21710	Anaheim	California	United States
21711	Antelope	California	United States
21712	Antioch	California	United States
21713	Apple Valley	California	United States
21714	Arcadia	California	United States
21715	Arroyo Grande	California	United States
21716	Artesia	California	United States
21717	Arvin	California	United States
21718	Ashland	California	United States
21719	Atascadero	California	United States
21720	Atwater	California	United States
21721	Avenal	California	United States
21722	Avocado Heights	California	United States
21723	Azusa	California	United States
21724	Bakersfield	California	United States
21725	Baldwin Park	California	United States
21726	Banning	California	United States
21727	Barstow	California	United States
21728	Barstow Heights	California	United States
21729	Bay Point	California	United States
21730	Beaumont	California	United States
21731	Bell	California	United States
21732	Bell Gardens	California	United States
21733	Bellflower	California	United States
21734	Belmont	California	United States
21735	Benicia	California	United States
21736	Berkeley	California	United States
21737	Beverly Hills	California	United States
21738	Bloomington	California	United States
21739	Blythe	California	United States
21740	Bostonia	California	United States
21741	Boyle Heights	California	United States
21742	Brawley	California	United States
21743	Brea	California	United States
21744	Brentwood	California	United States
21745	Buena Park	California	United States
21746	Burbank	California	United States
21747	Burlingame	California	United States
21748	Calabasas	California	United States
21749	Calexico	California	United States
21750	Camarillo	California	United States
21751	Cameron Park	California	United States
21752	Campbell	California	United States
21753	Canoga Park	California	United States
21754	Carlsbad	California	United States
21755	Carmichael	California	United States
21756	Carson	California	United States
21757	Castaic	California	United States
21758	Castro Valley	California	United States
21759	Cathedral City	California	United States
21760	Ceres	California	United States
21761	Cerritos	California	United States
21762	Chatsworth	California	United States
21763	Chico	California	United States
21764	Chino	California	United States
21765	Chino Hills	California	United States
21766	Chowchilla	California	United States
21767	Chula Vista	California	United States
21768	Citrus Heights	California	United States
21769	Claremont	California	United States
21770	Clearlake	California	United States
21771	Clovis	California	United States
21772	Coachella	California	United States
21773	Colton	California	United States
21774	Compton	California	United States
21775	Concord	California	United States
21776	Corcoran	California	United States
21777	Corona	California	United States
21778	Coronado	California	United States
21779	Costa Mesa	California	United States
21780	Covina	California	United States
21781	Cudahy	California	United States
21782	Culver City	California	United States
21783	Cupertino	California	United States
21784	Cypress	California	United States
21785	Daly City	California	United States
21786	Dana Point	California	United States
21787	Danville	California	United States
21788	Davis	California	United States
21789	Delano	California	United States
21790	Desert Hot Springs	California	United States
21791	Diamond Bar	California	United States
21792	Dinuba	California	United States
21793	Dixon	California	United States
21794	Downey	California	United States
21795	Duarte	California	United States
21796	Dublin	California	United States
21797	East Rancho Dominguez	California	United States
21798	East Hemet	California	United States
21799	East Los Angeles	California	United States
21800	East Palo Alto	California	United States
21801	El Cajon	California	United States
21802	El Centro	California	United States
21803	El Cerrito	California	United States
21804	El Dorado Hills	California	United States
21805	El Monte	California	United States
21806	El Segundo	California	United States
21807	Elk Grove	California	United States
21808	Encinitas	California	United States
21809	Escondido	California	United States
21810	Fair Oaks	California	United States
21811	Fairfield	California	United States
21812	Fallbrook	California	United States
21813	Florin	California	United States
21814	Folsom	California	United States
21815	Fontana	California	United States
21816	Foothill Farms	California	United States
21817	Foster City	California	United States
21818	Fountain Valley	California	United States
21819	Fremont	California	United States
21820	Fresno	California	United States
21821	Fullerton	California	United States
21822	Galt	California	United States
21823	Garden Grove	California	United States
21824	Gardena	California	United States
21825	Gilroy	California	United States
21826	Glen Avon	California	United States
21827	Glendale	California	United States
21828	Glendora	California	United States
21829	Goleta	California	United States
21830	Granite Bay	California	United States
21831	Greenfield	California	United States
21832	Hacienda Heights	California	United States
21833	Hanford	California	United States
21834	Hawthorne	California	United States
21835	Hayward	California	United States
21836	Hemet	California	United States
21837	Hercules	California	United States
21838	Hermosa Beach	California	United States
21839	Hesperia	California	United States
21840	Highland	California	United States
21841	Hollister	California	United States
21842	Hollywood	California	United States
21843	Huntington Beach	California	United States
21844	Huntington Park	California	United States
21845	Imperial Beach	California	United States
21846	Indio	California	United States
21847	Inglewood	California	United States
21848	Irvine	California	United States
21849	Lodi	California	United States
21850	Loma Linda	California	United States
21851	Lomita	California	United States
21852	Lompoc	California	United States
21853	Long Beach	California	United States
21854	Los Altos	California	United States
21855	Los Angeles	California	United States
21856	Los Banos	California	United States
21857	Los Gatos	California	United States
21858	Lynwood	California	United States
21859	Madera	California	United States
21860	Manhattan Beach	California	United States
21861	Manteca	California	United States
21862	Marina	California	United States
21863	Martinez	California	United States
21864	Maywood	California	United States
21865	Mead Valley	California	United States
21866	Menifee	California	United States
21867	Menlo Park	California	United States
21868	Merced	California	United States
21869	Millbrae	California	United States
21870	Milpitas	California	United States
21871	Mira Loma	California	United States
21872	Mission Viejo	California	United States
21873	Modesto	California	United States
21874	Monrovia	California	United States
21875	Montclair	California	United States
21876	Montebello	California	United States
21877	Monterey	California	United States
21878	Monterey Park	California	United States
21879	Moorpark	California	United States
21880	Moraga	California	United States
21881	Moreno Valley	California	United States
21882	Morgan Hill	California	United States
21883	Mountain View	California	United States
21884	Murrieta	California	United States
21885	Napa	California	United States
21886	National City	California	United States
21887	Newark	California	United States
21888	Newport Beach	California	United States
21889	Nipomo	California	United States
21890	Norco	California	United States
21891	North Glendale	California	United States
21892	North Highlands	California	United States
21893	North Hollywood	California	United States
21894	Northridge	California	United States
21895	Norwalk	California	United States
21896	Novato	California	United States
21897	Oakdale	California	United States
21898	Oakland	California	United States
21899	Oakley	California	United States
21900	Oceanside	California	United States
21901	Oildale	California	United States
21902	Ontario	California	United States
21903	Orange	California	United States
21904	Orangevale	California	United States
21905	Orcutt	California	United States
21906	Orinda	California	United States
21907	Oroville	California	United States
21908	Oxnard	California	United States
21909	Oxnard Shores	California	United States
21910	Pacifica	California	United States
21911	Pacific Grove	California	United States
21912	Palm Desert	California	United States
21913	Palm Springs	California	United States
21914	Palmdale	California	United States
21915	Palo Alto	California	United States
21916	Paradise	California	United States
21917	Paramount	California	United States
21918	Pasadena	California	United States
21919	Paso Robles	California	United States
21920	Patterson	California	United States
21921	Perris	California	United States
21922	Petaluma	California	United States
21923	Pico Rivera	California	United States
21924	Pinole	California	United States
21925	Pittsburg	California	United States
21926	Placentia	California	United States
21927	Pleasant Hill	California	United States
21928	Pleasanton	California	United States
21929	Pomona	California	United States
21930	Port Hueneme	California	United States
21931	Porterville	California	United States
21932	Poway	California	United States
21933	Prunedale	California	United States
21934	Ramona	California	United States
21935	Rancho Cordova	California	United States
21936	Rancho Cucamonga	California	United States
21937	Rancho Mirage	California	United States
21938	Rancho Palos Verdes	California	United States
21939	Rancho San Diego	California	United States
21940	Rancho Santa Margarita	California	United States
21941	Redlands	California	United States
21942	Redondo Beach	California	United States
21943	Redwood City	California	United States
21944	Reedley	California	United States
21945	Rialto	California	United States
21946	Richmond	California	United States
21947	Ridgecrest	California	United States
21948	Rio Linda	California	United States
21949	Riverbank	California	United States
21950	Riverside	California	United States
21951	Rocklin	California	United States
21952	Rohnert Park	California	United States
21953	Rosamond	California	United States
21954	Rosemead	California	United States
21955	Rosemont	California	United States
21956	Roseville	California	United States
21957	Rowland Heights	California	United States
21958	Rubidoux	California	United States
21959	Sacramento	California	United States
21960	Salinas	California	United States
21961	San Bernardino	California	United States
21962	San Bruno	California	United States
21963	San Carlos	California	United States
21964	San Clemente	California	United States
21965	San Diego	California	United States
21966	San Dimas	California	United States
21967	San Fernando	California	United States
21968	San Francisco	California	United States
21969	San Gabriel	California	United States
21970	San Jacinto	California	United States
21971	San Jose	California	United States
21972	San Juan Capistrano	California	United States
21973	San Leandro	California	United States
21974	San Lorenzo	California	United States
21975	San Luis Obispo	California	United States
21976	San Marcos	California	United States
21977	San Mateo	California	United States
21978	San Pablo	California	United States
21979	San Pedro	California	United States
21980	San Rafael	California	United States
21981	San Ramon	California	United States
21982	Sanger	California	United States
21983	Santa Ana	California	United States
21984	Santa Barbara	California	United States
21985	Santa Clara	California	United States
21986	Santa Clarita	California	United States
21987	Santa Cruz	California	United States
21988	Santa Fe Springs	California	United States
21989	Santa Maria	California	United States
21990	Santa Monica	California	United States
21991	Santa Paula	California	United States
21992	Santa Rosa	California	United States
21993	Santee	California	United States
21994	Saratoga	California	United States
21995	Seal Beach	California	United States
21996	Seaside	California	United States
21997	Selma	California	United States
21998	Shafter	California	United States
21999	Sherman Oaks	California	United States
22000	Simi Valley	California	United States
22001	Soledad	California	United States
22002	South El Monte	California	United States
22003	South Gate	California	United States
22004	South Lake Tahoe	California	United States
22005	South Pasadena	California	United States
22006	South San Francisco	California	United States
22007	South San Jose Hills	California	United States
22008	South Whittier	California	United States
22009	South Yuba City	California	United States
22010	Spring Valley	California	United States
22011	Stanton	California	United States
22012	Stockton	California	United States
22013	Suisun	California	United States
22014	Sun City	California	United States
22015	Sunnyvale	California	United States
22016	Temecula	California	United States
22017	Temple City	California	United States
22018	Thousand Oaks	California	United States
22019	Torrance	California	United States
22020	Tracy	California	United States
22021	Truckee	California	United States
22022	Tulare	California	United States
22023	Turlock	California	United States
22024	Tustin	California	United States
22025	North Tustin	California	United States
22026	Twentynine Palms	California	United States
22027	Ukiah	California	United States
22028	Union City	California	United States
22029	Universal City	California	United States
22030	Upland	California	United States
22031	Walnut Park	California	United States
22032	Watsonville	California	United States
22033	West Carson	California	United States
22034	West Covina	California	United States
22035	West Hollywood	California	United States
22036	West Puente Valley	California	United States
22037	West Sacramento	California	United States
22038	Westminster	California	United States
22039	Westmont	California	United States
22040	Whittier	California	United States
22041	Wildomar	California	United States
22042	Willowbrook	California	United States
22043	Windsor	California	United States
22044	Winter Gardens	California	United States
22045	Woodland	California	United States
22046	Woodland Hills	California	United States
22047	Yorba Linda	California	United States
22048	Yuba City	California	United States
22049	Yucaipa	California	United States
22050	Yucca Valley	California	United States
22051	Arvada	Colorado	United States
22052	Aurora	Colorado	United States
22053	Brighton	Colorado	United States
22054	Broomfield	Colorado	United States
22056	Castle Rock	Colorado	United States
22057	Castlewood	Colorado	United States
22058	Centennial	Colorado	United States
22059	Cimarron Hills	Colorado	United States
22060	Clifton	Colorado	United States
22061	Colorado Springs	Colorado	United States
22062	Columbine	Colorado	United States
22063	Commerce City	Colorado	United States
22064	Denver	Colorado	United States
22065	Durango	Colorado	United States
22066	Englewood	Colorado	United States
22067	Fountain	Colorado	United States
22068	Golden	Colorado	United States
22069	Grand Junction	Colorado	United States
22070	Highlands Ranch	Colorado	United States
22071	Ken Caryl	Colorado	United States
22072	Lafayette	Colorado	United States
22073	Lakewood	Colorado	United States
22074	Littleton	Colorado	United States
22075	Louisville	Colorado	United States
22076	Montrose	Colorado	United States
22077	Northglenn	Colorado	United States
22078	Parker	Colorado	United States
22079	Pueblo	Colorado	United States
22080	Pueblo West	Colorado	United States
22081	Sherrelwood	Colorado	United States
22082	Southglenn	Colorado	United States
22083	Thornton	Colorado	United States
22084	Westminster	Colorado	United States
22085	Wheat Ridge	Colorado	United States
22086	Dodge City	Kansas	United States
22087	Garden City	Kansas	United States
22088	Liberal	Kansas	United States
22089	Alamogordo	New Mexico	United States
22090	Albuquerque	New Mexico	United States
22091	Carlsbad	New Mexico	United States
22092	Clovis	New Mexico	United States
22093	Farmington	New Mexico	United States
22094	Gallup	New Mexico	United States
22095	Hobbs	New Mexico	United States
22096	Las Cruces	New Mexico	United States
22097	Rio Rancho	New Mexico	United States
22098	Roswell	New Mexico	United States
22099	Santa Fe	New Mexico	United States
22100	South Valley	New Mexico	United States
22101	Boulder City	Nevada	United States
22102	Carson City	Nevada	United States
22103	Enterprise	Nevada	United States
22104	Fernley	Nevada	United States
22105	Henderson	Nevada	United States
22106	Las Vegas	Nevada	United States
22107	Mesquite	Nevada	United States
22108	North Las Vegas	Nevada	United States
22109	Pahrump	Nevada	United States
22110	Paradise	Nevada	United States
22111	Reno	Nevada	United States
22112	Spanish Springs	Nevada	United States
22113	Sparks	Nevada	United States
22114	Spring Valley	Nevada	United States
22115	Sun Valley	Nevada	United States
22116	Sunrise Manor	Nevada	United States
22117	Whitney	Nevada	United States
22118	Winchester	Nevada	United States
22119	Amarillo	Texas	United States
22120	Big Spring	Texas	United States
22121	Del Rio	Texas	United States
22122	Eagle Pass	Texas	United States
22123	El Paso	Texas	United States
22124	Hereford	Texas	United States
22125	Horizon City	Texas	United States
22126	Lubbock	Texas	United States
22127	Midland	Texas	United States
22128	Odessa	Texas	United States
22129	Pampa	Texas	United States
22130	Plainview	Texas	United States
22131	San Angelo	Texas	United States
22132	Socorro	Texas	United States
22133	Socorro Mission Number 1 Colonia	Texas	United States
22134	West Odessa	Texas	United States
22135	Cedar City	Utah	United States
22136	Saint George	Utah	United States
22137	Washington	Utah	United States
22138	Wasco	California	United States
22139	Anthem	Arizona	United States
22140	Apache Junction	Arizona	United States
22141	Avondale	Arizona	United States
22142	Juneau	Alaska	United States
22143	Arcata	California	United States
22144	Bayside	California	United States
22145	Eureka	California	United States
22146	McKinleyville	California	United States
22147	Redding	California	United States
22148	Susanville	California	United States
22149	Boulder	Colorado	United States
22150	Erie	Colorado	United States
22151	Evans	Colorado	United States
22152	Fort Collins	Colorado	United States
22153	Greeley	Colorado	United States
22154	Longmont	Colorado	United States
22155	Loveland	Colorado	United States
22156	Windsor	Colorado	United States
22157	Boise	Idaho	United States
22158	Caldwell	Idaho	United States
22159	Coeur dAlene	Idaho	United States
22160	Eagle	Idaho	United States
22161	Idaho Falls	Idaho	United States
22162	Kuna	Idaho	United States
22163	Lewiston	Idaho	United States
22164	Lewiston Orchards	Idaho	United States
22165	Meridian	Idaho	United States
22166	Moscow	Idaho	United States
22167	Nampa	Idaho	United States
22168	Pocatello	Idaho	United States
22169	Post Falls	Idaho	United States
22170	Rexburg	Idaho	United States
22171	Twin Falls	Idaho	United States
22172	Billings	Montana	United States
22173	Bozeman	Montana	United States
22174	Butte	Montana	United States
22175	Great Falls	Montana	United States
22176	Helena	Montana	United States
22177	Kalispell	Montana	United States
22178	Missoula	Montana	United States
22179	Bismarck	North Dakota	United States
22180	Dickinson	North Dakota	United States
22181	Mandan	North Dakota	United States
22182	Minot	North Dakota	United States
22183	North Platte	Nebraska	United States
22184	Scottsbluff	Nebraska	United States
22185	Elko	Nevada	United States
22186	Albany	Oregon	United States
22187	Aloha	Oregon	United States
22188	Altamont	Oregon	United States
22189	Ashland	Oregon	United States
22190	Beaverton	Oregon	United States
22191	Bend	Oregon	United States
22192	Bethany	Oregon	United States
22193	Canby	Oregon	United States
22194	Central Point	Oregon	United States
22195	Coos Bay	Oregon	United States
22196	Corvallis	Oregon	United States
22197	Eugene	Oregon	United States
22198	Forest Grove	Oregon	United States
22199	Four Corners	Oregon	United States
22200	Grants Pass	Oregon	United States
22201	Gresham	Oregon	United States
22202	Hayesville	Oregon	United States
22203	Hermiston	Oregon	United States
22204	Hillsboro	Oregon	United States
22205	Keizer	Oregon	United States
22206	Klamath Falls	Oregon	United States
22207	Lake Oswego	Oregon	United States
22208	Lebanon	Oregon	United States
22209	Lents	Oregon	United States
22210	McMinnville	Oregon	United States
22211	Medford	Oregon	United States
22212	Milwaukie	Oregon	United States
22213	Newberg	Oregon	United States
22214	Oak Grove	Oregon	United States
22215	Oregon City	Oregon	United States
22216	Pendleton	Oregon	United States
22217	Portland	Oregon	United States
22218	Redmond	Oregon	United States
22219	Roseburg	Oregon	United States
22220	Salem	Oregon	United States
22221	Sherwood	Oregon	United States
22222	Springfield	Oregon	United States
22223	Tigard	Oregon	United States
22224	Troutdale	Oregon	United States
22225	Tualatin	Oregon	United States
22226	West Linn	Oregon	United States
22227	Wilsonville	Oregon	United States
22228	Woodburn	Oregon	United States
22229	Rapid City	South Dakota	United States
22230	Bountiful	Utah	United States
22231	Brigham City	Utah	United States
22232	Centerville	Utah	United States
22233	Clearfield	Utah	United States
22234	Clinton	Utah	United States
22235	Cottonwood Heights	Utah	United States
22236	Draper	Utah	United States
22237	Eagle Mountain	Utah	United States
22238	East Millcreek	Utah	United States
22239	Farmington	Utah	United States
22240	Herriman	Utah	United States
22241	Highland	Utah	United States
22242	Holladay	Utah	United States
22243	Kaysville	Utah	United States
22244	Kearns	Utah	United States
22245	Layton	Utah	United States
22246	Lehi	Utah	United States
22247	Logan	Utah	United States
22248	Magna	Utah	United States
22249	Midvale	Utah	United States
22250	Millcreek	Utah	United States
22251	Murray	Utah	United States
22252	North Ogden	Utah	United States
22253	North Salt Lake	Utah	United States
22254	Ogden	Utah	United States
22255	Orem	Utah	United States
22256	Payson	Utah	United States
22257	Pleasant Grove	Utah	United States
22258	Provo	Utah	United States
22259	Riverton	Utah	United States
22260	Roy	Utah	United States
22261	Salt Lake City	Utah	United States
22262	Sandy City	Utah	United States
22263	Sandy Hills	Utah	United States
22264	Saratoga Springs	Utah	United States
22265	South Jordan Heights	Utah	United States
22266	South Jordan	Utah	United States
22267	South Ogden	Utah	United States
22268	South Salt Lake	Utah	United States
22269	Spanish Fork	Utah	United States
22270	Springville	Utah	United States
22271	Syracuse	Utah	United States
22272	Taylorsville	Utah	United States
22273	Tooele	Utah	United States
22274	West Jordan	Utah	United States
22275	West Valley City	Utah	United States
22276	Aberdeen	Washington	United States
22277	Anacortes	Washington	United States
22278	Arlington	Washington	United States
22279	Auburn	Washington	United States
22280	Battle Ground	Washington	United States
22281	Bellevue	Washington	United States
22282	Bellingham	Washington	United States
22283	Bonney Lake	Washington	United States
22284	Bothell	Washington	United States
22285	Bremerton	Washington	United States
22286	Burien	Washington	United States
22287	Camas	Washington	United States
22288	Centralia	Washington	United States
22289	Cottage Lake	Washington	United States
22290	Covington	Washington	United States
22291	Des Moines	Washington	United States
22292	Edmonds	Washington	United States
22293	Ellensburg	Washington	United States
22294	Everett	Washington	United States
22295	Fairwood	Washington	United States
22296	Federal Way	Washington	United States
22297	Five Corners	Washington	United States
22298	Frederickson	Washington	United States
22299	Graham	Washington	United States
22300	Hazel Dell	Washington	United States
22301	Issaquah	Washington	United States
22302	Kenmore	Washington	United States
22303	Kennewick	Washington	United States
22304	Kent	Washington	United States
22305	Kirkland	Washington	United States
22306	Lacey	Washington	United States
22307	Lake Stevens	Washington	United States
22308	Lakewood	Washington	United States
22309	Longview	Washington	United States
22310	Lynnwood	Washington	United States
22311	Maple Valley	Washington	United States
22312	Martha Lake	Washington	United States
22313	Marysville	Washington	United States
22314	Mercer Island	Washington	United States
22315	Mill Creek	Washington	United States
22316	Monroe	Washington	United States
22317	Moses Lake	Washington	United States
22318	Mount Vernon	Washington	United States
22319	Mountlake Terrace	Washington	United States
22320	Mukilteo	Washington	United States
22321	North Creek	Washington	United States
22322	Oak Harbor	Washington	United States
22323	Olympia	Washington	United States
22324	Opportunity	Washington	United States
22325	Orchards	Washington	United States
22326	Parkland	Washington	United States
22327	Pasco	Washington	United States
22328	Port Angeles	Washington	United States
22329	Pullman	Washington	United States
22330	Puyallup	Washington	United States
22331	Redmond	Washington	United States
22332	Renton	Washington	United States
22333	Richland	Washington	United States
22334	Salmon Creek	Washington	United States
22335	Sammamish	Washington	United States
22336	SeaTac	Washington	United States
22337	Seattle	Washington	United States
22338	Shoreline	Washington	United States
22339	Silverdale	Washington	United States
22340	South Hill	Washington	United States
22341	Spanaway	Washington	United States
22342	Spokane	Washington	United States
22343	Spokane Valley	Washington	United States
22344	Sunnyside	Washington	United States
22345	Tacoma	Washington	United States
22346	Tukwila	Washington	United States
22347	Tumwater	Washington	United States
22348	University Place	Washington	United States
22349	Vancouver	Washington	United States
22350	Walla Walla	Washington	United States
22351	Wenatchee	Washington	United States
22352	West Lake Sammamish	Washington	United States
22353	West Lake Stevens	Washington	United States
22354	Bainbridge Island	Washington	United States
22355	Yakima	Washington	United States
22356	Casper	Wyoming	United States
22357	Cheyenne	Wyoming	United States
22358	Gillette	Wyoming	United States
22359	Laramie	Wyoming	United States
22360	Rock Springs	Wyoming	United States
22361	Sheridan	Wyoming	United States
22362	American Fork	Utah	United States
22363	Kahului	Hawaii	United States
22364	Kailua	Hawaii	United States
22366	Kihei	Hawaii	United States
22367	Makakilo City	Hawaii	United States
22368	Mililani Town	Hawaii	United States
22369	Pearl City	Hawaii	United States
22370	Wahiawa	Hawaii	United States
22371	Wailuku	Hawaii	United States
22372	Waipahu	Hawaii	United States
22374	Hilo	Hawaii	United States
22375	Honolulu	Hawaii	United States
22376	Eagle River	Alaska	United States
22377	Fairbanks	Alaska	United States
22378	Anchorage	Alaska	United States
22379	Badger	Alaska	United States
22380	Milton	Georgia	United States
22381	Johns Creek	Georgia	United States
22382	Cutler Bay	Florida	United States
22383	Alafaya	Florida	United States
22384	Fort Bragg	North Carolina	United States
22385	City of Milford (balance)	Connecticut	United States
22386	Butte-Silver Bow (Balance)	Montana	United States
22387	City of Sammamish	Washington	United States
22388	Silver Firs	Washington	United States
22389	Vineyard	California	United States
22390	Wallingford Center	Connecticut	United States
22391	Bel Air North	Maryland	United States
22392	Bel Air South	Maryland	United States
22393	Setauket-East Setauket	New York	United States
22394	Tonawanda	New York	United States
22395	Fort Leonard Wood	Missouri	United States
22396	West Bloomfield Township	Michigan	United States
22397	East Lake-Orient Park	Florida	United States
22398	Four Corners	Florida	United States
22399	Greater Northdale	Florida	United States
22400	Candler-McAfee	Georgia	United States
22401	University	Florida	United States
22402	Vero Beach South	Florida	United States
22403	Kendall West	Florida	United States
22404	Palm River-Clair Mel	Florida	United States
22405	Arden-Arcade	California	United States
22406	Bryn Mawr-Skyway	Washington	United States
22407	Casa de Oro-Mount Helix	California	United States
22408	Florence-Graham	California	United States
22409	Fort Hood	Texas	United States
22410	Inglewood-Finn Hill	Washington	United States
22411	La Crescenta-Montrose	California	United States
22412	East Hill-Meridian	Washington	United States
22413	Security-Widefield	Colorado	United States
22414	Union Hill-Novelty Hill	Washington	United States
22415	West Whittier-Los Nietos	California	United States
22416	Summerlin South	Nevada	United States
22417	Makakilo	Hawaii	United States
22418	Schofield Barracks	Hawaii	United States
22419	San Tan Valley	Arizona	United States
22420	Enchanted Hills	New Mexico	United States
22421	West Hills	California	United States
22422	Oak Hill	Virginia	United States
22423	Bridgewater	New Jersey	United States
22424	Warren Township	New Jersey	United States
22425	Fairfield Heights	Indiana	United States
22426	Randolph	New Jersey	United States
22427	Hot Springs National Park	Arkansas	United States
22428	Dixiana	Alabama	United States
22429	Cranberry Township	Pennsylvania	United States
22430	Silver Lake	California	United States
22433	Trinidad	Flores	Uruguay
22434	Trinidad	Flores	Uruguay
22435	Treinta y Tres	Treinta y Tres	Uruguay
22439	San Carlos	Maldonado	Uruguay
22440	Salto	Salto	Uruguay
22441	Rocha	Rocha	Uruguay
22442	Rivera	Rivera	Uruguay
22443	Progreso	Canelones	Uruguay
22445	Paso de Carrasco	Canelones	Uruguay
22446	Pando	Canelones	Uruguay
22447	Montevideo	Montevideo	Uruguay
22448	Minas	Lavalleja	Uruguay
22449	Mercedes	Soriano	Uruguay
22450	Melo	Cerro Largo	Uruguay
22451	Maldonado	Maldonado	Uruguay
22452	Las Piedras	Canelones	Uruguay
22453	La Paz	Canelones	Uruguay
22455	Florida	Florida	Uruguay
22456	Durazno	Durazno	Uruguay
22457	Dolores	Soriano	Uruguay
22459	Colonia del Sacramento	Colonia	Uruguay
22460	Carmelo	Colonia	Uruguay
22461	Canelones	Canelones	Uruguay
22462	Artigas	Artigas	Uruguay
22463	Nukus	Karakalpakstan	Uzbekistan
22464	Khujayli	Karakalpakstan	Uzbekistan
22466	Zomin	Jizzax	Uzbekistan
22467	Urgut	Samarqand	Uzbekistan
22468	Tirmiz	Surxondaryo	Uzbekistan
22470	Shahrisabz	Qashqadaryo	Uzbekistan
22471	Samarqand	Samarqand	Uzbekistan
22472	Qarshi	Qashqadaryo	Uzbekistan
22473	Muborak	Qashqadaryo	Uzbekistan
22474	Kitob	Qashqadaryo	Uzbekistan
22476	Koson	Qashqadaryo	Uzbekistan
22478	Kogon	Bukhara	Uzbekistan
22480	Galaosiyo	Bukhara	Uzbekistan
22481	Juma	Samarqand	Uzbekistan
22482	Denov	Surxondaryo	Uzbekistan
22483	Chiroqchi	Qashqadaryo	Uzbekistan
22484	Chelak	Samarqand	Uzbekistan
22486	Bukhara	Bukhara	Uzbekistan
22487	Beshkent	Qashqadaryo	Uzbekistan
22488	Boysun	Surxondaryo	Uzbekistan
22489	Oqtosh	Samarqand	Uzbekistan
22490	Zafar	Toshkent	Uzbekistan
22491	Yaypan	Fergana	Uzbekistan
22492	Yangiyul	Toshkent	Uzbekistan
22493	Yangiyer	Sirdaryo	Uzbekistan
22494	Yangirabot	Navoiy	Uzbekistan
22496	Yangiobod	Toshkent	Uzbekistan
22497	Wobkent	Bukhara	Uzbekistan
22498	Uychi	Namangan	Uzbekistan
22499	Urganch	Xorazm	Uzbekistan
22500	Dashtobod	Jizzax	Uzbekistan
22501	Uchqurghon Shahri	Namangan	Uzbekistan
22502	Tuytepa	Toshkent	Uzbekistan
22503	Turagurghon	Namangan	Uzbekistan
22504	Toshloq	Fergana	Uzbekistan
22505	Tashkent	Toshkent Shahri	Uzbekistan
22506	Toshbuloq	Namangan	Uzbekistan
22507	Sirdaryo	Sirdaryo	Uzbekistan
22508	Showot	Xorazm	Uzbekistan
22509	Shofirkon	Bukhara	Uzbekistan
22510	Salor	Toshkent	Uzbekistan
22511	Qushkupir	Xorazm	Uzbekistan
22513	Piskent	Toshkent	Uzbekistan
22514	Payshanba	Samarqand	Uzbekistan
22515	Parkent	Toshkent	Uzbekistan
22516	Pop	Namangan	Uzbekistan
22517	Paxtakor	Jizzax	Uzbekistan
22518	Olmaliq	Toshkent	Uzbekistan
22519	Ohangaron	Toshkent	Uzbekistan
22520	Nurota	Navoiy	Uzbekistan
22522	Navoiy	Navoiy	Uzbekistan
22523	Namangan	Namangan	Uzbekistan
22525	Manghit	Karakalpakstan	Uzbekistan
22526	Asaka	Andijon	Uzbekistan
22527	Quvasoy	Fergana	Uzbekistan
22528	Qurghontepa	Andijon	Uzbekistan
22529	Kirguli	Fergana	Uzbekistan
22530	Qibray	Toshkent	Uzbekistan
22531	Khujaobod	Andijon	Uzbekistan
22532	Khiwa	Xorazm	Uzbekistan
22533	Haqqulobod	Namangan	Uzbekistan
22534	Kosonsoy	Namangan	Uzbekistan
22535	Jizzax	Jizzax	Uzbekistan
22536	Iskandar	Toshkent	Uzbekistan
22537	Hazorasp	Xorazm	Uzbekistan
22538	Gurlan	Xorazm	Uzbekistan
22539	Guliston	Sirdaryo	Uzbekistan
22540	Ghijduwon	Bukhara	Uzbekistan
22542	Gagarin	Jizzax	Uzbekistan
22543	Fergana	Fergana	Uzbekistan
22544	Dustlik	Jizzax	Uzbekistan
22545	Chust Shahri	Namangan	Uzbekistan
22546	Chirchiq	Toshkent	Uzbekistan
22547	Chinoz	Toshkent	Uzbekistan
22548	Chortoq	Namangan	Uzbekistan
22549	Buka	Toshkent	Uzbekistan
22550	Beshariq	Fergana	Uzbekistan
22551	Beruniy	Karakalpakstan	Uzbekistan
22552	Bektemir	Toshkent Shahri	Uzbekistan
22553	Bekobod	Toshkent	Uzbekistan
22554	Angren	Toshkent	Uzbekistan
22555	Andijon	Andijon	Uzbekistan
22556	Oltiariq	Fergana	Uzbekistan
22557	Quva	Fergana	Uzbekistan
22558	Navoiy	Navoiy	Uzbekistan
22559	Vatican City	N/A	Vatican
22560	Kingstown	Saint George	Saint Vincent and the Grenadines
22561	Kingstown Park	Saint George	Saint Vincent and the Grenadines
22564	Alto Barinas	Barinas	Venezuela
22566	Yaritagua	Yaracuy	Venezuela
22567	Villa de Cura	Aragua	Venezuela
22568	Villa Bruzual	Portuguesa	Venezuela
22570	Valera	Trujillo	Venezuela
22571	Valencia	Carabobo	Venezuela
22573	Turmero	Aragua	Venezuela
22574	Tucupita	Delta Amacuro	Venezuela
22575	Trujillo	Trujillo	Venezuela
22576	Tinaquillo	Cojedes	Venezuela
22578	Santa Teresa	Miranda	Venezuela
22579	Santa Rita	Zulia	Venezuela
22581	San Mateo	Aragua	Venezuela
22586	San Felipe	Yaracuy	Venezuela
22588	San Carlos del Zulia	Zulia	Venezuela
22589	San Carlos	Cojedes	Venezuela
22591	San Antonio de Los Altos	Miranda	Venezuela
22593	La Villa del Rosario	Zulia	Venezuela
22598	Puerto Cabello	Carabobo	Venezuela
22599	Puerto Ayacucho	Amazonas	Venezuela
22600	Porlamar	Nueva Esparta	Venezuela
22601	Petare	Miranda	Venezuela
22602	Palo Negro	Aragua	Venezuela
22603	Ocumare del Tuy	Miranda	Venezuela
22604	Nirgua	Yaracuy	Venezuela
22608	Mariara	Carabobo	Venezuela
22609	Maracay	Aragua	Venezuela
22610	Maracaibo	Zulia	Venezuela
22612	Machiques	Zulia	Venezuela
22613	Los Teques	Miranda	Venezuela
22614	Los Rastrojos	Lara	Venezuela
22615	Los Dos Caminos	Miranda	Venezuela
22616	La Victoria	Aragua	Venezuela
22618	Lagunillas	Zulia	Venezuela
22619	La Guaira	Vargas	Venezuela
22620	Juan Griego	Nueva Esparta	Venezuela
22623	Guatire	Miranda	Venezuela
22624	Guarenas	Miranda	Venezuela
22625	Guanare	Portuguesa	Venezuela
22626	Guacara	Carabobo	Venezuela
22628	El Tocuyo	Lara	Venezuela
22631	El Hatillo	Miranda	Venezuela
22638	Chivacoa	Yaracuy	Venezuela
22639	Charallave	Miranda	Venezuela
22640	Chacao	Miranda	Venezuela
22641	Tacarigua	Carabobo	Venezuela
22643	Catia La Mar	Vargas	Venezuela
22645	Carrizal	Miranda	Venezuela
22646	Carora	Lara	Venezuela
22647	Caracas	Capital	Venezuela
22648	Caraballeda	Vargas	Venezuela
22651	Cagua	Aragua	Venezuela
22652	Cabimas	Zulia	Venezuela
22653	Baruta	Miranda	Venezuela
22654	Barquisimeto	Lara	Venezuela
22655	Barinitas	Barinas	Venezuela
22656	Barinas	Barinas	Venezuela
22658	Araure	Portuguesa	Venezuela
22660	Acarigua	Portuguesa	Venezuela
22663	El Cafetal	Miranda	Venezuela
22664	Caucaguita	Miranda	Venezuela
22665	La Dolorita	Miranda	Venezuela
22666	Guasdualito	Apure	Venezuela
22667	San Fernando de Apure	Apure	Venezuela
22668	Road Town	N/A	British Virgin Islands
22669	Tortola	N/A	British Virgin Islands
22670	Charlotte Amalie	Saint Thomas Island	U.S. Virgin Islands
22671	Saint Croix	Saint Croix Island	U.S. Virgin Islands
22675	V? Thanh	Hau Giang	Vietnam
22677	Vinh Long	Vinh Long	Vietnam
22678	Vinh	Ngh? An	Vietnam
22685	Ho Chi Minh City	Ho Chi Minh City	Vietnam
22691	Tam K?	Qu?ng Nam	Vietnam
22693	Son La	Son La	Vietnam
22701	Pleiku	Gia Lai	Vietnam
22709	M? Tho	Ti?n Giang	Vietnam
22715	Kon Tum	Kon Tum	Vietnam
22719	H?i An	Qu?ng Nam	Vietnam
22723	Hanoi	Ha N?i	Vietnam
22734	C? Chi	Ho Chi Minh City	Vietnam
22735	Cho Dok	An Giang	Vietnam
22739	C?n Tho	C?n Tho	Vietnam
22740	C?n Gi?	Ho Chi Minh City	Vietnam
22741	C?n Giu?c	Long An	Vietnam
22743	C?m Ph? Mines	Qu?ng Ninh	Vietnam
22748	B?n Tre	B?n Tre	Vietnam
22750	B?c Ninh	B?c Ninh	Vietnam
22752	B?c Giang	B?c Giang	Vietnam
22753	B?c K?n	B?c K?n	Vietnam
22755	Port-Vila	Shefa	Vanuatu
22757	Apia	Tuamasaga	Samoa
22758	Zvecan	Mitrovica	Kosovo
22759	Vushtrri	Mitrovica	Kosovo
22760	Vitina	Gjilan	Kosovo
22761	Ferizaj	Ferizaj	Kosovo
22762	Suva Reka	Prizren	Kosovo
22763	Shtime	Ferizaj	Kosovo
22764	Prizren	Prizren	Kosovo
22765	Pristina	Pristina	Kosovo
22766	Podujeva	Pristina	Kosovo
22768	Orahovac	Gjakova	Kosovo
22770	Leposaviq	Mitrovica	Kosovo
22772	Kosovo Polje	Pristina	Kosovo
22773	Istok	Pec	Kosovo
22774	Gjilan	Gjilan	Kosovo
22775	Glogovac	Pristina	Kosovo
22776	Dragash	Prizren	Kosovo
22779	Zinjibar	Abyan	Yemen
22781	Yarim	Ibb	Yemen
22783	Sayyan	Sanaa	Yemen
22784	Sanaa	Sanaa	Yemen
22785	Sa?ar	Sanaa	Yemen
22788	La?ij	La?ij	Yemen
22789	Ibb	Ibb	Yemen
22790	?ajjah	?ajjah	Yemen
22791	Dhi as Sufal	Ibb	Yemen
22792	Dhamar	Dhamar	Yemen
22795	Ataq	Shabwah	Yemen
22799	Al ?azm	Al Jawf	Yemen
22801	Aden	Aden	Yemen
22802	Mamoudzou	Mamoudzou	Mayotte
22803	Dzaoudzi	Dzaoudzi	Mayotte
22804	Koungou	Koungou	Mayotte
22805	Roodepoort	Gauteng	South Africa
22806	Zeerust	North-West	South Africa
22807	Wolmaransstad	North-West	South Africa
22808	White River	Mpumalanga	South Africa
22809	Witbank	Mpumalanga	South Africa
22810	Westonaria	Gauteng	South Africa
22811	Wesselsbron	Orange Free State	South Africa
22812	Welkom	Orange Free State	South Africa
22813	Warrenton	Northern Cape	South Africa
22814	Warmbaths	Limpopo	South Africa
22815	Vryheid	KwaZulu-Natal	South Africa
22816	Vryburg	North-West	South Africa
22817	Volksrust	Mpumalanga	South Africa
22818	Virginia	Orange Free State	South Africa
22819	Viljoenskroon	Orange Free State	South Africa
22820	Vereeniging	Gauteng	South Africa
22821	Vanderbijlpark	Gauteng	South Africa
22822	Upington	Northern Cape	South Africa
22823	Mthatha	Eastern Cape	South Africa
22824	Umkomaas	KwaZulu-Natal	South Africa
22825	Ulundi	KwaZulu-Natal	South Africa
22826	Uitenhage	Eastern Cape	South Africa
22827	Tzaneen	Limpopo	South Africa
22828	Thohoyandou	Limpopo	South Africa
22829	Theunissen	Orange Free State	South Africa
22830	Thaba Nchu	Orange Free State	South Africa
22831	Tembisa	Gauteng	South Africa
22832	Stutterheim	Eastern Cape	South Africa
22833	Stilfontein	North-West	South Africa
22834	Stanger	KwaZulu-Natal	South Africa
22835	Standerton	Mpumalanga	South Africa
22836	Springs	Gauteng	South Africa
22837	Soweto	Gauteng	South Africa
22838	Somerset East	Eastern Cape	South Africa
22839	Siyabuswa	Mpumalanga	South Africa
22840	Senekal	Orange Free State	South Africa
22841	Secunda	Mpumalanga	South Africa
22842	Scottburgh	KwaZulu-Natal	South Africa
22843	Schweizer-Reneke	North-West	South Africa
22844	Sasolburg	Orange Free State	South Africa
22845	Rustenburg	North-West	South Africa
22846	Richmond	KwaZulu-Natal	South Africa
22847	Richards Bay	KwaZulu-Natal	South Africa
22848	Reitz	Orange Free State	South Africa
22849	Randfontein	Gauteng	South Africa
22850	Queenstown	Eastern Cape	South Africa
22851	Queensdale	Eastern Cape	South Africa
22852	Pretoria	Gauteng	South Africa
22853	Mokopane	Limpopo	South Africa
22854	Potchefstroom	North-West	South Africa
22855	Port Shepstone	KwaZulu-Natal	South Africa
22856	Port Elizabeth	Eastern Cape	South Africa
22857	Port Alfred	Eastern Cape	South Africa
22858	Plettenberg Bay	Western Cape	South Africa
22859	Piet Retief	Mpumalanga	South Africa
22860	Polokwane	Limpopo	South Africa
22861	Pietermaritzburg	KwaZulu-Natal	South Africa
22862	Phuthaditjhaba	Orange Free State	South Africa
22863	Phalaborwa	Limpopo	South Africa
22864	Parys	Orange Free State	South Africa
22865	Pampierstad	North-West	South Africa
22866	Oudtshoorn	Western Cape	South Africa
22867	Orkney	North-West	South Africa
22868	Modimolle	Limpopo	South Africa
22869	Nkowakowa	Limpopo	South Africa
22870	Nigel	Gauteng	South Africa
22871	Newcastle	KwaZulu-Natal	South Africa
22872	Nelspruit	Mpumalanga	South Africa
22873	Mpumalanga	KwaZulu-Natal	South Africa
22874	Mpophomeni	KwaZulu-Natal	South Africa
22875	Mossel Bay	Western Cape	South Africa
22876	Mondlo	KwaZulu-Natal	South Africa
22877	Mmabatho	North-West	South Africa
22878	Middelburg	Eastern Cape	South Africa
22879	Middelburg	Mpumalanga	South Africa
22880	Messina	Limpopo	South Africa
22881	Margate	KwaZulu-Natal	South Africa
22882	Mabopane	Gauteng	South Africa
22883	Lydenburg	Mpumalanga	South Africa
22884	Louis Trichardt	Limpopo	South Africa
22885	Lichtenburg	North-West	South Africa
22886	Lebowakgomo	Limpopo	South Africa
22887	Lady Frere	Eastern Cape	South Africa
22888	Ladybrand	Orange Free State	South Africa
22889	Kutloanong	Orange Free State	South Africa
22890	Kruisfontein	Eastern Cape	South Africa
22891	Krugersdorp	Gauteng	South Africa
22892	Kroonstad	Orange Free State	South Africa
22893	Kriel	Mpumalanga	South Africa
22894	Komatipoort	Mpumalanga	South Africa
22895	Kokstad	KwaZulu-Natal	South Africa
22896	Knysna	Western Cape	South Africa
22897	Klerksdorp	North-West	South Africa
22898	Kimberley	Northern Cape	South Africa
22899	Johannesburg	Gauteng	South Africa
22900	Howick	KwaZulu-Natal	South Africa
22901	Hennenman	Orange Free State	South Africa
22902	Hendrina	Mpumalanga	South Africa
22903	Heilbron	Orange Free State	South Africa
22904	Heidelberg	Gauteng	South Africa
22905	Harrismith	Orange Free State	South Africa
22906	Grahamstown	Eastern Cape	South Africa
22907	Graaff-Reinet	Eastern Cape	South Africa
22908	Giyani	Limpopo	South Africa
22909	George	Western Cape	South Africa
22910	Ga-Rankuwa	North-West	South Africa
22911	Fort Beaufort	Eastern Cape	South Africa
22912	Fochville	North-West	South Africa
22913	eSikhawini	KwaZulu-Natal	South Africa
22914	Ermelo	Mpumalanga	South Africa
22915	Empangeni	KwaZulu-Natal	South Africa
22916	eMbalenhle	Mpumalanga	South Africa
22917	East London	Eastern Cape	South Africa
22918	Durban	KwaZulu-Natal	South Africa
22919	Dundee	KwaZulu-Natal	South Africa
22920	Duiwelskloof	Limpopo	South Africa
22921	Driefontein	Mpumalanga	South Africa
22922	Delmas	Mpumalanga	South Africa
22923	De Aar	Northern Cape	South Africa
22924	Cullinan	Gauteng	South Africa
22925	Cradock	Eastern Cape	South Africa
22926	Christiana	North-West	South Africa
22927	Carletonville	Gauteng	South Africa
22928	Butterworth	Eastern Cape	South Africa
22929	Bronkhorstspruit	Gauteng	South Africa
22930	Brits	North-West	South Africa
22931	Brakpan	Gauteng	South Africa
22932	Botshabelo	Orange Free State	South Africa
22933	Bothaville	Orange Free State	South Africa
22934	Boksburg	Gauteng	South Africa
22935	Bloemhof	North-West	South Africa
22936	Bloemfontein	Orange Free State	South Africa
22937	Bhisho	Eastern Cape	South Africa
22938	Bethlehem	Orange Free State	South Africa
22939	Bethal	Mpumalanga	South Africa
22940	Benoni	Gauteng	South Africa
22941	Beaufort West	Western Cape	South Africa
22942	Barberton	Mpumalanga	South Africa
22943	Ballitoville	KwaZulu-Natal	South Africa
22944	Balfour	Mpumalanga	South Africa
22945	Allanridge	Orange Free State	South Africa
22946	Aliwal North	Eastern Cape	South Africa
22947	Ekangala	Gauteng	South Africa
22948	Midrand	Gauteng	South Africa
22949	Centurion	Gauteng	South Africa
22950	Worcester	Western Cape	South Africa
22951	Stellenbosch	Western Cape	South Africa
22952	Saldanha	Western Cape	South Africa
22953	Paarl	Western Cape	South Africa
22954	Malmesbury	Western Cape	South Africa
22955	Lansdowne	Western Cape	South Africa
22956	Kraaifontein	Western Cape	South Africa
22957	Hermanus	Western Cape	South Africa
22958	Grabouw	Western Cape	South Africa
22959	Ceres	Western Cape	South Africa
22960	Cape Town	Western Cape	South Africa
22961	Atlantis	Western Cape	South Africa
22962	Rondebosch	Western Cape	South Africa
22963	Retreat	Western Cape	South Africa
22964	Diepsloot	Gauteng	South Africa
22965	Nchelenge	Luapula	Zambia
22966	Mbala	Northern	Zambia
22967	Kawambwa	Luapula	Zambia
22968	Siavonga	Southern	Zambia
22969	Sesheke	Western	Zambia
22970	Samfya	Luapula	Zambia
22971	Petauke	Eastern	Zambia
22972	Ndola	Copperbelt	Zambia
22973	Mumbwa	Central	Zambia
22974	Mufulira	Copperbelt	Zambia
22975	Mpika	Northern	Zambia
22976	Monze	Southern	Zambia
22977	Mongu	Western	Zambia
22978	Mazabuka	Southern	Zambia
22979	Mansa	Luapula	Zambia
22980	Lusaka	Lusaka	Zambia
22981	Luanshya	Copperbelt	Zambia
22982	Livingstone	Southern	Zambia
22983	Kitwe	Copperbelt	Zambia
22984	Kasama	Northern	Zambia
22985	Kapiri Mposhi	Central	Zambia
22986	Kansanshi	North-Western	Zambia
22987	Kalulushi	Copperbelt	Zambia
22988	Kafue	Lusaka	Zambia
22989	Kabwe	Central	Zambia
22990	Choma	Southern	Zambia
22991	Chipata	Eastern	Zambia
22992	Chingola	Copperbelt	Zambia
22993	Chililabombwe	Copperbelt	Zambia
22994	Zvishavane	Masvingo	Zimbabwe
22995	Victoria Falls	Matabeleland North	Zimbabwe
22996	Shurugwi	Midlands	Zimbabwe
22997	Rusape	Manicaland	Zimbabwe
22998	Redcliff	Midlands	Zimbabwe
22999	Norton	Mashonaland West	Zimbabwe
23000	Mutare	Manicaland	Zimbabwe
23001	Masvingo	Masvingo	Zimbabwe
23002	Marondera	Mashonaland East	Zimbabwe
23003	Kwekwe	Midlands	Zimbabwe
23004	Karoi	Mashonaland West	Zimbabwe
23005	Kariba	Mashonaland West	Zimbabwe
23006	Kadoma	Mashonaland West	Zimbabwe
23007	Hwange	Matabeleland North	Zimbabwe
23008	Harare	Harare	Zimbabwe
23009	Gweru	Midlands	Zimbabwe
23010	Gokwe	Midlands	Zimbabwe
23011	Chiredzi	Masvingo	Zimbabwe
23012	Chipinge	Manicaland	Zimbabwe
23013	Chinhoyi	Mashonaland West	Zimbabwe
23014	Chegutu	Mashonaland West	Zimbabwe
23015	Bulawayo	Bulawayo	Zimbabwe
23016	Bindura	Mashonaland Central	Zimbabwe
23017	Beitbridge	Matabeleland South	Zimbabwe
23018	Epworth	Harare	Zimbabwe
23019	Chitungwiza	Harare	Zimbabwe
\.


--
-- Data for Name: names; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY names (name, name_type, region) FROM stdin;
Liam	first_m	us
Noah	first_m	us
William	first_m	us
James	first_m	us
Oliver	first_m	us
Benjamin	first_m	us
Elijah	first_m	us
Lucas	first_m	us
Mason	first_m	us
Logan	first_m	us
Alexander	first_m	us
Ethan	first_m	us
Jacob	first_m	us
Michael	first_m	us
Daniel	first_m	us
Henry	first_m	us
Jackson	first_m	us
Sebastian	first_m	us
Aiden	first_m	us
Matthew	first_m	us
Samuel	first_m	us
David	first_m	us
Joseph	first_m	us
Carter	first_m	us
Owen	first_m	us
Wyatt	first_m	us
John	first_m	us
Jack	first_m	us
Luke	first_m	us
Jayden	first_m	us
Dylan	first_m	us
Grayson	first_m	us
Levi	first_m	us
Issac	first_m	us
Gabriel	first_m	us
Julian	first_m	us
Mateo	first_m	us
Anthony	first_m	us
Jaxon	first_m	us
Lincoln	first_m	us
Joshua	first_m	us
Christopher	first_m	us
Andrew	first_m	us
Theodore	first_m	us
Caleb	first_m	us
Ryan	first_m	us
Asher	first_m	us
Nathan	first_m	us
Thomas	first_m	us
Leo	first_m	us
Isaiah	first_m	us
Charles	first_m	us
Josiah	first_m	us
Hudson	first_m	us
Christian	first_m	us
Hunter	first_m	us
Connor	first_m	us
Eli	first_m	us
Ezra	first_m	us
Aaron	first_m	us
Landon	first_m	us
Adrian	first_m	us
Jonathan	first_m	us
Nolan	first_m	us
Jeremiah	first_m	us
Easton	first_m	us
Elias	first_m	us
Colton	first_m	us
Cameron	first_m	us
Carson	first_m	us
Robert	first_m	us
Angel	first_m	us
Maverick	first_m	us
Nicholas	first_m	us
Dominic	first_m	us
Jaxson	first_m	us
Greyson	first_m	us
Adam	first_m	us
Ian	first_m	us
Austin	first_m	us
Santiago	first_m	us
Jordan	first_m	us
Cooper	first_m	us
Brayden	first_m	us
Roman	first_m	us
Evan	first_m	us
Ezekiel	first_m	us
Xavier	first_m	us
Jose	first_m	us
Jace	first_m	us
Jameson	first_m	us
Leonardo	first_m	us
Bryson	first_m	us
Axel	first_m	us
Everett	first_m	us
Parker	first_m	us
Kayden	first_m	us
Miles	first_m	us
Sawyer	first_m	us
Jason	first_m	us
Emma	first_f	us
Olivia	first_f	us
Ava	first_f	us
Isabella	first_f	us
Sophia	first_f	us
Charlotte	first_f	us
Mia	first_f	us
Amelia	first_f	us
Harper	first_f	us
Evelyn	first_f	us
Abigail	first_f	us
Emily	first_f	us
Elizabeth	first_f	us
Mila	first_f	us
Ella	first_f	us
Avery	first_f	us
Sofia	first_f	us
Camila	first_f	us
Aria	first_f	us
Scarlett	first_f	us
Victoria	first_f	us
Madison	first_f	us
Luna	first_f	us
Grace	first_f	us
Chloe	first_f	us
Penelope	first_f	us
Layla	first_f	us
Riley	first_f	us
Zoey	first_f	us
Nora	first_f	us
Lily	first_f	us
Eleanor	first_f	us
Hannah	first_f	us
Lillian	first_f	us
Addison	first_f	us
Aubrey	first_f	us
Ellie	first_f	us
Stella	first_f	us
Natalie	first_f	us
Zoe	first_f	us
Leah	first_f	us
Hazel	first_f	us
Violet	first_f	us
Aurora	first_f	us
Savannah	first_f	us
Audrey	first_f	us
Brooklyn	first_f	us
Bella	first_f	us
Claire	first_f	us
Skylar	first_f	us
Lucy	first_f	us
Paisley	first_f	us
Everly	first_f	us
Anna	first_f	us
Caroline	first_f	us
Nova	first_f	us
Genesis	first_f	us
Emilia	first_f	us
Kennedy	first_f	us
Samantha	first_f	us
Maya	first_f	us
Willow	first_f	us
Kinsley	first_f	us
Naomi	first_f	us
Aaliyah	first_f	us
Elena	first_f	us
Sarah	first_f	us
Ariana	first_f	us
Allison	first_f	us
Gabriella	first_f	us
Alice	first_f	us
Madelyn	first_f	us
Cora	first_f	us
Ruby	first_f	us
Eva	first_f	us
Serenity	first_f	us
Autumn	first_f	us
Adeline	first_f	us
Hailey	first_f	us
Gianna	first_f	us
Valentina	first_f	us
Isla	first_f	us
Eliana	first_f	us
Quinn	first_f	us
Nevaeh	first_f	us
Ivy	first_f	us
Sadie	first_f	us
Piper	first_f	us
Lydia	first_f	us
Alexa	first_f	us
Josephine	first_f	us
Emery	first_f	us
Julia	first_f	us
Delilah	first_f	us
Arianna	first_f	us
Vivian	first_f	us
Kaylee	first_f	us
Sophie	first_f	us
Brielle	first_f	us
Madeline	first_f	us
Smith	last	us
Johnson	last	us
Williams	last	us
Jones	last	us
Brown	last	us
Davis	last	us
Miller	last	us
Wilson	last	us
Moore	last	us
Taylor	last	us
Anderson	last	us
White	last	us
Harris	last	us
Martin	last	us
Thompson	last	us
Garcia	last	us
Martinez	last	us
Robinson	last	us
Clark	last	us
Rodriguez	last	us
Lewis	last	us
Lee	last	us
Walker	last	us
Hall	last	us
Allen	last	us
Young	last	us
Hernandez	last	us
King	last	us
Wright	last	us
Lopez	last	us
Hill	last	us
Scott	last	us
Green	last	us
Adams	last	us
Baker	last	us
Gonzalez	last	us
Nelson	last	us
Mitchell	last	us
Perez	last	us
Roberts	last	us
Turner	last	us
Phillips	last	us
Campbell	last	us
Evans	last	us
Edwards	last	us
Collins	last	us
Stewart	last	us
Sanchez	last	us
Morris	last	us
Rogers	last	us
Reed	last	us
Cook	last	us
Morgan	last	us
Bell	last	us
Murphy	last	us
Bailey	last	us
Rivera	last	us
Richardson	last	us
Cox	last	us
Howard	last	us
Ward	last	us
Torres	last	us
Peterson	last	us
Gray	last	us
Ramirez	last	us
Watson	last	us
Brooks	last	us
Kelly	last	us
Sanders	last	us
Price	last	us
Bennett	last	us
Wood	last	us
Barnes	last	us
Ross	last	us
Henderson	last	us
Coleman	last	us
Jenkins	last	us
Perry	last	us
Powell	last	us
Long	last	us
Patterson	last	us
Hughes	last	us
Flores	last	us
Washington	last	us
Butler	last	us
Simmons	last	us
Foster	last	us
Gonzales	last	us
Bryant	last	us
Russell	last	us
Griffin	last	us
Diaz	last	us
Hayes	last	us
Myers	last	us
Ford	last	us
Hamilton	last	us
Graham	last	us
Sullivan	last	us
Wallace	last	us
Woods	last	us
Cole	last	us
West	last	us
Owens	last	us
Reynolds	last	us
Fisher	last	us
Ellis	last	us
Harrison	last	us
Gibson	last	us
Mcdonald	last	us
Cruz	last	us
Marshall	last	us
Ortiz	last	us
Gomez	last	us
Murray	last	us
Freeman	last	us
Wells	last	us
Webb	last	us
Simpson	last	us
Stevens	last	us
Tucker	last	us
Porter	last	us
Hicks	last	us
Crawford	last	us
Boyd	last	us
Morales	last	us
Warren	last	us
Dixon	last	us
Ramos	last	us
Reyes	last	us
Burns	last	us
Gordon	last	us
Shaw	last	us
Holmes	last	us
Rice	last	us
Robertson	last	us
Hunt	last	us
Black	last	us
Daniels	last	us
Palmer	last	us
Mills	last	us
Nichols	last	us
Grant	last	us
Knight	last	us
Ferguson	last	us
Rose	last	us
Stone	last	us
Hawkins	last	us
Dunn	last	us
Perkins	last	us
Spencer	last	us
Gardner	last	us
Stephens	last	us
Payne	last	us
Pierce	last	us
Berry	last	us
Matthews	last	us
Arnold	last	us
Wagner	last	us
Willis	last	us
Ray	last	us
Watkins	last	us
Olson	last	us
Carroll	last	us
Duncan	last	us
Snyder	last	us
Hart	last	us
Cunningham	last	us
Bradley	last	us
Lane	last	us
Andrews	last	us
Ruiz	last	us
Fox	last	us
Armstrong	last	us
Carpenter	last	us
Weaver	last	us
Greene	last	us
Lawrence	last	us
Elliott	last	us
Chavez	last	us
Sims	last	us
Peters	last	us
Kelley	last	us
Franklin	last	us
Lawson	last	us
Fields	last	us
Gutierrez	last	us
Schmidt	last	us
Carr	last	us
Vasquez	last	us
Castillo	last	us
Wheeler	last	us
Chapman	last	us
Montgomery	last	us
Richards	last	us
Williamson	last	us
Johnston	last	us
Banks	last	us
Meyer	last	us
Bishop	last	us
Mccoy	last	us
Howell	last	us
Alvarez	last	us
Morrison	last	us
Hansen	last	us
Fernandez	last	us
Garza	last	us
Harvey	last	us
Little	last	us
Burton	last	us
Stanley	last	us
Nguyen	last	us
George	last	us
Jacobs	last	us
Reid	last	us
Kim	last	us
Fuller	last	us
Lynch	last	us
Dean	last	us
Gilbert	last	us
Garrett	last	us
Romero	last	us
Welch	last	us
Larson	last	us
Frazier	last	us
Burke	last	us
Hanson	last	us
Day	last	us
Mendoza	last	us
Moreno	last	us
Bowman	last	us
Medina	last	us
Fowler	last	us
Brewer	last	us
Hoffman	last	us
Carlson	last	us
Silva	last	us
Pearson	last	us
Holland	last	us
Douglas	last	us
Fleming	last	us
Jensen	last	us
Vargas	last	us
Byrd	last	us
Davidson	last	us
Hopkins	last	us
May	last	us
Terry	last	us
Herrera	last	us
Wade	last	us
Soto	last	us
Walters	last	us
Curtis	last	us
Neal	last	us
Caldwell	last	us
Lowe	last	us
Jennings	last	us
Barnett	last	us
Graves	last	us
Jimenez	last	us
Horton	last	us
Shelton	last	us
Barrett	last	us
Obrien	last	us
Castro	last	us
Sutton	last	us
Gregory	last	us
Mckinney	last	us
Craig	last	us
Rodriquez	last	us
Chambers	last	us
Holt	last	us
Lambert	last	us
Fletcher	last	us
Watts	last	us
Bates	last	us
Hale	last	us
Rhodes	last	us
Pena	last	us
Beck	last	us
Newman	last	us
Haynes	last	us
Mcdaniel	last	us
Mendez	last	us
Bush	last	us
Vaughn	last	us
Parks	last	us
Dawson	last	us
Norris	last	us
Hardy	last	us
Love	last	us
Steele	last	us
Curry	last	us
Powers	last	us
Schultz	last	us
Barker	last	us
Guzman	last	us
Page	last	us
Munoz	last	us
Ball	last	us
Keller	last	us
Chandler	last	us
Weber	last	us
Leonard	last	us
Walsh	last	us
Lyons	last	us
Ramsey	last	us
Wolfe	last	us
Schneider	last	us
Mullins	last	us
Benson	last	us
Sharp	last	us
Bowen	last	us
Barber	last	us
Cummings	last	us
Hines	last	us
Baldwin	last	us
Griffith	last	us
Valdez	last	us
Hubbard	last	us
Salazar	last	us
Reeves	last	us
Warner	last	us
Stevenson	last	us
Burgess	last	us
Santos	last	us
Tate	last	us
Cross	last	us
Garner	last	us
Mann	last	us
Mack	last	us
Moss	last	us
Thornton	last	us
Dennis	last	us
Mcgee	last	us
Farmer	last	us
Delgado	last	us
Aguilar	last	us
Vega	last	us
Glover	last	us
Manning	last	us
Cohen	last	us
Harmon	last	us
Rodgers	last	us
Robbins	last	us
Newton	last	us
Todd	last	us
Blair	last	us
Higgins	last	us
Ingram	last	us
Reese	last	us
Cannon	last	us
Strickland	last	us
Townsend	last	us
Potter	last	us
Goodwin	last	us
Walton	last	us
Rowe	last	us
Hampton	last	us
Ortega	last	us
Patton	last	us
Swanson	last	us
Francis	last	us
Goodman	last	us
Maldonado	last	us
Yates	last	us
Becker	last	us
Erickson	last	us
Hodges	last	us
Rios	last	us
Conner	last	us
Adkins	last	us
Webster	last	us
Norman	last	us
Malone	last	us
Hammond	last	us
Flowers	last	us
Cobb	last	us
Moody	last	us
Blake	last	us
Maxwell	last	us
Pope	last	us
Floyd	last	us
Osborne	last	us
Paul	last	us
Mccarthy	last	us
Guerrero	last	us
Lindsey	last	us
Estrada	last	us
Sandoval	last	us
Gibbs	last	us
Tyler	last	us
Gross	last	us
Fitzgerald	last	us
Stokes	last	us
Doyle	last	us
Sherman	last	us
Saunders	last	us
Wise	last	us
Colon	last	us
Gill	last	us
Alvarado	last	us
Greer	last	us
Padilla	last	us
Simon	last	us
Waters	last	us
Nunez	last	us
Ballard	last	us
Schwartz	last	us
Mcbride	last	us
Houston	last	us
Christensen	last	us
Klein	last	us
Pratt	last	us
Briggs	last	us
Parsons	last	us
Mclaughlin	last	us
Zimmerman	last	us
French	last	us
Buchanan	last	us
Moran	last	us
Copeland	last	us
Roy	last	us
Pittman	last	us
Brady	last	us
Mccormick	last	us
Holloway	last	us
Brock	last	us
Poole	last	us
Frank	last	us
Bass	last	us
Marsh	last	us
Drake	last	us
Wong	last	us
Jefferson	last	us
Park	last	us
Morton	last	us
Abbott	last	us
Sparks	last	us
Patrick	last	us
Norton	last	us
Huff	last	us
Clayton	last	us
Massey	last	us
Lloyd	last	us
Figueroa	last	us
Bowers	last	us
Roberson	last	us
Barton	last	us
Tran	last	us
Lamb	last	us
Harrington	last	us
Casey	last	us
Boone	last	us
Cortez	last	us
Clarke	last	us
Mathis	last	us
Singleton	last	us
Wilkins	last	us
Cain	last	us
Bryan	last	us
Underwood	last	us
Hogan	last	us
Mckenzie	last	us
Collier	last	us
Phelps	last	us
Mcguire	last	us
Bridges	last	us
Wilkerson	last	us
Nash	last	us
Summers	last	us
Atkins	last	us
Wilcox	last	us
Pitts	last	us
Conley	last	us
Marquez	last	us
Burnett	last	us
Richard	last	us
Cochran	last	us
Chase	last	us
Davenport	last	us
Hood	last	us
Gates	last	us
Clay	last	us
Ayala	last	us
Vazquez	last	us
Dickerson	last	us
Hodge	last	us
Acosta	last	us
Flynn	last	us
Espinoza	last	us
Nicholson	last	us
Monroe	last	us
Wolf	last	us
Morrow	last	us
Kirk	last	us
Randall	last	us
Whitaker	last	us
Oconnor	last	us
Skinner	last	us
Ware	last	us
Molina	last	us
Kirby	last	us
Huffman	last	us
Bradford	last	us
Gilmore	last	us
Dominguez	last	us
Oneal	last	us
Bruce	last	us
Lang	last	us
Combs	last	us
Kramer	last	us
Heath	last	us
Hancock	last	us
Gallagher	last	us
Gaines	last	us
Shaffer	last	us
Short	last	us
Wiggins	last	us
Mathews	last	us
Mcclain	last	us
Fischer	last	us
Wall	last	us
Small	last	us
Melton	last	us
Hensley	last	us
Bond	last	us
Dyer	last	us
Grimes	last	us
Contreras	last	us
Baxter	last	us
Snow	last	us
Mosley	last	us
Shepherd	last	us
Larsen	last	us
Hoover	last	us
Beasley	last	us
Glenn	last	us
Petersen	last	us
Whitehead	last	us
Meyers	last	us
Keith	last	us
Garrison	last	us
Vincent	last	us
Shields	last	us
Horn	last	us
Savage	last	us
Olsen	last	us
Schroeder	last	us
Hartman	last	us
Woodard	last	us
Mueller	last	us
Kemp	last	us
Deleon	last	us
Booth	last	us
Patel	last	us
Calhoun	last	us
Wiley	last	us
Eaton	last	us
Cline	last	us
Navarro	last	us
Harrell	last	us
Lester	last	us
Humphrey	last	us
Parrish	last	us
Duran	last	us
Hutchinson	last	us
Hess	last	us
Dorsey	last	us
Bullock	last	us
Robles	last	us
Beard	last	us
Dalton	last	us
Avila	last	us
Vance	last	us
Rich	last	us
Blackwell	last	us
York	last	us
Johns	last	us
Blankenship	last	us
Trevino	last	us
Salinas	last	us
Campos	last	us
Pruitt	last	us
Moses	last	us
Callahan	last	us
Golden	last	us
Montoya	last	us
Hardin	last	us
Guerra	last	us
Mcdowell	last	us
Carey	last	us
Stafford	last	us
Gallegos	last	us
Henson	last	us
Wilkinson	last	us
Booker	last	us
Merritt	last	us
Miranda	last	us
Atkinson	last	us
Orr	last	us
Decker	last	us
Hobbs	last	us
Preston	last	us
Tanner	last	us
Knox	last	us
Pacheco	last	us
Stephenson	last	us
Glass	last	us
Rojas	last	us
Serrano	last	us
Marks	last	us
Hickman	last	us
English	last	us
Sweeney	last	us
Strong	last	us
Prince	last	us
Mcclure	last	us
Conway	last	us
Walter	last	us
Roth	last	us
Maynard	last	us
Farrell	last	us
Lowery	last	us
Hurst	last	us
Nixon	last	us
Weiss	last	us
Trujillo	last	us
Ellison	last	us
Sloan	last	us
Juarez	last	us
Winters	last	us
Mclean	last	us
Randolph	last	us
Leon	last	us
Boyer	last	us
Villarreal	last	us
Mccall	last	us
Gentry	last	us
Carrillo	last	us
Kent	last	us
Ayers	last	us
Lara	last	us
Shannon	last	us
Sexton	last	us
Pace	last	us
Hull	last	us
Leblanc	last	us
Browning	last	us
Velasquez	last	us
Leach	last	us
Chang	last	us
House	last	us
Sellers	last	us
Herring	last	us
Noble	last	us
Foley	last	us
Bartlett	last	us
Mercado	last	us
Landry	last	us
Durham	last	us
Walls	last	us
Barr	last	us
Mckee	last	us
Bauer	last	us
Rivers	last	us
Bradshaw	last	us
Pugh	last	us
Velez	last	us
Rush	last	us
Estes	last	us
Dodson	last	us
Morse	last	us
Sheppard	last	us
Weeks	last	us
Camacho	last	us
Bean	last	us
Barron	last	us
Livingston	last	us
Middleton	last	us
Spears	last	us
Branch	last	us
Blevins	last	us
Chen	last	us
Kerr	last	us
Mcconnell	last	us
Hatfield	last	us
Harding	last	us
Ashley	last	us
Solis	last	us
Herman	last	us
Frost	last	us
Giles	last	us
Blackburn	last	us
Pennington	last	us
Woodward	last	us
Finley	last	us
Mcintosh	last	us
Koch	last	us
Best	last	us
Solomon	last	us
Mccullough	last	us
Dudley	last	us
Blanchard	last	us
Rivas	last	us
Brennan	last	us
Mejia	last	us
Kane	last	us
Benton	last	us
Joyce	last	us
Buckley	last	us
Haley	last	us
Valentine	last	us
Maddox	last	us
Russo	last	us
Mcknight	last	us
Buck	last	us
Moon	last	us
Mcmillan	last	us
Crosby	last	us
Berg	last	us
Dotson	last	us
Mays	last	us
Roach	last	us
Church	last	us
Chan	last	us
Richmond	last	us
Meadows	last	us
Faulkner	last	us
Oneill	last	us
Knapp	last	us
Kline	last	us
Barry	last	us
Ochoa	last	us
Jacobson	last	us
Gay	last	us
Hendricks	last	us
Horne	last	us
Shepard	last	us
Hebert	last	us
Cherry	last	us
Cardenas	last	us
Mcintyre	last	us
Whitney	last	us
Waller	last	us
Holman	last	us
Donaldson	last	us
Cantu	last	us
Terrell	last	us
Morin	last	us
Gillespie	last	us
Fuentes	last	us
Tillman	last	us
Sanford	last	us
Bentley	last	us
Peck	last	us
Key	last	us
Salas	last	us
Rollins	last	us
Gamble	last	us
Dickson	last	us
Battle	last	us
Santana	last	us
Cabrera	last	us
Cervantes	last	us
Howe	last	us
Hinton	last	us
Hurley	last	us
Spence	last	us
Zamora	last	us
Yang	last	us
Mcneil	last	us
Suarez	last	us
Case	last	us
Petty	last	us
Gould	last	us
Mcfarland	last	us
Sampson	last	us
Carver	last	us
Bray	last	us
Rosario	last	us
Macdonald	last	us
Stout	last	us
Hester	last	us
Melendez	last	us
Dillon	last	us
Farley	last	us
Hopper	last	us
Galloway	last	us
Potts	last	us
Bernard	last	us
Joyner	last	us
Stein	last	us
Aguirre	last	us
Osborn	last	us
Mercer	last	us
Bender	last	us
Franco	last	us
Rowland	last	us
Sykes	last	us
Travis	last	us
Pickett	last	us
Crane	last	us
Sears	last	us
Mayo	last	us
Dunlap	last	us
Hayden	last	us
Wilder	last	us
Mckay	last	us
Coffey	last	us
Mccarty	last	us
Ewing	last	us
Cooley	last	us
Vaughan	last	us
Bonner	last	us
Cotton	last	us
Holder	last	us
Stark	last	us
Ferrell	last	us
Cantrell	last	us
Fulton	last	us
Lynn	last	us
Lott	last	us
Calderon	last	us
Rosa	last	us
Pollard	last	us
Hooper	last	us
Burch	last	us
Mullen	last	us
Fry	last	us
Riddle	last	us
Levy	last	us
Duke	last	us
Odonnell	last	us
Guy	last	us
Britt	last	us
Frederick	last	us
Daugherty	last	us
Berger	last	us
Dillard	last	us
Alston	last	us
Jarvis	last	us
Frye	last	us
Riggs	last	us
Chaney	last	us
Odom	last	us
Duffy	last	us
Fitzpatrick	last	us
Valenzuela	last	us
Merrill	last	us
Mayer	last	us
Alford	last	us
Mcpherson	last	us
Acevedo	last	us
Donovan	last	us
Barrera	last	us
Albert	last	us
Cote	last	us
Reilly	last	us
Compton	last	us
Raymond	last	us
Mooney	last	us
Mcgowan	last	us
Craft	last	us
Cleveland	last	us
Clemons	last	us
Wynn	last	us
Nielsen	last	us
Baird	last	us
Stanton	last	us
Snider	last	us
Rosales	last	us
Bright	last	us
Witt	last	us
Stuart	last	us
Hays	last	us
Holden	last	us
Rutledge	last	us
Kinney	last	us
Clements	last	us
Castaneda	last	us
Slater	last	us
Hahn	last	us
Emerson	last	us
Conrad	last	us
Burks	last	us
Delaney	last	us
Pate	last	us
Lancaster	last	us
Sweet	last	us
Justice	last	us
Tyson	last	us
Sharpe	last	us
Whitfield	last	us
Talley	last	us
Macias	last	us
Irwin	last	us
Burris	last	us
Ratliff	last	us
Mccray	last	us
Madden	last	us
Kaufman	last	us
Beach	last	us
Goff	last	us
Cash	last	us
Bolton	last	us
Mcfadden	last	us
Levine	last	us
Good	last	us
Byers	last	us
Kirkland	last	us
Kidd	last	us
Workman	last	us
Carney	last	us
Dale	last	us
Mcleod	last	us
Holcomb	last	us
England	last	us
Finch	last	us
Head	last	us
Burt	last	us
Hendrix	last	us
Sosa	last	us
Haney	last	us
Franks	last	us
Sargent	last	us
Nieves	last	us
Downs	last	us
Rasmussen	last	us
Bird	last	us
Hewitt	last	us
Lindsay	last	us
Le	last	us
Foreman	last	us
Valencia	last	us
Oneil	last	us
Delacruz	last	us
Vinson	last	us
Dejesus	last	us
Hyde	last	us
Forbes	last	us
Gilliam	last	us
Guthrie	last	us
Wooten	last	us
Huber	last	us
Barlow	last	us
Boyle	last	us
Mcmahon	last	us
Buckner	last	us
Rocha	last	us
Puckett	last	us
Langley	last	us
Knowles	last	us
Cooke	last	us
Velazquez	last	us
Whitley	last	us
Noel	last	us
Vangshea	last	us
Rouse	last	us
Hartley	last	us
Mayfield	last	us
Elder	last	us
Rankin	last	us
Hanna	last	us
Cowan	last	us
Lucero	last	us
Arroyo	last	us
Slaughter	last	us
Haas	last	us
Oconnell	last	us
Minor	last	us
Kendrick	last	us
Shirley	last	us
Kendall	last	us
Boucher	last	us
Archer	last	us
Boggs	last	us
Odell	last	us
Dougherty	last	us
Andersen	last	us
Newell	last	us
Crowe	last	us
Wang	last	us
Friedman	last	us
Bland	last	us
Swain	last	us
Holley	last	us
Felix	last	us
Pearce	last	us
Childs	last	us
Yarbrough	last	us
Galvan	last	us
Proctor	last	us
Meeks	last	us
Lozano	last	us
Mora	last	us
Rangel	last	us
Bacon	last	us
Villanueva	last	us
Schaefer	last	us
Rosado	last	us
Helms	last	us
Boyce	last	us
Goss	last	us
Stinson	last	us
Smart	last	us
Lake	last	us
Ibarra	last	us
Hutchins	last	us
Covington	last	us
Reyna	last	us
Gregg	last	us
Werner	last	us
Crowley	last	us
Hatcher	last	us
Mackey	last	us
Bunch	last	us
Womack	last	us
Polk	last	us
Jamison	last	us
Dodd	last	us
Childress	last	us
Childers	last	us
Camp	last	us
Villa	last	us
Dye	last	us
Springer	last	us
Mahoney	last	us
Dailey	last	us
Belcher	last	us
Lockhart	last	us
Griggs	last	us
Costa	last	us
Brandt	last	us
Winter	last	us
Walden	last	us
Moser	last	us
Tracy	last	us
Tatum	last	us
Mccann	last	us
Akers	last	us
Lutz	last	us
Pryor	last	us
Law	last	us
Orozco	last	us
Mcallister	last	us
Lugo	last	us
Davies	last	us
Shoemaker	last	us
Rutherford	last	us
Newsome	last	us
Magee	last	us
Chamberlain	last	us
Blanton	last	us
Simms	last	us
Godfrey	last	us
Flanagan	last	us
Crum	last	us
Cordova	last	us
Escobar	last	us
Downing	last	us
Sinclair	last	us
Donahue	last	us
Krueger	last	us
Mcginnis	last	us
Gore	last	us
Farris	last	us
Webber	last	us
Corbett	last	us
Andrade	last	us
Starr	last	us
Lyon	last	us
Yoder	last	us
Hastings	last	us
Mcgrath	last	us
Spivey	last	us
Krause	last	us
Harden	last	us
Crabtree	last	us
Kirkpatrick	last	us
Hollis	last	us
Brandon	last	us
Arrington	last	us
Ervin	last	us
Clifton	last	us
Ritter	last	us
Mcghee	last	us
Bolden	last	us
Maloney	last	us
Gagnon	last	us
Dunbar	last	us
Ponce	last	us
Pike	last	us
Mayes	last	us
Heard	last	us
Beatty	last	us
Mobley	last	us
Kimball	last	us
Butts	last	us
Montes	last	us
Herbert	last	us
Grady	last	us
Eldridge	last	us
Braun	last	us
Hamm	last	us
Gibbons	last	us
Seymour	last	us
Moyer	last	us
Manley	last	us
Herron	last	us
Plummer	last	us
Elmore	last	us
Cramer	last	us
Gary	last	us
Rucker	last	us
Hilton	last	us
Blue	last	us
Pierson	last	us
Fontenot	last	us
Field	last	us
Rubio	last	us
Goldstein	last	us
Elkins	last	us
Wills	last	us
Novak	last	us
Hickey	last	us
Worley	last	us
Gorman	last	us
Katz	last	us
Dickinson	last	us
Broussard	last	us
Fritz	last	us
Woodruff	last	us
Crow	last	us
Britton	last	us
Forrest	last	us
Nance	last	us
Lehman	last	us
Bingham	last	us
Zuniga	last	us
Whaley	last	us
Shafer	last	us
Coffman	last	us
Steward	last	us
Delarosa	last	us
Nix	last	us
Neely	last	us
Numbers	last	us
Mata	last	us
Manuel	last	us
Davila	last	us
Mccabe	last	us
Kessler	last	us
Bowling	last	us
Hinkle	last	us
Welsh	last	us
Pagan	last	us
Goldberg	last	us
Goins	last	us
Crouch	last	us
Cuevas	last	us
Quinones	last	us
Mcdermott	last	us
Hendrickson	last	us
Samuels	last	us
Denton	last	us
Bergeron	last	us
Lam	last	us
Ivey	last	us
Locke	last	us
Haines	last	us
Thurman	last	us
Snell	last	us
Hoskins	last	us
Byrne	last	us
Milton	last	us
Winston	last	us
Arthur	last	us
Arias	last	us
Stanford	last	us
Roe	last	us
Corbin	last	us
Beltran	last	us
Chappell	last	us
Hurt	last	us
Downey	last	us
Dooley	last	us
Tuttle	last	us
Couch	last	us
Payton	last	us
Mcelroy	last	us
Crockett	last	us
Groves	last	us
Clement	last	us
Leslie	last	us
Cartwright	last	us
Dickey	last	us
Mcgill	last	us
Dubois	last	us
Muniz	last	us
Erwin	last	us
Self	last	us
Tolbert	last	us
Dempsey	last	us
Cisneros	last	us
Sewell	last	us
Latham	last	us
Garland	last	us
Vigil	last	us
Tapia	last	us
Sterling	last	us
Rainey	last	us
Norwood	last	us
Lacy	last	us
Stroud	last	us
Meade	last	us
Amos	last	us
Tipton	last	us
Lord	last	us
Kuhn	last	us
Hilliard	last	us
Bonilla	last	us
Teague	last	us
Courtney	last	us
Gunn	last	us
Ho	last	us
Greenwood	last	us
Correa	last	us
Reece	last	us
Weston	last	us
Poe	last	us
Trent	last	us
Pineda	last	us
Phipps	last	us
Frey	last	us
Kaiser	last	us
Ames	last	us
Paige	last	us
Gunter	last	us
Schmitt	last	us
Milligan	last	us
Espinosa	last	us
Carlton	last	us
Bowden	last	us
Vickers	last	us
Lowry	last	us
Pritchard	last	us
Costello	last	us
Mcclellan	last	us
Lovell	last	us
Drew	last	us
Sheehan	last	us
Quick	last	us
Hatch	last	us
Dobson	last	us
Singh	last	us
Jeffries	last	us
Hollingsworth	last	us
Sorensen	last	us
Meza	last	us
Fink	last	us
Donnelly	last	us
Burrell	last	us
Bruno	last	us
Tomlinson	last	us
Colbert	last	us
Billings	last	us
Ritchie	last	us
Helton	last	us
Sutherland	last	us
Peoples	last	us
Mcqueen	last	us
Gaston	last	us
Thomason	last	us
Mckinley	last	us
Givens	last	us
Crocker	last	us
Vogel	last	us
Robison	last	us
Dunham	last	us
Coker	last	us
Swartz	last	us
Keys	last	us
Lilly	last	us
Ladner	last	us
Willard	last	us
Richter	last	us
Hargrove	last	us
Edmonds	last	us
Brantley	last	us
Albright	last	us
Murdock	last	us
Boswell	last	us
Muller	last	us
Quintero	last	us
Padgett	last	us
Kenney	last	us
Daly	last	us
Connolly	last	us
Pierre	last	us
Inman	last	us
Quintana	last	us
Lund	last	us
Barnard	last	us
Villegas	last	us
Simons	last	us
Land	last	us
Huggins	last	us
Tidwell	last	us
Sanderson	last	us
Bullard	last	us
Mcclendon	last	us
Duarte	last	us
Draper	last	us
Meredith	last	us
Marrero	last	us
Dwyer	last	us
Abrams	last	us
Stover	last	us
Goode	last	us
Fraser	last	us
Crews	last	us
Bernal	last	us
Smiley	last	us
Godwin	last	us
Fish	last	us
Conklin	last	us
Mcneal	last	us
Baca	last	us
Esparza	last	us
Crowder	last	us
Bower	last	us
Chung	last	us
Brewster	last	us
Mcneill	last	us
Dick	last	us
Rodrigues	last	us
Leal	last	us
Coates	last	us
Raines	last	us
Mccain	last	us
Mccord	last	us
Miner	last	us
Holbrook	last	us
Swift	last	us
Dukes	last	us
Carlisle	last	us
Aldridge	last	us
Ackerman	last	us
Starks	last	us
Ricks	last	us
Holliday	last	us
Ferris	last	us
Hairston	last	us
Sheffield	last	us
Lange	last	us
Fountain	last	us
Marino	last	us
Doss	last	us
Betts	last	us
Kaplan	last	us
Carmichael	last	us
Bloom	last	us
Ruffin	last	us
Penn	last	us
Kern	last	us
Bowles	last	us
Sizemore	last	us
Larkin	last	us
Dupree	last	us
Jewell	last	us
Silver	last	us
Seals	last	us
Metcalf	last	us
Hutchison	last	us
Henley	last	us
Farr	last	us
Castle	last	us
Mccauley	last	us
Hankins	last	us
Gustafson	last	us
Deal	last	us
Curran	last	us
Ash	last	us
Waddell	last	us
Ramey	last	us
Cates	last	us
Pollock	last	us
Major	last	us
Irvin	last	us
Cummins	last	us
Messer	last	us
Heller	last	us
Dewitt	last	us
Lin	last	us
Funk	last	us
Cornett	last	us
Palacios	last	us
Galindo	last	us
Cano	last	us
Hathaway	last	us
Singer	last	us
Pham	last	us
Enriquez	last	us
Salgado	last	us
Pelletier	last	us
Painter	last	us
Wiseman	last	us
Blount	last	us
Hand	last	us
Feliciano	last	us
Temple	last	us
Houser	last	us
Doherty	last	us
Mead	last	us
Mcgraw	last	us
Toney	last	us
Swan	last	us
Melvin	last	us
Capps	last	us
Blanco	last	us
Blackmon	last	us
Wesley	last	us
Thomson	last	us
Mcmanus	last	us
Fair	last	us
Burkett	last	us
Post	last	us
Gleason	last	us
Rudolph	last	us
Ott	last	us
Dickens	last	us
Cormier	last	us
Voss	last	us
Rushing	last	us
Rosenberg	last	us
Hurd	last	us
Dumas	last	us
Benitez	last	us
Arellano	last	us
Story	last	us
Marin	last	us
Caudill	last	us
Bragg	last	us
Jaramillo	last	us
Huerta	last	us
Gipson	last	us
Colvin	last	us
Biggs	last	us
Vela	last	us
Platt	last	us
Cassidy	last	us
Tompkins	last	us
Mccollum	last	us
Kay	last	us
Dolan	last	us
Daley	last	us
Crump	last	us
Street	last	us
Sneed	last	us
Kilgore	last	us
Grove	last	us
Grimm	last	us
Davison	last	us
Brunson	last	us
Prater	last	us
Marcum	last	us
Devine	last	us
\.


--
-- Data for Name: sentence_frag; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sentence_frag (fragment, id, type) FROM stdin;
\.


--
-- Data for Name: twitter_posts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY twitter_posts (user_id, id, id_str, created_at, text, hashtags, urls, user_mention, symbols, topic) FROM stdin;
\.


--
-- Data for Name: twitter_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY twitter_users (id, id_str, screen_name, location, created_at, followers, favourites, statuses, description, gender, group_name) FROM stdin;
1	000000001	user1	Fairfax	2018-10-25 12:00:00	50	100	25	I am a student	f	group1
\.


--
-- Data for Name: words; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY words (word, sentiment, type) FROM stdin;
\.


--
-- Name: locations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);


--
-- Name: names_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY names
    ADD CONSTRAINT names_pkey PRIMARY KEY (name, region);


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
-- Name: words_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY words
    ADD CONSTRAINT words_pkey PRIMARY KEY (word, type);


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

