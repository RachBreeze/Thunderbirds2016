import template from './mm-profile-advice.html';

export default {
    template,
    require: {
        mmProfile: '^^'
    },
    controller: function (AlzimersPattern) {
        "ngInject";
    },
    controllerAs: 'ProfileAdvice'
}