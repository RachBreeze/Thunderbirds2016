import angular from 'angular';
import angularResource from 'angular-resource';

import Profile from './Profile.factory.js';

let models = angular.module('mm.models', [angularResource])
    .factory('Profile', Profile);

export default models.name;