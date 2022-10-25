-- View: public.kaadot_ampujittain

-- DROP VIEW public.kaadot_ampujittain;

CREATE OR REPLACE VIEW public.kaadot_ampujittain
 AS
 SELECT (jasen.etunimi::text || ' '::text) || jasen.sukunimi::text AS ampuja,
    kaato.elaimen_nimi AS "eläin",
    kaato.sukupuoli,
    kaato.ikaluokka,
    count(kaato.elaimen_nimi) AS kpl,
    sum(kaato.ruhopaino) AS kg
   FROM kaato
     JOIN jasen ON kaato.jasen_id = jasen.jasen_id
  GROUP BY ((jasen.etunimi::text || ' '::text) || jasen.sukunimi::text), kaato.elaimen_nimi, kaato.sukupuoli, kaato.ikaluokka
  ORDER BY ((jasen.etunimi::text || ' '::text) || jasen.sukunimi::text);

ALTER TABLE public.kaadot_ampujittain
    OWNER TO postgres;

