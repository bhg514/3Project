jQuery(function ($) {
    var gradient = {
        17: '#f00', // red
        "0.33": '#ff0', // yellow
        "0.5": 'orange', // orange
        "0.66": '#0f0', // green
        1: '#00f' // blue
    };
    $('#myCanvas').tagcanvas({
        weightGradient: gradient,
        weight: true,
        weightFrom: 'data-weight',
        shadow: '#ccf',
        shadowBlur: 3,
        interval: 20,
        textFont: 'Impact,Arial Black,sans-serif',
        textColour: '#82797B',
        textHeight: 20,
        outlineColour: '#F2F0F0',
        outlineThickness: 5,
        maxSpeed: 0.1,
        minBrightness: 0.1,
        depth: 0.92,
        pulsateTo: 0.2,
        pulsateTime: 0.75,
        initial: [0.1, -0.1],
        decel: 0.98,
        reverse: true,
        hideTags: false
    }, 'weightTags');

});