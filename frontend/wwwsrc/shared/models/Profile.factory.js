import _ from 'lodash';

export default function (API_URL, $resource) {

    function transformResponse (data) {
        if (typeof data === 'string') {
            data = JSON.parse(data);
        };

        data.LastSeen = new Date(data.LastSeen);

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
        'id':'@id'
    };

    let Profile = $resource(`${API_URL}/api/Profiles/:id/`, options, actions);

    Profile.prototype.getLatLng = _.memoize(function () {
        return {
            latitude: this.Latitude,
            longitude: this.Longitude
        };
    }, function () {
        return `${this.Latitude}${this.Longtitude}`;
    });

    Profile.prototype.isUserDangerous = function () {
        return (this.IsDangerous === true);
        //return true;
    }
    
    Profile.prototype.getTags = function () {
        return this.Tags;
        //return ['Toddler'];
    };

    Profile.prototype.getFullName = function () {
        return `${this.Forename} ${this.Surname}`;
    };

    Profile.prototype.getMarkerOptions = _.memoize(function() {
        return {icon: 'http://maps.google.com/mapfiles/ms/icons/blue-dot.png'};
    }, function () {
        return this.getFullName();
    })

    Profile.prototype.getImage = function () {
        return this.ProfileURL;
    }

    return Profile;
}