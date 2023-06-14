function makeChart(htmlid, options) {
     var chart = new ApexCharts(document.querySelector("#" + htmlid), options);
     chart.render();
}
//datas est du format: [{"name":"nom", "data":datas }]
//category est du format: ["label", "label"]
//color est du format: ["#1abc9c", ...]
const colors=[
     "#FF0000", // Rouge
     "#00FF00", // Vert
     "#0000FF", // Bleu
     "#FFFF00", // Jaune
     "#FF00FF", // Magenta
     "#00FFFF", // Cyan
     "#FFA500", // Orange
     "#800080", // Violet
     "#008000", // Vert foncé
     "#000080", // Bleu foncé
     "#800000", // Marron
     "#FFC0CB", // Rose
     "#808080", // Gris
     "#800080", // Pourpre
     "#FFD700", // Or
     "#008080" // Sarcelle
   ];
function makeBasicLineChart(htmlid, datas, yaxis, color = ["#1abc9c"], longueur = 300) {
     console.log(datas);
     console.log(yaxis);
     var options = {
          chart: {
               height: longueur, //longueur
               type: "line", //type de chart
               zoom: {
                    enabled: false,
               },
          },
          dataLabels: {
               enabled: false, //afficher les données dans la representation des données?
               width: 2,
          },
          stroke: {
               curve: "straight",
          },
          colors: color,
          series: datas,
          title: {
               text: "",
               align: "left",
          },
          grid: {
               row: {
                    colors: ["#f3f6ff", "transparent"], // takes an array which will be repeated on columns
                    opacity: 0.5,
               },
          },
          xaxis: {
               categories: yaxis,
          },
     };
     makeChart(htmlid, options);
}
function makeAreaChart(htmlid, datas, yaxis, color = colors, longueur = 350) {
     console.log(datas);
     console.log(yaxis);
     var options = {
          chart: {
               height: longueur,
               type: 'area',
          },
          dataLabels: {
               enabled: false
          },
          stroke: {
               curve: 'smooth'
          },
          colors: color,
          series: datas,

          xaxis: {
               //type: 'datetime',
               categories: yaxis
          },
          /*tooltip: {
              x: {
                  format: 'dd/MM/yy HH:mm'
              },
          }*/
     }
     makeChart(htmlid, options);
}
function makeBarChart(htmlid, datas, yaxis, color = ["#1abc9c"], longueur = 350) {
     console.log(datas);
     console.log(yaxis);
     var options = {
          chart: {
               height: longueur,
               type: 'bar',
          },
          plotOptions: {
               bar: {
                    horizontal: false,
                    columnWidth: '55%',
                    endingShape: 'rounded'
               },
          },
          dataLabels: {
               enabled: false
          },
          colors: color,
          stroke: {
               show: true,
               width: 2,
               colors: ['transparent']
          },
          series: datas,
          xaxis: {
               categories: yaxis,
          },
          yaxis: {
               title: {
                    text: ''//text y?
               }
          },
          fill: {
               opacity: 1

          },
          /*tooltip: {
               y: {
                    formatter: function (val) {
                         return "$ " + val + " thousands"
                    }
               }
          }*/

     }
     makeChart(htmlid, options);
}
function makeBarChartStacked(htmlid, datas, yaxis, color = ["#1abc9c"], longueur = 350) {
     console.log(datas);
     console.log(yaxis);
     var options = {
          chart: {
               height: longueur,
               type: 'bar',
               stacked: true,
               toolbar: {
                    show: true
               },
               zoom: {
                    enabled: true
               }
          },
          colors: color,
          responsive: [{
               breakpoint: 480,
               options: {
                    legend: {
                         position: 'bottom',
                         offsetX: -10,
                         offsetY: 0
                    }
               }
          }],
          plotOptions: {
               bar: {
                    horizontal: false,
               },
          },
          series: datas,
          xaxis: {
               type: 'datetime',
               categories: yaxis,
          },
          legend: {
               position: 'right',
               offsetY: 40
          },
          fill: {
               opacity: 1
          },
     }
     makeChart(htmlid, options);
}
// les labels est de format: ["label", "label"]
function makePieChart(htmlid, datas,labels, color =colors, longueur = 320) {
     console.log(labels);
     console.log(datas);
     var options = {
          chart: {
               height: longueur,
               type: 'pie',
          },
          labels: labels,
          series: datas,
          colors: color,
          legend: {
               show: true,
               position: 'bottom',
          },
          dataLabels: {
               enabled: true,
               dropShadow: {
                    enabled: false,
               }
          },
          responsive: [{
               breakpoint: 480,
               options: {
                    legend: {
                         position: 'bottom'
                    }
               }
          }]
     }
     makeChart(htmlid, options);
}
function makePieChartDonut(htmlid, datas, color = ["#1abc9c"], longueur = 350){
     console.log(datas);
     console.log(yaxis);
     var options = {
          chart: {
              height: longueur,
              type: 'donut',
          },
          series: datas,
          colors: color,
          legend: {
              show: true,
              position: 'bottom',
          },
          plotOptions: {
              pie: {
                  donut: {
                      labels: {
                          show: true,
                          name: {
                              show: true
                          },
                          value: {
                              show: true
                          }
                      }
                  }
              }
          },
          dataLabels: {
              enabled: true,
              dropShadow: {
                  enabled: false,
              }
          },
          responsive: [{
              breakpoint: 480,
              options: {          
                  legend: {
                      position: 'bottom'
                  }
              }
          }]
      }
     makeChart(htmlid, options);
}

