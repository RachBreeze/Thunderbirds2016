import './mm-map.scss';
import template from './mm-map.html';

export default {
    template,
    require: {
        mmApp: '^^'
    },
    controller: function () {
        "ngInject";

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
    },
    controllerAs: 'Map'
}