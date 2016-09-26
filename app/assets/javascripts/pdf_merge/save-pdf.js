(function($) {
  $.widget( 'sh.savePdf', {
    options: {
      filename: 'new_file.pdf',
      folder_show_path: '/',
      form_authenticity_token: ''
    },

    _create: function() {
      var that = this;

      $('nav.navbar > form.navbar-form').submit(function(event){
        event.preventDefault();
      });

      this.element.click(function(){
        var $filename_input = $('nav.navbar > form.navbar-form input#pdf_name');
        if ($filename_input[0].checkValidity()) {
          that.options.filename = $filename_input.val();
          that._showSaveModal();
        } else {
          $("nav.navbar > form.navbar-form input[type='submit']").trigger('click'); // shows validation over field
        }
        return false;
      });
    },

    _rebuildSaveTree: function(){
      var that = this;

      $('#save_pdf_modal .save-tree').remove();
      var $save_tree = $("<div class='save-tree'></div>");
      $('#save_pdf_modal .modal-body > .save-instructions').after($save_tree);
      $save_tree.folderTree({
        root: '.',
        contents_url: this.options.folder_show_path,
        folder_click: function(event, data) {
          $save_tree.find('li.folder.selected-folder').removeClass('selected-folder');
          $save_tree.find("li.folder[data-path='"+data.path+"']").addClass('selected-folder');
          $('#save_pdf_modal .destination > .dest-path').text(data.path+'/'+that.options.filename);
        }
      });
    },

    _save: function(){
      var pdf_path = $('#save_pdf_modal .destination > .dest-path').text();
      $.post(this.element.prop('href'), $.param({
        authenticity_token: this.options.form_authenticity_token,
        path: pdf_path,
        sections: $('nav.navbar > .bundle-details').bundleContainer('getPagesWithSections')
      }))
      .done(function(data, textStatus, jqXHR){
        $('#save_pdf_modal').modal('hide');
        $('#alert_modal .alert-text').html('Saved successfully: <strong>'+pdf_path+'</strong>');
        $('#alert_modal').modal('show');
        setTimeout(function(){
          $('#alert_modal').modal('hide');
        }, 1000);
      });
    },

    _showSaveModal: function(){
      var that = this;
      $('#save_pdf_modal .save-instructions > .filename').text(this.options.filename);
      $('#save_pdf_modal .destination > .dest-path').text('');

      this._rebuildSaveTree();

      $('#save_pdf_modal .modal-footer > .btn-primary').off();
      $('#save_pdf_modal .modal-footer > .btn-primary').click(function(){
        if ($('#save_pdf_modal .destination > .dest-path').text()==''){
          alert('Click a destination directory to save '+that.options.filename+'.');
        } else {
          that._save();
        }
      });

      $('#save_pdf_modal').modal('show');
    },
  });
})(jQuery);
