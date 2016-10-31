let mock = [{"IsVerified":false,"DateTime":"2016-10-30T00:00:00","LocationType":"App Sighting","UserID":"383A353A3936393A3139","Latitude":53.53257,"Longitude":-2.406005,"ContactNumber":null,"DeviceID":null},{"IsVerified":false,"DateTime":"2016-10-30T00:00:00","LocationType":"App Sighting","UserID":"383A353A3936393A3139","Latitude":53.5938,"Longitude":-2.386993,"ContactNumber":null,"DeviceID":null},{"IsVerified":false,"DateTime":"2016-10-30T00:00:00","LocationType":"App Sighting","UserID":"383A353A3936393A3139","Latitude":53.54896,"Longitude":-2.13031,"ContactNumber":null,"DeviceID":null},{"IsVerified":false,"DateTime":"2016-10-30T00:00:00","LocationType":"App Sighting","UserID":"383A353A3936393A3139","Latitude":53.49519,"Longitude":-2.273497,"ContactNumber":null,"DeviceID":null},{"IsVerified":false,"DateTime":"2016-10-30T00:00:00","LocationType":"App Sighting","UserID":"383A353A3936393A3139","Latitude":53.44915,"Longitude":-2.114283,"ContactNumber":null,"DeviceID":null},{"IsVerified":true,"DateTime":"2016-10-30T00:00:00","LocationType":"Haunt","UserID":"383A353A3936393A3139","Latitude":53.54351,"Longitude":-2.62281,"ContactNumber":null,"DeviceID":null},{"IsVerified":true,"DateTime":"2016-10-30T00:00:00","LocationType":"Haunt","UserID":"383A353A3936393A3139","Latitude":53.4792,"Longitude":-2.237046,"ContactNumber":null,"DeviceID":null},{"IsVerified":true,"DateTime":"2016-10-30T00:00:00","LocationType":"Haunt","UserID":"383A353A3936393A3139","Latitude":53.53413,"Longitude":-2.143422,"ContactNumber":null,"DeviceID":null},{"IsVerified":true,"DateTime":"2016-10-30T00:00:00","LocationType":"Searched","UserID":"383A353A3936393A3139","Latitude":53.41793,"Longitude":-2.432691,"ContactNumber":null,"DeviceID":null},{"IsVerified":true,"DateTime":"2016-10-30T00:00:00","LocationType":"Searched","UserID":"383A353A3936393A3139","Latitude":53.49283,"Longitude":-2.070066,"ContactNumber":null,"DeviceID":null},{"IsVerified":true,"DateTime":"2016-10-30T00:00:00","LocationType":"Searched","UserID":"383A353A3936393A3139","Latitude":53.50923,"Longitude":-2.525777,"ContactNumber":null,"DeviceID":null},{"IsVerified":true,"DateTime":"2016-10-30T00:00:00","LocationType":"Searched","UserID":"383A353A3936393A3139","Latitude":53.46584,"Longitude":-2.228761,"ContactNumber":null,"DeviceID":null},{"IsVerified":true,"DateTime":"2016-10-30T00:00:00","LocationType":"Searched","UserID":"383A353A3936393A3139","Latitude":53.58996,"Longitude":-2.356951,"ContactNumber":null,"DeviceID":null},{"IsVerified":true,"DateTime":"2016-10-30T00:00:00","LocationType":"Searched","UserID":"383A353A3936393A3139","Latitude":53.54483,"Longitude":-2.197899,"ContactNumber":null,"DeviceID":null},{"IsVerified":true,"DateTime":"2016-10-30T00:00:00","LocationType":"Searched","UserID":"383A353A3936393A3139","Latitude":53.59935,"Longitude":-2.28168,"ContactNumber":null,"DeviceID":null},{"IsVerified":true,"DateTime":"2016-10-30T00:00:00","LocationType":"Searched","UserID":"383A353A3936393A3139","Latitude":53.46584,"Longitude":-2.228761,"ContactNumber":null,"DeviceID":null},{"IsVerified":true,"DateTime":"2016-10-30T00:00:00","LocationType":"Searched","UserID":"383A353A3936393A3139","Latitude":53.39466,"Longitude":-2.266324,"ContactNumber":null,"DeviceID":null},{"IsVerified":true,"DateTime":"2016-10-30T00:00:00","LocationType":"Searched","UserID":"383A353A3936393A3139","Latitude":53.39184,"Longitude":-2.214378,"ContactNumber":null,"DeviceID":null},{"IsVerified":true,"DateTime":"2016-10-30T00:00:00","LocationType":"Searched","UserID":"383A353A3936393A3139","Latitude":53.51766,"Longitude":-2.228723,"ContactNumber":null,"DeviceID":null}];

import template from './mm-profile.html';

export default {
    template,
    bindings: {
        profile: '<'
    },
    controller: function (AlzimersPattern,ToddlerPattern, $q, API_DOWN, mockSupermarkets, Sighting) {
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

        this.getSupermarkets = () => {
            return mockSupermarkets;
        }

        this.advice = [];

        this.sync = () => {
            this.syncAdvice();
            this.syncSightings();
        }

        this.syncAdvice = () => {
            let advices = [AlzimersPattern, ToddlerPattern];
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
            if (this.advice.length == 0 || this.advice[0] === undefined) {
                return undefined;
            };

            return this.advice[0].getMapEffect();
        }

        this.syncSightings = () => {
            this.loading = true;

            let $p;

            if (API_DOWN) {
                $p = $q.resolve(mock);
            } else {
                $p = Sighting.query().$promise;
            }

            return $p.then((sightings) => {
                this.sightings = sightings;
            }).finally(() => {
                this.loading = false;
            });
        };

        this.getSightings = () => {
            return this.sightings || [];
        }

        this.getTweetIds = () => {
            
        }
    },
    controllerAs:'Profile'
}