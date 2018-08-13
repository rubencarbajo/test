<table width="100%" border="0" cellpadding="0" cellspacing="0" class="smallpadding" style="padding-top:0px;">
	<!-- IF B_FRASE -->
	<tr>
		<td colspan="2">
			<a href="">
			<div class="listacto">
				<table>
					<tr>
						<td width="235px" style="text-align:center;">
							<span style="font-weight:bold;">La Frase del Vigía</span>
						</td>
						<td width="710px" style="text-align:center;">
							{FRASE}&nbsp;&nbsp;&nbsp;<span style="font-size:10px; font-weight:bold;">&copy;&nbsp;Heteróclito</span>
						</td>
					</tr>
				</table>
			</div>
			</a>
		</td>
	</tr>
	<!-- ENDIF -->
	<tr>
		<td width="250px" valign="top">
			
			<input type="text" id="datetimepicker3" value="{CAL_FECHA}"/>
			
			<br>
			<div class="listacto">
				<table>
					<tr>
						<td width="115px" style="border-right:1px solid #bbb; text-align:center; font-weight:bold">
							<a href="semana.php?fecha={CAL_FECHA}">Semana</a>
						</td>
						<td width="115px" style="text-align:center; font-weight:bold">
							<a href="findesemana.php?fecha={CAL_FECHA}">Fin de semana</a>
						</td>
					</tr>
				</table>
			</div>
			<div style="margin:5px; line-height:2em;">
				<form action="index.php?fecha={CAL_FECHA}" method="post">
				<select name="localidad" style="width:242px;" onchange="this.form.submit()">
					<option value="0">Todas las localidades</option>
					<!-- BEGIN localidades -->
					<option value="{localidades.ID}" <!-- IF localidades.B_ACTIVADO --> selected="true"<!-- ENDIF --> >{localidades.LOCALIDAD}</option>
					<!-- END localidades -->
				</select><br>
				<select name="genero" style="width:242px;" onchange="this.form.submit()">
					<option value="0">Todos los géneros</option>
					<!-- BEGIN generos -->
					<option value="{generos.ID}" <!-- IF generos.B_ACTIVADO --> selected="true"<!-- ENDIF --> >{generos.GENERO}</option>
					<!-- END generos -->
				</select><br>
				</form>					
			</div>
			<br/>
			<center>
				
				<a href="http://tamtampress.es/">
					<img src="images/enlaces/tamtampress2.jpg" title="Tráfico de cultura. Piensa, crea, actúa, retumba..." alt="Tam Tam Press. Tráfico de cultura. Piensa, crea, actúa, retumba...">
				</a>
				<br/><br>
				
				<!-- <a href="acto.php?id=7310">
					<img src="images/enlaces/steampunk2018.jpg" title="Mecánica SteamPunk - Ponferrada">
				</a>
				<br/><br> -->
				
				<!-- <a href="http://www.casabotines.es/catas/">
					<img src="images/enlaces/catas-2018.jpg" title="León Manjar de Reyes - Catas y Maridajes">
				</a>
				<br/><br> -->

				<a href="auditorio2018.php">
					<img src="images/enlaces/auditorio2018.jpg" title="Auditorio Ciudad de León - 2018">
				</a>
				<br/><br>
																				
			</center>
			
			
			<center>
				<script async src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
				<!-- Vertical160x600 -->
				<ins class="adsbygoogle"
					 style="display:inline-block;width:160px;height:600px"
					 data-ad-client="ca-pub-3159375298536836"
					 data-ad-slot="7951287503"></ins>
				<script>
				(adsbygoogle = window.adsbygoogle || []).push({});
				</script>
			<!-- IF B_BANNER2 -->
				<br/>&nbsp;<br/>
				<script async src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
				<!-- Vertical160x600 -->
				<ins class="adsbygoogle"
					 style="display:inline-block;width:160px;height:600px"
					 data-ad-client="ca-pub-3159375298536836"
					 data-ad-slot="7951287503"></ins>
				<script>
				(adsbygoogle = window.adsbygoogle || []).push({});
				</script>
			<!-- ENDIF -->
			</center>
			<br/>
			
			<!-- IF B_MUSEOS -->
			<div class="listacto">
				<table>
					<tr>
						<td width="230px" style="text-align:center; font-size:16px; font-weight:bold;">
							Museos y Exposiciones Permanentes
						</td>
					</tr>
					<!-- BEGIN museos -->
					<tr>
						<td width="230px" style="text-align:center">
							<a href="{museos.WEB}"><!-- IF museos.LOCALIDAD neq 'León' -->{museos.LOCALIDAD} - <!-- ENDIF -->{museos.LUGAR}</a>
						</td>
					</tr>
					<!-- END museos -->
				</table>
			</div>
			<!-- ENDIF -->
		
		</td>
		<td  valign="top">
			
			<!-- <div class="listacto" style="background-color:#eee;">
				<table>
					<tr>
						<td width="705px" align="center">
							<a href="semana-santa-2018.php">
								<span class="bigfont" style="color:#c33;text-decoration:underline";>- Programas de Semana Santa 2018 -</span>
							</a>
						</td>
					</tr>
				</table>
			</div> -->
			
			<div class="listacto">
				<table>
					<tr>
						<td width="705px" align="center">
							<span class="bigfont">Actos programados para el {DIASEMANA} {HOY}</span>
						</td>
					</tr>
				</table>
			</div>
		<!-- BEGIN actos -->
			<div class="listacto">
				<table>
					<tr>
						<td width="128px" align="center">
							<a href="acto.php?id={actos.ID}">
								<!-- IF actos.B_CANCELADO --><span class="blink_text" style="font-weight:bold; font-size:16px;">CANCELADO</span><br/><!-- ENDIF -->
								<span class="bigfont">{actos.HORA}</span>
							</a>
						</td>
					<!-- IF actos.B_IMAGEN -->
						<td width="134px" height="128px" align="center">
							<a href="acto.php?id={actos.ID}">
								<img src="getthumb.php?w=128&fromfile=images/actos/{actos.IMAGEN}">
							</a>
						</td>
					<!-- ELSE -->
						<!-- IF actos.IMAGEN_LUGAR neq '' -->
						<td width="134px" height="128px" align="center">
							<a href="acto.php?id={actos.ID}">
								<img src="getthumb.php?w=128&fromfile=images/lugares/{actos.IMAGEN_LUGAR}">
							</a>
						</td>
						<!-- ELSE -->
						<td width="134px" height="128px">
					
						</td>
						<!-- ENDIF -->
					<!-- ENDIF -->
						<td width="450px" valign="top">
							<p style="margin-bottom:10px;">
							<a href="acto.php?id={actos.ID}"><span class="bigfont">{actos.GENERO}<br></span></a>
							</p>
							<p style="margin-bottom:4px;">
							<b><a href="acto.php?id={actos.ID}">{actos.TITULO}</a></b><br>
							</p>
							<p style="margin-bottom:10px;">
							<b>{actos.AUTOR}</b><br>
							</p>
							<p>
							<b><span style="text-transform:uppercase;">{actos.LOCALIDAD}</span> - {actos.LUGAR}</b>
							</p>
						</td>
					</tr>
				</table>
			</div>
		<!-- END actos -->
			<br/>&nbsp;<br/>
			<script async src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
			<!-- Horizontal728x90 -->
			<ins class="adsbygoogle"
				 style="display:inline-block;width:728px;height:90px"
				 data-ad-client="ca-pub-3159375298536836"
				 data-ad-slot="6474554305"></ins>
			<script>
			(adsbygoogle = window.adsbygoogle || []).push({});
			</script>
			
			<br/>&nbsp;<br/>
		<!-- IF B_HAY_TEMPORALES -->
			<div class="listacto">
				<table>
					<tr>
						<td width="705px" align="center">
							<span class= bigfont>Exposiciones abiertas el {DIASEMANA} {HOY}</span>
						</td>
					</tr>
				</table>
			</div>
		<!-- ENDIF -->
		<!-- BEGIN temporales -->
			<!-- IF temporales.B_ABREHOY -->
			<div class="listacto">
				<table>
					<tr>
						<td width="128px" align="center">
							<a href="acto.php?id={temporales.ID}">
								<span class="bigfont">{temporales.HORARIO2}</span>
							</a>
						</td>
					<!-- IF temporales.B_IMAGEN -->
						<td width="134px" height="128px" align="center">
							<a href="acto.php?id={temporales.ID}">
								<img src="getthumb.php?w=128&fromfile=images/actos/{temporales.IMAGEN}">
							</a>
						</td>
					<!-- ELSE -->
						<!-- IF temporales.IMAGEN_LUGAR neq '' -->
						<td width="134px" height="128px" align="center">
							<a href="acto.php?id={temporales.ID}">
								<img src="getthumb.php?w=128&fromfile=images/lugares/{temporales.IMAGEN_LUGAR}">
							</a>
						</td>
						<!-- ELSE -->
						<td width="134px" height="128px">
					
						</td>
						<!-- ENDIF -->
					<!-- ENDIF -->
						<td width="450px" valign="top">
							<p style="margin-bottom:10px;">
							<a href="acto.php?id={temporales.ID}"><span class="bigfont">{temporales.GENERO}<br></span></a>
							</p>
							<p style="margin-bottom:4px;">
							<b><a href="acto.php?id={temporales.ID}">{temporales.TITULO}</a></b><br>
							</p>
							<p style="margin-bottom:10px;">
							<b>{temporales.AUTOR}</b><br>
							</p>
							<p>
							<b><span style="text-transform:uppercase;">{temporales.LOCALIDAD}</span> - {temporales.LUGAR}</b>
							</p>
						</td>
					</tr>
				</table>
			</div>
			<!-- ENDIF -->
		<!-- END temporales -->
		</td>
	</tr>
</table>

<script>
$.datetimepicker.setLocale('es');
var today = new Date();
$('#datetimepicker3').datetimepicker({
	inline:true,
	timepicker:false,
	//defaultDate:'{CAL_FECHA}',
	format:'Y-m-d',
	dayOfWeekStart : 1,
	scrollMonth:false,
	scrollTime:false,
	scrollInput:false,
	onSelectDate:function(ct,$i){
		window.location.assign("index.php?fecha=" + ct.dateFormat('Y-m-d'))
		},
	beforeShowDay: function(date) {
		if (date.getMonth() == today.getMonth() && date.getDate() == today.getDate()) {
			return [true, "today-style"];
		}
		return [true, ""];
		}
});
</script>

<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-71661386-1', 'auto');
  ga('send', 'pageview');

</script>
