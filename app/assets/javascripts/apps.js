var ready;
ready = function() {
  $('button.special').click(function() {
        $(this).addClass('active').siblings().removeClass('active');
  });
  $('.sector_select').change(function() {
        $("input[name='congress_house']").val($("button.active").val());
        $(this).closest("form").submit();
  });

};

$(document).ready(ready);
$(document).on('page:load', ready);


