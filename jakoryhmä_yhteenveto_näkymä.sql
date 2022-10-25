-- View: public.jakoryhma_yhteenveto

-- DROP VIEW public.jakoryhma_yhteenveto;

CREATE OR REPLACE VIEW public.jakoryhma_yhteenveto
 AS
 SELECT jakoryhma.ryhman_nimi AS "ryhmä",
    count(jasenyys.jasen_id) AS "jäseniä",
    sum(jasenyys.osuus)::double precision / 100::real AS "osuuksia"
   FROM jakoryhma
     JOIN jasenyys ON jasenyys.ryhma_id = jakoryhma.ryhma_id
  GROUP BY jakoryhma.ryhman_nimi
  ORDER BY jakoryhma.ryhman_nimi;

ALTER TABLE public.jakoryhma_yhteenveto
    OWNER TO postgres;

