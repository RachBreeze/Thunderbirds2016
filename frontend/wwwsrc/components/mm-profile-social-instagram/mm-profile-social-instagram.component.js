let mock = [{"UserID":"383A353A39363A3A3139","ImageURL":"https://scontent-lhr3-1.cdninstagram.com/t51.2885-15/s640x640/sh0.08/e35/c129.0.822.822/14474205_314768578891478_853430737817305088_n.jpg?ig_cache_key=MTM2MTY3Mjg4NDE2NjkzMzA5NA%3D%3D.2.c","DateTime":"2016-10-30T12:48:44.3998934+00:00","InstagramName":"suvi1301","PostUrl":"https://www.instagram.com/p/BLlokYRDTpm/"},{"UserID":"383A353A39363A3A3139","ImageURL":"https://scontent-lhr3-1.cdninstagram.com/t51.2885-15/s640x640/sh0.08/e35/c135.0.810.810/14659266_1235838669769679_74420899792551936_n.jpg?ig_cache_key=MTM2MDM0MzIzNjI5NjMyMjMwMA%3D%3D.2.c","DateTime":"2016-10-30T11:48:44.3998934+00:00","InstagramName":"suvi1301","PostUrl":"https://www.instagram.com/p/BLg6PdMDCz8/"},{"UserID":"383A353A39363A3A3139","ImageURL":"https://scontent-lhr3-1.cdninstagram.com/t51.2885-15/s640x640/sh0.08/e35/14550073_340937099585109_632864878469578752_n.jpg?ig_cache_key=MTM1NjY3MjYyMTk5NTgyNzk2MQ%3D%3D.2","DateTime":"2016-10-30T10:48:44.3998934+00:00","InstagramName":"suvi1301","PostUrl":"https://www.instagram.com/p/BLT3o_OjyL5/"},{"UserID":"383A353A39363A3A3139","ImageURL":"https://scontent-lhr3-1.cdninstagram.com/t51.2885-15/s640x640/sh0.08/e35/c135.0.810.810/14448352_309633779398584_5322349092683120640_n.jpg?ig_cache_key=MTM1NTkxMDM2MDc3MTQ1MDUwMQ%3D%3D.2.c","DateTime":"2016-10-30T09:48:44.3998934+00:00","InstagramName":"suvi1301","PostUrl":"https://www.instagram.com/p/BLRKUoJDdaF/"},{"UserID":"383A353A39363A3A3139","ImageURL":"https://scontent-lhr3-1.cdninstagram.com/t51.2885-15/s640x640/sh0.08/e35/14309735_585574381629351_1724658076352512000_n.jpg?ig_cache_key=MTM0NTA4MDM4MTE2MjkwMzYyNg%3D%3D.2","DateTime":"2016-10-30T08:48:44.3998934+00:00","InstagramName":"suvi1301","PostUrl":"https://www.instagram.com/p/BKqr3rpj9hK/"},{"UserID":"383A353A39363A3A3139","ImageURL":"https://scontent-lhr3-1.cdninstagram.com/t51.2885-15/s640x640/sh0.08/e35/14350895_1750765431830739_2123372140_n.jpg?ig_cache_key=MTM0MTIyOTMzMzIzMDg3OTAzMg%3D%3D.2","DateTime":"2016-10-30T07:48:44.3998934+00:00","InstagramName":"suvi1301","PostUrl":"https://www.instagram.com/p/BKdAPjxj4E4/"},{"UserID":"383A353A39363A3A3139","ImageURL":"https://scontent-lhr3-1.cdninstagram.com/t51.2885-15/s640x640/sh0.08/e35/c130.0.749.749/14360138_552749941516348_1220447711_n.jpg?ig_cache_key=MTM0MDE2NDkwMTkxNDI5ODc3Mw%3D%3D.2.c","DateTime":"2016-10-30T06:48:44.3998934+00:00","InstagramName":"suvi1301","PostUrl":"https://www.instagram.com/p/BKZOOC3DEmV/"},{"UserID":"383A353A39363A3A3139","ImageURL":"https://scontent-lhr3-1.cdninstagram.com/t51.2885-15/s640x640/sh0.08/e35/c135.0.809.809/14368934_291967361173792_267726946_n.jpg?ig_cache_key=MTM0MDE2MTI1MTQ1MjMyMzQ3NQ%3D%3D.2.c","DateTime":"2016-10-30T05:48:44.3998934+00:00","InstagramName":"suvi1301","PostUrl":"https://www.instagram.com/p/BKZNY7GjwaT/"},{"UserID":"383A353A39363A3A3139","ImageURL":"https://scontent-lhr3-1.cdninstagram.com/t51.2885-15/s640x640/sh0.08/e35/c135.0.809.809/14027185_1600924223533769_1491430757_n.jpg?ig_cache_key=MTMyODIxMTMzNTcxNjgzMDI0Mw%3D%3D.2.c","DateTime":"2016-10-30T04:48:44.3998934+00:00","InstagramName":"suvi1301","PostUrl":"https://www.instagram.com/p/BJuwSw0DHwj/"},{"UserID":"383A353A39363A3A3139","ImageURL":"https://scontent-lhr3-1.cdninstagram.com/t51.2885-15/s640x640/sh0.08/e35/c135.0.810.810/14032848_294664380905338_1191908358_n.jpg?ig_cache_key=MTMyODIxMDM1NTkwMjQ0NzIyNA%3D%3D.2.c","DateTime":"2016-10-30T03:48:44.3998934+00:00","InstagramName":"suvi1301","PostUrl":"https://www.instagram.com/p/BJuwEgSj354/"},{"UserID":"383A353A39363A3A3139","ImageURL":"https://scontent-lhr3-1.cdninstagram.com/t51.2885-15/s640x640/sh0.08/e35/c135.0.809.809/14145529_1254580204575439_974024562_n.jpg?ig_cache_key=MTMyNjQzMDAwNjQxOTQzNDA4NQ%3D%3D.2.c","DateTime":"2016-10-30T02:48:44.3998934+00:00","InstagramName":"suvi1301","PostUrl":"https://www.instagram.com/p/BJobRAoDKpl/"}];

import './mm-profile-social-instagram.scss';
import template from './mm-profile-social-instagram.html';

export default {
    template,
    controller: function (InstagramPost, $log, API_DOWN, $q) {
        "ngInject";
        
        this.downloading = false;

        let mockData = mock.map(InstagramPost.transformResponse).map((post) => new InstagramPost(post));

        this.sync = () => {
            this.downloading = true;

            let $p;

            if (API_DOWN) {
                $p = $q.resolve(mockData);
            } else {
                $p = InstagramPost.query().$promise;
            };

            return $p.then((posts) => {
                $log.info("Downloaded posts", posts);
                this.posts = posts;
            }).finally(() => {
                this.downloading = false;
            });
        };

        this.getPosts = () => {
            return this.posts || [];
        }
    },
    controllerAs: 'ProfileSocialInstagram'
}