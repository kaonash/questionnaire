import {Socket} from "phoenix"

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

channel.on("receive_question", function(question) {
  updateQuestion(question);
});

channel.on("receive_data", function(data) {
  updateChart(data);
});

$(function () {
  $('#chart').highcharts({
    title: { text: 'アンケート結果' },
    plotOptions: {
      pie: {
        dataLabels: {
          formatter: function() {
            return '<b>'+ this.point.name +'</b>:'+ Math.round(this.percentage*10)/10 + '%';
          }
        }
      }
    },
    series: [{ type: 'pie', name: '', data: [ ['A',0], ['B',0], ['C',0], ['D',0] ] }],
    tooltip: { formatter: function() { return this.y +'人';}, enabled:true }
  });
  // データの初期化を要求
  channel.push("get_aggregate");
});

$(function () {
  $("#a-button").click(function() {
    channel.push("send_answer", {answer: "A"});
  });

  $("#b-button").click(function() {
    channel.push("send_answer", {answer: "B"});
  });

  $("#c-button").click(function() {
    channel.push("send_answer", {answer: "C"});
  });

  $("#d-button").click(function() {
    channel.push("send_answer", {answer: "D"});
  });

  $("#reset-button").click(function() {
    channel.push("reset_answer");
  });
});

function updateQuestion(question) {
  $('#question').text("test");
};

function updateChart(data) {
  var chart = $("#chart").highcharts();
  chart.series[0].setData([['A',data.A],['B',data.B],['C',data.C],['D',data.D]]);
};
