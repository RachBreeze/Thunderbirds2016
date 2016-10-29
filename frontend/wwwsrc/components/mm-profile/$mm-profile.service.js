import template from './$mm-profile.html';

export default function ($mdDialog) {
    "ngInject";

    return function (profile, $event) {
        $mdDialog.show({
            targetEvent: $event,
            template,
            locals: {
                profile
            },
            controller: function () {
                "ngInject";

                this.close = () => {
                    $mdDialog.close;
                };

                this.profile = profile;
            },
            controllerAs: '$mmProfile'
        });
    }
}