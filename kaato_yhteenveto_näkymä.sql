-- View: public.kaatoyhteenveto

-- DROP VIEW public.kaatoyhteenveto

CREATE OR REPLACE VIEW public.kaatoyhteenveto
 AS
 SELECT kaato.elaimen_nimi,
 	kaato.sukupuoli,
	kaato.ikaluokka,
	count(kaato.elaimen_nimi) AS kpl,
	sum(kaato.ruhopaino) AS kg
   FROM kaato
  GROUP BY kaato.elaimen_nimi, kaato.sukupuoli, kaato.ikaluokka;
  
ALTER TABLE public.kaatoyhteenveto
	OWNER TO postgres;