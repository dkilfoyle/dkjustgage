HTMLWidgets.widget({

  name: 'dkjustgage',

  type: 'output',

  factory: function(el, width, height) {

    var id = el.id;
    var g;

    return {
      renderValue: function(x) {

        x.id = id;

        if (g)
          g.refresh(x.value, x.max, x);
        else
        {
          g = new JustGage(x);
          var tab = $(el).closest('div.tab-pane');
          if (tab !== null) {
            var tabID = tab.attr('id');
            var tabAnchor = $('a[data-toggle="tab"][href="#' + tabID + '"]');
            if (tabAnchor !== null) {
              tabAnchor.on('shown.bs.tab', function() {
                g.refresh(0, x.max, { refreshAnimationTime: 0, onAnimationEnd: function() {
                  g.refresh(x.value, x.max, { refreshAnimationTime: 700, onAnimationEnd: null });
                }});
              });
            }
          }
        }
      },

      resize: function(width, height) {
        //console.log("resizing");
      }

    };
  }
});
