-- View: public.jaetut_lihat

-- DROP VIEW public.jaetut_lihat;

CREATE OR REPLACE VIEW public.jaetut_lihat
 AS
 SELECT jakoryhma.ryhman_nimi,
    sum(jakotapahtuma.maara) AS kg
   FROM jakoryhma
     LEFT JOIN jakotapahtuma ON jakotapahtuma.ryhma_id = jakoryhma.ryhma_id
  GROUP BY jakoryhma.ryhman_nimi
  ORDER BY jakoryhma.ryhman_nimi;

ALTER TABLE public.jaetut_lihat
    OWNER TO postgres;

