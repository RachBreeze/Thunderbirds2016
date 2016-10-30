import duff from './duff.json';

import './mm-app.scss';
import template from './mm-app.html';

export default {
    transclude: true,
    template,
    controller: function ($log, $q, Profile, API_DOWN) {
        "ngInject";

        let testData = duff.map((profile) => new Profile(profile));

        this.profiles = [];

        this.sync = () => {
            this.downloading = true;

            let $p;

            if (API_DOWN) {
                $p = $q.resolve()
                    .then(() => {
                        this.profiles = testData;
                    })
            } else {
                $p = Profile.query().$promise
                    .then((profiles) => {
                        $log.info("DOWNLOADED PROFILES", profiles);
                        this.profiles = profiles;
                    })
            };

            return $p
                .finally(() => {
                    this.downloading = false;
                })
        };
    },
    controllerAs: 'App'
}