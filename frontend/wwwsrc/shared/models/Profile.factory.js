import _ from 'lodash';

export default function (API_URL, $resource) {

    let actions = {};

    let options = {
        'id':'@'
    };

    let Profile = $resource(`${API_URL}/api/Profiles/:id/`, actions, options);

    Profile.prototype.getLatLng = _.memoize(function () {
        return {
            latitude: this.Latitude,
            longitude: this.Longitude
        };
    }, function () {
        return `${this.Latitude}${this.Longtitude}`;
    });

    Profile.prototype.getFullName = function () {
        return `${this.Forename} ${this.Surname}`;
    };

    Profile.prototype.getMarkerOptions = _.memoize(function() {
        return {labelClass:'marker_labels',labelAnchor:'12 60', labelContent:this.getFullName()};
    }, function () {
        return this.getFullName();
    })

    return Profile;
}