import './mm-userbar.scss';
import template from './mm-userbar.html';

export default {
    require: {
        mmApp: '^^'
    },
    template,
    controller: function ($mmProfile) {
        "ngInject";

        this.openProfile = (profile, $event) => {
            $mmProfile(profile, $event);
        }
    },
    controllerAs: 'Userbar'
}