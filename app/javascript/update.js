$(function(){
  $('.button').on('click', function() {
    setTimeout("location.reload()",100);
    //少し時間を遅らせないとstatusの更新がトップページに反映されないためsetTimeoutを使用
  });
});