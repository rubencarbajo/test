<?php
/***************************************************************************
 *   RBN 2015
 ***************************************************************************/

include 'common.php';

include 'includes/diasemana.php';

date_default_timezone_set('Europe/Madrid');

//comprobar si viene una fecha, y es correcta
//$hoy = (isset($_GET['fecha']))? $_GET['fecha'] : date('Y-m-d');
if (isset($_GET['fecha'])) {
	$comprobar=(strpos($_GET['fecha'],'-')==4)&&(strpos(strrev($_GET['fecha']),'-')==2);
	$hoy=($comprobar)?$_GET['fecha']:date('Y-m-d');
} else {
	$hoy=date('Y-m-d');
}


//comprobar si vienen filtros
if (isset($_POST['localidad'])) $_SESSION['LC_FILTRO_LOCALIDAD']=$_POST['localidad'];
if (isset($_POST['genero'])) $_SESSION['LC_FILTRO_GENERO']=$_POST['genero'];

//preparar los filtros para las consultas
$sql_localidad='';
$sql_genero='';
if (isset($_SESSION['LC_FILTRO_LOCALIDAD']) && $_SESSION['LC_FILTRO_LOCALIDAD']!=0)
{
	$sql_localidad = " AND l.id_localidad=" . $_SESSION['LC_FILTRO_LOCALIDAD'];
}
if (isset($_SESSION['LC_FILTRO_GENERO']) && $_SESSION['LC_FILTRO_GENERO']!=0)
{
	$sql_genero = " AND a.id_categoria=" . $_SESSION['LC_FILTRO_GENERO'];
}

//actos no temporales para $hoy
$porpagina = 100;
$query = "SELECT a.id, a.id_tipo, t.tipo, a.id_categoria, c.categoria, a.id_lugar, l.lugar,
		l.id_localidad, loc.localidad, a.titulo, a.autor, a.fecha, a.hora, a.permanente, a.activo, a.cancelado  
		FROM lc_actos a
		LEFT JOIN lc_tipos t ON (a.id_tipo = t.id)
		LEFT JOIN lc_categorias c ON (a.id_categoria = c.id)
		LEFT JOIN lc_lugares l ON (a.id_lugar = l.id) 
		LEFT JOIN lc_localidades loc ON (l.id_localidad = loc.id) 
		WHERE a.fecha='" . $hoy . "' 
		AND a.permanente=0 
		AND a.activo=1 " . 
		$sql_localidad . 
		$sql_genero . " 
		ORDER BY a.hora 
		LIMIT " . $porpagina;
$res = mysql_query($query);
$system->check_mysql($res, $query, __LINE__, __FILE__);
$n_actos = mysql_num_rows($res);
while ($row = mysql_fetch_array($res))
{
	$row_imagen=buscaimagen($row['id']);
	$row_imagen_lugar = (file_exists($main_path . 'images/lugares/lugar' . $row['id_lugar'] . '.jpg'))? 'lugar' . $row['id_lugar'] . '.jpg' : '';
	$n_diasemana=date('N', strtotime($row['fecha']));
	$hora2 = str_replace(" // ","<br/>",$row['hora']);
	$template->assign_block_vars('actos', array(
			'ID' => $row['id'],
			'GENERO' => $row['tipo'] . " - " . $row['categoria'],
			'LOCALIDAD' => $row['localidad'],
			'LUGAR' => $row['lugar'],
			'TITULO' => $row['titulo'],
			'AUTOR' => $row['autor'],
			'DIASEMANA' => $str_diasemana[$n_diasemana],
			'HORA' => str_replace("//","<br/>",$hora2),
			'IMAGEN' => $row_imagen,
			'B_IMAGEN' => ($row_imagen!=''),
			'IMAGEN_LUGAR' => $row_imagen_lugar,
			'B_CANCELADO' => ($row['cancelado']!=0),
			));
}

//actos temporales para $hoy
$query = "SELECT a.*, t.tipo, c.categoria, l.lugar,	l.id_localidad, loc.localidad, loc.orden 
		FROM lc_actos a
		LEFT JOIN lc_tipos t ON (a.id_tipo = t.id)
		LEFT JOIN lc_categorias c ON (a.id_categoria = c.id)
		LEFT JOIN lc_lugares l ON (a.id_lugar = l.id) 
		LEFT JOIN lc_localidades loc ON (l.id_localidad = loc.id) 
		WHERE a.fecha<='" . $hoy . "' 
		AND a.fecha_fin>='" . $hoy . "' 
		AND a.permanente=1 
		AND a.activo=1 " . 
		$sql_localidad . 
		$sql_genero . " 
		ORDER BY loc.orden, a.fecha_fin 
		LIMIT " . $porpagina;
$res = mysql_query($query);
$system->check_mysql($res, $query, __LINE__, __FILE__);
$n_exposiciones = 0;
$hay_temporales=(mysql_num_rows($res)!=0);
while ($row = mysql_fetch_array($res))
{
	$n_diasemana=date('N', strtotime($hoy));
	if ($n_diasemana==1) $diasemana='lunes';
	if ($n_diasemana==2) $diasemana='martes';
	if ($n_diasemana==3) $diasemana='miercoles';
	if ($n_diasemana==4) $diasemana='jueves';
	if ($n_diasemana==5) $diasemana='viernes';
	if ($n_diasemana==6) $diasemana='sabados';
	if ($n_diasemana==7) $diasemana='domingos';
	if ($row[$diasemana]!='') $n_exposiciones++;
	$row_imagen=buscaimagen($row['id']);
	$row_imagen_lugar = (file_exists($main_path . 'images/lugares/lugar' . $row['id_lugar'] . '.jpg'))? 'lugar' . $row['id_lugar'] . '.jpg' : '';
	$horario2 = str_replace(" // ","<br/>",$row[$diasemana]);
	$template->assign_block_vars('temporales', array(
			'ID' => $row['id'],
			'GENERO' => $row['tipo'] . " - " . $row['categoria'],
			'LOCALIDAD' => $row['localidad'],
			'LUGAR' => $row['lugar'],
			'TITULO' => $row['titulo'],
			'AUTOR' => $row['autor'],
			'HORA' => $row['hora'],
			'IMAGEN' => $row_imagen,
			'B_IMAGEN' => ($row_imagen!=''),
			'IMAGEN_LUGAR' => $row_imagen_lugar,
			'B_ABREHOY' => ($row[$diasemana]!=''),
			'HORARIO' => $row[$diasemana],
			'HORARIO2' => str_replace("//","<br/>",$horario2),
			));
}

//Preparar listado de localidades.
$filtro_localidad=(isset($_SESSION['LC_FILTRO_LOCALIDAD']))? $_SESSION['LC_FILTRO_LOCALIDAD'] : 0;
$query = "SELECT * FROM lc_localidades ORDER BY orden, localidad";
$res = mysql_query($query);
$system->check_mysql($res, $query, __LINE__, __FILE__);
while ($row = mysql_fetch_array($res))
{
	$template->assign_block_vars('localidades', array(
			'ID' => $row['id'],
			'LOCALIDAD' => $row['localidad'],
			'B_ACTIVADO' => ($row['id']==$filtro_localidad),
			));
}

//Preparar listado de géneros.
$filtro_genero=(isset($_SESSION['LC_FILTRO_GENERO']))? $_SESSION['LC_FILTRO_GENERO'] : 0;
$query = "SELECT * FROM lc_categorias ORDER BY orden ASC";
$res = mysql_query($query);
$system->check_mysql($res, $query, __LINE__, __FILE__);
while ($row = mysql_fetch_array($res))
{
	$template->assign_block_vars('generos', array(
			'ID' => $row['id'],
			'GENERO' => $row['categoria'],
			'B_ACTIVADO' => ($row['id']==$filtro_genero),
			));
}

//La frase del vigía.
$query = "SELECT * FROM lc_frases WHERE fecha='" . date('Y-m-d') . "' LIMIT 1";
$res = mysql_query($query);
$system->check_mysql($res, $query, __LINE__, __FILE__);
$frase='';
if (mysql_num_rows($res)!=0) $frase = mysql_result($res, 0, 'frase');
$b_frase=($frase!='');
if (isset($_GET['fecha']) && $_GET['fecha']!=date('Y-m-d')) $b_frase=false;

//pseudoencriptar la frase
/*
$i=0;
$frase2='';
while ($i < strlen($frase))
{
	if ( ord(substr($frase, $i, 1))>=32 && ord(substr($frase, $i, 1))<=127 ) 
	{
		$frase2.='<span style="font-size:0px;">' . chr(rand(33,127)) . '</span>' . substr($frase, $i, 1);
	}
	else
	{
		$frase2.= substr($frase, $i, 1);
	}
	$i++;
}
*/

//Museos
$query = "SELECT l.*, loc.localidad, loc.orden
		FROM lc_lugares l
		LEFT JOIN lc_localidades loc ON (l.id_localidad = loc.id)
		WHERE l.museo=1 " . 
		$sql_localidad . "
		ORDER BY loc.orden";
$res = mysql_query($query);
$system->check_mysql($res, $query, __LINE__, __FILE__);
$b_museos=(mysql_num_rows($res)!=0);
while ($row = mysql_fetch_array($res))
{
	$web='';
	if ($row['sitio_web']!='') $web=(substr($row['sitio_web'],0,4)=="http")? $row['sitio_web'] : "http://" . $row['sitio_web'];
	$template->assign_block_vars('museos', array(
			'ID' => $row['id'],
			'LUGAR' => $row['lugar'],
			'LOCALIDAD' => $row['localidad'],
			'WEB' => $web,
			));
}

//numero de actos
$n_total=$n_actos + $n_exposiciones;

//Preparar plantilla
$n_diasemana=date('N', strtotime($hoy));
$template->assign_vars(array(
		'SITIO' => $system->SETTINGS['sitename'],
		'HOY' => lee_fecha($hoy),
		'CAL_FECHA' => $hoy,
		'DIASEMANA' => $str_diasemana[$n_diasemana],
		'B_HAY_TEMPORALES' => $hay_temporales,
		'FRASE' => $frase,
		'B_FRASE' => $b_frase,
		'B_BANNER2' => ($n_total>16),
		'B_MUSEOS' => $b_museos,

		));

include 'header.php';

$template->set_filenames(array(
		'body' => 'index.tpl'
		));
$template->display('body');
include 'footer.php';

?>
