(function($) {
  $.widget('sh.bundleContainer', {
    options: {
      sections: {
        // 1: {
        //   name: 'Example section name',
        //   pages: [
        //     {fyle_id: 123, page_num: 14},
        //     {fyle_id: 123, page_num: 16},
        //     {fyle_id: 456, page_num: 3}
        //   ]
        // }
      }
    },

    _create: function(){},

    // expected properties of opts:
    //   section_id   - (integer), id of the section to add the pages to
    //   section_name - (string), name of the section to add the pages to
    //   fyle_id      - (integer), rails id of the Fyle that the pages come from
    //   pages        - (array of integers), page numbers of the Fyle to add to the bundle
    insertPages: function(opts){
      var that = this;
      if (!this.options.sections.hasOwnProperty(opts.section_id)) {
        this.options.sections[opts.section_id] = {name: opts.section_name, pages: []};
      }
      $.each(opts.pages, function(idx, page_num){
        that.options.sections[opts.section_id].pages.push({fyle_id: opts.fyle_id, page_num: page_num});
      });
      this.element.find('.section-count').text(Object.keys(this.options.sections).length);
      this.element.find('.page-count').text(this.numPages());
    },

    numPages: function(){
      var page_count = 0;
      $.each(this.options.sections, function(section_id, section){
        page_count += section.pages.length;
      });
      return page_count;
    }
  });
})(jQuery);
