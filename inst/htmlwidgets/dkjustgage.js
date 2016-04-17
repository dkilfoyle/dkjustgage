HTMLWidgets.widget({

  name: 'dkjustgage',

  type: 'output',

  factory: function(el, width, height) {

    var id = el.id;
    var g;

    return {
      renderValue: function(x) {

        var config = {
            id: id,
            value: x.value,
            min: x.min,
            max: x.max,
            title: x.title,
            label: x.label,
            symbol: x.symbol,
            reverse: x.reverse,
            relativeGaugeSize: true
        };

        if (x.target !== null)
          config.customSectors = [{
              color : "#ff0000",
              lo: x.min,
              hi: x.target
            }, {
              color: "#00ff00",
              lo: x.target,
              hi: x.max
            }]

        if (g)
          g.refresh(x.value, x.max, config);
        else
        {
          g = new JustGage(config);
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
