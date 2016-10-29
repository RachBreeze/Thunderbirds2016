import template from './mm-profile.html';

export default {
    template,
    bindings: {
        profile: '<'
    },
    controller: function (AlzimersPattern) {
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

        this.advice = [];

        this.syncAdvice = () => {
            let advices = [AlzimersPattern];
            let profile = this.profile;

            let results = [];

            advices.forEach((advice) => {
                if (advice.checkConditions(profile) === true) {
                    results.push(advice);
                };
            });

            this.advice = results;
        };

        this.getAdviceMap = () => {
            console.log("ADVICE MAP:", this.advice[0].getMapEffect());
            return this.advice[0].getMapEffect();
        }

    },
    controllerAs:'Profile'
}