
  function getBackgroundColors(dataPoints) {
    var result = [];
    for (var x=0; x < dataPoints.length; x++ ) {
      var rand1 = Math.random() * 256;
      var rand2 = Math.random() * 256;
      var rand3 = Math.random() * 256;
      result.push ("rgb(" + rand1.toFixed(0).toString()+","+rand2.toFixed(0).toString()+","+rand3.toFixed(0).toString()+")");
    }
    return result;
  }
  