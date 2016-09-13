(function($) {
  $.widget( 'sh.sectionSelector', {
    options: {
      setSectionSelection: function(event, data){
        console.log('fyle_id = ', data.fyle_id);
        console.log('selected section id = ', data.section_id);
        console.log('selected section name = ', data.section_name);
        console.log('selected pages array = ', data.pages);
      }
    },
    fyle_id: null,
    pages: [],

    _create: function() {
      var that = this;

      $('body').on('click', '#selections_modal .btn-primary', function(){
        var selected_section = $("#selections_modal input:checked[name='section']").val();
        if (selected_section == '-1') { // add new section
          var section_name = $.trim($('#selections_modal #new_section').val());
          if (section_name == '') {
            alert('Please enter a name for the new section.');
            return false;
          }
          var max_radio_val = Math.max(...$("#selections_modal input[name='section']").map(function(){
            return parseInt($(this).val());
          }).get());

          var $new_section = $('#selections_modal .section-template').clone();
          $new_section.removeClass('section-template');
          $new_section.find('.section-name').text(section_name);
          $new_section.find('input').val(max_radio_val+1);

          $('#selections_modal .new-section').before($new_section);
          $('#selections_modal #new_section').val('');
          $new_section.find('input').trigger('click');
        }

        var $section = $("#selections_modal input:checked[name='section']");
        $('#selections_modal').modal('hide');
        that._trigger('setSectionSelection', null, {
          fyle_id: that.fyle_id,
          section_id: parseInt($section.val()),
          section_name: $section.next('.section-name').text(),
          pages: that.pages
        });
      });

      $('body').on('focus', '#selections_modal #new_section', function(){
        $("#selections_modal input[name='section'][value='-1']").trigger('click');
      });
    },

    show: function(fyle_id, pages) {
      this.fyle_id = fyle_id;
      this.pages = pages;
      $('#selections_modal .num-pages').text(pages.length.toString());
      $('#selections_modal').modal('show');
      $("#selections_modal input[name='section'][value='-1']").trigger('click');
    }
  });
})(jQuery);
