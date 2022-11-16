-- View: public.ryhmien_osuudet

-- DROP VIEW public.ryhmien_osuudet;

CREATE OR REPLACE VIEW public.ryhmien_osuudet
 AS
 SELECT jasenyys.ryhma_id AS "ryhmä",
    sum(jasenyys.osuus)/100::float AS "osuuksia"
   FROM jasenyys
  GROUP BY jasenyys.ryhma_id
  ORDER BY jasenyys.ryhma_id;

ALTER TABLE public.ryhmien_osuudet
    OWNER TO postgres;

