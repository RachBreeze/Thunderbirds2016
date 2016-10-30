let mock = [{"Id":"792704269325656065","TwitterHandle":"BreezeRachel", "DateTime":"2016-10-29T08:20:54"},{"Id":"791552552466776064","TwitterHandle":"BreezeRachel", "DateTime":"2016-10-27T09:10:09"},{"Id":"790839929462984704","TwitterHandle":"BreezeRachel", "DateTime":"2016-10-25T09:58:26"},{"Id":"790837432379998208","TwitterHandle":"BreezeRachel", "DateTime":"2016-10-25T09:48:31"},{"Id":"790829520647585792","TwitterHandle":"BreezeRachel", "DateTime":"2016-10-25T09:17:05"},{"Id":"789743094619107328","TwitterHandle":"BreezeRachel", "DateTime":"2016-10-22T09:20:01"},{"Id":"789223464204898305","TwitterHandle":"BreezeRachel", "DateTime":"2016-10-20T22:55:11"},{"Id":"789164709362536448","TwitterHandle":"BreezeRachel", "DateTime":"2016-10-20T19:01:43"}];

import './mm-profile-social-twitter.scss';
import template from './mm-profile-social-twitter.html';

export default {
    template,
    controller: function (Tweet, $log, API_DOWN, $q) {
        "ngInject";
        
        this.downloading = false;

        let mockData = mock.map(Tweet.transformResponse).map((tweet) => new Tweet(tweet));]

        this.sync = () => {
            this.downloading = true;

            let $p;

            if (API_DOWN) {
                $p = $q.resolve(mockData);
            } else {
                $p = Tweet.query().$promise;
            };

            return $p.then((tweets) => {
                $log.info("Downloaded tweets", tweets);
                this.tweets = tweets;
            }).finally(() => {
                this.downloading = false;
            });
        };

        this.getTweets = () => {
            return this.tweets || [];
        }
    },
    controllerAs: 'ProfileSocialTwitter'
}