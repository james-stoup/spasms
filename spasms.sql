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
	CONSTRAINT nametypes_check CHECK (((VALUE)::text = ANY ((ARRAY['first_m'::character varying, 'first_f'::character varying, 'last'::character varying])::text[])));


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
	CONSTRAINT wordtypes_check CHECK (((VALUE)::text = ANY (ARRAY[('noun'::character varying)::text, ('adjective'::character varying)::text, ('adverb'::character varying)::text, ('verb'::character varying)::text])));


ALTER DOMAIN public.wordtypes OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: locations; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE locations (
    id numeric(9,0) NOT NULL,
    city character varying(20) NOT NULL,
    state character varying(20),
    country character varying(30) NOT NULL
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
    symbols character varying(500)
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
    word character varying(20) NOT NULL,
    sentiment numeric(1,0) NOT NULL,
    type wordtypes
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
2422	Coquitlam	British Columbia	Canada
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
2582	Yorkton	Saskatchewan	Canada
2583	Halifax	Nova Scotia	Canada
2591	Edmundston	New Brunswick	Canada
2592	Thetford-Mines	Quebec	Canada
2593	Scarborough	Ontario	Canada
2594	Cole Harbour	Nova Scotia	Canada
2595	Okanagan	British Columbia	Canada
2596	West Kelowna	British Columbia	Canada
2600	Ladner	British Columbia	Canada
2601	Walnut Grove	British Columbia	Canada
2602	Ancaster	Ontario	Canada
2603	West Vancouver	British Columbia	Canada
2604	Willowdale	Ontario	Canada
2605	Lower Sacvkille	Nova Scotia	Canada
2606	West Island	N/A	Cocos Islands
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
2777	Seen (Kreis 3)	Zurich	Switzerland
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
2873	Punta Arenas	Magallanes	Chile
2874	Puerto Varas	Los Lagos	Chile
2876	Puerto Natales	Magallanes	Chile
2877	Puerto Montt	Los Lagos	Chile
2883	Parral	Maule	Chile
2886	Ovalle	Coquimbo	Chile
2887	Osorno	Los Lagos	Chile
2891	Molina	Maule	Chile
2912	Frutillar	Los Lagos	Chile
2914	Diego de Almagro	Atacama	Chile
2918	Coquimbo	Coquimbo	Chile
3270	Qingdao	Shandong Sheng	China
3271	Qingyuan	Guangdong	China
3272	Hongqiao	Hunan	China
3273	Puyang Chengguanzhen	Henan Sheng	China
3274	Puyang	Zhejiang Sheng	China
3275	Putian	Fujian	China
3276	Puqi	Hubei	China
3278	Pulandian	Liaoning	China
3279	Poyang	Jiangxi Sheng	China
3280	Pingyin	Shandong Sheng	China
3281	Pingyi	Shandong Sheng	China
3282	Gutao	Shanxi Sheng	China
3283	Pingxiang	Jiangxi Sheng	China
3284	Pingshan	Guangdong	China
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
3299	Nanyang	Henan Sheng	China
3300	Nantong	Jiangsu	China
3301	Pucheng	Fujian	China
3302	Nanping	Fujian	China
3304	Nanma	Shandong Sheng	China
3305	Nanlong	Sichuan	China
3306	Nanjing	Jiangsu	China
3307	Nangong	Hebei	China
3308	Nanfeng	Guangdong	China
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
3357	Lincheng	Hainan	China
3358	Linfen	Shanxi Sheng	China
3359	Xishan	Hunan	China
3360	Lichuan	Hubei	China
3361	Licheng	Guangdong	China
3362	Liaocheng	Shandong Sheng	China
3363	Lianzhou	Guangdong	China
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
3572	Binzhou	Shandong Sheng	China
3574	Bijie	Guizhou Sheng	China
3575	Bianzhuang	Shandong Sheng	China
3576	Bengbu	Anhui Sheng	China
3577	Beijing	Beijing	China
3579	Beidao	Gansu Sheng	China
3580	Beidaihehaibin	Hebei	China
3581	Beibei	Chongqing Shi	China
3582	Baoying	Jiangsu	China
3583	Langzhong	Sichuan	China
3584	Baoding	Hebei	China
3585	Baiyin	Gansu Sheng	China
3587	Shangyu	Zhejiang Sheng	China
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
4308	Zossen	Brandenburg	Germany
4309	Zittau	Saxony	Germany
4310	Zirndorf	Bavaria	Germany
4311	Zerbst	Saxony-Anhalt	Germany
4312	Zeitz	Saxony-Anhalt	Germany
4313	Zehlendorf	Berlin	Germany
4315	Wurzen	Saxony	Germany
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
4336	Winterhude	Hamburg	Germany
4337	Winsen	Lower Saxony	Germany
4340	Wilmersdorf	Berlin	Germany
4342	Wilhelmstadt	Berlin	Germany
4343	Wilhelmshaven	Lower Saxony	Germany
4344	Wildeshausen	Lower Saxony	Germany
4346	Wiesbaden	Hesse	Germany
4348	Wetzlar	Hesse	Germany
4350	Westerstede	Lower Saxony	Germany
4351	Westend	Berlin	Germany
4355	Wernigerode	Saxony-Anhalt	Germany
4360	Werder	Brandenburg	Germany
4361	Werdau	Saxony	Germany
4364	Wendelstein	Bavaria	Germany
4365	Weiterstadt	Hesse	Germany
4372	Weimar	Thuringia	Germany
4373	Weilheim	Bavaria	Germany
4377	Weiden	Bavaria	Germany
4380	Weener	Lower Saxony	Germany
4381	Wedel	Schleswig-Holstein	Germany
4382	Wedding	Berlin	Germany
4387	Wardenburg	Lower Saxony	Germany
4390	Wandlitz	Brandenburg	Germany
4392	Walsrode	Lower Saxony	Germany
4393	Wallenhorst	Lower Saxony	Germany
4395	Waldkraiburg	Bavaria	Germany
4400	Wadgassen	Saarland	Germany
4401	Wadern	Saarland	Germany
4407	Vilshofen	Bavaria	Germany
4410	Viernheim	Hesse	Germany
4413	Verden	Lower Saxony	Germany
4415	Vechta	Lower Saxony	Germany
4416	Vechelde	Lower Saxony	Germany
4417	Vaterstetten	Bavaria	Germany
4418	Varel	Lower Saxony	Germany
4420	Uetersen	Schleswig-Holstein	Germany
4421	Uslar	Lower Saxony	Germany
4423	Unterhaching	Bavaria	Germany
4427	Uelzen	Lower Saxony	Germany
4434	Trier	Rheinland-Pfalz	Germany
4435	Traunstein	Bavaria	Germany
4436	Traunreut	Bavaria	Germany
4437	Torgau	Saxony	Germany
4440	Templin	Brandenburg	Germany
4441	Tempelhof	Berlin	Germany
4442	Teltow	Brandenburg	Germany
4444	Tegel	Berlin	Germany
4445	Taunusstein	Hesse	Germany
4446	Taufkirchen	Bavaria	Germany
4447	Syke	Lower Saxony	Germany
4449	Sulzbach-Rosenberg	Bavaria	Germany
4450	Sulzbach	Saarland	Germany
4451	Suhl	Thuringia	Germany
4453	Stuhr	Lower Saxony	Germany
4454	Strausberg	Brandenburg	Germany
4455	Straubing	Bavaria	Germany
4459	Stockelsdorf	Schleswig-Holstein	Germany
4461	Stendal	Saxony-Anhalt	Germany
4462	Stellingen	Hamburg	Germany
4465	Steilshoop	Hamburg	Germany
4466	Steglitz	Berlin	Germany
4468	Starnberg	Bavaria	Germany
4470	Stadthagen	Lower Saxony	Germany
4471	Stadtallendorf	Hesse	Germany
4472	Stade	Lower Saxony	Germany
4473	Staaken	Berlin	Germany
4475	Springe	Lower Saxony	Germany
4476	Speyer	Rheinland-Pfalz	Germany
4478	Sonthofen	Bavaria	Germany
4479	Sonneberg	Thuringia	Germany
4480	Sondershausen	Thuringia	Germany
4482	Soltau	Lower Saxony	Germany
4485	Sinzig	Rheinland-Pfalz	Germany
4493	Senftenberg	Brandenburg	Germany
4495	Senden	Bavaria	Germany
4497	Seligenstadt	Hesse	Germany
4498	Selb	Bavaria	Germany
4499	Sehnde	Lower Saxony	Germany
4500	Seevetal	Lower Saxony	Germany
4501	Seesen	Lower Saxony	Germany
4502	Seelze	Lower Saxony	Germany
4507	Schweinfurt	Bavaria	Germany
4508	Schwedt (Oder)	Brandenburg	Germany
4509	Schwarzenberg	Saxony	Germany
4510	Schwanewede	Lower Saxony	Germany
4511	Schwandorf in Bayern	Bavaria	Germany
4513	Schwalmstadt	Hesse	Germany
4514	Schwalbach	Saarland	Germany
4517	Schwabach	Bavaria	Germany
4518	Schrobenhausen	Bavaria	Germany
4520	Schortens	Lower Saxony	Germany
4525	Schneverdingen	Lower Saxony	Germany
4526	Schneeberg	Saxony	Germany
4527	Schmelz	Saarland	Germany
4528	Schmargendorf	Berlin	Germany
4530	Schmalkalden	Thuringia	Germany
4532	Schleswig	Schleswig-Holstein	Germany
4533	Schkeuditz	Saxony	Germany
4534	Schiffweiler	Saarland	Germany
4535	Schifferstadt	Rheinland-Pfalz	Germany
4537	Sasel	Hamburg	Germany
4538	Sarstedt	Lower Saxony	Germany
4539	Sankt Wendel	Saarland	Germany
4540	Sankt Ingbert	Saarland	Germany
4542	Sangerhausen	Saxony-Anhalt	Germany
4543	Salzwedel	Saxony-Anhalt	Germany
4545	Saarlouis	Saarland	Germany
4547	Saalfeld	Thuringia	Germany
4549	Rummelsburg	Berlin	Germany
4550	Rudow	Berlin	Germany
4551	Rudolstadt	Thuringia	Germany
4554	Roth	Bavaria	Germany
4555	Rotenburg	Lower Saxony	Germany
4558	Rosenheim	Bavaria	Germany
4559	Ronnenberg	Lower Saxony	Germany
4560	Rinteln	Lower Saxony	Germany
4562	Riesa	Saxony	Germany
4563	Riegelsberg	Saarland	Germany
4573	Rendsburg	Schleswig-Holstein	Germany
4575	Remagen	Rheinland-Pfalz	Germany
4576	Reinickendorf	Berlin	Germany
4577	Reinheim	Hesse	Germany
4578	Reinbek	Schleswig-Holstein	Germany
4579	Reichenbach/Vogtland	Saxony	Germany
4580	Regensburg	Bavaria	Germany
4585	Rathenow	Brandenburg	Germany
4586	Ratekau	Schleswig-Holstein	Germany
4587	Rastede	Lower Saxony	Germany
4592	Radebeul	Saxony	Germany
4593	Radeberg	Saxony	Germany
4594	Quickborn	Schleswig-Holstein	Germany
4595	Quedlinburg	Saxony-Anhalt	Germany
4598	Puchheim	Bavaria	Germany
4599	Prenzlauer Berg	Berlin	Germany
4600	Prenzlau	Brandenburg	Germany
4601	Preetz	Schleswig-Holstein	Germany
4602	Potsdam	Brandenburg	Germany
4606	Plauen	Saxony	Germany
4607	Pirna	Saxony	Germany
4608	Pirmasens	Rheinland-Pfalz	Germany
4609	Pinneberg	Schleswig-Holstein	Germany
4610	Pfungstadt	Hesse	Germany
4615	Penzberg	Bavaria	Germany
4616	Peine	Lower Saxony	Germany
4617	Passau	Bavaria	Germany
4618	Pasing	Bavaria	Germany
4620	Papenburg	Lower Saxony	Germany
4621	Pankow	Berlin	Germany
4623	Oyten	Lower Saxony	Germany
4625	Ottweiler	Saarland	Germany
4626	Ottobrunn	Bavaria	Germany
4627	Osterholz-Scharmbeck	Lower Saxony	Germany
4629	Oschersleben	Saxony-Anhalt	Germany
4630	Oschatz	Saxony	Germany
4631	Oranienburg	Brandenburg	Germany
4635	Oldenburg	Lower Saxony	Germany
4636	Olching	Bavaria	Germany
4639	Offenbach	Hesse	Germany
4645	Oberursel	Hesse	Germany
4646	Obertshausen	Hesse	Germany
4648	Ober-Ramstadt	Hesse	Germany
4651	Oberasbach	Bavaria	Germany
4656	Northeim	Lower Saxony	Germany
4658	Nordhorn	Lower Saxony	Germany
4659	Nordhausen	Thuringia	Germany
4660	Norderstedt	Schleswig-Holstein	Germany
4661	Nordenham	Lower Saxony	Germany
4662	Norden	Lower Saxony	Germany
4664	Nikolassee	Berlin	Germany
4665	Nienburg	Lower Saxony	Germany
4669	Nieder-Ingelheim	Rheinland-Pfalz	Germany
4670	Nidderau	Hesse	Germany
4671	Nidda	Hesse	Germany
4672	Neu Wulmstorf	Lower Saxony	Germany
4673	Neuwied	Rheinland-Pfalz	Germany
4674	Neu-Ulm	Bavaria	Germany
4676	Neustadt in Holstein	Schleswig-Holstein	Germany
4677	Neustadt bei Coburg	Bavaria	Germany
4678	Neustadt	Rheinland-Pfalz	Germany
4680	Neue Neustadt	Saxony-Anhalt	Germany
4682	Neuruppin	Brandenburg	Germany
4683	Neunkirchen	Saarland	Germany
4686	Neu Isenburg	Hesse	Germany
4688	Neuenhagen	Brandenburg	Germany
4689	Neuburg an der Donau	Bavaria	Germany
4692	Neu-Anspach	Hesse	Germany
4696	Naumburg	Saxony-Anhalt	Germany
4697	Nauen	Brandenburg	Germany
4699	Munster	Lower Saxony	Germany
4702	Munich	Bavaria	Germany
4713	Moosburg	Bavaria	Germany
4718	Moabit	Berlin	Germany
4719	Mittweida	Saxony	Germany
4721	Michelstadt	Hesse	Germany
4725	Merzig	Saarland	Germany
4726	Merseburg	Saxony-Anhalt	Germany
4727	Meppen	Lower Saxony	Germany
4729	Memmingen	Bavaria	Germany
4730	Melle	Lower Saxony	Germany
4731	Meissen	Saxony	Germany
4732	Meiningen	Thuringia	Germany
4736	Meerane	Saxony	Germany
4739	Mayen	Rheinland-Pfalz	Germany
4740	Marzahn	Berlin	Germany
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
4759	Ludwigsfelde	Brandenburg	Germany
4763	Luckenwalde	Brandenburg	Germany
4767	Loxstedt	Lower Saxony	Germany
4768	Losheim	Saarland	Germany
4770	Lohr am Main	Bavaria	Germany
4771	Lohne	Lower Saxony	Germany
4776	Lingen	Lower Saxony	Germany
4778	Lindau	Bavaria	Germany
4779	Limburg an der Lahn	Hesse	Germany
4780	Limbach-Oberfrohna	Saxony	Germany
4781	Lilienthal	Lower Saxony	Germany
4782	Lichterfelde	Berlin	Germany
4783	Lichtenrade	Berlin	Germany
4784	Lichtenfels	Bavaria	Germany
4785	Lichtenberg	Berlin	Germany
4793	Leipzig	Saxony	Germany
4797	Lehrte	Lower Saxony	Germany
4798	Leer	Lower Saxony	Germany
4799	Lebach	Saarland	Germany
4801	Lauf an der Pegnitz	Bavaria	Germany
4802	Lauchhammer	Brandenburg	Germany
4803	Lankwitz	Berlin	Germany
4804	Langenhorn	Hamburg	Germany
4805	Langenhagen	Lower Saxony	Germany
4807	Langen	Lower Saxony	Germany
4808	Langen	Hesse	Germany
4809	Landshut	Bavaria	Germany
4810	Landsberg am Lech	Bavaria	Germany
4811	Landau in der Pfalz	Rheinland-Pfalz	Germany
4812	Lampertheim	Hesse	Germany
4814	Lahnstein	Rheinland-Pfalz	Germany
4816	Laatzen	Lower Saxony	Germany
4821	Kulmbach	Bavaria	Germany
4822	Kronberg	Hesse	Germany
4823	Kronach	Bavaria	Germany
4825	Kreuzberg	Berlin	Germany
4832	Korbach	Hesse	Germany
4835	Konz	Rheinland-Pfalz	Germany
4843	Kolbermoor	Bavaria	Germany
4844	Koblenz	Rheinland-Pfalz	Germany
4846	Kleinmachnow	Brandenburg	Germany
4847	Kitzingen	Bavaria	Germany
4850	Kirchhain	Hesse	Germany
4852	Kiel	Schleswig-Holstein	Germany
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
4870	Kamenz	Saxony	Germany
4872	Kaltenkirchen	Schleswig-Holstein	Germany
4873	Kaiserslautern	Rheinland-Pfalz	Germany
4877	Johannisthal	Berlin	Germany
4878	Jena	Thuringia	Germany
4879	Itzehoe	Schleswig-Holstein	Germany
4882	Ingolstadt	Bavaria	Germany
4883	Ilmenau	Thuringia	Germany
4884	Illingen	Saarland	Germany
4885	Illertissen	Bavaria	Germany
4886	Idstein	Hesse	Germany
4887	Idar-Oberstein	Rheinland-Pfalz	Germany
4889	Husum	Schleswig-Holstein	Germany
4894	Hude	Lower Saxony	Germany
4897	Hoyerswerda	Saxony	Germany
4902	Homburg	Saarland	Germany
4904	Holzminden	Lower Saxony	Germany
4905	Holzkirchen	Bavaria	Germany
4906	Hohenstein-Ernstthal	Saxony	Germany
4907	Hohen Neuendorf	Brandenburg	Germany
4908	Hofheim am Taunus	Hesse	Germany
4909	Hofgeismar	Hesse	Germany
4910	Hof	Bavaria	Germany
4912	Hochheim am Main	Hesse	Germany
4915	Hildesheim	Lower Saxony	Germany
4919	Heusweiler	Saarland	Germany
4920	Heusenstamm	Hesse	Germany
4921	Hettstedt	Saxony-Anhalt	Germany
4922	Hessisch Oldendorf	Lower Saxony	Germany
4924	Herzogenaurach	Bavaria	Germany
4928	Hermsdorf	Berlin	Germany
4931	Herborn	Hesse	Germany
4933	Hennigsdorf	Brandenburg	Germany
4935	Hemmingen	Lower Saxony	Germany
4937	Helmstedt	Lower Saxony	Germany
4938	Hellersdorf	Berlin	Germany
4941	Heiligensee	Berlin	Germany
4945	Heidenau	Saxony	Germany
4947	Heide	Schleswig-Holstein	Germany
4950	Hattersheim	Hesse	Germany
4953	Haren	Lower Saxony	Germany
4954	Harburg	Hamburg	Germany
4955	Hannover	Lower Saxony	Germany
4956	Hanau am Main	Hesse	Germany
4959	Hameln	Lower Saxony	Germany
4960	Wandsbek	Hamburg	Germany
4961	Marienthal	Hamburg	Germany
4962	Hamburg-Mitte	Hamburg	Germany
4964	Altona	Hamburg	Germany
4965	Hamburg	Hamburg	Germany
4968	Halstenbek	Schleswig-Holstein	Germany
4970	Halle (Saale)	Saxony-Anhalt	Germany
4971	Haldensleben I	Saxony-Anhalt	Germany
4972	Halberstadt	Saxony-Anhalt	Germany
4973	Hakenfelde	Berlin	Germany
4974	Haiger	Hesse	Germany
4976	Haar	Bavaria	Germany
4980	Gunzenhausen	Bavaria	Germany
4983	Guben	Brandenburg	Germany
4990	Grimma	Saxony	Germany
4991	Griesheim	Hesse	Germany
4994	Greiz	Thuringia	Germany
4998	Gotha	Thuringia	Germany
4999	Goslar	Lower Saxony	Germany
5003	Glinde	Schleswig-Holstein	Germany
5004	Glauchau	Saxony	Germany
5006	Ginsheim-Gustavsburg	Hesse	Germany
5007	Gilching	Bavaria	Germany
5008	Gifhorn	Lower Saxony	Germany
5012	Gesundbrunnen	Berlin	Germany
5015	Gersthofen	Bavaria	Germany
5016	Germersheim	Rheinland-Pfalz	Germany
5017	Germering	Bavaria	Germany
5019	Geretsried	Bavaria	Germany
5020	Gera	Thuringia	Germany
5023	Gelnhausen	Hesse	Germany
5027	Geesthacht	Schleswig-Holstein	Germany
5028	Gauting	Bavaria	Germany
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
5051	Freital	Saxony	Germany
5052	Freising	Bavaria	Germany
5053	Freilassing	Bavaria	Germany
5056	Freiberg	Saxony	Germany
5058	Frankfurt am Main	Hesse	Germany
5059	Frankfurt (Oder)	Brandenburg	Germany
5060	Frankenthal	Rheinland-Pfalz	Germany
5061	Frankenberg	Hesse	Germany
5062	Frankenberg	Saxony	Germany
5063	Forst	Brandenburg	Germany
5064	Forchheim	Bavaria	Germany
5066	Flensburg	Schleswig-Holstein	Germany
5067	Finsterwalde	Brandenburg	Germany
5071	Falkensee	Brandenburg	Germany
5072	Eutin	Schleswig-Holstein	Germany
5079	Eschwege	Hesse	Germany
5080	Eschborn	Hesse	Germany
5082	Erlangen	Bavaria	Germany
5085	Erfurt	Thuringia	Germany
5087	Erding	Bavaria	Germany
5089	Eppelborn	Saarland	Germany
5097	Emden	Lower Saxony	Germany
5098	Eltville	Hesse	Germany
5100	Elmshorn	Schleswig-Holstein	Germany
5105	Eisenach	Thuringia	Germany
5106	Einbeck	Lower Saxony	Germany
5107	Eilenburg	Saxony	Germany
5110	Edewecht	Lower Saxony	Germany
5112	Eberswalde	Brandenburg	Germany
5119	Duderstadt	Lower Saxony	Germany
5120	Dresden	Saxony	Germany
5122	Dreieich	Hesse	Germany
5131	Dingolfing	Bavaria	Germany
5133	Dillingen	Saarland	Germany
5134	Dillenburg	Hesse	Germany
5135	Dietzenbach	Hesse	Germany
5136	Diepholz	Lower Saxony	Germany
5137	Dieburg	Hesse	Germany
5140	Dessau	Saxony-Anhalt	Germany
5141	Delmenhorst	Lower Saxony	Germany
5142	Delitzsch	Saxony	Germany
5144	Deggendorf	Bavaria	Germany
5146	Darmstadt	Hesse	Germany
5147	Damme	Lower Saxony	Germany
5148	Dahlem	Berlin	Germany
5149	Dachau	Bavaria	Germany
5150	Cuxhaven	Lower Saxony	Germany
5151	Crimmitschau	Saxony	Germany
5153	Cottbus	Brandenburg	Germany
5154	Coswig	Saxony	Germany
5156	Coburg	Bavaria	Germany
5157	Cloppenburg	Lower Saxony	Germany
5158	Clausthal-Zellerfeld	Lower Saxony	Germany
5159	Chemnitz	Saxony	Germany
5160	Charlottenburg	Berlin	Germany
5161	Cham	Bavaria	Germany
5162	Celle	Lower Saxony	Germany
5165	Buxtehude	Lower Saxony	Germany
5166	Butzbach	Hesse	Germany
5169	Burghausen	Bavaria	Germany
5170	Burgdorf	Lower Saxony	Germany
5171	Burg bei Magdeburg	Saxony-Anhalt	Germany
5176	Buckow	Berlin	Germany
5186	Britz	Berlin	Germany
5190	Bremerhaven	Bremen	Germany
5191	Bremen	Bremen	Germany
5192	Braunschweig	Lower Saxony	Germany
5194	Bramsche	Lower Saxony	Germany
5196	Brake (Unterweser)	Lower Saxony	Germany
5200	Borna	Saxony	Germany
5202	Boppard	Rheinland-Pfalz	Germany
5205	Bogenhausen	Bavaria	Germany
5209	Bobingen	Bavaria	Germany
5211	Blieskastel	Saarland	Germany
5212	Blankenburg	Saxony-Anhalt	Germany
5213	Bitterfeld-Wolfen	Saxony	Germany
5214	Bingen am Rhein	Rheinland-Pfalz	Germany
5216	Biesdorf	Berlin	Germany
5219	Bexbach	Saarland	Germany
5221	Bernburg	Saxony-Anhalt	Germany
5222	Bernau bei Berlin	Brandenburg	Germany
5223	Berlin	Berlin	Germany
5228	Bensheim	Hesse	Germany
5229	Bendorf	Rheinland-Pfalz	Germany
5232	Beckingen	Saarland	Germany
5233	Bayreuth	Bavaria	Germany
5234	Bautzen	Saxony	Germany
5235	Baunatal	Hesse	Germany
5236	Baumschulenweg	Berlin	Germany
5237	Bassum	Lower Saxony	Germany
5238	Bamberg	Bavaria	Germany
5242	Bad Zwischenahn	Lower Saxony	Germany
5243	Bad Wildungen	Hesse	Germany
5245	Bad Vilbel	Hesse	Germany
5247	Bad Soden am Taunus	Hesse	Germany
5248	Bad Segeberg	Schleswig-Holstein	Germany
5249	Bad Schwartau	Schleswig-Holstein	Germany
5250	Bad Salzungen	Thuringia	Germany
5253	Bad Reichenhall	Bavaria	Germany
5255	Bad Pyrmont	Lower Saxony	Germany
5256	Bad Oldesloe	Schleswig-Holstein	Germany
5260	Bad Nauheim	Hesse	Germany
5265	Bad Langensalza	Thuringia	Germany
5266	Bad Kreuznach	Rheinland-Pfalz	Germany
5267	Bad Kissingen	Bavaria	Germany
5270	Bad Hersfeld	Hesse	Germany
5271	Bad Harzburg	Lower Saxony	Germany
5272	Bad Essen	Lower Saxony	Germany
5277	Bad Bentheim	Lower Saxony	Germany
5278	Bad Aibling	Bavaria	Germany
5280	Babenhausen	Hesse	Germany
5281	Aurich	Lower Saxony	Germany
5282	Augsburg	Bavaria	Germany
5283	Auerbach	Saxony	Germany
5284	Aue	Saxony	Germany
5286	Aschersleben	Saxony-Anhalt	Germany
5288	Aschaffenburg	Bavaria	Germany
5289	Bad Arolsen	Hesse	Germany
5290	Arnstadt	Thuringia	Germany
5292	Apolda	Thuringia	Germany
5293	Ansbach	Bavaria	Germany
5294	Annaberg-Buchholz	Saxony	Germany
5296	Andernach	Rheinland-Pfalz	Germany
5297	Amberg	Bavaria	Germany
5298	Alzey	Rheinland-Pfalz	Germany
5300	Altglienicke	Berlin	Germany
5301	Altenburg	Thuringia	Germany
5303	Altdorf	Bavaria	Germany
5304	Alsfeld	Hesse	Germany
5307	Alfeld	Lower Saxony	Germany
5309	Aichach	Bavaria	Germany
5310	Ahrensburg	Schleswig-Holstein	Germany
5313	Adlershof	Berlin	Germany
5314	Achim	Lower Saxony	Germany
5317	Vellmar	Hesse	Germany
5318	Henstedt-Ulzburg	Schleswig-Holstein	Germany
5321	Riedstadt	Hesse	Germany
5325	Rodgau	Hesse	Germany
5326	Gropiusstadt	Berlin	Germany
5327	Seeheim-Jugenheim	Hesse	Germany
5328	Charlottenburg-Nord	Berlin	Germany
5329	Mitte	Berlin	Germany
5330	Spremberg	Brandenburg	Germany
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
5908	Keren	Anseba	Eritrea
5909	Barentu	Gash Barka	Eritrea
5912	Mendefera	Debub	Eritrea
5913	Zubia	Andalusia	Spain
5914	Zafra	Extremadura	Spain
5915	Yecla	Murcia	Spain
5916	Villena	Valencia	Spain
5917	Villarrobledo	Castille-La Mancha	Spain
5918	Vila-real	Valencia	Spain
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
5944	Sueca	Valencia	Spain
5945	Silla	Valencia	Spain
5946	Sevilla	Andalusia	Spain
5948	Santomera	Murcia	Spain
5949	Santa Pola	Valencia	Spain
5956	San Roque	Andalusia	Spain
5959	San Miguel De Abona	Canary Islands	Spain
5962	San Juan de Alicante	Valencia	Spain
5963	San Javier	Murcia	Spain
5964	San Isidro	Canary Islands	Spain
5965	San Fernando	Andalusia	Spain
5966	La Laguna	Canary Islands	Spain
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
6038	Los Barrios	Andalusia	Spain
6040	Lorca	Murcia	Spain
6042	Loja	Andalusia	Spain
6043	Llucmajor	Balearic Islands	Spain
6045	Linares	Andalusia	Spain
6046	Lepe	Andalusia	Spain
6047	Lebrija	Andalusia	Spain
6051	La Solana	Castille-La Mancha	Spain
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
6371	Esparreguera	Catalonia	Spain
6372	Ermua	Basque Country	Spain
6373	Erandio	Basque Country	Spain
6374	El Prat de Llobregat	Catalonia	Spain
6375	Ferrol	Galicia	Spain
6376	El Astillero	Cantabria	Spain
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

COPY twitter_posts (user_id, id, id_str, created_at, text, hashtags, urls, user_mention, symbols) FROM stdin;
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

