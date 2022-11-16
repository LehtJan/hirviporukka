-- View public.kaadot_ryhmittain

-- DROP VIEW public.kaadot_ryhmittain

CREATE OR REPLACE VIEW public.kaadot_ryhmittain
 AS
 SELECT jakoryhma.ryhman_nimi,
 	kaato.elaimen_nimi,
	kaato.sukupuoli,
	kaato.ikaluokka,
	count(kaato.elaimen_nimi) AS kpl,
	sum(kaato.ruhopaino) AS kg
   FROM jakoryhma
     JOIN jasenyys ON jakoryhma.ryhma_id = jasenyys.ryhma_id
	 JOIN kaato ON jasenyys.jasen_id = kaato.jasen_id
  GROUP BY jakoryhma.ryhman_nimi, kaato.elaimen_nimi, kaato.sukupuoli, kaato.ikaluokka;
  
ALTER TABLE public.kaadot_ryhmittain
	OWNER TO postgres;