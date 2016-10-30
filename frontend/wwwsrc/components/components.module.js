import angular from 'angular';

import mmApp from './mm-app/mm-app.component.js';
import mmToolbar from './mm-toolbar/mm-toolbar.component.js';
import mmSidebar from './mm-sidebar/mm-sidebar.component.js';
import mmMap from './mm-map/mm-map.component.js';
import mmProfile from './mm-profile/mm-profile.component.js';
import mmProfileAdvice from './mm-profile-advice/mm-profile-advice.component.js';
import mmProfileTags from './mm-profile-tags/mm-profile-tags.component.js';
import mmProfileDangerous from './mm-profile-dangerous/mm-profile-dangerous.component.js';
import mmProfileSocialTwitter from './mm-profile-social-twitter/mm-profile-social-twitter.component.js';
import mmProfileSocialInstagram from './mm-profile-social-instagram/mm-profile-social-instagram.component.js';
import mmFilter from './mm-filter/mm-filter.component.js';
import mmUserbar from './mm-userbar/mm-userbar.component.js';
import $mmProfile from './mm-profile/$mm-profile.service.js';

let componentsModule = angular.module('mm.components', [])
    .component('mmApp', mmApp)
    .component('mmToolbar', mmToolbar)
    .component('mmSidebar', mmSidebar)
    .component('mmUserbar', mmUserbar)
    .component('mmMap', mmMap)
    .component('mmProfile', mmProfile)
    .component('mmProfileAdvice', mmProfileAdvice)
    .component('mmProfileTags', mmProfileTags)
    .component('mmProfileDangerous', mmProfileDangerous)
    .component('mmProfileSocialTwitter', mmProfileSocialTwitter)
    .component('mmProfileSocialInstagram', mmProfileSocialInstagram)
    .component('mmFilter', mmFilter)
    .service('$mmProfile', $mmProfile);

export default componentsModule.name;