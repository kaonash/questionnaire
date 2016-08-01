$(function () {
  $("#send_question").click(function() {
    channel.push("send_question", {question: "testetst"});
  });
});
