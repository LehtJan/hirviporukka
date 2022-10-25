-- View: public.jako_ka

-- DROP VIEW public.jako_ka

CREATE OR REPLACE VIEW public.jako_ka
 AS
 SELECT avg(jaetut_lihat.kg) AS liha_ka
   FROM jaetut_lihat;
   
ALTER TABLE public.jako_ka
	OWNER TO postgres;