import _ from 'lodash';

export default function (API_URL, $resource) {

    function transformResponse (data) {
        data.DateTime = new Date(data.DateTime);

        return data;
    }

    let actions = {
        get: {
            transformResponse:(data) => transformResponse(JSON.parse(data))
        },
        query: {
            transformResponse:(data) => JSON.parse(data).map(transformResponse),
            isArray: true
        }
    };

    let options = {
        'uniqueID':'383A353A3936393A3139'
    };

    let Sighting = $resource(`${API_URL}/api/Sightings`, options, actions);

    Sighting.prototype.getId = function () {
        return `${this.UserID}_sighting`;
    }

    Sighting.prototype.getLatLng = _.memoize(function () {
        return {
            latitude: this.Latitude,
            longitude: this.Longitude
        };
    }, function () {
        return `${this.Latitude}${this.Longtitude}`;
    });

    Sighting.prototype.isVerified = function () {
        return this.IsVerified;
    }
    
    Sighting.prototype.getLocationType = function () {
        return this.LocationType;
    };

    Sighting.prototype.getMarkerOptions = _.memoize(function() {
        return {
            icon: this.getMarkerIcon()
        };
    }, function () {
        return this.getLocationType();
    })

    Sighting.prototype.getMarkerIcon = function () {
        switch(this.getLocationType()) {
            case 'Haunt':
                return 'http://maps.google.com/mapfiles/ms/icons/red-dot.png';
            case 'App Sighting':
                return 'http://maps.google.com/mapfiles/ms/icons/green-dot.png';
            case 'Social Media Friend':
                return 'http://maps.google.com/mapfiles/ms/icons/yellow-dot.png';
            case 'Searched':
                return 'http://maps.google.com/mapfiles/ms/icons/orange-dot.png';
        };
    };

    return Sighting;
}