HTMLWidgets.widget({

  name: 'dkjustgage',

  type: 'output',

  factory: function(el, width, height) {

    var id = el.id;

    return {
      renderValue: function(x) {
        // TODO: code to render the widget, e.g.

        if (x.target) {
          var g = new JustGage({
            id: id,
            value: x.value,
            min: x.min,
            max: x.max,
            title: x.title,
            label: x.label,
            symbol: x.symbol,
            reverse: x.reverse,
            relativeGaugeSize: true,
            customSectors: [{
              color : "#ff0000",
              lo: x.min,
              hi: x.target
            }, {
              color: "#00ff00",
              lo: x.target,
              hi: x.max
            }]
          });
        }
        else
        {
          var g = new JustGage({
            id: id,
            value: x.value,
            min: x.min,
            max: x.max,
            title: x.title,
            label: x.label,
            symbol: x.symbol,
            reverse: x.reverse,
            relativeGaugeSize: true,

          });
        }
      },

      resize: function(width, height) {
        //g.refresh(g.config.value);
      }

    };
  }
});
