import angular from 'angular';
import angularAnimate from 'angular-animate';

import mmLoading from './mm-loading.component.js';

let loadingModule = angular.module('mableCms.shared.loading', [angularAnimate])
    .component('mmLoading', mmLoading);

export default loadingModule.name;