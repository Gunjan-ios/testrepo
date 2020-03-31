var styles = {
    'currentLocation': new ol.style.Style({
        image: new ol.style.Circle({
            radius: 10,
            fill: new ol.style.Fill({
                color: '#2196F3'
            }),
            stroke: new ol.style.Stroke({
                color: '#FFF',
                width: 3
            })
        })
    }),
    'storeLocation': new ol.style.Style({
        image: new ol.style.Circle({
            radius: 10,
            fill: new ol.style.Fill({
                color: '#FFCC33'
            }),
            stroke: new ol.style.Stroke({
                color: '#FFF',
                width: 3
            })
        })
    })
};

var locationVector = new ol.layer.Vector({
    source: new ol.source.Vector(),
    style: function (ft) {
        return styles[ft.get('type')];
    }
})

// Initialize map
var map = new ol.Map({
    target: 'map',
    layers: [
        new ol.layer.Tile({
            source: new ol.source.OSM()
        }),
        locationVector
    ],
    view: new ol.View({
        projection: 'EPSG:4326',
        center: [80.171875, 22.203125],
        zoom: 4
    })
});

function showLocationInfo(data) {
    data = JSON.parse(data);

    let currentLocation = new ol.Feature({
        type: 'currentLocation',
        geometry: new ol.geom.Point([data.currentLocation.longitude, data.currentLocation.latitude])
    })

    let storeLocation = new ol.Feature({
        type: 'storeLocation',
        geometry: new ol.geom.Point([data.storeLocation.longitude, data.storeLocation.latitude])
    })

    // Clear source so that only one feature exists
    locationVector.getSource().clear();

    // Add feature to source
    locationVector.getSource().addFeatures([currentLocation, storeLocation]);

    map.getView().fit(locationVector.getSource().getExtent(), { padding: [5, 5, 5, 5] });

    // Remove translate interaction if exists
    map.removeInteraction(
        map.getInteractions().getArray().find(i => i instanceof ol.interaction.Translate)
    );

    // Add translate interaction
    map.addInteraction(
        new ol.interaction.Translate({
            features: new ol.Collection([storeLocation])
        })
    );
}

function getLocationInfo() {
    try {
        let feature = locationVector.getSource().getFeatures().find(ft => ft.get('type') == 'storeLocation');
        let coords = feature.getGeometry().getCoordinates();

        let data = {
            longitude: coords[0],
            latitude: coords[1]
        }

        console.log(data);

        // For Android
        if (window.appInterface) {
            window.appInterface.setLocationInfo(JSON.stringify(data));
        }
        // For iOS
        if (window.webkit && window.webkit.messageHandlers) {
            //window.webkit.messageHandlers.setLocationInfo.postMessage(JSON.stringify(data));
            window.webkit.messageHandlers.setLocationInfo.postMessage(data);
        }
    }
    catch (e) {
        console.log(e);
    }
}

var searchVector = new ol.layer.Vector({
    source: new ol.source.Vector(),
    style: new ol.style.Style({
        image: new ol.style.Circle({
            radius: 10,
            fill: new ol.style.Fill({
                color: '#2196F3'
            }),
            stroke: new ol.style.Stroke({
                color: '#FFF',
                width: 3
            })
        })
    })
});

map.addLayer(searchVector);

function search(keyword) {

    keyword = keyword.trim();
    searchVector.getSource().clear();

    if (!keyword || keyword == '') {
        console.log('Invalid search parameter')
        return;
    }

    // TODO: Configurable URL
    var url = 'http://192.168.10.196/geoserver_196/kvic/ows';

    var http = new XMLHttpRequest();
    var params = {
        service: 'WFS',
        version: '1.0.0',
        request: 'GetFeature',
        typeName: 'kvic:overlay',
        srsName: 'EPSG:3857',
        maxFeatures: 25,
        bbox: ol.proj.transformExtent(map.getView().calculateExtent(), 'EPSG:3857', 'EPSG:4326').toString(),
        outputFormat: 'application/json',
        viewparams: 'category_id:4;fuzzyparam:' + keyword
    }

    http.open("GET", url + formatParams(params), true);
    http.onreadystatechange = function () {
        if (http.readyState == 4 && http.status == 200) {
            var features = new ol.format.GeoJSON().readFeatures(http.responseText);
            if (features.length) {
                searchVector.getSource().addFeatures(features);
            }
            else {
                console.log('No features found')
            }
        }
    }
    http.send(params);
}

function clearMap() {
    searchVector.getSource().clear();
}

function formatParams(params) {
    return "?" + Object
        .keys(params)
        .map(function (key) {
            return key + "=" + encodeURIComponent(params[key])
        })
        .join("&")
}
