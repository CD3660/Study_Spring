<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#legend span {
	width: 44px;
	height: 17px;
	margin-right: 5px;
}

#legend li {
	display: flex;
	align-items: center;
}
</style>
</head>
<body>
	<h3 class="mb-4">사원정보분석</h3>
	<ul class="nav nav-tabs">
		<li class="nav-item"><a class="nav-link active">부서원수</a></li>
		<li class="nav-item"><a class="nav-link">채용인원수</a></li>
		<li class="nav-item"><a class="nav-link">Link</a></li>
		<li class="nav-item"><a class="nav-link">Disabled</a></li>
	</ul>
	<div id="tab-content" class="py-3" style="height: 520px">
		<canvas id="chart" class="m-auto" style="height: 520px"></canvas>
	</div>



	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2"></script>
	<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-autocolors"></script>
	<script>
		function makeLegend() {
			var li = "";
			var i
			for(i = 0; i<=5; i++){
				li += `
					<li class="col-auto"><span></span><font>\${i*10}~${i*10+9}명</font></li>
				`;
			}
			li += `
					<li class="col-auto"><span></span><font>\${i*10}명 이상</font></li>
				`;
			var tag = `
				<ul class="row d-flex justify-content-center" id="legend">
					\${li}
				</ul>
			`;
			$("#tab-content").after(tag);
			$("#legend span").each(function(idx) {
				$(this).css("background-color", colors[idx]);
			})
		}
	
		/* $("ul.nav-tabs li").on("click",function(){
			$("ul.nav-tabs li a").removeClass("active");
			$(this).find("a").addClass("active");
		});
		$("ul.nav-tabs li").on("mouseover",function(){
			$(this).addClass("shadow");
		});
		$("ul.nav-tabs li").on("mouseleave",function(){
			$(this).removeClass("shadow");
		}); */
		$("ul.nav-tabs li").on({
			"click" : function() {
				$("ul.nav-tabs li a").removeClass("active");
				$(this).find("a").addClass("active");
				var idx = $(this).index();
				if (idx == 0)
					department();
				else if (idx == 1)
					hirement();
			},
			"mouseover" : function() {
				$(this).addClass("shadow");
			},
			"mouseleave" : function() {
				$(this).removeClass("shadow");
			}
		});

		function department() {
			$.ajax({
				url : "department"
			}).done(function(resp) {
				var info = {};
				info.category = [];
				info.data = [];
				info.colors = [];
				$(resp).each(function() {
					info.category.push(this.DEPARTMENT_NAME);
					info.data.push(this.COUNT);
					info.colors.push(colors[Math.floor(this.COUNT / 10)]);
				})
				barChart(info);
				
			})

		}

		Chart.defaults.font.size = 16;
		Chart.defaults.plugins.legend.position = 'bottom';
		Chart.register(ChartDataLabels);
		Chart.register(window['chartjs-plugin-autocolors']);

		Chart.defaults.set('plugins.datalabels', {
			color : '#000000',
			anchor : 'end',
			font : {
				weight : 'bold'
			}
		});
		var colors = [ '#e60215', '#ff9500', '#fff200', '#a2ff00', '#00ff08',
				'#00ffff', '#002aff', '#8c00ff', '#ff00f2', '#7b0094' ];
		function barChart(info) {
			console.log(info);
			new Chart($("#chart"), {
				type : 'bar',
				data : {
					labels : info.category,
					datasets : [ {
						label : '부서원수',
						data : info.data,
						borderWidth : 1,
						barPercentage : 0.5,
						backgroundColor : info.colors,
					} ]
				},
				options : {
					plugins : {
						datalabels : {
							formatter : function(value, context) {
								return value + '명';
							}

						},
						legend : {
							display : false
						},
						autocolors : {
							mode : 'data'
						},
					},
					responsive : false,
					maintainAspectRatio : false,
					scales : {
						y : {
							beginAtZero : true,
							title : {
								color : 'black',
								display : true,
								text : '부서원수'
							}
						}
					}
				}
			});
			makeLegend()
		}

		function hirement() {
			$.ajax({
				url : "department"
			}).done(function(resp) {
				var info = {};
				info.category = [];
				info.data = [];
				info.colors = [];
				$(resp).each(function() {
					info.category.push(this.DEPARTMENT_NAME);
					info.data.push(this.COUNT);
					info.colors.push(colors[Math.floor(this.COUNT / 10)]);
				})
				lineChart(info);
				
			})
		}
		function lineChart(info) {
			new Chart($("#chart"), {
				type : 'line',
				data : {
					labels : info.category,
					datasets : [ {
						label : '부서원수',
						data : info.data,
						pointBackgroundColor : "black",
						borderColor:"grey",
						pointRadius:5,
						tension: 0.1
					} ]
				},
				options : {
					plugins : {
						datalabels : {
							formatter : function(value, context) {
								return value + '명';
							}

						},
						legend : {
							display : false
						},
					},
					responsive : false,
					maintainAspectRatio : false,
					scales : {
						y : {
							beginAtZero : true,
							title : {
								color : 'black',
								display : true,
								text : '부서원수'
							}
						}
					}
				}
			});
			
		}

		function sampleChart() {
			new Chart($("#chart"), {
				type : 'bar',
				data : {
					labels : [ 'Red', 'Blue', 'Yellow', 'Green', 'Purple',
							'Orange' ],
					datasets : [ {
						label : '# of Votes',
						data : [ 12, 19, 3, 5, 2, 3 ],
						borderWidth : 1
					} ]
				},
				options : {
					scales : {
						y : {
							beginAtZero : true
						}
					}
				}
			});
		}

		$(function() {
			$("ul.nav-tabs li").eq(0).trigger("click");//페이지 리로딩 시 기본값 설정
		})
	</script>
</body>
</html>