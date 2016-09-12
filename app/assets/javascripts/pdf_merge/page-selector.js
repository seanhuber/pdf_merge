(function($) {
  $.widget( 'sh.pageSelector', {
    options: {
      fyle_id: '',
      thumbs_url: '',
      page_image_size: 1000,
      setPageSelections: function(event, data){
        console.log('selections:', data.selections);
      }
    },

    _create: function() {
      var that = this;
      that.backdrop = $('.pg-selector-backdrop');

      that.element.click(function() {
        that.backdrop.fadeIn('fast');

        that.backdrop.find('.close-pg-selector').click(function() {
          that.close();
        });

        $(document).on('keyup',function(evt) {
          if (evt.keyCode == 27) { // escape key up
            that.close();
          }
        });

        that.backdrop.find('.page-view > .page-img').html("<img src='"+$('.right-pane img.first-page').attr('src')+"'/>");
        that.backdrop.find('.page-view .num-pages').text($('.right-pane .fyle-overview .num-pages').text());
        that.backdrop.find('.page-view h3.filename').text($('.right-pane .fyle-overview h3').text());

        $.get(that.options.thumbs_url, $.param({id: that.options.fyle_id}));
      });
    },

    close: function() {
      this.backdrop.find('.close-pg-selector').off('click');
      $(document).off('keyup');
      this.backdrop.fadeOut('fast');
    },

    _selectionChange: function() {
      this.backdrop.find('.thumbs > .buttons > .add-selections').toggleClass('disabled', this.backdrop.find('.thumbs li.selected').length == 0);
    },

    updateThumbs: function(thumbs_html) {
      var that = this;
      this.backdrop.find('.thumbs').replaceWith(thumbs_html);

      this.backdrop.find('.thumbs > ul').height($(document).height() - this.backdrop.find('.thumbs > .buttons').outerHeight());

      this.backdrop.find('.thumbs').resizable({
        handles: { e: '.pg-selector-backdrop .ui-resizable-handle' },
        create: function( event, ui ) {
          $('.ui-resizable-e').css('cursor','ew-resize');
        }
      });

      this.backdrop.find('.thumbs > .buttons > .select-all').click(function() {
        if ($(this).text() == 'Select All') {
          that.backdrop.find('.thumbs li').addClass('selected');
          that.backdrop.find(".thumbs li > input[type='checkbox']").prop('checked', true);
          $(this).text('Deselect All');
        } else {
          that.backdrop.find('.thumbs li').removeClass('selected');
          that.backdrop.find(".thumbs li > input[type='checkbox']").prop('checked', false);
          $(this).text('Select All');
        }
        that._selectionChange();
      });

      this.backdrop.find('.thumbs > .buttons > .add-selections').click(function() {
        if ($(this).hasClass('disabled')) return false;
        var selections = that.backdrop.find('.thumbs li.selected').map(function() {
          return $(this).data('page-num');
        }).get();
        that.close();
        that._trigger('setPageSelections', null, {selections: selections});
      });

      this.backdrop.find('.thumbs li').click(function() {
        that.backdrop.find('.thumbs li').removeClass('clicked');
        $(this).addClass('clicked');

        var page_num = $(this).data('page-num');
        var $img = that.backdrop.find('.page-view > .page-img > img');

        var src_pieces = $img.attr('src').split('/');
        src_pieces[ src_pieces.length - 1 ] = that.options.page_image_size+'_'+page_num+'.png';
        $img.attr('src', src_pieces.join('/') );

        that.backdrop.find('.page-view .selected-page').text(page_num);
      });

      this.backdrop.find('.thumbs li').dblclick(function() {
        var page_num = $(this).data('page-num');
        $(this).toggleClass('selected');
        $(this).find("input[type='checkbox']").prop('checked', $(this).hasClass('selected'));
        that._selectionChange();
      });
    }
  });
})(jQuery);
