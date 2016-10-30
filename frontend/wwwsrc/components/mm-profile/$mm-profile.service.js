import './$mm-profile.scss';
import template from './$mm-profile.html';

export default function ($mdDialog, $log) {
    "ngInject";

    return function (profile, $event) {
        $log.info("Opened profile:", profile);
        
        $mdDialog.show({
            targetEvent: $event,
            template,
            locals: {
                profile
            },
            controller: function () {
                "ngInject";

                this.close = () => {
                    $mdDialog.hide();
                };

                this.legend = [
                    {
                        img:'http://maps.google.com/mapfiles/ms/icons/blue-dot.png',
                        title: 'Last known'
                    },
                    {
                        img:'http://maps.google.com/mapfiles/ms/icons/red-dot.png',
                        title: 'Haunt'
                    },
                    {
                        img:'http://maps.google.com/mapfiles/ms/icons/green-dot.png',
                        title: 'App Sighting'
                    },
                    {
                        img:'http://maps.google.com/mapfiles/ms/icons/yellow-dot.png',
                        title: 'Social Media'
                    },
                    {
                        img:'http://maps.google.com/mapfiles/ms/icons/orange-dot.png',
                        title: 'Searched'
                    }
                ]

                this.profile = profile;
            },
            controllerAs: '$mmProfile'
        });
    }
}