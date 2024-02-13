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
		<div class="tab text-center mb-3">
			<div class="form-check form-check-inline">
				<label class="form-check-label"> <input
					class="form-check-input" type="radio" name="chart" value="bar"
					checked>막대그래프
				</label>
			</div>
			<div class="form-check form-check-inline">
				<label class="form-check-label"> <input
					class="form-check-input" type="radio" name="chart" value="doughnut">도넛그래프
				</label>

			</div>
		</div>
		<div class="tab text-center mb-3">
			<div class="form-check form-check-inline">
				<label class="form-check-label"> <input
					class="form-check-input" type="checkbox" id="top3"> Top3부서
				</label>
			</div>
			<div class="form-check form-check-inline">
				<label class="form-check-label"> <input
					class="form-check-input" type="radio" name="unit" value="year"
					checked>년도별
				</label>
			</div>
			<div class="form-check form-check-inline">
				<label class="form-check-label"> <input
					class="form-check-input" type="radio" name="unit" value="month">월별
				</label>
			</div>
		</div>
		<canvas id="chart" class="m-auto" style="height: 100%"></canvas>
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
					<li class="col-auto"><span></span><font>\${i*10}~\${i*10+9}명</font></li>
				`;
			}
			li += `
					<li class="col-auto"><span></span><font>\${i*10}명 이상</font></li>
				`;
			var tag = `
				<ul class="row d-flex justify-content-center mt-4" id="legend">
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
				
				$("#tab-content .tab").addClass("d-none");
				$("#tab-content .tab").eq(idx).removeClass("d-none");
				
				if (idx == 0)
					department();
				else if (idx == 1)
					if($("#top3").prop("checked")) hirement_top3();
					else hirement();
			},
			"mouseover" : function() {
				$(this).addClass("shadow");
			},
			"mouseleave" : function() {
				$(this).removeClass("shadow");
			}
		});
		$("[name=chart]").change(function() {
			department();
		})
		$("[name=unit]").change(function() {
			if($("#top3").prop("checked")) hirement_top3();
			else hirement();
		})
		$("#top3").change(function() {
			if($("#top3").prop("checked")) hirement_top3();
			else hirement();
		})
		
		function department() {
			//if(typeof visual != "undefined") visual.destroy();
			initChart();
			$.ajax({
				url : "department"
			}).done(function(resp) {
				var info = {};
				info.category = [];
				info.datas = [];
				info.colors = [];
				$(resp).each(function() {
					info.category.push(this.DEPARTMENT_NAME);
					info.datas.push(this.COUNT);
					info.colors.push(colors[Math.floor(this.COUNT / 10)]);
				})
				if($("[name=chart]:checked").val()=="bar")
					barChart(info);
				else
					doughnutChart(info);
				//visual.update();그래프를 바꾸는 것에 영향을 못 준다.
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
			new Chart($("#chart"), {
				type : 'bar',
				data : {
					labels : info.category,
					datasets : [ {
						label : '부서원수',
						data : info.datas,
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
		function lineChart(info) {
			new Chart($("#chart"), {
				type : 'line',
				data : {
					labels : info.category,
					datasets : [ {
						label : '부서원수',
						data : info.datas,
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
		function doughnutChart(info) {
			var sum = 0;
			$(info.datas).each(function() {
				sum+=this;
			});
			info.pct = info.datas.map(function( value ) {
				return Math.round(value/sum*10000)/100;
			});
			new Chart($("#chart"), {
				type : 'doughnut',
				data : {
					labels : info.category,
					datasets : [ {
						label : '부서원수',
						data : info.datas,
						/* pointBackgroundColor : "black",
						borderColor:"grey", */
					    hoverOffset: 15
					} ]
				},
				options : {
					plugins : {
						datalabels : {
							formatter : function(v, item) {
								return `\${info.pct[item.dataIndex]}%`;
							},
							anchor:"middle",
						},
						autocolors:{mode:"data"}
					},
					responsive : false,
					maintainAspectRatio : false,
					cutout : "60%",
				}
			});
			
		}
		function hirement() {
			initChart();
			
			var unit = $("[name=unit]:checked").val();
			
			$.ajax({
				url : "hirement/"+unit
			}).done(function(resp) {
				var info = {};
				info.datas=[], info.category =[], info.colors=[];
				$(resp).each(function() {
					info.datas.push(this.COUNT);
					info.category.push(this.UNIT);
					info.colors.push(colors[Math.floor(this.COUNT/10)]);
					info.title = (unit == "year" ? "년도별 " : "월별 ")+"채용인원수";
				})
				unitChart(info);
			})
		}
		function hirement_top3() {
			initChart();
			
			var unit = $("[name=unit]:checked").val();
			
			$.ajax({
				url : "hirement/top3/"+unit
			}).done(function(resp) {
				var info = {};
				info.datas=[], info.category =resp.unit, info.colors=[], info.label=[];
				info.type = (unit == "year" ? "bar" : "line ");
				$(resp.list).each(function(idx, dept) {
					info.label.push(this.DEPARTMENT_NAME);
					var datas = info.category.map(function(item) {
						return dept[item];
					});
					info.datas.push(datas);
				})
				top3Chart(info);
			})
		}
		function top3Chart(info) {
			var datas = [];
			for(var idx=0; idx<info.datas.length; idx++){
				var department = {};
				department.data = info.datas[idx];
				department.label = info.label[idx];
				department.backgroundColor = colors[idx];
				datas.push(department);
			}
			
			new Chart($("#chart"), {
				type : info.type,
				data : {
					labels : info.category,
					datasets : datas
				},
				options : {
					plugins : {
						datalabels : {
							formatter : function(value, context) {
								return value !=0 ? value + '명' : '';
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
								text : info.title
							}
						}
					}
				}
			});
			makeLegend()
		}
		
		function unitChart(info) {
			new Chart($("#chart"), {
				type : 'bar',
				data : {
					labels : info.category,
					datasets : [ {
						label : '채용인원',
						data : info.datas,
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
								text : info.title
							}
						}
					}
				}
			});
			makeLegend()
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
		function initChart() {
			$("#legend").remove();
			$("canvas#chart").remove();
			$("#tab-content").append(`<canvas id="chart" class="m-auto" style="height: 100%"></canvas>`);
			
			
		}
		
		
		$(function() {
			$("ul.nav-tabs li").eq(0).trigger("click");//페이지 리로딩 시 기본값 설정
		})
	</script>
</body>
</html>