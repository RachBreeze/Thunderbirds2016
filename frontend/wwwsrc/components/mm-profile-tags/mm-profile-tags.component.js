import template from './mm-profile-tags.html';

export default {
    template,
    require: {
        mmProfile: '^^'
    },
    controller: function (AlzimersPattern) {
        "ngInject";

        this.init = () => {
        this.tags = this.mmProfile.profile.getTags()
        }
    },
    controllerAs: 'ProfileTags'
}