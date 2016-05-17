import {Socket} from "phoenix"

var a = 0;
var b = 0;
var c = 0;
var d = 0;

var socket = new Socket("/socket");
socket.connect();
var channel = socket.channel("rooms:lobby", {});
channel.join();

$("form").submit(function(e) {
  e.preventDefault();
  channel.push("send_message", {message: $("#input-send-message").val()});
  $("#input-send-message").val("");
});

channel.on("receive_message", function(dt) {
  var div = $("<div></div>", {"class": "received-message"}).text(dt.message);
  $("#received-message").prepend(div);
});

channel.on("receive_data", function(dt) {
  updateChart(dt.data);
});

$(function () {
        $('#chart').highcharts({
            title: {
                text: 'アンケート結果'
            },
            plotOptions: {
                pie: {
                    dataLabels: {
                         formatter: function() {
                             return '<b>'+ this.point.name +'</b>:'+ Math.round(this.percentage*10)/10 + '%';
                        }
                    }
                }
            },
            series: [{
                type: 'pie',
                name: '',
                data: [
                    ['A',a],
                    ['B',b],
                    ['C',c],
                    ['D',d]
                ]
            }],
            tooltip: {
                formatter: function() {
                    return this.y +'人';},
                enabled:true
            }
        });
    });

$(function () {
  $("#a-button").click(function() {
    a = a+1;
    channel.push("send_data", {data: [
        ['A',a],
        ['B',b],
        ['C',c],
        ['D',d]
    ]});
  });

  $("#b-button").click(function() {
    b = b+1;
    channel.push("send_data", {data: [
        ['A',a],
        ['B',b],
        ['C',c],
        ['D',d]
    ]});
  });

  $("#c-button").click(function() {
    c = c+1;
    channel.push("send_data", {data: [
        ['A',a],
        ['B',b],
        ['C',c],
        ['D',d]
      ]});
    });

  $("#d-button").click(function() {
    d = d+1;
    channel.push("send_data", {data: [
        ['A',a],
        ['B',b],
        ['C',c],
        ['D',d]
    ]});
  });
  $("#reset-button").click(function() {
    a = 0;
    b = 0;
    c = 0;
    d = 0;
    channel.push("send_data", {data: [
        ['A',a],
        ['B',b],
        ['C',c],
        ['D',d]
    ]});
  });
});

function updateChart(data) {
  a = data[0][1];
  b = data[1][1];
  c = data[2][1];
  d = data[3][1];

  var chart = $("#chart").highcharts();
    chart.series[0].setData(data);
};
