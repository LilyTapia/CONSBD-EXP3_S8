-- Creación del usuario PRY2205_USER2 para consultas

CREATE USER PRY2205_USER2
IDENTIFIED BY "Antonia12345"
DEFAULT TABLESPACE DATA
TEMPORARY TABLESPACE TEMP
QUOTA UNLIMITED ON DATA;

GRANT CREATE SESSION TO PRY2205_USER2;

-- CASO 2--

CREATE OR REPLACE VIEW PRY2205_USER2.V_RECALCULO_PAGOS AS
SELECT 
  p.pac_run AS PAC_RUN,
  p.dv_run AS DV_RUN,
  -- Subconsulta para obtener el sistema de salud:
  (SELECT s.descripcion 
     FROM SALUD s 
    WHERE s.sal_id = p.sal_id) AS SIST_SALUD,
  -- Nombre del paciente: apaterno y pnombre con primera letra mayúscula y el resto minúsculas
  INITCAP(p.apaterno) || ' ' || INITCAP(p.pnombre) AS NOMBRE_PCIENTE,
  bc.costo AS COSTO,
  CASE 
    WHEN bc.hr_consulta > '17:15' AND bc.costo BETWEEN 15000 AND 25000 
      THEN ROUND(bc.costo * 1.15)        -- Aplica 15% si es tarde y entre 15.000 y 25.000
    WHEN bc.hr_consulta > '17:15' AND bc.costo > 25000 
      THEN ROUND(bc.costo * 1.20)        -- Aplica 20% si es tarde y costo mayor a 25.000
    ELSE bc.costo                        -- Caso contrario, mantiene el costo original
  END AS MONTO_A_CANCELAR,
  TRUNC((SYSDATE - p.fecha_nacimiento)/365.25) AS EDAD
FROM PACIENTE p
INNER JOIN BONO_CONSULTA bc ON p.pac_run = bc.pac_run
ORDER BY p.pac_run, MONTO_A_CANCELAR ;


SELECT * FROM v_recalculo_pagos;

-- Para verificar la cantidad de filas 

SELECT COUNT(*) FROM PACIENTE p
INNER JOIN BONO_CONSULTA bc ON p.pac_run = bc.pac_run;

SELECT COUNT(*) FROM V_RECALCULO_PAGOS;



