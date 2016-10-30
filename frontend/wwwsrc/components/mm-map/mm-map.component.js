import _ from 'lodash';
import './mm-map.scss';
import template from './mm-map.html';

export default {
    template,
    require: {
        mmApp: '^^',
        mmFilter: '^^'
    },
    controller: function ($mmProfile) {
        "ngInject";

        this.getProfiles = _.memoize(() => {
            return this.mmApp.profiles;
        }, () => {
            return this.mmApp.profiles.map((profile) => profile.UserID).join(',');
        });

        this.doesPassFilter = (profile) => {
            if (this.mmFilter.name && profile.getFullName().indexOf(this.mmFilter.name) === -1) {
                return false;
            };

            if (this.mmFilter.date) {
                if (this.mmFilter.date.getMonth() !== profile.LastSeen.getMonth() ||
                this.mmFilter.date.getDate() !== profile.LastSeen.getDate()); {
                    return false;
                }
            }

            return true;
        }

        this.adviceRenderer = undefined;

        let styles = [{"featureType":"administrative.province","elementType":"geometry.fill","stylers":[{"visibility":"off"}]},{"featureType":"administrative.locality","elementType":"geometry.fill","stylers":[{"visibility":"on"}]},{"featureType":"landscape.man_made","elementType":"geometry.fill","stylers":[{"visibility":"on"},{"color":"#ffe4e4"}]},{"featureType":"landscape.natural","elementType":"geometry.fill","stylers":[{"visibility":"on"},{"color":"#ffd5db"}]},{"featureType":"poi","elementType":"geometry.fill","stylers":[{"visibility":"on"},{"color":"#bddcff"}]},{"featureType":"road","elementType":"geometry","stylers":[{"lightness":100},{"visibility":"simplified"}]},{"featureType":"road","elementType":"labels","stylers":[{"visibility":"off"}]},{"featureType":"transit.line","elementType":"geometry","stylers":[{"visibility":"on"},{"lightness":700}]},{"featureType":"water","elementType":"all","stylers":[{"color":"#eef5fd"}]}];

        //° N, ° W
        this.map = {
            center: { latitude: 53.4808, longitude: -2.2426 },
            zoom: 12,
            options: {
                styles
            }
        };

        let windowOptions = {}
        this.getWindowOptions = (key) => {
            if (!windowOptions[key]) {
                windowOptions[key] = {
                    visible:false
                };
            };

            return windowOptions[key];
        }

        this.toggleWindow = (key) => {
            windowOptions[key].visible = !windowOptions[key].visible;
        }

        this.openProfile = (profile, $event) => {
            $mmProfile(profile, $event);
        }
    },
    controllerAs: 'Map'
}