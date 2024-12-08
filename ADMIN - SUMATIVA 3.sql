
/* Creación de usuario si está trabajando con BD Oracle Cloud */

CREATE USER PRY2205_S8 
IDENTIFIED BY "PRY2205.semana_8"
DEFAULT TABLESPACE "DATA"
TEMPORARY TABLESPACE "TEMP";
ALTER USER PRY2205_S8 QUOTA UNLIMITED ON DATA;
GRANT CREATE SESSION TO PRY2205_S8;
GRANT "RESOURCE" TO PRY2205_S8;
ALTER USER PRY2205_S8 DEFAULT ROLE "RESOURCE";

-- CASO 1--

-- Creación del usuario PRY2205_USER1
CREATE USER PRY2205_USER1 
IDENTIFIED BY "Colomba123456"
DEFAULT TABLESPACE DATA
TEMPORARY TABLESPACE TEMP
QUOTA UNLIMITED ON DATA;

GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW, CREATE SYNONYM, CREATE PROCEDURE, CREATE SEQUENCE TO PRY2205_USER1;

-- Creación del usuario PRY2205_USER2 para consultas

CREATE USER PRY2205_USER2
IDENTIFIED BY "Antonia12345"
DEFAULT TABLESPACE DATA
TEMPORARY TABLESPACE TEMP
QUOTA UNLIMITED ON DATA;

GRANT CREATE SESSION TO PRY2205_USER2;


-- Creación de roles 
CREATE ROLE PRY2205_ROL_D;
CREATE ROLE PRY2205_ROL_P;


-- Para otorgar privilegios a PRY2205_ROL_D
GRANT SELECT ON PRY2205_USER1.MEDICO TO PRY2205_ROL_D;
GRANT SELECT ON PRY2205_USER1.CARGO TO PRY2205_ROL_D;
GRANT SELECT ON PRY2205_USER1.PACIENTE TO PRY2205_ROL_D;
GRANT SELECT ON PRY2205_USER1.BONO_CONSULTA TO PRY2205_ROL_D;
GRANT SELECT ON PRY2205_USER1.SALUD TO PRY2205_ROL_D;


-- Para otorgar privilegios a PRY2205_ROL_P

GRANT CREATE PROCEDURE TO PRY2205_ROL_P;
GRANT CREATE FUNCTION TO PRY2205_ROL_P;

-- Asignar rol a usuario

GRANT PRY2205_ROL_D TO PRY2205_USER2;

-- Permiso para crear sinonimos 

GRANT CREATE SYNONYM TO PRY2205_USER1;
GRANT CREATE PUBLIC SYNONYM TO PRY2205_USER1;
GRANT CREATE SYNONYM TO PRY2205_USER2;
GRANT CREATE PUBLIC SYNONYM TO PRY2205_USER2;

-- Para crear sinónimos públicos 

CREATE PUBLIC SYNONYM PACIENTE FOR PRY2205_USER1.PACIENTE;
CREATE PUBLIC SYNONYM BONO_CONSULTA FOR PRY2205_USER1.BONO_CONSULTA;
CREATE PUBLIC SYNONYM SALUD FOR PRY2205_USER1.SALUD;

-- Para otorgar permisos de consulta

GRANT SELECT ON PRY2205_USER1.PACIENTE TO PRY2205_USER2;
GRANT SELECT ON PRY2205_USER1.BONO_CONSULTA TO PRY2205_USER2;
GRANT SELECT ON PRY2205_USER1.SALUD TO PRY2205_USER2;


-- Privilegios para vistas
GRANT CREATE VIEW TO PRY2205_USER2;




