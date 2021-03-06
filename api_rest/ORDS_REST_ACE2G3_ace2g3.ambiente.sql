
-- Generated by ORDS REST Data Services 18.1.1.95.1251
-- Schema: ACE2G3  Date: Thu Feb 28 03:29:55 2019 
--

BEGIN
  ORDS.ENABLE_SCHEMA(
      p_enabled             => TRUE,
      p_schema              => 'ACE2G3',
      p_url_mapping_type    => 'BASE_PATH',
      p_url_mapping_pattern => 'ace2g3',
      p_auto_rest_auth      => FALSE);
    
  ORDS.DEFINE_MODULE(
      p_module_name    => 'ace2g3.ambiente',
      p_base_path      => '/sensores/',
      p_items_per_page => 25,
      p_status         => 'PUBLISHED',
      p_comments       => NULL);

  ORDS.DEFINE_TEMPLATE(
      p_module_name    => 'ace2g3.ambiente',
      p_pattern        => 'ambiente/',
      p_priority       => 0,
      p_etag_type      => 'HASH',
      p_etag_query     => NULL,
      p_comments       => 'Deveuelve o graba una lectura de ambiente registrada por los sensores');

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'ace2g3.ambiente',
      p_pattern        => 'ambiente/',
      p_method         => 'GET',
      p_source_type    => 'json/query',
      p_items_per_page => 0,
      p_mimes_allowed  => '',
      p_comments       => 'Devuelve el listado de los registros leidos por los sensores para el ambiente',
      p_source         => 
'select ID
, TO_CHAR(FECHA-interval ''6'' hour, ''DD/MM/YYYY'') FECHA
, TO_CHAR(FECHA-interval ''6'' hour, ''HH24:MI:SS'') HORA
, LATITUD
, LONGITUD
, MQ7
, MQ135
, GUVAS12SDUV
from ambiente
order by ID asc
');

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'ace2g3.ambiente',
      p_pattern        => 'ambiente/',
      p_method         => 'POST',
      p_source_type    => 'plsql/block',
      p_mimes_allowed  => 'application/json',
      p_comments       => NULL,
      p_source         => 
'begin
    insert into ambiente (LATITUD, LONGITUD, MQ7, MQ135, GUVAS12SDUV)
    values (:latitud, :longitud, :mq7, :mq135, :guvas12sduv);
end;
');

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'ace2g3.ambiente',
      p_pattern            => 'ambiente/',
      p_method             => 'POST',
      p_name               => 'guvas12sduv',
      p_bind_variable_name => 'guvas12sduv',
      p_source_type        => 'URI',
      p_param_type         => 'DOUBLE',
      p_access_method      => 'IN',
      p_comments           => 'Valor obtenido del sensor guvas12sduv');

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'ace2g3.ambiente',
      p_pattern            => 'ambiente/',
      p_method             => 'POST',
      p_name               => 'latitud',
      p_bind_variable_name => 'latitud',
      p_source_type        => 'URI',
      p_param_type         => 'DOUBLE',
      p_access_method      => 'IN',
      p_comments           => 'Valor de la latitud');

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'ace2g3.ambiente',
      p_pattern            => 'ambiente/',
      p_method             => 'POST',
      p_name               => 'longitud',
      p_bind_variable_name => 'longitud',
      p_source_type        => 'URI',
      p_param_type         => 'DOUBLE',
      p_access_method      => 'IN',
      p_comments           => 'Valor de la longitud');

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'ace2g3.ambiente',
      p_pattern            => 'ambiente/',
      p_method             => 'POST',
      p_name               => 'mq135',
      p_bind_variable_name => 'mq135',
      p_source_type        => 'URI',
      p_param_type         => 'DOUBLE',
      p_access_method      => 'IN',
      p_comments           => 'Valor obtenido del sensor mq13');

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'ace2g3.ambiente',
      p_pattern            => 'ambiente/',
      p_method             => 'POST',
      p_name               => 'mq7',
      p_bind_variable_name => 'mq7',
      p_source_type        => 'URI',
      p_param_type         => 'DOUBLE',
      p_access_method      => 'IN',
      p_comments           => 'Valor obtenido del sensor mq7');

  ORDS.DEFINE_TEMPLATE(
      p_module_name    => 'ace2g3.ambiente',
      p_pattern        => 'ambiente/:id',
      p_priority       => 0,
      p_etag_type      => 'HASH',
      p_etag_query     => NULL,
      p_comments       => 'Retorna los datos del registro guardado para el ambiente con el id dado');

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'ace2g3.ambiente',
      p_pattern        => 'ambiente/:id',
      p_method         => 'GET',
      p_source_type    => 'json/query;type=single',
      p_items_per_page => 25,
      p_mimes_allowed  => '',
      p_comments       => 'Deveuelve el registro de la lectura de sensores solicitada por id',
      p_source         => 
'select ID
, TO_CHAR(FECHA, ''DD/MM/YYYY'') FECHA
, TO_CHAR(FECHA, ''HH24:MI:SS'') HORA
, LATITUD
, LONGITUD
, MQ7
, MQ135
, GUVAS12SDUV
from ambiente
where ID = :id');

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'ace2g3.ambiente',
      p_pattern            => 'ambiente/:id',
      p_method             => 'GET',
      p_name               => 'id',
      p_bind_variable_name => 'id',
      p_source_type        => 'HEADER',
      p_param_type         => 'INT',
      p_access_method      => 'IN',
      p_comments           => 'Valor de id de la lectura registrada');

  ORDS.DEFINE_TEMPLATE(
      p_module_name    => 'ace2g3.ambiente',
      p_pattern        => 'ambientefecha/:fecha',
      p_priority       => 0,
      p_etag_type      => 'HASH',
      p_etag_query     => NULL,
      p_comments       => 'Servicio de retorna una lectura de ambiente para una fecha dada en un formato yyyymmdd <Año><mes><dia>');

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'ace2g3.ambiente',
      p_pattern        => 'ambientefecha/:fecha',
      p_method         => 'GET',
      p_source_type    => 'json/query',
      p_items_per_page => 0,
      p_mimes_allowed  => '',
      p_comments       => 'Get de lecturas para una fecha particular',
      p_source         => 
'  select ID
, TO_CHAR(FECHA-interval ''6'' hour, ''DD/MM/YYYY'') FECHA
, TO_CHAR(FECHA-interval ''6'' hour, ''HH24:MI:SS'') HORA
, LATITUD
, LONGITUD
, MQ7
, MQ135
, GUVAS12SDUV
from ambiente
WHERE TO_DATE(:fecha, ''YYYYMMDD'') = TRUNC(FECHA - INTERVAL ''6'' HOUR) 
order by ID asc');

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'ace2g3.ambiente',
      p_pattern            => 'ambientefecha/:fecha',
      p_method             => 'GET',
      p_name               => 'fecha',
      p_bind_variable_name => 'fecha',
      p_source_type        => 'URI',
      p_param_type         => 'INT',
      p_access_method      => 'IN',
      p_comments           => 'Fecha de la lectura que se quiere obtener');

  ORDS.DEFINE_TEMPLATE(
      p_module_name    => 'ace2g3.ambiente',
      p_pattern        => 'ambientes/:fecha/:horainicial/:horafinal/:latitud/:longitud',
      p_priority       => 0,
      p_etag_type      => 'HASH',
      p_etag_query     => NULL,
      p_comments       => 'Valores promedio de los sensores por ubicación para una fecha');

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'ace2g3.ambiente',
      p_pattern        => 'ambientes/:fecha/:horainicial/:horafinal/:latitud/:longitud',
      p_method         => 'GET',
      p_source_type    => 'json/query',
      p_items_per_page => 0,
      p_mimes_allowed  => '',
      p_comments       => 'Valores promedio de los sensores por ubicación para una fecha',
      p_source         => 
'SELECT  TO_CHAR(FECHA-interval ''6'' hour, ''DD/MM/YYYY'') AS FECHA
      , TO_CHAR(FECHA-interval ''6'' hour, ''HH24:MI:SS'') HORA
      , LATITUD
      , LONGITUD
      , MQ7
      , MQ135
      , GUVAS12SDUV 
 FROM AMBIENTE
WHERE TRUNC(FECHA-interval ''6'' hour) = TO_DATE(:fecha, ''YYYYMMDD'')
  AND TO_NUMBER(TO_CHAR(FECHA - INTERVAL ''6'' HOUR, ''HH24'')) BETWEEN :HORAINICIAL AND :HORAFINAL
  AND DISTANCIA_MAPA(LATITUD, LONGITUD, :LATITUD, :LONGITUD) < 5');

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'ace2g3.ambiente',
      p_pattern            => 'ambientes/:fecha/:horainicial/:horafinal/:latitud/:longitud',
      p_method             => 'GET',
      p_name               => 'fecha',
      p_bind_variable_name => 'fecha',
      p_source_type        => 'HEADER',
      p_param_type         => 'INT',
      p_access_method      => 'IN',
      p_comments           => 'Fecha de la que se solicita el promedio de los sensores');

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'ace2g3.ambiente',
      p_pattern            => 'ambientes/:fecha/:horainicial/:horafinal/:latitud/:longitud',
      p_method             => 'GET',
      p_name               => 'horafinal',
      p_bind_variable_name => 'horafinal',
      p_source_type        => 'HEADER',
      p_param_type         => 'INT',
      p_access_method      => 'IN',
      p_comments           => 'Hora final del rango');

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'ace2g3.ambiente',
      p_pattern            => 'ambientes/:fecha/:horainicial/:horafinal/:latitud/:longitud',
      p_method             => 'GET',
      p_name               => 'horainicial',
      p_bind_variable_name => 'horainicial',
      p_source_type        => 'HEADER',
      p_param_type         => 'INT',
      p_access_method      => 'IN',
      p_comments           => 'Hora inicial del rango');

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'ace2g3.ambiente',
      p_pattern            => 'ambientes/:fecha/:horainicial/:horafinal/:latitud/:longitud',
      p_method             => 'GET',
      p_name               => 'latitud',
      p_bind_variable_name => 'latitud',
      p_source_type        => 'HEADER',
      p_param_type         => 'DOUBLE',
      p_access_method      => 'IN',
      p_comments           => 'Latitud del filtro');

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'ace2g3.ambiente',
      p_pattern            => 'ambientes/:fecha/:horainicial/:horafinal/:latitud/:longitud',
      p_method             => 'GET',
      p_name               => 'longitud',
      p_bind_variable_name => 'longitud',
      p_source_type        => 'HEADER',
      p_param_type         => 'DOUBLE',
      p_access_method      => 'IN',
      p_comments           => 'Longitud del filtro');

  ORDS.DEFINE_TEMPLATE(
      p_module_name    => 'ace2g3.ambiente',
      p_pattern        => 'ambientesavg/:fecha',
      p_priority       => 0,
      p_etag_type      => 'HASH',
      p_etag_query     => NULL,
      p_comments       => 'Devuleve la media captada por los sensores para una fecha especifica');

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'ace2g3.ambiente',
      p_pattern        => 'ambientesavg/:fecha',
      p_method         => 'GET',
      p_source_type    => 'json/query',
      p_items_per_page => 0,
      p_mimes_allowed  => '',
      p_comments       => 'Devuleve la media captada por los sensores para una fecha especifica',
      p_source         => 
'SELECT  TO_CHAR(FECHA, ''DD/MM/YYYY'') AS FECHA
      , ROUND(AVG(MQ7), 5) AS MQ7
      , ROUND(AVG(MQ135), 5) AS MQ135
      , ROUND(AVG(GUVAS12SDUV), 5) AS GUVAS12SDUV 
 FROM VW_AMBIENTE
WHERE FECHA = TO_DATE(:fecha, ''YYYYMMDD'')
GROUP BY FECHA');

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'ace2g3.ambiente',
      p_pattern            => 'ambientesavg/:fecha',
      p_method             => 'GET',
      p_name               => 'fecha',
      p_bind_variable_name => 'fecha',
      p_source_type        => 'URI',
      p_param_type         => 'STRING',
      p_access_method      => 'IN',
      p_comments           => 'Fecha de la que se quiere el promedio en formato yyyymmdd');

  ORDS.DEFINE_TEMPLATE(
      p_module_name    => 'ace2g3.ambiente',
      p_pattern        => 'ambientesavgpos/:fecha/:horainicial/:horafinal/:latitud/:longitud',
      p_priority       => 0,
      p_etag_type      => 'HASH',
      p_etag_query     => NULL,
      p_comments       => 'Devuelve el promedio de lecturas de una ubicacion en una fecha y en un rago de horas dado');

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'ace2g3.ambiente',
      p_pattern        => 'ambientesavgpos/:fecha/:horainicial/:horafinal/:latitud/:longitud',
      p_method         => 'GET',
      p_source_type    => 'json/query',
      p_items_per_page => 0,
      p_mimes_allowed  => '',
      p_comments       => 'Devuelve el promedio de lecturas de una ubicacion en una fecha y en un rago de horas dado',
      p_source         => 
'SELECT  TO_CHAR(FECHA, ''DD/MM/YYYY'') AS FECHA
      , TRUNC(AVG(MQ7), 5) AS MQ7
      , TRUNC(AVG(MQ135), 5) AS MQ135
      , TRUNC(AVG(GUVAS12SDUV), 5) AS GUVAS12SDUV 
 FROM VW_AMBIENTE
WHERE FECHA = TO_DATE(:fecha, ''YYYYMMDD'')
  AND HORA BETWEEN :HORAINICIAL AND :HORAFINAL
  AND DISTANCIA_MAPA(LATITUD, LONGITUD, :LATITUD, :LONGITUD) < 5
GROUP BY FECHA');

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'ace2g3.ambiente',
      p_pattern            => 'ambientesavgpos/:fecha/:horainicial/:horafinal/:latitud/:longitud',
      p_method             => 'GET',
      p_name               => 'fecha',
      p_bind_variable_name => 'fecha',
      p_source_type        => 'URI',
      p_param_type         => 'STRING',
      p_access_method      => 'IN',
      p_comments           => 'Fecha del filtro en formato yyymmdd');

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'ace2g3.ambiente',
      p_pattern            => 'ambientesavgpos/:fecha/:horainicial/:horafinal/:latitud/:longitud',
      p_method             => 'GET',
      p_name               => 'horafinal',
      p_bind_variable_name => 'horafinal',
      p_source_type        => 'URI',
      p_param_type         => 'INT',
      p_access_method      => 'IN',
      p_comments           => 'Hora de filtro final');

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'ace2g3.ambiente',
      p_pattern            => 'ambientesavgpos/:fecha/:horainicial/:horafinal/:latitud/:longitud',
      p_method             => 'GET',
      p_name               => 'horainicial',
      p_bind_variable_name => 'horainicial',
      p_source_type        => 'URI',
      p_param_type         => 'INT',
      p_access_method      => 'IN',
      p_comments           => 'Hora de filtro inicial');

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'ace2g3.ambiente',
      p_pattern            => 'ambientesavgpos/:fecha/:horainicial/:horafinal/:latitud/:longitud',
      p_method             => 'GET',
      p_name               => 'latitud',
      p_bind_variable_name => 'latitud',
      p_source_type        => 'URI',
      p_param_type         => 'DOUBLE',
      p_access_method      => 'IN',
      p_comments           => 'Latitud del filtro');

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'ace2g3.ambiente',
      p_pattern            => 'ambientesavgpos/:fecha/:horainicial/:horafinal/:latitud/:longitud',
      p_method             => 'GET',
      p_name               => 'longitud',
      p_bind_variable_name => 'longitud',
      p_source_type        => 'URI',
      p_param_type         => 'DOUBLE',
      p_access_method      => 'IN',
      p_comments           => 'Longitud del filtro');

    
    
COMMIT;

END;