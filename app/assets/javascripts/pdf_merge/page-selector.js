(function($) {
  $.widget( 'sh.pageSelector', {
    options: {
      fyle_id: '',
      thumbs_url: ''
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

    updateThumbs: function(thumbs_html) {
      var that = this;

      this.backdrop.find('.thumbs').replaceWith(thumbs_html);
      this.backdrop.find('.thumbs').resizable({
        handles: { e: '.pg-selector-backdrop .ui-resizable-handle' },
        create: function( event, ui ) {
          $('.ui-resizable-e').css('cursor','ew-resize');
        }
      });

      this.backdrop.find('.thumbs li').click(function() {
        var page_num = $(this).data('page-num');
        var $img = that.backdrop.find('.page-view > .page-img > img');
        
        var src_pieces = $img.attr('src').split('/');
        src_pieces[ src_pieces.length - 1 ] = '500_'+page_num+'.png';
        $img.attr('src', src_pieces.join('/') );

        that.backdrop.find('.page-view .selected-page').text(page_num);
      });
    }
  });
})(jQuery);
